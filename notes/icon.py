#!/usr/bin/env -S uv run --quiet --with pillow --with numpy --python 3.13 python
"""Generate Log.app's icon: a wood-grain squircle in the macOS icon style.

Writes icon.png (1024x1024) next to this file. install.sh turns it into
Log.app/Contents/Resources/Log.icns with sips and iconutil.
"""

from __future__ import annotations

import pathlib

import numpy as np
from PIL import Image, ImageFilter

SS = 2                      # supersample factor, downsampled at the end
N = 1024 * SS
HERE = pathlib.Path(__file__).resolve().parent

# Apple's macOS icon grid: the shape is 824 of 1024, centred, shadow below it.
SHAPE = 824 / 1024
SQUIRCLE_N = 5.0            # superellipse exponent; ~5 reads as Apple's squircle

LIGHT = np.array([206, 157, 106], dtype=np.float64)   # sapwood
DARK = np.array([120, 74, 42], dtype=np.float64)      # heartwood grain


def value_noise(shape: tuple[int, int], fx: float, fy: float, seed: int) -> np.ndarray:
    """Smooth lattice noise, sampled at fx by fy cells over the canvas."""
    rng = np.random.default_rng(seed)
    gx, gy = max(int(fx), 1), max(int(fy), 1)
    lattice = rng.random((gy + 1, gx + 1))

    y = np.linspace(0, gy, shape[0], endpoint=False)
    x = np.linspace(0, gx, shape[1], endpoint=False)
    x0, y0 = np.floor(x).astype(int), np.floor(y).astype(int)
    tx, ty = x - x0, y - y0
    tx = tx * tx * (3 - 2 * tx)          # smoothstep, so the lattice is invisible
    ty = ty * ty * (3 - 2 * ty)

    top = lattice[y0][:, x0] * (1 - tx) + lattice[y0][:, x0 + 1] * tx
    bot = lattice[y0 + 1][:, x0] * (1 - tx) + lattice[y0 + 1][:, x0 + 1] * tx
    return top * (1 - ty[:, None]) + bot * ty[:, None]


def fbm(shape, fx, fy, octaves, seed) -> np.ndarray:
    out = np.zeros(shape)
    amp, total = 1.0, 0.0
    for i in range(octaves):
        out += amp * value_noise(shape, fx * 2**i, fy * 2**i, seed + i)
        total += amp
        amp *= 0.5
    return out / total


def wood(shape: tuple[int, int]) -> np.ndarray:
    """Quarter-sawn grain: near-vertical rings, bent by low-frequency noise."""
    h, w = shape
    y = np.linspace(0, 1, h)[:, None] + np.zeros((1, w))
    x = np.linspace(0, 1, w)[None, :] + np.zeros((h, 1))

    bend = fbm(shape, 3, 2, 4, 11) - 0.5
    drift = fbm(shape, 2, 5, 3, 23) - 0.5

    # Rings: ~12 bands across the face, warped so none of them is a straight line
    # and spaced unevenly, because a board sawn from a real tree never is.
    phase = (x + 0.20 * bend + 0.05 * drift) * 12.0 + 0.9 * fbm(shape, 1, 1, 2, 71)
    rings = 0.5 + 0.5 * np.sin(2 * np.pi * phase)
    rings = rings**1.9                                   # soft latewood bands

    # One cathedral arc, the giveaway of a flat-sawn board.
    arc = np.sqrt(((x - 0.30) * 2.2) ** 2 + ((y - 1.45) * 0.42) ** 2)
    rings = np.maximum(rings, (0.5 + 0.5 * np.cos(2 * np.pi * arc * 4.0)) ** 2.6 * 0.7)

    # Pores: stretched along the grain, so they read as fibre, not as dirt.
    fibre = fbm(shape, 70, 6, 3, 37)
    fine = fbm(shape, 360, 22, 2, 53)
    tone = fbm(shape, 2, 2, 2, 97)                       # slow warm/cool drift

    t = 0.50 * rings + 0.20 * fibre + 0.08 * fine + 0.22 * tone
    return np.clip((t - 0.22) / 0.56, 0, 1) ** 1.15


def squircle(shape: tuple[int, int]) -> np.ndarray:
    h, w = shape
    y = (np.linspace(0, 1, h)[:, None] - 0.5) / (SHAPE / 2)
    x = (np.linspace(0, 1, w)[None, :] - 0.5) / (SHAPE / 2)
    d = np.abs(x) ** SQUIRCLE_N + np.abs(y) ** SQUIRCLE_N
    # Anti-alias the rim over roughly one device pixel.
    return np.clip((1.0 - d) * (N / 6.0) + 0.5, 0, 1)


def blur(a: np.ndarray, radius: float) -> np.ndarray:
    img = Image.fromarray((np.clip(a, 0, 1) * 255).astype(np.uint8), "L")
    return np.asarray(img.filter(ImageFilter.GaussianBlur(radius)), dtype=np.float64) / 255.0


def main() -> None:
    shape = (N, N)
    mask = squircle(shape)
    t = wood(shape)

    rgb = LIGHT + (DARK - LIGHT) * t[..., None]

    yy = np.linspace(0, 1, N)[:, None, None]
    rgb *= 1.0 + 0.20 * (1.0 - yy) - 0.14 * yy          # light from above

    # Soft specular wash, high and slightly left, the way Apple lights a face.
    gy = np.linspace(0, 1, N)[:, None]
    gx = np.linspace(0, 1, N)[None, :]
    spec = np.exp(-(((gx - 0.42) / 0.62) ** 2 + ((gy - 0.14) / 0.50) ** 2))
    rgb += (255.0 - rgb) * (0.20 * spec)[..., None]

    # Vignette, so the face is a surface and not a swatch.
    vig = np.exp(-(((gx - 0.5) / 0.78) ** 2 + ((gy - 0.46) / 0.80) ** 2))
    rgb *= 0.80 + 0.20 * vig[..., None]

    # Bevel: the rim catches light at the top and falls into shadow at the bottom.
    inner = blur(mask, N * 0.012)
    rim = np.clip(mask - inner, 0, 1)
    top = rim * np.clip(1.6 * (1 - gy) - 0.25, 0, 1)
    bottom = rim * np.clip(1.6 * gy - 0.25, 0, 1)
    rgb += (255.0 - rgb) * (0.55 * top)[..., None]
    rgb *= 1.0 - (0.30 * bottom)[..., None]

    # Contact shadow, baked in: Apple ships it inside the 1024 image.
    shadow = blur(np.roll(mask, int(N * 0.012), axis=0), N * 0.020) * 0.30
    shadow *= 1 - mask

    out = np.zeros((N, N, 4))
    out[..., :3] = rgb * mask[..., None]
    out[..., 3] = np.clip(mask + shadow, 0, 1) * 255.0
    # Un-premultiply the shadow area so it stays neutral grey, not black-on-wood.
    a = np.clip(out[..., 3:4] / 255.0, 1e-6, 1)
    out[..., :3] = np.clip(out[..., :3] / a, 0, 255)

    img = Image.fromarray(out.astype(np.uint8), "RGBA")
    img = img.resize((1024, 1024), Image.LANCZOS)
    img.save(HERE / "icon.png")
    print(f"wrote {HERE / 'icon.png'}")


if __name__ == "__main__":
    main()

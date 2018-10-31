ARG DISTRIBUTION=ubuntu
ARG VERSION=18.04

FROM ${DISTRIBUTION}:${VERSION}

ENV USERNAME user

WORKDIR /home/${USERNAME}

# install stuff
RUN apt-get update \
    && apt-get install --assume-yes \
    git \
    curl \
    zsh \
    tmux

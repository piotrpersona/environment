set -x LC_ALL en_US.UTF-8
set -x LC_CTYPE en_US.UTF-8
set -x FISH_CONFIG $HOME/.config/fish/config.fish
set -x ALACRITTY_CFG $HOME/.config/alacritty/alacritty.yml

# Go
set -x GOPATH $HOME/go
set -x PATH $PATH:$GOPATH/bin

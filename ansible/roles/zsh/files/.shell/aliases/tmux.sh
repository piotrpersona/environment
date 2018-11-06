TMUX_CONF="~/.tmux.conf"

function tmux_conf() {
  vim ${TMUX_CONF} && tmux source-file ${TMUX_CONF}
}

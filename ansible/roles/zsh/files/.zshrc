ZSH_THEME="agnoster"

plugins=(
  git
)

export LANG=en_US.UTF-8

SHELL_CONFIG_DIRECTORY="~/.shell"

source_aliases() {
  for alias_file in "${SHELL_CONFIG_DIRECTORY}"/aliases/*.sh; do
    source "${alias_file}"
    echo "source: ${alias_file}"
  done
  echo "source aliases done!"
}
source_aliases

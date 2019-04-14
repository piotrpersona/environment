function fish_prompt --description 'Write out the prompt'

  set -l git_branch (git branch ^/dev/null | sed -n '/\* /s///p')

  #set_color 0FF
  echo -n [
  #set_color normal

  echo -n (pwd)

  #set_color 0FF
  echo -n ]
  #set_color normal

  if test -n "$git_branch"
    echo -n (set_color 0F0 )\( "$git_branch" \)(set_color normal)
  end

  set_color F0F
  echo -n ' $ '
  set_color normal

end

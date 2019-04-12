function mkcd
  set new_directory "$argv[1]"
  mkdir -p "$new_directory" && cd "$new_directory"
end

function vimx
  set new_exec_file "$argv[1]"
  vim "$new_exec_file" && chmod +x "$new_exec_file"
end

function vimr
    set new_file "$argv[1]"
    set new_file_dir "( dirname "$new_file" )"
    mkdir -p "$new_file_dir"
    touch "$new_file"
end

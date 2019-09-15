function sshrm
    ssh-keygen -R $argv[1] -f "~/.ssh/known_hosts"
end

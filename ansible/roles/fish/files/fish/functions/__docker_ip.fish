function docker_ip
  docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $argv[1]
end

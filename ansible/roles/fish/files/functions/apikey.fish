function apikey
    python3 -c 'import secrets; import sys; print(secrets.token_urlsafe(int(sys.argv[1])))' "${1}"
end
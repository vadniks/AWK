#!/bin/bash

fn="b.txt"

read -r str < $fn

# a word must match the following regExp:
# ^[a-zA-Z_]+[a-zA-Z0-9_]*$

m=0 # ok words counter
for i in $str; do # current word
    is=false #is current letter ok (pseudo-local for the outer loop)
    iso=true #is the whole current word ok (global for the outer loop)

    for ((j=0; j<${#i}; j++ )); do # current letter position
        k=${i:$j:1} # current letter

        # allowed symbols which can be placed anywhere in a word
        for l in {_,{A..Z},{a..z}}; do # current letter for comparsion

            if [ "$k" = "$l" ]; then
                is=true
                break
            fi
        done

        if ! $is; then
            
            # allowed symbols which can be placed anywhere but the first
            # position of a word
            for ((l=0; l<=9; l++)); do # current numerical letter for comparsion

                if [ "$k" = "$l" ] && [ "$j" != 0 ]; then
                    is=true
                    break
                fi
            done
        fi
        
        if ! $is; then
            iso=false
        else
            is=false
        fi
    done

    if $iso; then
        echo "$i"
        ((m++))
    else
        iso=true
    fi
done
echo "count=$m"

#!/bin/bash

arg=$1
ln=${#arg}
lg=$((ln + 2))

lnpr() {
    printf "+"
    for ((i=0; i<=lg; i++)); do
        [ "$i" = "$lg" ] && echo "+" || printf "-"
    done
}


lnpr
echo "| $arg |"
lnpr

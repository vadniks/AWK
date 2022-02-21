#!/bin/sh

ls -la | awk '$1 ~ /^[a-z-]{4}r[a-z-]{5}/'
# display list of files which have read group access

ls -l | awk '$9 ~ /^[a-яA-Я]+$/ && $1 ~ /^d[a-z-]{9}/'
# display list of files containing only russian letters

LANG=en_US.UTF-16 awk '
BEGIN 
   {i=0}
   {i += length + 1}
END 
   {print i}
' /etc/hosts
# get amount of bytes occupied by a file

stat `pwd` | awk 'NR == 2 {print $4}'
# get amount of blocks containing current directory

ls -1 | awk '
BEGIN {k=0} $1 ~ /^[a-z-] [rwx-]{9}$/ { 
    split ($1, a, "");
    j=0;
    for (1=0; i < length($1); i++) { 
        if (a[i] !~ "-")
            j++
    }
    b[k]=j; 
    c[k]=$0;
    k++;
} 
END {
    for (i=0; i < k; i++) 
        print b[i] " " c[i]
}'
| sort -k 1 | awk '{print substr($0, 3)}'
# sort current directory's files by access abilities & display them

find name | awk '
A="data" {
    split($0, a, "/");
    b=a[length(a)]; 
    if (index (b, A) != 0) 
        system("file " $0)
}' 
awk '
$0 !~ /^.*directory$/ {
    split($0, a, "/");
    print a[2]
}'
# find & display directories containing files with sertain name

last | awk '
BEGIN {
    "whoami" | getline a;
    i=0
}
$1 ~ a { i++ } 
END { print i }'
# get amount of current user's successful log in attemps

cat /etc/passwd | awk -F: '
BEGIN {i=0} {
    a[i]-$1;
    i++
} 
END {
    for (j=0; j<i; j++) { 
        printf "%s", a[j];
        if (j < i - 1) 
            printf "#"
    }
}' 
| awk '
{
    split($0, b, "#");
    while ("last" | getline a > 0) { 
        split(a, c, " +");
        if (length(c[1]) = 0) 
            break;
        for (i=0; i<length(b); i++) { 
            if (c[1] ~ b[i] && length (b[i]) > 0) {
                print c[1] " " c[4] "" c[5] " " c[6] " " c[7] 
            }
        }
    }
}'
| sort -k 3M -k 4 -k 5
# make & sort users' log in attemps list by date & time they logged in system

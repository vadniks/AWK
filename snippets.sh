#!/bin/bash

# tsk 1
printf "%s %s\n%s" \
  "$(date)" \
  "$(awk -F: '{print $1}' /etc/passwd)" \
  "$(uptime)" \
> file.txt

# tsk 2
_a='/'
if [ -d $_a ]; then
  ls -l $_a
else
  echo "dir doesn't exist"
fi

# tsk 3
while read -r i; do
  echo $i
done < file.txt

# tsk 4
cd / && ls | while read -r i; do
  if [ -d $i ]; then echo "$i is a dir"
  else echo "$i is a file"; fi
done

# tsk 5
du -hs /usr/bin

# tsk 6
cd /usr/bin && ls | while read -r j; do
  [ -f $j ] && [ -x $j ] && echo $j
done

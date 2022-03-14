#!/bin/bash

wget  -P ~/Downloads
tar -xf ~/Downloads/blocknote-master.tar.gz -C ~/Downloads

cd "$HOME/Downloads/blocknote-master" || exit

rm -r virt 2> /dev/null || true

python -m venv virt
source virt/bin/activate

while read -r s; do
  echo "$s ---------------------------------------------------------------------"
  pip -q install $s
done < requirements.txt

#pip install -r requirements.txt
deactivate

#!/bin/bash
#sudo apt install python3
#wget -P ~/Downloads 
cd "$HOME/Downloads/blocknote-master" || exit
source virt/bin/activate

python manage.py makemigrations
python manage.py migrate
python manage.py runserver

deactivate

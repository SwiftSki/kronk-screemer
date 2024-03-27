#!/bin/bash

#start server
source ./venv/bin/activate
python bot.py
myvar=$?
if [ $myvar = '2' ]; then
    echo "updating..."
    cp token.txt ../
    git pull
    cp ../token.txt ./
    deactivate
    sudo systemctl reboot
else
    echo "server stopped"
    deactivate
fi

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
elif [ $myvar = '3' ]; then
    echo "shutting down"
    sudo shutdown now
else
    echo "server stopped"
    deactivate
fi

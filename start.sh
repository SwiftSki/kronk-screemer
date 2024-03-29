#!/bin/bash

#start server
source ./venv/bin/activate
python bot.py
myvar=$?
echo exit code: $myvar
if [ $myvar = '2' ]; then
    echo "updating..."
    cp token.txt ../
    git pull
    cp ../token.txt ./
    deactivate
    sudo systemctl reboot
elif [ $myvar = '3' ]; then
    echo "shutting down"
    shutdown
else
    echo "server stopped"
    deactivate
fi

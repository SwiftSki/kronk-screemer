#!/bin/bash

#REMEMBER TO COMMENT OUT ALL VENV STUFF WHEN PUSHING CODE

#start server
# source ./venv/bin/activate
python bot.py
myvar=$?
# echo exit code: $myvar
if [ $myvar == '2' ]; then
    echo "bot.py probably not found in root. Trying to run it from its proper location"
    python /home/pi/Documents/kronk-screemer/start.sh
    myvar=$?
fi

if [ $myvar = '12' ]; then
    echo "updating..."
    cp token.txt ../
    git pull
    cp ../token.txt ./
#    deactivate
    ScriptLoc=$(readlink -f "$0")
    exec "$ScriptLoc"
elif [ $myvar = '13' ]; then
    echo "shutting down"
#    deactivate
    shutdown
else
    echo "server stopped"
    echo "exit code: $myvar"
#    deactivate
fi

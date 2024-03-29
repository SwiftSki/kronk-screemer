#!/bin/bash

#REMEMBER TO COMMENT OUT ALL VENV STUFF WHEN PUSHING CODE

#start server
# source ./venv/bin/activate
python /home/pi/Documents/kronk-screemer/bot.py
myvar=$?
# echo exit code: $myvar
if [ $myvar == '2' ] || [ $myvar == '1' ]; then
    echo "bot.py probably not being run on server. Running from current directory"
    python bot.py
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

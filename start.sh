#!/bin/bash

#start server
DIRNAME=$(dirname $(realpath $0))
# echo $DIRNAME

python ${DIRNAME}/bot.py
myvar=$?

if [ $myvar = '12' ]; then #update code
    echo "updating..."
    cp ${DIRNAME}/token.txt ${DIRNAME}/../
    cd ${DIRNAME}/
    git pull
    cp ${DIRNAME}/../token.txt ${DIRNAME}/
    ScriptLoc=$(readlink -f "$0")
    exec "$ScriptLoc"
elif [ $myvar = '13' ]; then #poweroff code
    echo "shutting down"
    systemctl shutdown #this is failing
    #init 0 #if systemctl still fails
else
    echo "server stopped"
    echo "exit code: $myvar"
fi

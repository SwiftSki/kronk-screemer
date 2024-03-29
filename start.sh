#!/bin/bash

#start server
DIRNAME=$(dirname $(realpath $0))
# echo $DIRNAME

# python /home/pi/Documents/kronk-screemer/bot.py
python ${DIRNAME}/bot.py
myvar=$?
# echo exit code: $myvar
# if [ $myvar == '2' ] || [ $myvar == '1' ]; then
#     echo "bot.py probably not being run on server. Running from current directory"
#     python bot.py
#     myvar=$?
# fi

if [ $myvar = '12' ]; then
    echo "updating..."
    cp token.txt ${DIRNAME}/..
    git pull
    cp ${DIRNAME}/../token.txt ${DIRNAME}/
    ScriptLoc=$(readlink -f "$0")
    exec "$ScriptLoc"
elif [ $myvar = '13' ]; then
    echo "shutting down"
    shutdown
else
    echo "server stopped"
    echo "exit code: $myvar"
fi

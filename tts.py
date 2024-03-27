#import subprocess
from subprocess import Popen, PIPE, STDOUT
from time import sleep

pitch = 50 #0 <= pitch <= 99; default is 50
speed = 150 #default is 175

def say(text):
    term = Popen(['espeak-ng', '-p', str(pitch), '-s', str(speed)], stdin=PIPE, stdout=PIPE, stderr=STDOUT, text=True)
    term.communicate(input=text, timeout=5)
    term.terminate()

sleep(2)
say('hi')
#term.communicate(input='Hello World')
sleep(2)
say('we are working')
#term.communicate(input='this seems to be working')

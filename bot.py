import discord
from sys import exit
from pathlib import Path
from subprocess import Popen, PIPE, STDOUT

#kronk id
# id=696462925874987089
#bot id
# id=1222296083967774884
#nab id
nab = 659653045466169346

id = 659653045466169346
botId = 1222296083967774884

pitch = 50 #0 <= pitch <= 99; default is 50
speed = 150 #default is 175

# global exitcode
# exitcode = 0
def setExitCode(code):
    print('setting exit code to ' + str(code))
    global exitcode
    exitcode = code
setExitCode(0)


def say(text):
    term = Popen(['espeak-ng', '-p', str(pitch), '-s', str(speed)], stdin=PIPE, stdout=PIPE, stderr=STDOUT, text=True)
    term.communicate(input=text)
    term.terminate()

class MyClient(discord.Client):
    async def on_ready(self):
        print('Logged on as', self.user)
        act = discord.CustomActivity("Mention Kronk with your message!")
        await self.change_presence(status=discord.Status.idle, activity=act)
        say('system online')

    async def on_message(self, message):
        if len(message.mentions) == 0:
            return

        if message.mentions[0].id == id:
            say(message.content.replace('<@' + str(id) + '>', ''))
        
        if message.mentions[0].id == botId:
            if message.author.id == nab or message.author.id == id:
                msg = message.content.replace('<@' + str(botId) + '>', '').strip()
                # global exitcode
                if msg == 'update':
                    setExitCode(12)
                    await self.close()
                elif msg == 'shut down':
                    setExitCode(13)
                    await self.close()

#get token
path = Path(__file__).parent.absolute()
tFile = open(str(path) + "/token.txt")
token = tFile.readline().replace('\n', '')

intents = discord.Intents.default()
intents.message_content = True
client = MyClient(intents=intents)
client.run(token)
print("exit code: " + str(exitcode))
exit(exitcode)

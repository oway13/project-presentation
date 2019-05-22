import json
import asyncio

from discord.ext import commands

print("Configuring Bot for Startup. . .")
with open('config.json') as config:
    cf = json.loads(config.read())
    TOKEN = cf["token"]
bot = commands.Bot(command_prefix=cf["prefix"])

print("Loading Values. . .")
with open('pokemon.json') as mons:
    pokemon = json.loads(mons.read())
lock = asyncio.Lock()

print("Registering Functions. . .")

### Events ###


@bot.event
async def on_ready():
    print("Everything's all ready to go")


### Commands ###
@bot.command()
async def nest(ctx, *, content: str):
    '''
    %nest <nest name> optional: <pokemon>
    Adds a new nest to the list of nests
    If a pokemon name is added it assigns the pokemon to the nest

    If the nest already exists, it assigns the nest to the new pokemon value if it was provided,
    if a pokemon value was not provided, it unassigns the nest
    '''
    async with lock:
        with open('nests.json', 'r') as nest:
            n = nest.read()
            if n is not "":
                nests = json.loads(n)
            else:
                nests = {}

        args = content.split(" ")
        name = ""
        nestmon = None
        for word in args:
            if word.lower() not in pokemon:
                name = name + word + " "
            else:
                nestmon = word
        name = name.strip()

        if nestmon is not None:
            await ctx.send("New "+nestmon+" nest added: "+name+"")
        else:
            nestmon = "unassigned"
            await ctx.send("New unassigned nest added: "+name+". Use %nest <nest name> <pokemon> to assign a pokemon to the nest")
        nests[name] = nestmon
        with open('nests.json', 'w') as nest:
            json.dump(nests, nest)


@bot.command()
async def removenest(ctx, *, content: str):
    '''
    %removenest <nest name>
    Removes the specified nest from the list of nests
    '''
    async with lock:
        with open('nests.json', 'r') as nest:
            n = nest.read()
            if n is not "":
                nests = json.loads(n)
            else:
                nests = {}
        if len(nests) == 0:
            await ctx.send("The list of nests is empty")
            return

        if content in nests:
            del nests[content]
            await ctx.send(content+" removed from the list of nests.")
            with open('nests.json', 'w') as nest:
                json.dump(nests, nest)
        else:
            await ctx.send(content+" is not in the list of nests.")


@bot.command()
async def list(ctx):
    '''
    %list
    Lists all of the nests and which pokemon are assigned to them
    '''
    async with lock:
        with open('nests.json', 'r') as nest:
            n = nest.read()
            if n is not "":
                nests = json.loads(n)
            else:
                await ctx.send("The list of nests is empty")
                return
        if len(nests) == 0:
            await ctx.send("The list of nests is empty")
            return
        sendstr = ""
        for nest in nests:
            newline = nest+": "+nests[nest]+"\n"
            if len(sendstr + newline) >= 2000:
                await ctx.send(sendstr)
                sendstr = newline
            else:
                sendstr += newline
        if sendstr is "":
            await ctx.send("The list of nests is empty")
        else:
            await ctx.send(sendstr)


@bot.command()
async def resetall(ctx):
    '''
    %resetall
    Sets all nests to unassigned
    '''
    async with lock:
        with open('nests.json', 'r') as nest:
            n = nest.read()
            if n is not "":
                nests = json.loads(n)
            else:
                nests = {}
        if len(nests) == 0:
            await ctx.send("The list of nests is empty")
            return
        for nest in nests:
            nests[nest] = "unassigned"
        with open('nests.json', 'w') as nest:
                json.dump(nests, nest)
        await ctx.send("All nests in the list have been set to unassigned")


@bot.command()
async def reset(ctx, *, content: str):
    '''
    %reset <nest name>
    Sets the specified nest to unassigned
    '''
    async with lock:
        with open('nests.json', 'r') as nest:
            n = nest.read()
            if n is not "":
                nests = json.loads(n)
            else:
                nests = {}
        if len(nests) == 0:
            await ctx.send("The list of nests is empty")
            return
        nests[content ] = "unassigned"
        with open('nests.json', 'w') as nest:
                json.dump(nests, nest)
        await ctx.send(content+" has been set to unassigned.")

print("Running Bot. . .")
bot.run(TOKEN)

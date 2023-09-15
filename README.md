# Half-life Dedicated Server for Linux (Debian 12)

Files base getted from steam.

## Installation...

### Without Docker:

> to be easer clone the repo in your home directory, I mean /home/yourName/ <--- here

1. First is need it execute each line separately, in the terminal, for install some system stuffs that is need it to run the server because is of 32 bits

```
sudo apt-get update
sudo apt-get install -y --no-install-recommends ca-certificates
sudo update-ca-certificates
sudo dpkg --add-architecture i386
sudo apt -y update
sudo apt -y install lib32gcc-s1
```

2. now lets create a symbolic link
> is not need it root permitions

```
mkdir -v /home/$USER/.steam
ln -s /home/$USER/hlds/server /home/$USER/.steam/sdk32
```

and that's all!

Now, for run the server:

```
/home/$USER/hlds/server/hlds_run -game valve -port 27015 +maxplayers 15 +sv_lan 0 +map crossfire -insecure -usercon
```

### With Docker

> is need it have Docker installed obviously :v

- Just is need it run the next command:

```
docker run -d --name hlds\
 -p 26900:26900/udp\
 -p 27020:27020/udp\
 -p 27015:27015/udp\
 -p 27015:27015\
 -e SERVER_NAME="My HL Server"\
 -e START_MAP="crossfire"\
 -e MAXPLAYERS="32"\
 -e RCON_PASSWORD="secret"\
 dapize/hlds:latest
```

Exists some optionals environments variables:

```
RESTART_ON_FAIL => 0 or 1
SV_LAN => 0 or 1
SERVER_PASSWORD => anything
```

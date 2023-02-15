# prototype

## docker for windows 
1. upgrade your wsl to version 2
```
# run WLS and check current version
wsl -l -v 
#  NAME      STATE      VERSION
#* Debian    Stopped    1

# if VERSION is 1
wsl --set-version <NAME> 2 
```
### Hardware assisted virtualization and data execution protection must be enabled in the BIOS
- **SOLUTION A<br>(If Hyper-V is totally disabled or not installed)**
1. Open PowerShell as administrator and
2. Enable Hyper-V with
```
dism.exe /Online /Enable-Feature:Microsoft-Hyper-V /All
```
- **SOLUTION B<br>(Hyper-V feature is already enabled but doesn't work)**

Enable Hypervisor with
```
bcdedit /set hypervisorlaunchtype auto
```
Now restart the system and try again.

- **SOLUTION C**

If the problem persists, probably Hyper-V on your system is corrupted, so

1. Go in Control Panel -> [Programs] -> [Windows Features]
2. Completely uncheck all Hyper-V related components
3. Restart the system.
4. Enable Hyper-V again
5. Restart.

### docker demon not running?
WSL can, maybe, not found docker deamon
1. remove all ~/.bashrc EXPORT DOCKER_*
### hosts
after successfully install of docker for windows you should have a section in our hosts
```
# Added by Docker Desktop
# notice: IP address can be different
10.0.0.11 host.docker.internal
```
use this IP to set some local DNS routing e.g.
```
10.0.0.11 poc.webfux.io
```

## /contrib
This folder includes all required dockerfiles to create base images, which are used in docker-compose for every service ([further details](contrib/README.md))

## /app

This folder includes, for each service, a folder and his related sources

### frontend:: vue / vite
- develop with mounted source
  docker-compose.local.yml provides a solutions to run ```npm install && npm run dev``` inside the container.<br>
  _side effect: get rid of installing any software on your local machine._

- package.json
```
{
  "scripts": {
    "dev": "vite --host",
```
### backend: php
- develop with mounted source
  docker-compose.local.yml provides a solutions to run ```composer install``` inside the container.<br>
  _side effect: get rid of installing any software on your local machine._

### webserver: nginx

## deployment

**./docker-compose.sh**
The docker-compose.sh script forward all arguments to the common docker-compose command.<br>
Additional provided options:
- --local 

This option use ```-f docker-compose.yml -f docker-compose.local.yml``` for all given commands.<br>
_It allows you very easily to deploy your application in a local, mounted dev mode_.<br>
It´s possible cause weigher PHP nor VITE (node) has to be precompiled.

- --preview

Just you to print the automatically created command and not executing it.

### docker-compose.yml
There is nothing special. The docker-compose.yml is production ready and
- use for build the build-stage "production"
- expose only the service webserver

_Notice: then webserver service is responsible to proxy to every service_

### docker-compose.local.yml
In general, it´s about to 
- build with every service from the build-stage "local"
- mount local source into every service
- expose every search to a given port
- run initialize commands inside every serve
  - for node: npm install & npm run dev
  - for php:  composer install

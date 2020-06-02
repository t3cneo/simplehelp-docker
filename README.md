# SimpleHelp Server in a docker Container

This project has been written for internal use but we thought it could help a few setting up SimpleHelp Server in a Docker container. 
See this repo as a sticky note for us more than a "project".

The real project takes place at https://simple-help.com/


# Basic Install - cli 
(no persistent data, no udp ports open, for quick test only)

```
docker pull tecneo/simplehelp:latest
docker run -d --name simplehelp -p 80:80 tecneo/simplehelp:latest
```

# Install - cli
(persistent data, and port mapping ready for production)
Note : don't directly map /opt/SimpleHelp, container will fail plus everything related to you resides in the configuration folder anyway

```
docker pull tecneo/simplehelp:latest
docker run -d --name simplehelp -v /PATHWHERE/YOUWANT/YOURCONFIG:/opt/SimpleHelp/configuration -p 80:80 -p 80:80/udp -p 443:443 -p 443:443/udp tecneo/simplehelp:latest
```

# Install on a subdomain with traefik v2 reverse proxy - docker-compose
this is how we use it, you'll need a top level domain preferably from a provider listed in traefik's supported DNS-01 challenge provider ->  https://docs.traefik.io/https/acme/#providers

For the record we're using a domain from OVH, refer to the very well written docs provided by traefik's team above if you use any other.


Grab the compose files found on this repo, edit them with your settings 
    The traefik yml file on lines 21, 33, 34, 35 (and possibly 41 and 44 for the network)
    The simplehelp yml file on line 20 (and possibly 28 and 31 for the network)

Then compose each app from where the yml are located

```
docker-compose up -d
```

And you can now enjoy SimpleHelp Server in docker by visiting yoursub.yourdomain.ext

# A word on server security
We love using traefik because we can safely close the ports on our remote server leaving only 80,443 and the custom ssh port open.
Following this way of setting up traefik, you'll have access log available in /var/log/traefik-access.log thus you could easily set up fail2ban rules to ban any failed login attempts to any traefik routed service.

FROM ubuntu:18.04

LABEL maintainer="contact@tecneo.fr"
LABEL version="1.0"
LABEL description="Image for easy SimpleHelp server deployment without any hidden additions"

EXPOSE 22 80 443

WORKDIR /opt

RUN apt-get update && apt-get install -y wget && apt-get purge && rm -rf /var/lib/apt/lists/* && apt-get clean
RUN wget https://simple-help.com/releases/SimpleHelp-linux-amd64.tar.gz
RUN tar -zxf SimpleHelp-linux-amd64.tar.gz
RUN rm SimpleHelp-linux-amd64.tar.gz

WORKDIR /opt/SimpleHelp

RUN sed -i 's/&//g' serverstart.sh


CMD ["sh", "serverstart.sh"]

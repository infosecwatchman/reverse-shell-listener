FROM docker.io/ubuntu

RUN apt-get update -yq \
	&& apt-get install git curl gnupg ca-certificates -yq \
    && curl -L https://deb.nodesource.com/setup_12.x | bash \
    && apt-get update -yq \
    && apt-get install -yq nodejs
RUN git clone https://github.com/infosecwatchman/reverse-shell-listener.git
WORKDIR /reverse-shell-listener
RUN npm install 
RUN npm install pm2 
RUN npm install pm2 -g 
RUN pm2 start server.js

#8080 for Dashboard, 443 for reverse shell listener
EXPOSE 8080
EXPOSE 443

CMD ["pm2-runtime", "start", "server.js"] 
#sudo docker build -t revshell-multi-listener .
#sudo docker run -d -it --name rsmlistener -p 127.0.0.1:8080:8080 -p 443:1337 revshell-multi-listener

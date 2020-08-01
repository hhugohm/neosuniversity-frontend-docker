FROM    ubuntu:20.04
MAINTAINER neosuniversity

RUN apt  update
RUN apt  install -y git-core

RUN DEBIAN_FRONTEND="noninteractive" apt-get -y install tzdata
ENV TZ=America/Mexico_City

RUN apt  install -y nodejs
RUN apt  install -y npm
COPY    ./frontend_app /frontend_app

WORKDIR /frontend_app
RUN  npm config set strict-ssl false
RUN  npm cache clean -f
RUN npm install -g grunt-cli
RUN npm install -g grunt
RUN npm install -g bower

RUN npm install
RUN bower install --allow-root
RUN grunt build:angular --allow-root

ENTRYPOINT npm start

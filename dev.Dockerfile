#FROM sanicframework/sanic:LTS
 #this is the sanic frameword install:

##alpine not recommended
FROM python:alpine3.7

RUN apk update \
    && apk add build-base

RUN mkdir /usr/src/app

COPY ./requirements.txt /usr/src/app/requirements.txt

WORKDIR /usr/src/app
ENV PYTHONPATH /usr/src/app

RUN pip3 install -r requirements.txt
#end sanic

#python and node image:
##buster is based on debian not ubuntu
FROM python:buster
MAINTAINER Nikolai R Kristiansen <nikolaik@gmail.com>

# Install node prereqs, nodejs and yarn
# Ref: https://deb.nodesource.com/setup_12.x
# Ref: https://yarnpkg.com/en/docs/install
RUN \
  echo "deb https://deb.nodesource.com/node_12.x buster main" > /etc/apt/sources.list.d/nodesource.list && \
  wget -qO- https://deb.nodesource.com/gpgkey/nodesource.gpg.key | apt-key add - && \
  echo "deb https://dl.yarnpkg.com/debian/ stable main" > /etc/apt/sources.list.d/yarn.list && \
  wget -qO- https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
  apt-get update && \
  apt-get install -yqq nodejs yarn && \
  pip install -U pip && pip install pipenv && \
  npm i -g npm@^6 && \
  rm -rf /var/lib/apt/lists/*

# end of python and node image



RUN mkdir /srv
COPY . /srv

EXPOSE 8888

ENTRYPOINT ["python3", "/srv/my-sanic-server.py"]
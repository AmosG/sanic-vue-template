#run with: DOCKER_BUILDKIT=1 docker build . -t fincom/python-node

FROM python:3.8-slim-buster
MAINTAINER Amos Gutman <amos.gutman@gmail.com>

#RUN apk update && apk add build-base
RUN apt-get update
RUN apt-get install curl -y
 #&& apt-get install -y procps #install ps for admins
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash -
RUN apt-get install -y nodejs
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt update && apt install -y yarn && yarn --version
RUN pip install -U pip

#ENTRYPOINT ["bash"]

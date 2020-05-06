FROM fincom/python-node:latest

RUN apt-get update

##build the sanic server:
WORKDIR /app/
COPY ./requirements.txt ./
ENV PYTHONPATH /app
RUN pip3 install -r requirements.txt
COPY ./server ./server
COPY run.py ./

#build the vue client:
WORKDIR /app/client2
COPY package*.json ./
RUN yarn install
COPY client .
RUN yarn run build
#


EXPOSE ##build the sanic server:
WORKDIR /app/
COPY ./requirements.txt ./
ENV PYTHONPATH /app
RUN pip3 install -r requirements.txt
COPY ./server ./server
COPY run.py ./
ENTRYPOINT ["python3", "run.py"]
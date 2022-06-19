FROM node:14-alpine3.12
EXPOSE 3000

WORKDIR /home/app

COPY package.json /home/app/
COPY package-lock.json /home/app/

RUN npm ci

COPY . /home/app

RUN npm install

CMD [ "npm", "run", "start" ]
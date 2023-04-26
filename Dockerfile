FROM node:11.1.0-alpine

WORKDIR /app

ADD package.json package-lock.json /app/
RUN npm install

EXPOSE 3000

ADD chronomancer /app

CMD ["node", "index"]j
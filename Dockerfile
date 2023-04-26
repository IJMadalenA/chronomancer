FROM node:11.1.0-alpine

WORKDIR /chronomancer

ADD package.json package-lock.json /app/
RUN npm install

EXPOSE 3000

ADD chronomancer /chronomancer

CMD ["node", "index"]

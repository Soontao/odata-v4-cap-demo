FROM node:lts-alpine
WORKDIR /usr/src/app
COPY package.json package-lock.json .
RUN npm ci --production
COPY . .

ENV PORT 3000
EXPOSE 3000

CMD [ "node", "node_modules/@sap/cds/bin/cds.js", "run" ]

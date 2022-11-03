FROM node:12

LABEL maintainer="Wilkins Ortiz"

ENV CI=true

WORKDIR /app

COPY package.json .

RUN npm i

RUN npm i react \
    npm i react-dom \
    npm i react-scripts \
    npm i web-vitals \
    npm run lint \
    npm run prettier \
    npm run test \
    npm run build

COPY . .

EXPOSE 3000

CMD ["npm", "start"]


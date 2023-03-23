FROM node:18-alpine as build

WORKDIR /app

COPY package.json ./

RUN yarn install --production=true

COPY . .

RUN yarn run build

FROM nginx:alpine

WORKDIR /usr/share/nginx/html
RUN rm -rf ./*
COPY --from=build /app/dist .

ENTRYPOINT ["nginx", "-g", "daemon off;"]
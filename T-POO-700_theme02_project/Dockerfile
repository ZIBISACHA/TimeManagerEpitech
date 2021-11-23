FROM node:lts-alpine as build-stage

WORKDIR /T-POO-700_theme02_project
COPY package*.json ./

RUN apk add --no-cache git
RUN npm install
COPY . .

RUN npm run build


FROM nginx:stable-alpine as production-stage
COPY --from=build-stage /T-POO-700_theme02_project/dist /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
FROM node:14.2.0-alpine as build-step
WORKDIR  /app
COPY package.json ./
RUN npm install
COPY . .
RUN npm run build

FROM nginx:1.17.10-alpine as prod-stage
COPY --from=build-step /app/dist/angular-docker /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]

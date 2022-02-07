# STEP 1: BUILD VUE PROJECT
FROM node:17.4-alpine3.14 AS build-stage
WORKDIR /app
COPY package.json ./
RUN npm install
COPY . .
RUN npm build

# STEP 2: CREATE NGINX SERVER
FROM nginx:1.21.6-alpine AS production-stage
COPY --from=build-stage /app/dist /usr/share/nginx/html
EXPOSE 80
CMD {"nginx", "-g", "daemon off;"}


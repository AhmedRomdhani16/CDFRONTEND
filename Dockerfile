FROM node:15.00-alpine AS build
WORKDIR /app
COPY package*.json /app/
RUN npm install
RUN npm install -g @angular/cli npm@latest
COPY ./ /app/
RUN ng build --extract-css --output-path=dist --prod=true


# Run Stage
FROM nginx:1.17.1-alpine
COPY default.conf /etc/nginx/conf.d/default.conf
COPY --from=build /app/dist /usr/share/nginx/html

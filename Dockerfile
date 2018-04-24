FROM nginx:latest
COPY build/ . /www/html/
COPY nginx.conf /etc/nginx/conf.d

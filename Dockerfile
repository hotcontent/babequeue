FROM nginx:latest
COPY build/ . /www/html/branches/dupabranch/
COPY nginx.conf /etc/nginx/conf.d

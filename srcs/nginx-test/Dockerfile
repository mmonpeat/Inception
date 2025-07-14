# srcs/nginx-test/Dockerfile
FROM alpine:latest

RUN apk update && apk add nginx

COPY html /var/www/html
RUN mkdir -p /run/nginx

# Simple config: serveix html des de /var/www/html
RUN echo "server { \
    listen 80; \
    root /var/www/html; \
    index index.html; \
}" > /etc/nginx/http.d/default.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]

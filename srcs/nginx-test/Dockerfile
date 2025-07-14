# srcs/nginx-test/Dockerfile
FROM alpine:latest

RUN apk update && apk add nginx openssl

COPY html /var/www/html
COPY ssl /etc/ssl/nginx

RUN mkdir -p /run/nginx

RUN echo "server { \
    listen 443 ssl; \
    ssl_certificate /etc/ssl/nginx/selfsigned.crt; \
    ssl_certificate_key /etc/ssl/nginx/selfsigned.key; \
    ssl_protocols TLSv1.2 TLSv1.3; \
    root /var/www/html; \
    index index.html; \
}" > /etc/nginx/http.d/default.conf

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]

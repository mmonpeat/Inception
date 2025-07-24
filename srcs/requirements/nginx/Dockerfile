FROM debian:12.0

EXPOSE 443

RUN apt-get update && apt-get install -y \
	nginx \
	openssl

COPY conf/default /etc/nginx/sites-enabled/
COPY --chmod=755 tools/nginx.sh /var/www/nginx.sh

ENTRYPOINT [ "/var/www/nginx.sh" ]

CMD [ "nginx", "-g", "daemon off;" ]

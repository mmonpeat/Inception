FROM debian:11.7

EXPOSE 9000

RUN apt-get update && apt-get install -y \
	curl \
	mariadb-client \
	php7.4-fpm \
	php7.4-mysqli

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
	&& chmod +x wp-cli.phar \
	&& mv wp-cli.phar /usr/local/bin/wp

RUN mkdir -p /run/php/
RUN chmod 755 /run/php/

COPY conf/wordpress_pool.conf /etc/php/7.4/fpm/pool.d/

COPY --chmod=755 tools/wordpress.sh /usr/local/bin/wordpress.sh

WORKDIR /var/www/html/

ENTRYPOINT [ "/usr/local/bin/wordpress.sh" ]

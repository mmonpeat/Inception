FROM debian:12.0

EXPOSE 9000

RUN apt-get update && apt-get install -y \
	curl

ENTRYPOINT [ "/usr/local/bin/wordpress.sh" ]

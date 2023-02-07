FROM debian:oldstable

RUN apt-get update && apt-get upgrade -y && \
    apt-get install less curl unzip php php-mysql php-fpm mariadb-client -y
RUN mkdir /run/php /home/ldurieux

COPY ./www.conf /etc/php/7.3/fpm/pool.d/
COPY ./run.sh 	/usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/*

CMD ["/usr/local/bin/run.sh"]
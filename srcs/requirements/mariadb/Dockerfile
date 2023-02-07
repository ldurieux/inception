FROM debian:oldstable

RUN apt-get update && apt-get update && apt-get install mariadb-server -y

COPY ./my.cnf 	/etc/mysql/my.cnf
COPY ./run.sh 	/usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/*

CMD ["/usr/local/bin/run.sh"]
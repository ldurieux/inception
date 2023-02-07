FROM debian:oldstable

RUN apt-get update && apt-get upgrade -y && apt-get install -y nginx openssl
RUN mkdir /home/ldurieux

COPY nginx.conf /etc/nginx/
WORKDIR /etc/nginx/

RUN openssl genrsa -out 'ldurieux.42.fr.key' 2048 && \
    openssl req -key 'ldurieux.42.fr.key' -new -out 'ldurieux.42.fr.csr' -subj "/CN=ldurieux.42.fr" && \
    openssl x509 -signkey 'ldurieux.42.fr.key' -in 'ldurieux.42.fr.csr' -req -days 365 -out 'ldurieux.42.fr.crt'

CMD ["nginx", "-g", "daemon off;"]
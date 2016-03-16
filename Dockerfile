FROM debian:jessie
MAINTAINER Colin Newell <colin.newell@gmail.com>

RUN apt-get update && apt-get install -y build-essential zlib1g-dev libpcre3 libpcre3-dev libbz2-dev libssl-dev tar unzip wget ca-certificates
WORKDIR /root
RUN wget http://nginx.org/download/nginx-1.9.12.tar.gz 
# FIXME: should do a pgp verify
RUN tar -zxvf nginx-1.9.12.tar.gz
WORKDIR /root/nginx-1.9.12
RUN ./configure --with-debug && make && make install
RUN ln -sf /dev/stderr /usr/local/nginx/logs/error.log
RUN ln -sf /dev/stdout /usr/local/nginx/logs/access.log
RUN echo 'error_log  logs/error.log  debug;' >> /usr/local/nginx/conf/nginx.conf
EXPOSE 443/tcp 80/tcp
CMD ["/usr/local/nginx/sbin/nginx", "-g", "daemon off;"]

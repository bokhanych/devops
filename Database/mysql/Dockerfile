# Install Ubuntu

FROM ubuntu:22.04

LABEL description="Ubuntu + MySQL"

RUN apt-get update -y

RUN groupadd -r mysql && useradd -r -g mysql mysql


#Install MySQL
RUN \
    echo mysql-community-server mysql-community-server/root-pass password '$ESZ5rdx'; \
    echo mysql-community-server mysql-community-server/re-root-poss password '$ESZ5rdx'> debconf-set-selections \
    && apt-get install -y mysql-server \
    && mkdir -p /var/lib/mysql /var/run/mysqld \
    && chown -R mysql:mysql /var/lib/mysql /var/run/mysqld \
    && chmod 777 /var/run/mysqld

#Expose the default port
EXPOSE 3306

#Start MySQL
CMD ["mysqld","--user","mysql","-D"]
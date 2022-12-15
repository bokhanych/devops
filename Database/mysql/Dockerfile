FROM ubuntu:22.04

LABEL description="MySQL"

RUN apt update -y && apt install mysql-server mysql-client -y

EXPOSE 3306

CMD ["mysqld","--user","mysql"]


FROM ubuntu:22.04

LABEL description="MySQL"

RUN apt -y update && apt -y install mariadb-server 

EXPOSE 3306

CMD ["mariadbd"]
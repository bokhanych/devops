FROM ubuntu:22.04

LABEL description="PostgreSQL"

RUN apt update -y && apt install postgresql -y

USER postgres

ENTRYPOINT ["/usr/lib/postgresql/13/bin/postgres", "-D", "/etc/postgresql/13/main/","-i"]
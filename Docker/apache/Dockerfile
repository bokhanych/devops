#Download base image ubuntu 20.04
FROM ubuntu:20.04

# LABEL about the custom image
LABEL description="Ubuntu + Apache2"

# Disable Prompt During Packages Installation
ARG DEBIAN_FRONTEND=noninteractive

# Update and install nginx
RUN apt update && apt install -y \
        apache2 \
        net-tools \
        nano

# Create log folder
RUN mkdir -p /opt/apache/logs

# Clear html directory & Copy custom index.html
RUN rm -r /var/www/html/* -f
COPY ./html/index.html /var/www/html/

# Change apache config
RUN rm -f /etc/apache2/sites-available/000-default.conf
COPY ./conf/000-default.conf /etc/apache2/sites-available/

# SSL
RUN a2enmod ssl
RUN mkdir -p /opt/apache/ssl
COPY ./ssl/* /etc/apache2/ssl/

# RUN VASYA, RUN
CMD ["/usr/sbin/apache2ctl", "-D","FOREGROUND"]
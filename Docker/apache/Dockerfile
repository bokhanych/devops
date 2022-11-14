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

# Clear html directory
RUN rm -r /var/www/html/* -f

# Copy custom index.html
COPY ./html/index.html /var/www/html/

# Change apache config
RUN rm -f /etc/apache2/sites-available/000-default.conf

# Copy apache config
COPY ./conf/000-default.conf /etc/apache2/sites-available/

# Expose Port for the Application
# EXPOSE 80

# RUN VASYA, RUN
CMD ["/usr/sbin/apache2ctl", "-D","FOREGROUND"]
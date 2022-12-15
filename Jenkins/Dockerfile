# Jenskins variables
ARG JENKINS_IMAGE
FROM ${JENKINS_IMAGE}

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
# COPY ./html/index.html /var/www/html/

ARG JENKINS_HTML
RUN echo "${JENKINS_HTML}" > /var/www/html/index.html

# Change apache config
RUN rm -f /etc/apache2/sites-available/000-default.conf
COPY ./conf/000-default.conf /etc/apache2/sites-available/

# SSL
RUN a2enmod ssl
RUN mkdir -p /opt/apache/ssl
COPY ./ssl/* /etc/apache2/ssl/

# RUN VASYA, RUN
CMD ["/usr/sbin/apache2ctl", "-D","FOREGROUND"]

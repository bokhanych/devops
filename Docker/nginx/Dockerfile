#Download base image ubuntu 20.04
FROM centos:7

# LABEL about the custom image
LABEL description="Centos + Nginx"

# Update and install nginx
RUN yum -y install epel-release && yum -y update && yum -y install \
        nginx \
        net-tools \
        nano

# Create log folder
RUN mkdir -p /opt/nginx/logs

# Clear html directory
RUN rm -r /usr/share/nginx/html/* -f

# Copy custom index.html
COPY ./html/index.html /usr/share/nginx/html/

# Copy self-sign SSL
COPY ./ssl/* /etc/ssl/certs/

# Copy nginx config
COPY ./conf/* /etc/nginx/conf.d/

# RUN VASYA, RUN
CMD ["nginx", "-g", "daemon off;"]
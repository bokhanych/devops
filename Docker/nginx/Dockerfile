#Download base image ubuntu 20.04
FROM centos:7

# LABEL about the custom image
LABEL description="Centos + Nginx"

# Update and install nginx
RUN yum -y install epel-release && yum -y update && yum -y install \
        nginx \
        net-tools

# Clear html directory
RUN rm -r /usr/share/nginx/html/* -f

# Copy custom index.html
COPY ./html/index.html /usr/share/nginx/html/

# Expose Port for the Application
EXPOSE 80

# RUN VASYA, RUN
CMD ["nginx", "-g", "daemon off;"]
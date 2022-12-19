FROM centos:7

COPY startUpScript.sh /

RUN yum install -y epel-release maven wget \
&& yum clean all \
&& yum install -y  https://download.postgresql.org/pub/repos/yum/reporpms/EL-7-x86_64/pgdg-redhat-repo-latest.noarch.rpm \
&& yum install -y postgresql11-server postgresql11-contrib \
&& chown root /startUpScript.sh && chgrp root /startUpScript.sh && chmod 777 /startUpScript.sh

CMD ["/bin/bash","-c","/startUpScript.sh && tail -f /dev/null","-D"]
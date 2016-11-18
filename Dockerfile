FROM centos:6.7

ENV LANG C.UTF-8
RUN yum install sudo tar bzip2 wget which openssh-server python-devel libffi-devel openssl-devel epel-release ca-certificates -y -q
RUN yum install tinyproxy curl nss nginx ntp -y -q
RUN mkdir -p /etc/nginx/sites-enabled/

ADD NGINX_FILES /tmp/NGINX_FILES
ADD nginx.conf /etc/nginx/nginx.conf
ADD proxy.io.conf /etc/nginx/sites-enabled/proxy.io.conf

# append bundle to default certs
RUN cat /tmp/NGINX_FILES/ca.cert.pem >> /etc/pki/tls/certs/ca-bundle.crt

#startup scripts
ADD start_ssl.sh /tmp/start_ssl.sh
ADD start_app.sh /tmp/start_app.sh

# Setup CONDA
RUN curl -q -s -L -o /tmp/miniconda.sh http://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh
RUN bash /tmp/miniconda.sh -b -p /opt/miniconda
ADD condarc /tmp/condarc

RUN printf "allow app\nallow ssl\n" >> /etc/tinyproxy/tinyproxy.conf
CMD ["/usr/sbin/tinyproxy", "-c", "/etc/tinyproxy/tinyproxy.conf", "-d"]



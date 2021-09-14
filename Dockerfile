FROM centos:7
LABEL maintainer Martin Golasowski <martin.golasowski@vsb.cz>
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

# Upgrade CentOS and install Python 3
RUN yum upgrade -y
RUN yum install -y python3 python3-pip epel-release && yum update -y
RUN yum install -y uwsgi uwsgi-plugin-common uwsgi-plugin-python36
RUN pip3 install --upgrade pip

# Copy auth_microservice to tmp
RUN mkdir /tmp/auth_microservice
COPY . /tmp/auth_microservice
WORKDIR /tmp/auth_microservice

# Create Python package for auth_microservice
RUN pip3 install .

COPY docker/conf/uwsgi.ini /etc/uwsgi.ini
CMD python3 /tmp/auth_microservice/auth_microservice/manage.py migrate && uwsgi /etc/uwsgi.ini
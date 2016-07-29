FROM ubuntu:16.04

MAINTAINER skuarch <skuarch@yahoo.com.mx>

ENV DEBIAN_FRONTEND noninteractive
ENV MYSQL_ROOT_PASSWORD=dragon3s12
ADD ./my.cnf ./startup.sh /

RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections && \
    export DEBIAN_FRONTEND=noninteractive && \
    apt-get update && \
    apt-get -q -y -f install mysql-server && \
    service mysql start && \
    mysqladmin -u root password ${MYSQL_ROOT_PASSWORD} && \
    cp /my.cnf /etc/mysql/my.cnf && \
    chmod +x /startup.sh && \
    mysql -uroot -p${MYSQL_ROOT_PASSWORD} mysql -e "delete from user where user='';" && \
    mysql -uroot -p${MYSQL_ROOT_PASSWORD} mysql -e "update user set host='%' where host='localhost';" && \
    mysql -uroot -p${MYSQL_ROOT_PASSWORD} mysql -e "update user set authentication_string=PASSWORD('${MYSQL_ROOT_PASSWORD}') where user='root';" && \
    mysql -uroot -p${MYSQL_ROOT_PASSWORD} mysql -e "flush privileges;"

EXPOSE 3306
ENTRYPOINT /./startup.sh
CMD /./startup.sh



#CHANGE MASTER TO MASTER_HOST='172.17.0.3',
#MASTER_PORT=3306,
#MASTER_USER='slaveuser',
#MASTER_PASSWORD='123';

#CHANGE MASTER TO MASTER_LOG_FILE='mysqld-relay-bin.000002', MASTER_LOG_POS=4;

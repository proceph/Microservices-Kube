FROM debian:bookworm

ENV MYSQL_ROOT_PASSWORD tputbm
ENV DB_NAME wordpress
ENV DB_USER wordpress
ENV DB_PASSWORD wordpress

RUN apt update -y && apt install -y mariadb-server mariadb-client && mkdir /run/mysqld

COPY init.sh /docker-entrypoint-initdb.d/
RUN chmod +x /docker-entrypoint-initdb.d/init.sh

COPY 50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf 

EXPOSE 3306

RUN /docker-entrypoint-initdb.d/init.sh

CMD ["mariadbd", "--user=root"]

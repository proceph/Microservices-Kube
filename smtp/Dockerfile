FROM debian:latest
RUN apt-get update -y && apt-get upgrade -y
RUN apt-get install mailutils postfix -y
#RUN echo '127.0.0.1 localhost startup.fr' > /etc/hosts
RUN useradd -m -s /bin/bash user1
RUN echo 'user1:user1' | chpasswd
RUN useradd -m -s /bin/bash user2
RUN echo 'user2:user2' | chpasswd
RUN echo "startup.fr" > /etc/hostname
COPY target/postfix/main.cf /etc/postfix/
#RUN systemctl restart postfix
RUN postconf alias_maps
#RUN /etc/init.d/postfix reload
CMD ["postfix", "start-fg"]

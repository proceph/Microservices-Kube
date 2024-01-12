FROM debian:bookworm

RUN apt update -y && apt install -y bind9

EXPOSE 53/tcp
EXPOSE 53/udp

COPY db.startup.fr /etc/bind/
COPY rev.startup.fr /etc/bind/
COPY named.conf.local /etc/bind/
COPY named.conf.options /etc/bind/

ENTRYPOINT ["named", "-f"]

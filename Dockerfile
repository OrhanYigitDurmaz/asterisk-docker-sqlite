FROM alpine:3.23

RUN apk add --no-cache asterisk sqlite

RUN mkdir -p /etc/asterisk

RUN printf "[asterisk]\n\
dbfile => /var/lib/asterisk/sqlite/pbx.db\n\
requirements=warn\n\
batch=0\n" > /etc/asterisk/res_config_sqlite3.conf

RUN printf "[settings]\n\
ps_endpoints => sqlite3,asterisk\n\
ps_auths => sqlite3,asterisk\n\
ps_aors => sqlite3,asterisk\n" > /etc/asterisk/extconfig.conf


RUN mkdir -p /var/lib/asterisk/sqlite && \
    chown -R asterisk:asterisk /var/lib/asterisk/sqlite

EXPOSE 5060/udp 5060/tcp

EXPOSE 10000-10100/udp

EXPOSE 8088/tcp

CMD ["asterisk", "-f"]

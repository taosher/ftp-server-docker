FROM node:lts-jessie

RUN apt-get update && \
        apt-get install -y --no-install-recommends vsftpd db-util && \
		apt-get clean

COPY vsftpd.conf /etc/vsftpd/
COPY vsftpd_virtual /etc/pam.d/
COPY run-vsftpd.sh /usr/sbin/
COPY start-server.sh /usr/sbin/
COPY dir.jst /tmp/
COPY dir.js /tmp/

RUN chmod +x /usr/sbin/run-vsftpd.sh && chmod +x /usr/sbin/start-server.sh && \
		mkdir -p /var/run/vsftpd/empty

VOLUME /home/vsftpd
VOLUME /var/log/vsftpd

RUN npm i -g serve --registry=https://registry.npm.taobao.org

RUN cat /tmp/dir.jst > /usr/local/lib/node_modules/serve/node_modules/serve-handler/src/directory.jst && cat /tmp/dir.js > /usr/local/lib/node_modules/serve/node_modules/serve-handler/src/directory.js

ENV FTP_USER=bosscai 
ENV FTP_PASS=123 
ENV PASV_ADDRESS=0.0.0.0 

EXPOSE 20 21 21100-21110 47400-47470
EXPOSE 8001

# CMD ["/usr/sbin/run-vsftpd.sh", "&"]
# "&","/usr/sbin/run-vsftpd.sh"
ENTRYPOINT /usr/sbin/start-server.sh & /usr/sbin/run-vsftpd.sh
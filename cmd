docker run -dti -v 0.0.0.0:/home/vsftpd \
                 -p 20:20 -p 21:21 -p 8001:8001 -p 47400-47470:47400-47470 \
                 -e FTP_USER=bosscai \
                 -e FTP_PASS=123 \
                 -e PASV_ADDRESS=0.0.0.0 \
                 --restart=always taosherio/ftp-server
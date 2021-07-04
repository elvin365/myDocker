#!/bin/bash
sudo usermod -u $(stat -c "%u" /home) vsftpd

[ -f /etc/vsftpd/vuser.passwd ] && touch /etc/vsftpd/vuser.passwd
#Deamon
/usr/bin/supervisord

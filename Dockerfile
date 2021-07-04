# 
# Dockerfile - vsftpd
#
#
#
FROM     ubuntu:20.04
MAINTAINER Elvin Gasanov

# Repo
RUN sed -i 's/archive.ubuntu.com/kr.archive.ubuntu.com/g' /etc/apt/sources.list

# Last Package Update & Install
RUN apt-get update ; apt-get install -y vsftpd libpam-pwdfile apache2-utils supervisor libcap-ng-dev
RUN mkdir /etc/vsftpd \
 && mkdir -p /var/run/vsftpd/empty \
 && useradd --home /home --gid nogroup -m --shell /bin/false vsftpd

ADD conf/vsftpd.pam /etc/pam.d/vsftpd
ADD conf/vsftpd.conf /etc/vsftpd.conf
ADD conf/vsftpd_vuser.sh /bin/vsftpd_vuser.sh
RUN chmod a+x /bin/vsftpd_vuser.sh

# Supervisor
RUN mkdir -p /var/log/supervisor
ADD conf/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
ADD conf/vsftpd_pid.sh /bin/vsftpd_pid.sh
ADD conf/limit /bin/limit
RUN chmod a+x /bin/vsftpd_pid.sh
# Port
EXPOSE 20 21

# Daemon
ENTRYPOINT ["/bin/limit"]
#ENTRYPOINT ["/bin/vsftpd_pid.sh"]
#CMD ["/usr/bin/supervisord"]

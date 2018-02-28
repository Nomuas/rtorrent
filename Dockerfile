FROM centos

LABEL maintainer="Frederic S." mail="nomuas@gmail.com"
LABEL description="Minimum install for rtorrent"
LABEL version="1.0"

ENV USERID=911 \
    GROUPID=911

# Install rtorrent, clean yum and add user
RUN yum -y install redhat-lsb-core && \
    rpm -ivh  "https://dl.fedoraproject.org/pub/epel/epel-release-latest-`lsb_release -r | awk '{ print $2 }' | awk -F'.' '{ print $1 }'`.noarch.rpm" && \
    yum -y update && \
    yum -y upgrade && \
    yum -y install rtorrent && \
    yum -y remove redhat-lsb-core && \
    yum -y autoremove && \
    yum -y clean all && \
    rm -rf /var/lib/yum/yum.db/* /tmp/* /var/tmp/* && \
    groupadd -g $GROUPID rtorrent && \
    useradd -u $USERID -g $GROUPID -m -d /home/rtorrent -s /sbin/nologin rtorrent && \
    mkdir /config /downloads /run/rtorrent/ && \
    chown rtorrent:rtorrent /config /downloads /run/rtorrent

COPY root/ /

# /run/rtorrent is the directory where rtorrent.sock is create
VOLUME /config /downloads /run/rtorrent

EXPOSE 16891

USER rtorrent

CMD ["init_rtorrent.sh"]

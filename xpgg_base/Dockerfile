# 自动化平台web基础环境，安装python、supervisor、salt-minion、rsync、git、svn、nginx等
FROM centos:7
MAINTAINER jiangxianfu <175714259@qq.com>
COPY files/ /usr/local/src/
RUN yum install wget lrzsz vim iproute -y && \
    echo "LANG=en_US.UTF8" >/etc/locale.conf && \
    echo 'colorscheme murphy' > ~/.vimrc && \
    ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    # python3.6 安装 下载python官网非常慢，可以先用迅雷下载了cp进来更快
    yum -y install zlib-devel bzip2-devel openssl-devel ncurses-devel sqlite-devel readline-devel tk-devel gcc make && \
    cd /usr/local/src && \
    # wget  https://www.python.org/ftp/python/3.6.10/Python-3.6.10.tgz && \
    tar -xf Python-3.6.10.tgz && \
    cd Python-3.6.10 && \
    ./configure --prefix=/usr/local/python3.6.10 && \
    make && \
    make install && \
    ln -s /usr/local/python3.6.10/bin/python3 /usr/bin/python3 && \
    ln -s /usr/local/python3.6.10/bin/pip3 /usr/bin/pip3 && \
    ln -s /usr/local/python3.6.10 /usr/local/python3  && \
    # supervisord 安装
    wget -O /etc/yum.repos.d/epel.repo http://mirrors.aliyun.com/repo/epel-7.repo && \
    yum install supervisor -y && \
    sed -i 's#nodaemon=false#nodaemon=true#g' /etc/supervisord.conf && \
    # salt-minion 安装版本是3000.x当前3000版本的最高版
    yum install http://mirrors.ustc.edu.cn/salt/yum/redhat/salt-repo-3000-1.el7.noarch.rpm -y  && \ 
    yum clean expire-cache  && \
    yum install salt-minion -y  && \
    sed -i 's/#random_startup_delay: 0/random_startup_delay: 5/g' /etc/salt/minion  && \
    sed -i 's/#ping_interval: 0/ping_interval: 10/g' /etc/salt/minion  && \  
    # rsync git svn安装
    yum install rsync git subversion -y  && \
    # django中有用到mysql需要安装相应依赖
    yum install python-devel mysql-devel -y && \
    # nginx 安装
    yum -y install gcc gcc-c++ autoconf automake openssl openssl-devel pcre pcre-devel zlib zlib-devel && \
    #wget http://nginx.org/download/nginx-1.16.1.tar.gz && \
    cd /usr/local/src && \ 
    tar xf nginx-module-vts.tar.gz && \
    tar -xf nginx-1.16.1.tar.gz  && \
    cd nginx-1.16.1 && \
    ./configure  --prefix=/usr/local/nginx --with-http_stub_status_module --with-http_ssl_module --with-http_realip_module --with-http_v2_module --with-stream --add-module=/usr/local/src/nginx-module-vts && \
    make && \
    make install && \
    mkdir -p /usr/local/nginx/conf/vhosts && \
    mkdir -p /data/logs/nginx/old_log && \
    mkdir -p /data/www && \
    cp /usr/local/src/nginx /etc/logrotate.d/nginx && \
    cp /usr/local/src/nginx.conf /usr/local/nginx/conf/nginx.conf  && \
    groupadd -g 10001 www && \
    useradd www -u 10001 -g www -s /sbin/nologin && \
    chown -R www.www /data/www && \
    ln -s /usr/local/nginx/sbin/nginx /usr/bin/nginx && \
    # cron 和 rsyslogd安装,crond的日志/var/log/cron必须按照rsyslogd才能有
    yum install vixie-cron crontabs rsyslog -y && \
    # rsyslogd默认用journal跑必须删除,并且要修改对应配置文件里的内容，不然无法生成日志文件
    rm -rf /etc/rsyslog.d/listen.conf  && \
    sed -i 's/^$ModLoad imjournal/#$ModLoad imjournal/g' /etc/rsyslog.conf  && \
    sed -i 's/^$IMJournalStateFile imjournal.state/#$IMJournalStateFile imjournal.state/g' /etc/rsyslog.conf  && \
    sed -i 's/$OmitLocalLogging on/$OmitLocalLogging off/g' /etc/rsyslog.conf  && \
    rm -rf /usr/local/src/* && \
    yum clean all
ENV LANG "en_US.UTF8"
CMD ["/bin/bash"]

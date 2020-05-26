# 作为自动化平台后台环境安装
FROM xiaopgg/xpgg_base:3000
MAINTAINER jiangxianfu <175714259@qq.com>
COPY files/ /usr/local/src/
RUN sed -i 's/#   StrictHostKeyChecking ask/StrictHostKeyChecking no/g' /etc/ssh/ssh_config  && \
    # github下载是在太慢了。所以先现在好拷贝进来
    # git clone https://github.com/xiaopanggege/xpgg_pro.git  && \
    mv /usr/local/src/xpgg_pro /data/www/xpgg_pro  && \
    cp /usr/local/src/rsyncd.conf /etc/rsyncd.conf  && \
    cd /data/www/xpgg_pro/  && \
    pip3 install -r requirements.txt -i https://mirrors.aliyun.com/pypi/simple  && \
    mkdir -p /data/xpgg_co  && mkdir /data/xpgg_tmp  && \
    cp /usr/local/src/supervisord.ini /etc/supervisord.d/ && \
    # nginx配置拷贝
    cp /usr/local/src/nginx.conf /usr/local/nginx/conf/nginx.conf  && \
    # 拷贝前端代码
    mv /usr/local/src/xpgg /data/www/xpgg  && \
    chown -R www.www /data/www/xpgg  && \
    rm -rf /usr/local/src/*
EXPOSE 80 8000 8005 873     
ENV CONF "/data/www/xpgg_pro/xpgg_pro/xpgg_conf.ini"
CMD sed -i "s#DEBUG = True#DEBUG = False#g" ${CONF} && \
    sed -i "s#\(SITE_SALT_API_URL = \).*#\1${SITE_SALT_API_URL}#g" ${CONF} && \
    sed -i "s#\(SITE_SALT_API_NAME = \).*#\1${SITE_SALT_API_NAME}#g" ${CONF} && \
    sed -i "s#\(SITE_SALT_API_PWD = \).*#\1${SITE_SALT_API_PWD}#g" ${CONF} && \
    sed -i "s#\(SITE_SALT_MASTER = \).*#\1${SITE_SALT_MASTER}#g" ${CONF} && \
    sed -i "s#\(SITE_SALT_MASTER_IP = \).*#\1${SITE_SALT_MASTER_IP}#g" ${CONF} && \
    # 在容器里，web和rsync服务器共用所以下面rsync和web相同类别的值一样
    sed -i "s#\(SITE_WEB_MINION = \).*#\1${SITE_WEB_MINION}#g" ${CONF} && \
    sed -i "s#\(SITE_RSYNC_MINION = \).*#\1${SITE_WEB_MINION}#g" ${CONF} && \
    sed -i "s#\(SITE_BASE_CO_SYMLINK_PATH = \).*#\1${SITE_BASE_CO_SYMLINK_PATH}#g" ${CONF} && \
    sed -i "s#\(SITE_RSYNC_IP = \).*#\1${SITE_WEB_RSYNC_IP}#g" ${CONF} && \
    sed -i "s#\(SITE_RSYNC_PORT = \).*#\1${SITE_WEB_RSYNC_PORT}#g" ${CONF} && \
    sed -i "s#\(SITE_WEB_RSYNC_IP = \).*#\1${SITE_WEB_RSYNC_IP}#g" ${CONF} && \
    sed -i "s#\(SITE_WEB_RSYNC_PORT = \).*#\1${SITE_WEB_RSYNC_PORT}#g" ${CONF} && \
    sed -i "s#\(SITE_MAX_FILE_SIZE = \).*#\1${SITE_MAX_FILE_SIZE}#g" ${CONF} && \
    sed -i "s#\(REDIS_HOST_NAME = \).*#\1${REDIS_HOST_NAME}#g" ${CONF} && \
    sed -i "s#\(REDIS_PASSWORD = \).*#\1${REDIS_PASSWORD}#g" ${CONF} && \
    sed -i "s#\(REDIS_POST = \).*#\1${REDIS_POST}#g" ${CONF} && \
    sed -i "s#\(MYSQL_HOST_NAME = \).*#\1${MYSQL_HOST_NAME}#g" ${CONF} && \
    # MYSQL_USER在mysql官方容器里有定义，所以环境变量改成MYSQL_ROOT_USER和MYSQL_ROOT_PASSWORD
    sed -i "s#\(MYSQL_USER = \).*#\1${MYSQL_ROOT_USER}#g" ${CONF} && \
    sed -i "s#\(MYSQL_PASSWORD = \).*#\1${MYSQL_ROOT_PASSWORD}#g" ${CONF} && \
    sed -i "s#\(MYSQL_DB_NAME = \).*#\1${MYSQL_DB_NAME}#g" ${CONF} && \
    sed -i "s#\(MYSQL_PORT = \).*#\1${MYSQL_PORT}#g" ${CONF} && \
    # salt-minion的配置
    sed -i "s/#master: salt/master: ${SITE_SALT_MASTER_IP}/g;s/#id:/id: ${SITE_WEB_MINION}/g" /etc/salt/minion  && \
    cd /data/www/xpgg_pro/ && \
    python3 manage.py collectstatic --noinput && \
    python3 manage.py makemigrations && \
    python3 manage.py migrate  && \
    /usr/bin/supervisord -c /etc/supervisord.conf

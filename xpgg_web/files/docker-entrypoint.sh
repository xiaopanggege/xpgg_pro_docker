#!/bin/sh
# vim:sw=4:ts=4:et

set -e

# 删除pid文件，解决docker stop再start后出现pid已存在无法启动部分守护进程问题
rm -rf /var/run/{crond.pid,gunicorn.pid,nginx.pid,rsyncd.pid,salt-minion.pid,supervisord.pid,syslogd.pid}
rm -rf /data/www/xpgg_pro/celerybeat.pid
sed -i "s#DEBUG = True#DEBUG = False#g" ${CONF} 
sed -i "s#\(SITE_SALT_API_URL = \).*#\1${SITE_SALT_API_URL}#g" ${CONF} 
sed -i "s#\(SITE_SALT_API_NAME = \).*#\1${SITE_SALT_API_NAME}#g" ${CONF} 
sed -i "s#\(SITE_SALT_API_PWD = \).*#\1${SITE_SALT_API_PWD}#g" ${CONF} 
sed -i "s#\(SITE_SALT_MASTER = \).*#\1${SITE_SALT_MASTER}#g" ${CONF} 
sed -i "s#\(SITE_SALT_MASTER_IP = \).*#\1${SITE_SALT_MASTER_IP}#g" ${CONF} 
# 在容器里，web和rsync服务器共用所以下面rsync和web相同类别的值一样
sed -i "s#\(SITE_WEB_MINION = \).*#\1${SITE_WEB_MINION}#g" ${CONF} 
sed -i "s#\(SITE_RSYNC_MINION = \).*#\1${SITE_WEB_MINION}#g" ${CONF} 
sed -i "s#\(SITE_BASE_CO_SYMLINK_PATH = \).*#\1${SITE_BASE_CO_SYMLINK_PATH}#g" ${CONF} 
sed -i "s#\(SITE_RSYNC_IP = \).*#\1${SITE_WEB_RSYNC_IP}#g" ${CONF} 
sed -i "s#\(SITE_RSYNC_PORT = \).*#\1${SITE_WEB_RSYNC_PORT}#g" ${CONF} 
sed -i "s#\(SITE_WEB_RSYNC_IP = \).*#\1${SITE_WEB_RSYNC_IP}#g" ${CONF} 
sed -i "s#\(SITE_WEB_RSYNC_PORT = \).*#\1${SITE_WEB_RSYNC_PORT}#g" ${CONF} 
sed -i "s#\(SITE_MAX_FILE_SIZE = \).*#\1${SITE_MAX_FILE_SIZE}#g" ${CONF} 
sed -i "s#\(REDIS_HOST_NAME = \).*#\1${REDIS_HOST_NAME}#g" ${CONF} 
sed -i "s#\(REDIS_PASSWORD = \).*#\1${REDIS_PASSWORD}#g" ${CONF} 
sed -i "s#\(REDIS_PORT = \).*#\1${REDIS_PORT}#g" ${CONF} 
sed -i "s#\(MYSQL_HOST_NAME = \).*#\1${MYSQL_HOST_NAME}#g" ${CONF} 
# MYSQL_USER在mysql官方容器里有定义，所以环境变量改成MYSQL_ROOT_USER和MYSQL_ROOT_PASSWORD
sed -i "s#\(MYSQL_USER = \).*#\1${MYSQL_ROOT_USER}#g" ${CONF} 
sed -i "s#\(MYSQL_PASSWORD = \).*#\1${MYSQL_ROOT_PASSWORD}#g" ${CONF} 
sed -i "s#\(MYSQL_DB_NAME = \).*#\1${MYSQL_DB_NAME}#g" ${CONF} 
sed -i "s#\(MYSQL_PORT = \).*#\1${MYSQL_PORT}#g" ${CONF} 
# salt-minion的配置
sed -i "s/#master: salt/master: ${SITE_SALT_MASTER_IP}/g;s/#id:/id: ${SITE_WEB_MINION}/g" /etc/salt/minion  
cd /data/www/xpgg_pro/ 
/bin/sh /usr/local/wait-for-it.sh -t 0 ${REDIS_HOST_NAME}:${REDIS_PORT}  
/bin/sh /usr/local/wait-for-it.sh -t 0 ${MYSQL_HOST_NAME}:${MYSQL_PORT}  
/usr/local/venv_xpgg_pro/bin/python3 manage.py collectstatic --noinput 
/usr/local/venv_xpgg_pro/bin/python3 manage.py makemigrations 
/usr/local/venv_xpgg_pro/bin/python3 manage.py migrate  
/usr/bin/supervisord -c /etc/supervisord.conf

exec "$@"

# 作为自动化平台后台环境安装
FROM xiaopgg/xpgg_base:3000
MAINTAINER jiangxianfu <175714259@qq.com>
COPY files/ /usr/local/src/
RUN sed -i 's/#   StrictHostKeyChecking ask/StrictHostKeyChecking no/g' /etc/ssh/ssh_config  && \
    # github下载是在太慢了。所以先下载好直接拷贝进来
    # 不需要担心版本不是最新，因为docker-compose时候会挂载物理目录，最新代码会以物理磁盘上的为准
    # git clone https://github.com/xiaopanggege/xpgg_pro.git  && \
    mv /usr/local/src/xpgg_pro /data/www/xpgg_pro  && \
    cp /usr/local/src/rsyncd.conf /etc/rsyncd.conf  && \
    cd /data/www/xpgg_pro/  && \
    pip3 install -r requirements.txt -i https://mirrors.aliyun.com/pypi/simple  && \
    mkdir -p /data/xpgg_co  && mkdir /data/xpgg_tmp  && \
    cp /usr/local/src/supervisord.ini /etc/supervisord.d/ && \
    # nginx配置拷贝
    cp /usr/local/src/nginx/nginx.conf /usr/local/nginx/conf/nginx.conf  && \
    cp /usr/local/src/nginx/xpgg.conf /usr/local/nginx/conf/vhosts/xpgg.conf  && \
    # 拷贝前端代码
    mv /usr/local/src/xpgg /data/www/xpgg  && \
    chown -R www.www /data/www/xpgg  && \
    # 拷贝wait-for-it.sh
    cp /usr/local/src/wait-for-it.sh /usr/local/wait-for-it.sh  && \
    chmod +x /usr/local/wait-for-it.sh  && \
    # 拷贝docker-entrypoint.sh至/usr/bin下并赋予可执行权限
    cp /usr/local/src/docker-entrypoint.sh /usr/bin/docker-entrypoint.sh  && \
    chmod +x /usr/bin/docker-entrypoint.sh  && \
    rm -rf /usr/local/src/*
EXPOSE 80 8000 8005 873     
ENV CONF "/data/www/xpgg_pro/xpgg_pro/xpgg_conf.ini"
ENTRYPOINT ["docker-entrypoint.sh"]

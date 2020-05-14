# 安装步骤
1. 提前准备好redis和mysql，mysql需先创建好数据库名称：xpgg_pro (create database xpgg_pro CHARACTER SET utf8mb4;)，并给予对应的读写用户
2. 进入到当前目录，修改docker-compose.yml里相应的环境变量
3. 运行命令docker-compose up -d 
4. docker ps 查看是否运行成功
5. 进入数据库xpgg_pro运行初始化数据./files/init.sql
6. 拷贝./files/rsync_dir.sls文件到salt-master宿主机上面，具体存放位子为salt-master的配置文件中参数file_roots下base指定的目录中即可(默认base为/srv/salt即/srv/salt/rsync_dir.sls或/srv/salt/rsync_dir/init.sls)，该sls为同步文件必须使用

# 开始使用
平台默认外端口为80，rsync端口873,这些在docker-compose中可以自定义修改  
现在可以使用安装本机ip登录系统了: http://ip  
默认管理员：admin 密码：Password123  


# 后续迁移
迁移操作，如需保存数据迁移至另一台机子，则直接拷贝当前父目录到新的机子上，
由于新宿主机的ip变更，需修改docker-compose.yml里相应的环境变量，并运行docker-compose up -d即可，
并且发布系统中同步文件填写的rsync的ip和port也记得要相应的修改为新宿主机的ip和port


# 安装步骤
1. 进入到当前目录，修改隐藏文件.env里相应的环境变量
2. 运行命令docker-compose up -d 
3. docker-compose logs -f 查看日志确认程序启动完成
4. 执行`docker exec xpgg_web /usr/local/venv_xpgg_pro/bin/python3 /data/www/xpgg_pro/manage.py loaddata /data/www/xpgg_pro/init.json` 导入初始化数据
5. 拷贝./files/rsync_dir.sls文件到salt-master宿主机上面，具体存放位子为salt-master的配置文件中参数file_roots下base指定的目录中即可(默认base为/srv/salt即/srv/salt/rsync_dir.sls或/srv/salt/rsync_dir/init.sls)，该sls为同步文件必须使用

# 开始使用
平台默认外端口为80，rsync端口873,这些在docker-compose中可以自定义修改  
现在可以使用安装本机ip登录系统了: http://ip  
默认管理员：admin 密码：Password123  

# 常见问题
1、salt-api权限设置问题导致调用接口失败，参考./file/api.conf设置salt-api的权限

# 后续迁移
迁移操作，如需保存数据迁移至另一台机子，则直接拷贝当前父目录到新的机子上，
由于新宿主机的ip变更，请检查是否需要修改.env里相应的环境变量如rsync的IP，并运行docker-compose up -d即可，
并且发布系统中同步文件填写的rsync的ip和port也记得要相应的修改为新宿主机的ip和port

***
## 功能介绍

***
### 仪表盘
>用来显示资产汇总、minion汇总等信息，统计信息  
![dashbord.png](https://github.com/xiaopanggege/pro_img/raw/main/xpgg_pro/dashboard.png)  

***
### Minion管理
>通过后台定时采集minion数据入库，实时显示minion的情况，支持手动更新  
![minion_sys.png](https://github.com/xiaopanggege/pro_img/raw/main/xpgg_pro/minion_sys.png) 
minion详情  
![minion_info_sys.png](https://github.com/xiaopanggege/pro_img/raw/main/xpgg_pro/minion_info_sys.png)  

***
### SaleKey管理
>把saltkey命令搬到了平台里，方便直接操作minion的添加删除等  
![saltkey_sys.png](https://github.com/xiaopanggege/pro_img/raw/main/xpgg_pro/saltkey_sys.png)  


***
### Salt命令集
>自动收集salt命令，提供官方的使用帮助查看，自定义选择要收集的salt主机，因为windows和linux命令有不同  
![saltcmdinfo_sys.png](https://github.com/xiaopanggege/pro_img/raw/main/xpgg_pro/saltcmdinfo_sys.png)

***
### Salt命令执行
>强大的salt命令执行页面，直接把CLI的salt迁移到页面来，并且支持模块自动补全，命令自动补全，命令使用帮助自动加载  
![saltcmd_sys.png](https://github.com/xiaopanggege/pro_img/raw/main/xpgg_pro/saltcmd_sys.png)  


***
### 文件服务
>能够通过自动化平台上传脚本到salt-master服务端，实现平台化脚本传输等
![file_sys.png](https://github.com/xiaopanggege/pro_img/raw/main/xpgg_pro/file_sys.png)


***
### 应用发布
>可以自定义新增发布，文件推送目前只支持使用svn，svn如果使用https第一次需要到CLI进行一次认证，功能非常个性化，可以按正常流程更新svn->停止应用->同步文件->启动应用，可以单独用来应用停止、启动、同步文件，可以支持对客户端执行命令等等
![release_sys.png](https://github.com/xiaopanggege/pro_img/raw/main/xpgg_pro/release_sys.png)  
![release_sys_create.png](https://github.com/xiaopanggege/pro_img/raw/main/xpgg_pro/release_sys_create.png)  


***
### 发布授权
>对登录用户进行权限控制，按需分配可执行的发布应用
![release_permission.png](https://github.com/xiaopanggege/pro_img/raw/main/xpgg_pro/release_permission.png)  

***
### 任务调度
>实现平台控制定时执行任务，立即执行任务等功能
![task_new.png](https://github.com/xiaopanggege/pro_img/raw/main/xpgg_pro/task_new.png)  
![task_log.png](https://github.com/xiaopanggege/pro_img/raw/main/xpgg_pro/task_log.png)  
![task_time.png](https://github.com/xiaopanggege/pro_img/raw/main/xpgg_pro/task_time.png)  

***
### 授权管理
>控制用户可访问自动化平台的各个功能区域
![authorization.png](https://github.com/xiaopanggege/pro_img/raw/main/xpgg_pro/authorization.png)


***
### 系统管理
>增删改用户
![user_sys.png](https://github.com/xiaopanggege/pro_img/raw/main/xpgg_pro/user_sys.png)


#!/bin/sh

# 开启所有服务

filename=$(basename $(readlink -f "$0"))
filepath=$(readlink -f "$0")

# 判断是否设置开机启动
if [ "${1}" == "run" ];then
	echo " --- "
elif [ "${1}" == "delay" ];then
	sleep 30
elif [ "${1}" == "install" ];then
    echo "nohup ${filepath} delay &">>/etc/rc.local
    chmod +x /etc/rc.local
    chmod +x ${filepath}
    exit 0
else
    echo "usage:"
    echo " ./${filename} install     设置开机启动本脚本"
    echo " ./${filename} run         直接执行本脚本"
    echo " ./${filename} delay       延时执行本脚本，一般用于开机执行"
    echo " ./${filename} help        显示使用说明"
    echo
    exit 0
fi

echo "开始执行脚本..."



########################## 以下可以增加一些启动服务的脚本(注意要用绝对路径) ###############################

# docker-compose
nohup /usr/local/bin/docker-compose -f /data/docker-compose.yml up -d &
sleep 30

# 启动 ecology
nohup /data/weaver/Resin4/bin/startresin.sh &



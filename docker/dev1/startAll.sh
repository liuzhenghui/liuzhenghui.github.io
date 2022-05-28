#!/bin/sh

# 开启所有服务

filename=$(basename $(readlink -f "$0"))
filepath=$(readlink -f "$0")

# 判断是否设置开机启动
if [ "${1}" == "check" ]; then
  if [ $(grep -c "${filepath}" /etc/rc.local) -ne '0' ]; then
    echo "已设置开机启动"
    echo -n '/etc/rc.local: ' && cat '/etc/rc.local' | grep --color=auto "${filepath}"
  else
    echo "未设置开机，请运行 ./${filename} boot 进行设置"
  fi
  exit 0
elif [ "${1}" == "boot" ]; then
  if [ $(grep -c "${filepath}" /etc/rc.local) -ne '0' ]; then
    echo "已设置过开机启动，无需设置"
  else
    echo "nohup ${filepath} delay &" >>/etc/rc.local
    chmod +x /etc/rc.local
    chmod +x ${filepath}
    echo "设置成功"
  fi
  echo -n '/etc/rc.local: ' && cat '/etc/rc.local' | grep --color=auto "${filepath}"
  exit 0
elif [ "${1}" == "run" ]; then
  echo " --- "
elif [ "${1}" == "delay" ]; then
  sleep 30
else
  echo "usage:"
  echo " ./${filename} check       检测是否已设置开机启动"
  echo " ./${filename} boot        设置开机启动本脚本"
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

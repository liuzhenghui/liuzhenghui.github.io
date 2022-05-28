sudo wget https://aliyun-client-assist.oss-accelerate.aliyuncs.com/linux/aliyun_assist_latest.rpm
sudo rpm -ivh aliyun_assist_latest.rpm --force
sudo aliyun-service --register --RegionId "cn-shenzhen" \
   --ActivationCode "a-sz0pdrfLrUl32PVRTmDClEtzwFeI/" \
   --ActivationId "3E48E742-9368-53D9-A54D-558B9FD1E663"
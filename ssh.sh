#!/bin/bash
export SLAVES="10.0.56.190"
export USER='root'
ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa                   #生成本机密钥对，一般在登录用户的.ssh目录下
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys            #把公钥追加到授权的key里面去，此时已经可以ssh本机了，可用ssh localhost测试
chmod 600 ~/.ssh/authorized_keys                           #修改文件"authorized_keys"权限，不安全的设置安全设置，会让你不能使用RSA功能
                                                           #在验证时，扔提示你输入密码，经常都是这里出问题
echo $SLAVES | tr " " "\n"| while read LINE                
do
        ssh-copy-id -i ~/.ssh/id_rsa.pub $USER@$LINE       # 把公钥分发到集群其他节点，$SLAVES为节点主机名列表
        echo "Copying keygen  to $LINE"
done
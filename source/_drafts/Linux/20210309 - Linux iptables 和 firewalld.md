---
title: Linux iptables 和 firewalld
mathjax: true
date: 2021-03-09 21:21:28
updated:
categories:
tags:
urlname: about-linux-iptables-and-firewalld
---



<!-- more -->



# firewalld

[CentOS 7 为firewalld添加开放端口及相关资料 - 北斗极星 - 博客园](https://www.cnblogs.com/hubing/p/6058932.html)

## 添加规则



```sh
# 开单个端口
firewall-cmd --zone=public --add-port=80/tcp --permanent

# 开多个端口
firewall-cmd --zone=public --add-port=100-500/tcp --permanent
```



## 查询规则

```
firewall-cmd --zone=public --query-port=80/tcp
firewall-cmd --zone=public --query-port=8000-9000/tcp
```



## 移除规则

```
firewall-cmd --zone=public --remove-port=80/tcp --permanent
```



## 载入规则

修改之后必须 reload 才会生效

```
firewall-cmd --reload
```

> after you executed commands with "--permanent". Those commands work only on the config file but not on the current running configuration. IF you do not use --permanent, you are working on the running configuration and can see you changes immediately.
>
> [Firewalld not saving ports, but show success, info in the config but not in --list-all - Unix & Linux Stack Exchange](https://unix.stackexchange.com/questions/383517/firewalld-not-saving-ports-but-show-success-info-in-the-config-but-not-in-li)





## 开机启动

```sql
systemctl enable firewalld.service
```



## 关闭 firewalld

````
systemctl status firewalld.service
systemctl stop firewalld.service
systemctl disable firewalld.service
firewall-cmd --state
````





# iptables



## 参数

[iptables 命令，Linux iptables 命令详解：Linux上常用的防火墙软件 - Linux 命令搜索引擎](https://wangchujiang.com/linux-command/c/iptables.html)

```
-L, --list [chain] 列出链 chain 上面的所有规则，如果没有指定链，列出表上所有链的所有规则。
--verbose	-v		verbose mode
--numeric	-n		numeric output of addresses and ports
```



## 查看规则



```
iptables -S
```



```
[root@bi-finetube gpload]# iptables -S
-P INPUT ACCEPT
-P FORWARD ACCEPT
-P OUTPUT ACCEPT
-A INPUT -i virbr0 -p udp -m udp --dport 53 -j ACCEPT
-A INPUT -i virbr0 -p tcp -m tcp --dport 53 -j ACCEPT
-A INPUT -i virbr0 -p udp -m udp --dport 67 -j ACCEPT
-A INPUT -i virbr0 -p tcp -m tcp --dport 67 -j ACCEPT
-A FORWARD -d 192.168.122.0/24 -o virbr0 -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
-A FORWARD -s 192.168.122.0/24 -i virbr0 -j ACCEPT
-A FORWARD -i virbr0 -o virbr0 -j ACCEPT
-A FORWARD -o virbr0 -j REJECT --reject-with icmp-port-unreachable
-A FORWARD -i virbr0 -j REJECT --reject-with icmp-port-unreachable
-A OUTPUT -o virbr0 -p udp -m udp --dport 68 -j ACCEPT
```



```
iptables -L -v -n --line-number

或
iptables -L -v --line-number
```

示例：

```
[root@bi-finetube gpload]# iptables -v -L
Chain INPUT (policy ACCEPT 1771K packets, 2715M bytes)
 pkts bytes target     prot opt in     out     source               destination         
    0     0 ACCEPT     udp  --  virbr0 any     anywhere             anywhere             udp dpt:domain
    0     0 ACCEPT     tcp  --  virbr0 any     anywhere             anywhere             tcp dpt:domain
    0     0 ACCEPT     udp  --  virbr0 any     anywhere             anywhere             udp dpt:bootps
    0     0 ACCEPT     tcp  --  virbr0 any     anywhere             anywhere             tcp dpt:bootps

Chain FORWARD (policy ACCEPT 0 packets, 0 bytes)
 pkts bytes target     prot opt in     out     source               destination         
    0     0 ACCEPT     all  --  any    virbr0  anywhere             192.168.122.0/24     ctstate RELATED,ESTABLISHED
    0     0 ACCEPT     all  --  virbr0 any     192.168.122.0/24     anywhere            
    0     0 ACCEPT     all  --  virbr0 virbr0  anywhere             anywhere            
    0     0 REJECT     all  --  any    virbr0  anywhere             anywhere             reject-with icmp-port-unreachable
    0     0 REJECT     all  --  virbr0 any     anywhere             anywhere             reject-with icmp-port-unreachable

Chain OUTPUT (policy ACCEPT 1833K packets, 5119M bytes)
 pkts bytes target     prot opt in     out     source               destination         
    0     0 ACCEPT     udp  --  any    virbr0  anywhere             anywhere             udp dpt:bootpc
```





### 关于规则



[iptables default rules understanding - Super User](https://superuser.com/questions/895435/iptables-default-rules-understanding)



开放所有端口

```
iptables -P INPUT ACCEPT   
iptables -P OUTPUT ACCEPT
```



```
Chain INPUT (policy ACCEPT) target prot opt source
destination ACCEPT all -- 0.0.0.0/0 0.0.0.0/0
state RELATED,ESTABLISHED ACCEPT icmp -- 0.0.0.0/0
0.0.0.0/0 ACCEPT all -- 0.0.0.0/0 0.0.0.0/0 ACCEPT tcp -- 0.0.0.0/0 0.0.0.0/0 state NEW tcp dpt:22 REJECT all -- 0.0.0.0/0 0.0.0.0/0
reject-with icmp-host-prohibited ACCEPT tcp -- 0.0.0.0/0
0.0.0.0/0 tcp dpt:8443 ACCEPT tcp -- 0.0.0.0/0 0.0.0.0/0 tcp dpt:8080 ACCEPT tcp -- 0.0.0.0/0 0.0.0.0/0 tcp dpt:9443 ACCEPT tcp -- 0.0.0.0/0 0.0.0.0/0 tcp dpt:2124

Chain FORWARD (policy ACCEPT) target prot opt source
destination REJECT all -- 0.0.0.0/0 0.0.0.0/0
reject-with icmp-host-prohibited

Chain OUTPUT (policy ACCEPT) target prot opt source
destination
```





## 关闭 iptables



```
yum install iptables-services
systemctl status iptables.service 
systemctl stop iptables.service 

// 停止开机启动
systemctl disable iptables.service
cd /etc/sysconfig
mv /etc/sysconfig/iptables  /etc/sysconfig/iptables.bak
mv /etc/sysconfig/iptables-config /etc/sysconfig/iptables-config.bak
touch /etc/sysconfig/iptables
touch /etc/sysconfig/iptables-config
reboot
```



## 参考资料

1. [在Centos7上使用Iptables - 陈健的博客 | ChenJian Blog](https://o-my-chenjian.com/2017/02/28/Using-Iptables-On-Centos7/)





# SELinux





## 查看 SELinux 状态



```
[root@bi-finetube sysconfig]# sestatus
SELinux status:                 enabled
SELinuxfs mount:                /sys/fs/selinux
SELinux root directory:         /etc/selinux
Loaded policy name:             targeted
Current mode:                   enforcing
Mode from config file:          enforcing
Policy MLS status:              enabled
Policy deny_unknown status:     allowed
Max kernel policy version:      31
```



[SELinux 宽容模式(permissive) 强制模式(enforcing) 关闭(disabled) 几种模式之间的转换_Lionel_新浪博客](http://blog.sina.com.cn/s/blog_5aee9eaf0100y44q.html)

[linux为什么要关闭防火墙和selinux - 知乎](https://zhuanlan.zhihu.com/p/61822057)

[centos7 关闭防火墙和selinux - 简书](https://www.jianshu.com/p/d6414b5295b8)





# 参考资料

1. [Linux 防火墙：关于 iptables 和 firewalld 的那些事 - 知乎](https://zhuanlan.zhihu.com/p/45920510)
2. [CentOS 7之FirewallD与iptables的区别 - 有个地方叫作遥远 - OSCHINA - 中文开源技术交流社区](https://my.oschina.net/deanzhao/blog/3058904)
3. [Linux查看并对外开放端口 - 简书](https://www.jianshu.com/p/b3068288d80d)
4. [深入理解firewalld设置防火墙_chenxiangneu的博客-CSDN博客](https://blog.csdn.net/chenxiangneu/article/details/80172799)
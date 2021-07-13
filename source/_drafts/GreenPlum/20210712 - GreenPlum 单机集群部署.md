---
title: GreenPlum 单机集群部署
mathjax: true
date: 2021-07-12 09:36:00
updated:
categories:
tags:
urlname: greenplum-cluster-on-docker
---



<!-- more -->

# 部署

参考：

1. [3分钟快速搭建Greenplum集群 - Greenplum 中文社区](https://cn.greenplum.org/build_greenplum_cluster/)
2. [lij55/gphost: Image to run Greenplum](https://github.com/lij55/gphost)



# 常用操作

## 启动

切换到 `/root/gphost/example6`

启动集群：

```
docker-compose up -d
```

连接到 master：

```
ssh -p 6222 gpadmin@127.0.0.1
```

密码：changeme

启动 GreenPlum 集群：

```
gpstart -a
```



# 参考资料

1. [3分钟快速搭建Greenplum集群 - Greenplum 中文社区](https://cn.greenplum.org/build_greenplum_cluster/)
2. [lij55/gphost: Image to run Greenplum](https://github.com/lij55/gphost)
3. [docker安装Greenplum集群 - Greenplum 中文社区](https://cn.greenplum.org/install-greenplum-cluster-on-docker/)


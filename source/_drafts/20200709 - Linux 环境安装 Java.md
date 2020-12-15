---
title: Linux 环境安装 Java
mathjax: true
date: 2020-07-09 15:32:47
updated:
categories:
tags:
urlname: installing-java-on-linux
---



<!-- more -->



# 压缩包安装

因为不需要在服务器上进行开发，所以服务器上只需要安装 JRE。



顺便，了解一下 Java 8 之后的收费策略：[Oracle如何对JDK收费](https://zhuanlan.zhihu.com/p/64731331)

如果想要免费，只能用 Java8u202 之前的版本。

查看 Linux 版本：

```shell
peng@DESKTOP-VUB939L:~$ sudo lsb_release -a
No LSB modules are available.
Distributor ID: Ubuntu
Description:    Ubuntu 18.04.2 LTS
Release:        18.04
Codename:       bionic
```



[Java Archive Downloads - Java SE 8](https://www.oracle.com/java/technologies/javase/javase8-archive-downloads.html)

[8 Server JRE 8 Installation for Linux Platforms](https://docs.oracle.com/javase/8/docs/technotes/guides/install/linux_server_jre.html)【Linux 安装 Java 步骤】



wget 下载

```
wget https://download.oracle.com/otn/java/jdk/8u202-b08/1961070e4c9b4e26a04e7f5a083f551e/server-jre-8u202-linux-x64.tar.gz?AuthParam=1582959723_365cef16ac9fce2e8ac532e0c48ed2c5 -O server-jre-8u202-linux-x64.tar.gz
```

这个链接是在浏览器中下载然后拷贝过来的链接，现在 Oracle 做了限制，一个链接好像有一定的有效期，不能无限次重复使用。



```
tar zxvf server-jre-8uversion-linux-x64.tar.gz
```



## 配置环境变量

[Linux环境变量配置全攻略](https://www.cnblogs.com/youyoui/p/10680329.html)



```
vim ~/.bashrc
```



加入以下内容：

```
export JAVA_HOME=/path/to/jre
export JRE_HOME=${JAVA_HOME}/jre
export CLASSPATH=.:${JAVA_HOME}/lib:${JRE_HOME}/lib
export PATH=.:${JAVA_HOME}/bin:$PATH
```



使生效

```
source ~/.bashrc
```



# RPM 安装

[CentOS7 下rpm安装jdk1.8\_小小默：进无止境-CSDN博客\_centos7 rpm dk1.8.0_231](https://blog.csdn.net/J080624/article/details/78133464)

下载 https://www.oracle.com/java/technologies/javase/javase8-archive-downloads.html



```
wget https://download.oracle.com/otn/java/jdk/8u202-b08/1961070e4c9b4e26a04e7f5a083f551e/jdk-8u202-linux-x64.rpm?AuthParam=1594282253_c9ec213dbd858bb035a6b02f7c1eaa18 -O jdk-8u202-linux-x64.rpm
```



安装 RPM 包

```
rpm -ivh jdk-8u202-linux-x64.rpm
```



RPM 安装方式不需要配置环境变量，原因可以参考《[为什么JDK的RPM包安装方式不需要配置Java环境变量_chuanxincui的博客-CSDN博客](https://blog.csdn.net/chuanxincui/article/details/82850538)》



# 参考资料




---
title: JDK JRE JVM 区别与联系
mathjax: true
date: 2019-05-09 16:34:07
updated:
categories:
- Java
tags:
urlname: jdk-jre-jvm-differences-and-relations
---

从 JDK 安装后的文件夹说起。

<!-- more -->

以 JDK 11.0.2 为例，在 Windows 平台上，安装完成之后，其文件结构如下所示：

```
jdk-11.0.2
├─bin 存在 JDK 的各种工具命令，常用的 javac、java 等命令就在该路径下
├─conf 存放了 JDK 的相关配置文件
├─include 参访一些平台特定的头文件
├─jmods 存放了 JDK 的各种模块
├─legal 存放了 JDK 的各种模块的授权文档
└─lib JDK 工具的一些补充 JAR 包。比如 src.zip 文件中保存了 Java 的源代码。
```



# 参考资料

1. 疯狂 Java. 第4版.
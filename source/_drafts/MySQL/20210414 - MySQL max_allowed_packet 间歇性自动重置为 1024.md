---
title: MySQL max_allowed_packet 间歇性自动重置为 1024
mathjax: true
date: 2021-04-14 11:06:00
updated:
categories:
tags:
urlname: mysql-max_allowed_packet-frequently-changed-to-1024
---



<!-- more -->

最近遇到了这个问题，MySQL 服务是运行在一台华为云的机器上的。

最初查资料，查到了 Stackoverflow 上，看到了排第一的答案讲很有可能是被黑客入侵了，我还感觉不相信，，但是后边又查了一些资料，发现可能确实如此，比如这两篇：

[mysql max_allowed_packet自动重置为1024 终结解决 - 南坡小枣 - 博客园](https://www.cnblogs.com/qdpurple/p/5742059.html)

[Mysql max_allowed_packet自动重置为1024（黑客入侵？）_Abysscarry的博客-CSDN博客](https://blog.csdn.net/Abysscarry/article/details/79714114)



查看：

```sql
SELECT @@global.max_allowed_packet, @@session.max_allowed_packet;
```

设置

```sql
SET global max_allowed_packet = 16*1024*1024;
```



# 参考资料

1. [Why mysql max_allowed_packet reset to 1m automatically - Stack Overflow](https://stackoverflow.com/questions/28979660/why-mysql-max-allowed-packet-reset-to-1m-automatically)
2. [MySQL :: MySQL 5.7 Reference Manual :: B.3.2.8 Packet Too Large](https://dev.mysql.com/doc/refman/5.7/en/packet-too-large.html)
3. [mysql max_allowed_packet自动重置为1024 终结解决 - 南坡小枣 - 博客园](https://www.cnblogs.com/qdpurple/p/5742059.html)
4. [Mysql max_allowed_packet自动重置为1024（黑客入侵？）_Abysscarry的博客-CSDN博客](https://blog.csdn.net/Abysscarry/article/details/79714114)
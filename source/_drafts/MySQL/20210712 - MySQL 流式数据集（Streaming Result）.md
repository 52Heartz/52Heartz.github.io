---
title: MySQL 流式数据集（Streaming Result）
mathjax: true
date: 2021-07-12 13:42:32
updated:
categories:
tags:
urlname: about-mysql-streaming-reusltset
---



<!-- more -->

官方文档中的说明：

> By default, ResultSets are completely retrieved and stored in memory. In most cases this is the most efficient way to operate and, due to the design of the MySQL network protocol, is easier to implement. If you are working with ResultSets that have a large number of rows or large values and cannot allocate heap space in your JVM for the memory required, you can tell the driver to stream the results back one row at a time.
>
> To enable this functionality, create a `Statement` instance in the following manner:
>
> ```java
> stmt = conn.createStatement(java.sql.ResultSet.TYPE_FORWARD_ONLY,
>               java.sql.ResultSet.CONCUR_READ_ONLY);
> stmt.setFetchSize(Integer.MIN_VALUE);
> ```
>
> ——[MySQL :: MySQL Connector/J 8.0 Developer Guide :: 6.4 JDBC API Implementation Notes](https://dev.mysql.com/doc/connector-j/8.0/en/connector-j-reference-implementation-notes.html)



# 缺点

> There are some caveats with this approach. You must read all of the rows in the result set (or close it) before you can issue any other queries on the connection, or an exception will be thrown.
>
> ——[MySQL :: MySQL Connector/J 8.0 Developer Guide :: 6.4 JDBC API Implementation Notes](https://dev.mysql.com/doc/connector-j/8.0/en/connector-j-reference-implementation-notes.html)

官方文档中说必须读取所有结果或者关闭 ResultSet，事实上，调用 `close()` 关闭 ResultSet 同样会继续把所有的数据传输完成。所以如果对应的表的数据非常大的话，调用 `ResultSet.close()` 可能要等比较久的时间。



网上有人提到过这个问题，但是 MySQL 官方答复这个不是 BUG。

[MySQL Bugs: #95763: can not closed streaming result set](https://bugs.mysql.com/bug.php?id=95763)

[MySQL Bugs: #42929: closing jdbc streaming resultset waits for all records](https://bugs.mysql.com/bug.php?id=42929)



可以看《[MySQL JDBC StreamResult通信原理浅析_xieyuooo的专栏-CSDN博客](https://blog.csdn.net/xieyuooo/article/details/83109971)》了解更多。



# 参考资料

1. [MySQL :: MySQL Connector/J 8.0 Developer Guide :: 6.4 JDBC API Implementation Notes](https://dev.mysql.com/doc/connector-j/8.0/en/connector-j-reference-implementation-notes.html)
2. [MySQL JDBC StreamResult通信原理浅析_xieyuooo的专栏-CSDN博客](https://blog.csdn.net/xieyuooo/article/details/83109971)
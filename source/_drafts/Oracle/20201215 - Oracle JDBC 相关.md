---
title: Oracle JDBC 相关
mathjax: true
date: 2020-12-15 22:00:36
updated:
categories:
tags:
urlname: about-oracle-jdbc
---



<!-- more -->



# 数据类型

[Data Types](https://docs.oracle.com/database/121/SQLRF/sql_elements001.htm#SQLRF0021)



# JDBC API

在网上没有找到在线版的 Javadoc，不过可以在 Maven 仓库下载到：[Maven Repository: com.oracle.database.jdbc » ojdbc8 » 19.8.0.0](https://mvnrepository.com/artifact/com.oracle.database.jdbc/ojdbc8/19.8.0.0)

点击【Files】中的 【View All】就可以下载。



# PreparedStatement 数字类型写入问题

`PreparedStatement` 有一个 `void setObject(int parameterIndex, Object x, int targetSqlType, int scaleOrLength)` 方法，如果指定了 `targetSqlType` 为 `Types.NUMERIC`，那么当插入的 Object 是一个 String 且是小数的时候，会报错。



如果一个字段在目标表中是 `NUMBER` 类型，但是使用 JDBC 插入数据的时候，数字是使用字符串表示的，那么当这个字符串形式的数字是整形的时候可以插入成功，但是当这个字符串类型的数字为小数时，会插入失败。报错大概是：

```
Caused by: java.lang.NumberFormatException: For input string: "9."
     at java.lang.NumberFormatException.forInputString(NumberFormatException.java:65)
     at java.lang.Integer.parseInt(Integer.java:580)
     at java.lang.Integer.parseInt(Integer.java:615)
     at oracle.sql.NUMBER.toBytes(NUMBER.java:1938)
     at oracle.sql.NUMBER.(NUMBER.java:289)
     at oracle.jdbc.driver.OraclePreparedStatement.setObjectCritical(OraclePreparedStatement.java:7742)
     at oracle.jdbc.driver.OraclePreparedStatement.setObjectInternal(OraclePreparedStatement.java:7581)
     at oracle.jdbc.driver.OraclePreparedStatement.setObject(OraclePreparedStatement.java:7554)
     at oracle.jdbc.driver.OraclePreparedStatementWrapper.setObject(OraclePreparedStatementWrapper.java:1032)
     at com.zaxxer.hikari.pool.HikariProxyPreparedStatement.setObject(HikariProxyPreparedStatement.java)
```

原因是 Oracle JDBC 在底层会对字符串格式的数字进行类型转换，但是只有整形的可以转换成功，字符串类型的就会失败。解决方法就是如果数字是小数，那么就不要把 `tart` 设置为 `Types.NUMERIC`，而是设置为不在 `Types` 中的一个值，这样就可以插入成功。









# 参考资料

1. [Data Types](https://docs.oracle.com/database/121/SQLRF/sql_elements001.htm#SQLRF0021)
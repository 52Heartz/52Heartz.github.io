---
title: JDBC 连接 MySQL 获取主键报错 Incorrect database name ''
mathjax: true
date: 2021-05-30 16:46:54
updated:
categories:
tags:
urlname: jdbc-connect-to-mysql-report-incorrect-database-name
---



<!-- more -->



数据库版本：5.7.16-log

报错：

```
com.mysql.jdbc.exceptions.jdbc4.MySQLSyntaxErrorException: Incorrect database name ''
     at sun.reflect.NativeConstructorAccessorImpl.newInstance0(Native Method)
     at sun.reflect.NativeConstructorAccessorImpl.newInstance(NativeConstructorAccessorImpl.java:62)
     at sun.reflect.DelegatingConstructorAccessorImpl.newInstance(DelegatingConstructorAccessorImpl.java:45)
     at java.lang.reflect.Constructor.newInstance(Constructor.java:423)
     at com.mysql.jdbc.Util.handleNewInstance(Util.java:404)
     at com.mysql.jdbc.Util.getInstance(Util.java:387)
     at com.mysql.jdbc.SQLError.createSQLException(SQLError.java:942)
     at com.mysql.jdbc.MysqlIO.checkErrorPacket(MysqlIO.java:3966)
     at com.mysql.jdbc.MysqlIO.checkErrorPacket(MysqlIO.java:3902)
     at com.mysql.jdbc.MysqlIO.sendCommand(MysqlIO.java:2526)
     at com.mysql.jdbc.MysqlIO.sqlQueryDirect(MysqlIO.java:2673)
     at com.mysql.jdbc.ConnectionImpl.execSQL(ConnectionImpl.java:2545)
     at com.mysql.jdbc.ConnectionImpl.execSQL(ConnectionImpl.java:2503)
     at com.mysql.jdbc.StatementImpl.executeQuery(StatementImpl.java:1369)
     at com.mysql.jdbc.DatabaseMetaData$7.forEach(DatabaseMetaData.java:3739)
     at com.mysql.jdbc.DatabaseMetaData$7.forEach(DatabaseMetaData.java:3729)
     at com.mysql.jdbc.IterateBlock.doForAll(IterateBlock.java:50)
     at com.mysql.jdbc.DatabaseMetaData.getPrimaryKeys(DatabaseMetaData.java:3727)
```



原因：

连接使用的 JDBC 驱动是 `mysql-connector-java-5.1.39`，换成 `mysql-connector-java-8.0.20` 之后就不再报错了。


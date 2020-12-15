---
title: MySQL JDBC 相关
mathjax: true
date: 2020-09-04 11:09:58
updated:
categories:
tags:
urlname: about-mysql-jdbc
---



<!-- more -->



# 关键配置项

## allowMultiQueries

> Allow the use of ';' to delimit multiple queries during one statement (true/false), defaults to 'false', and does not affect the addBatch() and executeBatch() methods, which instead rely on rewriteBatchedStatements.
>
> Default: false

该配置项为 false，则 `Statement#execute()` 一次只能执行一条 SQL 语句。如果为 true，则可以一次执行多条 SQL 语句，语句之间使用 `;` 分隔即可。





# 参考资料

1. [MySQL :: MySQL Connector/J 5.1 Developer Guide :: 5.3 Configuration Properties for Connector/J](https://dev.mysql.com/doc/connector-j/5.1/en/connector-j-reference-configuration-properties.html)
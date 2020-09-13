---
title: 关于 MySQL binlog
mathjax: true
date: 2020-07-24 19:51:03
updated:
categories:
tags:
urlname: about-mysql-binlog
---



<!-- more -->



# 备份

- 热备：服务器不停机备份
- 冷备：



RPO(Recovery point objective)

RTO(Recovery Time Objective)



# Binlog



> The binary log is not used for statements such as [`SELECT`](https://dev.mysql.com/doc/refman/8.0/en/select.html) or [`SHOW`](https://dev.mysql.com/doc/refman/8.0/en/show.html) that do not modify data. To log all statements (for example, to identify a problem query), use the general query log. See [Section 5.4.3, “The General Query Log”](https://dev.mysql.com/doc/refman/8.0/en/query-log.html).

Binlog 只记录修改数据的记录。SELECT 和 SHOW 这种不造成数据修改的查询是不会记录的。



> Passwords in statements written to the binary log are rewritten by the server not to occur literally in plain text. See also [Section 6.1.2.3, “Passwords and Logging”](https://dev.mysql.com/doc/refman/8.0/en/password-logging.html).

如果 SQL 语句中有密码信息，会自动被重写，不会以明文形式出现。



## 开启关闭

> Binary logging is enabled by default (the [`log_bin`](https://dev.mysql.com/doc/refman/8.0/en/replication-options-binary-log.html#sysvar_log_bin) system variable is set to ON). The exception is if you use [**mysqld**](https://dev.mysql.com/doc/refman/8.0/en/mysqld.html) to initialize the data directory manually by invoking it with the [`--initialize`](https://dev.mysql.com/doc/refman/8.0/en/server-options.html#option_mysqld_initialize) or [`--initialize-insecure`](https://dev.mysql.com/doc/refman/8.0/en/server-options.html#option_mysqld_initialize-insecure) option, when binary logging is disabled by default, but can be enabled by specifying the [`--log-bin`](https://dev.mysql.com/doc/refman/8.0/en/replication-options-binary-log.html#option_mysqld_log-bin) option.



查看 binlog 是否开启：

```sql
show VARIABLES LIKE "log_bin";
```



> In MySQL 5.7, a server ID had to be specified when binary logging was enabled, or the server would not start. In MySQL 8.0, the [`server_id`](https://dev.mysql.com/doc/refman/8.0/en/replication-options.html#sysvar_server_id) system variable is set to 1 by default. The server can be started with this default ID when binary logging is enabled, but an informational message is issued if you do not specify a server ID explicitly using the [`server_id`](https://dev.mysql.com/doc/refman/8.0/en/replication-options.html#sysvar_server_id) system variable. For servers that are used in a replication topology, you must specify a unique nonzero server ID for each server.



## 日志命名

>  [`--log-bin[=base_name]`](https://dev.mysql.com/doc/refman/8.0/en/replication-options-binary-log.html#option_mysqld_log-bin)

[MySQL binlog后面的编号如何取值？ | 《Linux就该这么学》](https://www.linuxprobe.com/mysql-binlog.html)







## 日志格式

> The format of the events recorded in the binary log is dependent on the binary logging format. Three format types are supported: row-based logging, statement-based logging and mixed-base logging. The binary logging format used depends on the MySQL version. For general descriptions of the logging formats, see [Section 5.4.4.1, “Binary Logging Formats”](https://dev.mysql.com/doc/refman/8.0/en/binary-log-formats.html). For detailed information about the format of the binary log, see [MySQL Internals: The Binary Log](https://dev.mysql.com/doc/internals/en/binary-log.html).



> Note that the binary log format differs in MySQL 8.0 from previous versions of MySQL, due to enhancements in replication. See [Section 17.5.2, “Replication Compatibility Between MySQL Versions”](https://dev.mysql.com/doc/refman/8.0/en/replication-compatibility.html).

8.0 开始，日志格式有所不同。



[MySQL :: MySQL 8.0 Reference Manual :: 5.4.4.1 Binary Logging Formats](https://dev.mysql.com/doc/refman/8.0/en/binary-log-formats.html)



# binlog 常用参数

## binlog_rows_query_log_events

> This system variable affects row-based logging only. When enabled, it causes the server to write informational log events such as row query log events into its binary log. This information can be used for debugging and related purposes, such as obtaining the original query issued on the source when it cannot be reconstructed from the row updates.
>
> These informational events are normally ignored by MySQL programs reading the binary log and so cause no issues when replicating or restoring from backup. To view them, increase the verbosity level by using mysqlbinlog's [`--verbose`](https://dev.mysql.com/doc/refman/5.7/en/mysqlbinlog.html#option_mysqlbinlog_verbose) option twice, either as `-vv` or `--verbose --verbose`.

这个参数只在 binlog 模式为 `ROW` 时起作用。当开启的时候，会记录下来 `ROWS_QUERY_EVENT`。



[MySQL :: MySQL Internals Manual :: 14.10.3 ROWS_QUERY_EVENT](https://dev.mysql.com/doc/internals/en/rows-query-event.html)

[MySQL :: MySQL Internals Manual :: 14.9.4.3 Binlog Event Type](https://dev.mysql.com/doc/internals/en/binlog-event-type.html)



## binlog_row_image

[MySQL :: MySQL 8.0 Reference Manual :: 17.1.6.4 Binary Logging Options and Variables](https://dev.mysql.com/doc/refman/8.0/en/replication-options-binary-log.html#sysvar_binlog_row_image)

[安全考虑，binlog_row_image建议尽量使用FULL - MySQL分布式中间件DBLE - SegmentFault 思否](https://segmentfault.com/a/1190000016008847)

[MySQL 5.7贴心参数之binlog_row_image - yayun - 博客园](https://www.cnblogs.com/gomysql/p/6155160.html)

[参数binlog_row_image设置MINIMAL，你今天被坑了吗？-贺春旸的技术博客-51CTO博客](https://blog.51cto.com/hcymysql/2143391)



# Relay log



# 常用操作

## 查看 MySQL 的 binlog 配置

```sql
show variables like'log_bin%';
```



## 查看

```sql
show binary logs;
```



## 过期时间

```
expire_logs_days=0
```

表示 binlog 永不过期。

[Mysql设置binlog过期时间并自动删除 - Ruthless - 博客园](https://www.cnblogs.com/linjiqin/p/11520052.html)



# 坑点

## 修改配置文件没有用

修改 `my.ini` 的时候，注意，配置文件会被 `[mysqld]`、`[mysql]` 和 `[client]` 分为三段，要把关于 binlog 的配置写到 `[mysqld]` 对应的范围内。





# 关于 GTID

[MySQL :: MySQL 5.7 Reference Manual :: 16.1.3.1 GTID Format and Storage](https://dev.mysql.com/doc/refman/5.7/en/replication-gtids-concepts.html)

[MySQL5.7杀手级新特性：GTID原理与实战 | Focus on MySQL,Focus on Life](https://keithlan.github.io/2016/06/23/gtid/)

[GTID介绍, 以及GTID在failover中的用法 - 知乎](https://zhuanlan.zhihu.com/p/35471971)

[与MySQL传统复制相比，GTID有哪些独特的复制姿势? - MySQL - dbaplus社群：围绕Data、Blockchain、AiOps的企业级专业社群。技术大咖、原创干货，每天精品原创文章推送，每周线上技术分享，每月线下技术沙龙。](https://dbaplus.cn/news-11-857-1.html)





# 事件类型

[MySQL binlog中的事件类型 - iVictor - 博客园](https://www.cnblogs.com/ivictor/p/5780617.html)







# 其他

## MySQL 8.0.1 更新，binlog 事件中包含列信息

[More Metadata Is Written Into Binary Log | MySQL High Availability](https://mysqlhighavailability.com/more-metadata-is-written-into-binary-log/)









# 参考资料

1. [MySQL :: MySQL 8.0 Reference Manual :: 5.4.4 The Binary Log](https://dev.mysql.com/doc/refman/8.0/en/binary-log.html)
2. [MySQL :: MySQL 5.7 Reference Manual :: 4.2.2.2 Using Option Files](https://dev.mysql.com/doc/refman/5.7/en/option-files.html)
3. [MySQL :: MySQL 5.7 Reference Manual :: 16.1.6.4 Binary Logging Options and Variables](https://dev.mysql.com/doc/refman/5.7/en/replication-options-binary-log.html)
4. [maxwell实时同步mysql中binlog - kris12 - 博客园](https://www.cnblogs.com/shengyang17/p/12069175.html)
5. [腾讯工程师带你深入解析 MySQL binlog - 知乎](https://zhuanlan.zhihu.com/p/33504555)

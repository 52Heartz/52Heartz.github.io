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



# 官方文档

[MySQL :: MySQL 8.0 Reference Manual :: 5.4.4 The Binary Log](https://dev.mysql.com/doc/refman/8.0/en/binary-log.html)

[MySQL :: MySQL Internals Manual :: 14.10.2 ROWS_EVENT](https://dev.mysql.com/doc/internals/en/rows-event.html#packet-Binlog::RowsEventExtraData)



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



## binlog 过期时间

查看 binlog 过期时间：

```
show variables like 'expire_logs_days';
```

或

```
select @@global.expire_logs_days;
```



`expire_logs_days` 为 `0` 表示 binlog 永不过期。

[Mysql设置binlog过期时间并自动删除 - Ruthless - 博客园](https://www.cnblogs.com/linjiqin/p/11520052.html)



## 查看当前所有的 binlog 文件及文件大小

```sql
show binary logs;
```



## 查看 binlog 内容

查看第一个 binlog 文件的内容：

```
SHOW BINLOG EVENTS;
```



查看指定 binlog 文件的内容：

```
SHOW BINLOG EVENTS IN 'mysql-bin.000001';
```



指定起始 binlog position：

```
SHOW BINLOG EVENTS IN 'mysql-bin.000001' FROM 123;
```

这种情况下，指定的 binlog position 必须是一个有效的 binlog position，那么会报错：

```
Error when executing command SHOW BINLOG EVENTS: Wrong offset or I/O error
```



指定行号 offset 和 limit：

```
SHOW BINLOG EVENTS IN 'mysql-bin.000001' LIMIT 0, 100;
```



[MySQL :: MySQL 8.0 Reference Manual :: 13.7.7.2 SHOW BINLOG EVENTS Statement](https://dev.mysql.com/doc/refman/8.0/en/show-binlog-events.html)



# 坑点

## 修改配置文件没有用

修改 `my.ini` 的时候，注意，配置文件会被 `[mysqld]`、`[mysql]` 和 `[client]` 分为三段，要把关于 binlog 的配置写到 `[mysqld]` 对应的范围内。



# 关于 GTID

[MySQL :: MySQL 5.7 Reference Manual :: 16.1.3.1 GTID Format and Storage](https://dev.mysql.com/doc/refman/5.7/en/replication-gtids-concepts.html)

[MySQL5.7杀手级新特性：GTID原理与实战 | Focus on MySQL,Focus on Life](https://keithlan.github.io/2016/06/23/gtid/)

[GTID介绍, 以及GTID在failover中的用法 - 知乎](https://zhuanlan.zhihu.com/p/35471971)

[与MySQL传统复制相比，GTID有哪些独特的复制姿势? - MySQL - dbaplus社群：围绕Data、Blockchain、AiOps的企业级专业社群。技术大咖、原创干货，每天精品原创文章推送，每周线上技术分享，每月线下技术沙龙。](https://dbaplus.cn/news-11-857-1.html)



# 关于 table_id

[MySQL table_id原理及风险分析 - yuyue2014 - 博客园](https://www.cnblogs.com/yuyue2014/p/3721172.html)

[MySQL Binlog中TABLE ID源码分析-king_wangheng-ChinaUnix博客](http://blog.chinaunix.net/uid-26896862-id-3329896.html)

[mysql TableMap id递增问题 - agapple - ITeye博客](https://www.iteye.com/blog/agapple-1797061)

[【MySQL】再说MySQL中的 table_id _ITPUB博客](http://blog.itpub.net/22664653/viewspace-1158547/)

[hate mysql because you love her deeply » Blog Archive » 淘宝物流MySQL slave数据丢失详细原因](https://web.archive.org/web/20130921165829/http://hatemysql.com/2012/11/23/淘宝物流mysql-slave数据丢失详细原因/)

[物流MySQL slave复制数据部分丢失问题 | hickey](https://web.archive.org/web/20130920122424/http://hickey.in/?p=146)





# 同步相关

WRITE_ROW_EVENT、UPDATE_ROWS_EVENT、UPDATE_ROWS_EVENT 等事件之前总是有一个 TABLE_MAP_EVENT，两个 event 通过一个 table_id 关联。



# EventLength

MySQL 中规定 eventLength 的类型为 4 字节：https://dev.mysql.com/doc/internals/en/event-header-fields.html，意味着 一个 event 最大长度不能超过 $2^{32}-1$。



# 事件类型

[MySQL :: MySQL Internals Manual :: 14.9.4.3 Binlog Event Type](https://dev.mysql.com/doc/internals/en/binlog-event-type.html)

[MySQL binlog中的事件类型 - iVictor - 博客园](https://www.cnblogs.com/ivictor/p/5780617.html)【MySQL 5.7】



### 常见事件类型

#### QUERY_EVENT

[MySQL :: MySQL Internals Manual :: 14.9.4.9 QUERY_EVENT](https://dev.mysql.com/doc/internals/en/query-event.html)



#### TABLE_MAP



#### UPDATE_ROWS_EVENT

既包含行 update 之前的值，也包含 update 之后的值。



[MySQL Binlog解析 - 朱小厮的博客](https://www.honeypps.com/backend/mysql-binlog-analysis/)



# 其他

## MySQL 8.0.1 更新，binlog 事件中包含列信息

[More Metadata Is Written Into Binary Log | MySQL High Availability](https://mysqlhighavailability.com/more-metadata-is-written-into-binary-log/)





# 相关的项目



京东的开源组件 binlake，官方介绍为：

> 一个集群化的数据库Binary Log管理、采集和分发系统，并且透明集成JMQ和Kafka等消息分发和订阅系统。

https://github.com/jd-tiger/binlake





# 问题

## TableMapEvent 顺序的一个问题

WriteRowEvent 等事件前边都是一个 TableMapEvent，但是是不是严格按照这个顺序的呢？



> **TABLE_MAP_EVENT**
>
> Used for row-based binary logging. This event precedes each row operation event. It maps a table definition to a number, where the table definition consists of database and table names and column definitions. The purpose of this event is to enable replication when a table has different definitions on the master and slave. Row operation events that belong to the same transaction may be grouped into sequences, in which case each such sequence of events begins with a sequence of `TABLE_MAP_EVENT` events: one per table used by events in the sequence.
>
> [MySQL :: MySQL Internals Manual :: 20.6 Event Meanings](https://dev.mysql.com/doc/internals/en/event-meanings.html)

TODO：上边的这段没太看懂





# 参考资料

1. [MySQL :: MySQL 8.0 Reference Manual :: 5.4.4 The Binary Log](https://dev.mysql.com/doc/refman/8.0/en/binary-log.html)
2. [MySQL :: MySQL 5.7 Reference Manual :: 4.2.2.2 Using Option Files](https://dev.mysql.com/doc/refman/5.7/en/option-files.html)
3. [MySQL :: MySQL 5.7 Reference Manual :: 16.1.6.4 Binary Logging Options and Variables](https://dev.mysql.com/doc/refman/5.7/en/replication-options-binary-log.html)
4. [maxwell实时同步mysql中binlog - kris12 - 博客园](https://www.cnblogs.com/shengyang17/p/12069175.html)
5. [腾讯工程师带你深入解析 MySQL binlog - 知乎](https://zhuanlan.zhihu.com/p/33504555)
6. [MySQL Binlog(十一)——MySQL binlog event解析实例 | Win-Man's Blog](https://win-man.github.io/2019/12/07/MySQL Binlog(十一)——MySQL binlog event解析实例/)
7. [MySql-Binlog协议详解-报文篇 - 无毁的湖光-Al的个人空间 - OSCHINA - 中文开源技术交流社区](https://my.oschina.net/alchemystar/blog/850467)

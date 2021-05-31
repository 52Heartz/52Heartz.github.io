---
title: GreenPlum 日常维护
mathjax: true
date: 2021-04-29 01:05:26
updated:
categories:
tags:
urlname: about-greenplum-routine-maintenance
---



<!-- more -->

# 表膨胀（table bloating）

数据库的目录（catalog）中保存有数据库对象的所有数据，所有数据库命令执行之前都要查询数据库目录。每个数据库都有自己数据库目录。

其中有两张表尤其重要：

`pg_classs`：存储所有的表信息

`pg_attribute`：存储所有的列信息

当数据库目录的表发生膨胀时，数据库访问和处理速度就会变慢。

[官方建议]([Pivotal Greenplum: Life in a Vacuum by Howard Goldberg – Greenplum Database](https://greenplum.org/pivotal-greenplum-vacuum-howard-goldberg/))每天 `VACUUM/ANALYZE` 系统表两次。





## 导致系统表膨胀的原因

gpload





## 定位外部表使用记录



> How do you find large external table usage?
>
> To identify frequent creation of external tables, the pg_logs can be scanned using the grep command or the pg_logs can be queried via the Greenplum gp_toolkit.__gp_log_master_ext external table. For example,
>
> ```
> select logtime::date,count(*) from gp_toolkit.__gp_log_master_ext where logmessage ilike '%create external%' group by 1 order by 1;
> ```





# Routine Vacuuming

[PostgreSQL: Documentation: 9.6: Routine Vacuuming](https://www.postgresql.org/docs/9.6/routine-vacuuming.html)





# 参考资料

1. [PostgreSQL: Documentation: 9.5: Routine Vacuuming](https://www.postgresql.org/docs/9.5/routine-vacuuming.html)
2. [Pivotal Greenplum: Life in a Vacuum by Howard Goldberg – Greenplum Database](https://greenplum.org/pivotal-greenplum-vacuum-howard-goldberg/)
3. [Understanding of Bloat and VACUUM in PostgreSQL - Percona Database Performance Blog](https://www.percona.com/blog/2018/08/06/basic-understanding-bloat-vacuum-postgresql-mvcc/)
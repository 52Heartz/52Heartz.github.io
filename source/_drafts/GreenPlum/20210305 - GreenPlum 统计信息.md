---
title: GreenPlum 统计信息
mathjax: true
date: 2021-03-05 20:44:57
updated:
categories:
tags:
urlname: about-greenplum-statistics
---



<!-- more -->







# pg_stat_activity



## query 长度被截断问题

查询出来的 query 中的 SQL 如果太长可能会被阶段。默认长度是 1024 个字节，这个配置由 `track_activity_query_size` 这个参数控制。

> Specifies the number of bytes reserved to track the currently executing command for each active session, for the `pg_stat_activity`.`query` field. The default value is 1024. This parameter can only be set at server start.
>
> ——[PostgreSQL: Documentation: 9.6: Run-time Statistics](https://www.postgresql.org/docs/9.6/runtime-config-statistics.html)





查看当前的值

```sql
SHOW track_activity_query_size;
```



修改方法

```sql
ALTER SYSTEM SET track_activity_query_size = 32768;
```

修改之后需要重启数据库服务才能生效。



[Fixing track_activity_query_size in postgresql.conf - Cybertec](https://www.cybertec-postgresql.com/en/fixing-track_activity_query_size-in-postgresql-conf/)









# 其他



## gp_vmem_idle_resource_timeout（待研究）

[How to auto terminate IDLE connection (gp_vmem_idle_resource_timeout)](https://community.pivotal.io/s/article/How-to-Auto-Terminate-IDLE-Connection-gpvmemidleresourcetimeout?language=en_US)







# 参考资料

1. [pg_stat_activity | Pivotal Greenplum Docs](https://gpdb.docs.pivotal.io/6-5/ref_guide/system_catalogs/pg_stat_activity.html)
2. [PostgreSQL: Documentation: 9.2: The Statistics Collector - pg_stat_activity](https://www.postgresql.org/docs/9.2/monitoring-stats.html#PG-STAT-ACTIVITY-VIEW)
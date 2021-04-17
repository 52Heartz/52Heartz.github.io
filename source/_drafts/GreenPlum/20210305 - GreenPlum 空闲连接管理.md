---
title: GreenPlum 空闲连接处理
mathjax: true
date: 2021-03-05 12:09:57
updated:
categories:
tags:
urlname: about-greenplum-idle-connection-handling
---



<!-- more -->



# 定时清理



```sql
-- 杀掉1小时以上的无效连接
WITH inactive_connections AS (SELECT pid,
                                     usename,
                                     query,
                                     state,
                                     application_name,
                                     client_addr,
                                     client_port,
                                     now() - state_change AS duration
                              FROM pg_stat_activity
                              WHERE
                                -- Exclude the thread owned connection (ie no auto-kill)
                                  pid <> pg_backend_pid()
                                AND
                                -- Exclude known applications connections
                                  application_name !~ '(?:psql)|(?:pgAdmin.+)'
                                AND datname = current_database()
                                AND state in
                                    ('idle', 'idle in transaction', 'idle in transaction (aborted)', 'disabled')
                                AND current_timestamp - state_change > interval '1 hours'
                              ORDER BY duration)
SELECT pid,
       usename,
       query,
       state,
       application_name,
       client_addr,
       client_port,
       duration,
       pg_terminate_backend(pid) AS terminate_success
FROM inactive_connections;
```



# pgbouncer

[PostgreSQL 连接池 pgbouncer 使用 - Digoal.Zhou’s Blog](https://billtian.github.io/digoal.blog/2010/05/11/03.html)

[Pgbouncer最佳实践：系列一 - SegmentFault 思否](https://segmentfault.com/a/1190000039308023)

[Pgbouncer最佳实践：系列二 - SegmentFault 思否](https://segmentfault.com/a/1190000039317832)

[Pgbouncer最佳实践：系列三 - SegmentFault 思否](https://segmentfault.com/a/1190000039325896)

[Pgbouncer最佳实践：系列四 - SegmentFault 思否](https://segmentfault.com/a/1190000039336288)



# 其他

GreenPlum 6 是基于 PostgreSQL 9.4 的，但是如果是 PostgreSQL 9.4 以上，还有其他方案。

比如 9.5 中引入了 `idle_in_transaction_session_timeout` 参数。

[PostgreSQL: Documentation: 13: 19.11. Client Connection Defaults - idle_in_transaction_session_timeout](https://www.postgresql.org/docs/current/runtime-config-client.html#GUC-IDLE-IN-TRANSACTION-SESSION-TIMEOUT)



# 参考资料

1. [postgresql - postgres "idle in transaction" for 13 hours - Stack Overflow](https://stackoverflow.com/questions/58103168/postgres-idle-in-transaction-for-13-hours)
2. [Is it possible to configure PostgreSQL to automatically close idle connections? - Database Administrators Stack Exchange](https://dba.stackexchange.com/questions/24193/is-it-possible-to-configure-postgresql-to-automatically-close-idle-connections)
3. [How to close idle connections in PostgreSQL automatically? - Stack Overflow](https://stackoverflow.com/questions/12391174/how-to-close-idle-connections-in-postgresql-automatically/30769511#30769511)




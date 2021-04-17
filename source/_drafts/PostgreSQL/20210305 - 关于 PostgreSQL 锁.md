---
title: 关于 PostgreSQL 锁
mathjax: true
date: 2021-03-05 12:09:57
updated:
categories:
tags:
urlname: about-postgresql-locks
---



<!-- more -->



关于锁的等待：

> Every lock in PostgreSQL has a queue. If a transaction B tries to acquire a lock that is already held by transaction A with a conflicting lock level, then transaction B will wait in the lock queue. Now something interesting happens: if another transaction C comes in, then it will not only have to check for conflict with A, but also with transaction B, and any other transaction in the lock queue.
>
> This means that even if your DDL command can run very quickly, it might be in a queue for a long time waiting for queries to finish, and *queries that start after it will be blocked behind it*.
>
> When you can have long-running SELECT queries on a table, don’t do this:
>
> ```
> ALTER TABLE items ADD COLUMN last_update timestamptz;
> ```
>
> Instead, do this:
>
> ```
> SET lock_timeout TO '2s'
> ALTER TABLE items ADD COLUMN last_update timestamptz;
> ```
>
> By setting `lock_timeout`, the DDL command will fail if it ends up waiting for a lock, and thus blocking queries for more than 2 seconds. The downside is that your `ALTER TABLE` might not succeed, but you can try again later. You may want to query [`pg_stat_activity`](https://www.postgresql.org/docs/current/static/monitoring-stats.html#PG-STAT-ACTIVITY-VIEW) to see if there are long-running queries before starting the DDL command.
>
> ——[PostgreSQL: Documentation: 13: 13.3. Explicit Locking](https://www.postgresql.org/docs/13/explicit-locking.html)

可以认为 PostgreSQL 中的表级锁都是“公平锁”，如果一个需要锁的操作没有申请到锁，那么会加入一个等待队列中，后续所有申请同一个锁的操作也会加入同一个等待队列中。这样就会有可能会导致大量操作等待，如果持有锁的操作一直没有释放锁，可能会造成严重的问题。



# pg_terminate_backend 和 pg_cancel_backend 的区别

> `pg_cancel_backend` and `pg_terminate_backend` send signals (SIGINT or SIGTERM respectively) to backend processes identified by process ID.
>
> ——[PostgreSQL: Documentation: 13: 9.27. System Administration Functions](https://www.postgresql.org/docs/current/functions-admin.html)







# 参考资料

1. [PostgreSQL 锁浅析 | PostgreSQL 中文网](https://postgres.fun/20100921154343.html)
2. [PostgreSQL: Documentation: 13: 13.3. Explicit Locking](https://www.postgresql.org/docs/13/explicit-locking.html)
3. [PostgreSQL: Documentation: 13: 9.27. System Administration Functions](https://www.postgresql.org/docs/current/functions-admin.html)
4. [Lock Monitoring - PostgreSQL wiki](https://wiki.postgresql.org/wiki/Lock_Monitoring)
5. [不要使用kill -9 杀 PostgreSQL 进程 | PostgreSQL 中文网](https://postgres.fun/20101008174858.html)
6. [PostgreSQL9.6：新增pg_blocking_pids函数准确定位 Blocking SQL - SegmentFault 思否](https://segmentfault.com/a/1190000007397817) 
7. [PostgreSQL9.6：新增加“idle in transaction”超时空闲事务自动查杀功能 - SegmentFault 思否](https://segmentfault.com/a/1190000007397841)
8. [PostgreSQL: Documentation: 9.6: Client Connection Defaults](https://www.postgresql.org/docs/9.6/runtime-config-client.html)

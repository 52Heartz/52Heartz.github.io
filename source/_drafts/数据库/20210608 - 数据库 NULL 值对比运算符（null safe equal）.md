---
title: 数据库 NULL 值对比运算符（null safe equal）
mathjax: true
date: 2021-06-08 00:13:35
updated:
categories:
tags:
urlname: about-database-null-equality
---



<!-- more -->



在 SQL 的规定中，NULL 是不等于 NULL 的，所以如果使用类似 `SELECT NULL = NULL` 这种语句，获取到的会是一个 FALSE。

但是有些时候我们又希望能够匹配到数据库中的 NULL，通常写法是 `SELECT NULL IS NULL`，但是有没有能够同时兼容 NULL 和非 NULL 的情况呢？





# MySQL

[MySQL :: MySQL 5.7 Reference Manual :: 12.4.2 Comparison Functions and Operators](https://dev.mysql.com/doc/refman/5.7/en/comparison-operators.html)

```
mysql> SELECT 1 <=> 1, NULL <=> NULL, 1 <=> NULL;
        -> 1, 1, 0
mysql> SELECT 1 = 1, NULL = NULL, 1 = NULL;
        -> 1, NULL, NULL
```







# Oracle

[Comparing NULLable Values | An Oracle Programmer](https://stewashton.wordpress.com/2015/03/02/comparing-nullable-values/)

[Oracle Null Safe Comparison (Spoiler alert: SYS_OP_MAP_NONNULL) | Aykut Akın's Blog](https://aykutakin.wordpress.com/2017/10/18/oracle-null-safe-comparison-spoiler-alert-sys_op_map_nonnull/)





# Postgresql

```sql
a IS DISTINCT FROM b
a IS NOT DISTINCT FROM b
```



[PostgreSQL: Documentation: 9.2: Comparison Operators](https://www.postgresql.org/docs/9.2/functions-comparison.html)

[PostgreSQL: Re: NULL safe equality operator](https://www.postgresql.org/message-id/Pine.LNX.4.44.0511250648580.25251-100000%40zigo.dhs.org)





# 参考资料

1. [Modern SQL: IS DISTINCT FROM — A comparison operator that treats two NULL values as the same](https://modern-sql.com/feature/is-distinct-from)
2. [Comparing NULLable Values | An Oracle Programmer](https://stewashton.wordpress.com/2015/03/02/comparing-nullable-values/)




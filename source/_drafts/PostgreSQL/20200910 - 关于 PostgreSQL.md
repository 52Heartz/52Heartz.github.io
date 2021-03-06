---
title: 关于 PostgreSQL
mathjax: true
date: 2020-09-10 16:47:50
updated:
categories:
tags:
urlname: about-postgresql-database
---



<!-- more -->

文档：[PostgreSQL: The world's most advanced open source database](https://www.postgresql.org/)



# 概念

[PostgreSQL: Documentation: 8.3: Concepts](https://www.postgresql.org/docs/8.3/tutorial-concepts.html)

Postgresql 中的很多系统表中的列名都和 Postgresql 中的概念有关，所以了解 Postgresql 定义的概念是很有必要的。比如，在 Postgresql 中，表叫做 `关系`。`关系` 其实是一种偏学术的表达。

> Relation is essentially a mathematical term for *table*.









# 模式

[PostgreSQL: Documentation: 9.0: Schemas](https://www.postgresql.org/docs/9.0/ddl-schemas.html)

> Schema names beginning with `pg_` are reserved for system purposes and cannot be created by users.
>
> [PostgreSQL: Documentation: 9.0: Schemas](https://www.postgresql.org/docs/9.0/ddl-schemas.html)



# 大小写敏感

> All **identifiers** (including column names) that are not double-quoted are folded to lower case in PostgreSQL. Column names that were created with double-quotes and thereby retained upper-case letters (and/or other syntax violations) have to be double-quoted for the rest of their life: (`"first_Name"`)

[sql - Are PostgreSQL column names case-sensitive? - Stack Overflow](https://stackoverflow.com/questions/20878932/are-postgresql-column-names-case-sensitive)





# pg_cancel_backend 和 pg_terminate_backend

[PostgreSQL: Documentation: 9.3: System Administration Functions](https://www.postgresql.org/docs/9.3/functions-admin.html)

除管理员之外，一个用户只能对自己执行的查询调用 pg_cancel_backend 和 pg_terminate_backend。

`pg_cancel_backend` and `pg_terminate_backend` 分别对执行的进程发送 SIGINT(2) 和 SIGTERM(15) 信号。













# 参考资料

1. [PostgreSQL: The world's most advanced open source database](https://www.postgresql.org/)








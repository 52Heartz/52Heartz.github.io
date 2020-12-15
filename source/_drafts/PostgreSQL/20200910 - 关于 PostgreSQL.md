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





# 模式

[PostgreSQL: Documentation: 9.0: Schemas](https://www.postgresql.org/docs/9.0/ddl-schemas.html)

> Schema names beginning with `pg_` are reserved for system purposes and cannot be created by users.
>
> [PostgreSQL: Documentation: 9.0: Schemas](https://www.postgresql.org/docs/9.0/ddl-schemas.html)









# 大小写敏感

> All **identifiers** (including column names) that are not double-quoted are folded to lower case in PostgreSQL. Column names that were created with double-quotes and thereby retained upper-case letters (and/or other syntax violations) have to be double-quoted for the rest of their life: (`"first_Name"`)

[sql - Are PostgreSQL column names case-sensitive? - Stack Overflow](https://stackoverflow.com/questions/20878932/are-postgresql-column-names-case-sensitive)





# 参考资料

1. [PostgreSQL: The world's most advanced open source database](https://www.postgresql.org/)








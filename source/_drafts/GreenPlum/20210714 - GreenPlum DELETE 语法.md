---
title: GreenPlum DELETE 语法
mathjax: true
date: 2021-07-14 01:22:10
updated:
categories:
tags:
urlname: about-greenplum-delete
---



<!-- more -->



# 删除全表时

> When using DELETE to remove all the rows of a table (for example: DELETE * FROM table;), Greenplum Database adds an implicit TRUNCATE command (when user permissions allow). The added TRUNCATE command frees the disk space occupied by the deleted rows without requiring a VACUUM of the table. This improves scan performance of subsequent queries, and benefits ELT workloads that frequently insert and delete from temporary tables.
>
> ——[DELETE | Pivotal Greenplum Database Docs](https://gpdb.docs.pivotal.io/43290/ref_guide/sql_commands/DELETE.html)

DELETE 全表的时候，数据库会自动跟一个 TRUNCATE 语句，这样就可以回收该表的所有表空间，减少表膨胀，也就不需要额外的 VACUUM 操作了。



# 参考资料

1. [DELETE | Pivotal Greenplum Database Docs](https://gpdb.docs.pivotal.io/43290/ref_guide/sql_commands/DELETE.html)
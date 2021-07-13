---
title: PostgreSQL IS DISTINCT FROM 语法
mathjax: true
date: 2021-07-14 01:25:30
updated:
categories:
tags:
urlname: about-postgresql-is-distinct-from
---



<!-- more -->



几种常见的使用方式：

（1）对比值

```sql
SELECT NULL IS DISTINCT FROM NULL;
```

（2）对比行

```sql
SELECT ('1', '2') IS DISTINCT FROM ('1', '3');
```







不支持的语法：

```sql
SELECT ('1', '2') IS DISTINCT FROM (('1', '3'), ('1', '4'));
```

报错：

[0A000] ERROR: input of anonymous composite types is not implemented









# 参考资料

1. [PostgreSQL: Documentation: 9.0: Row and Array Comparisons](https://www.postgresql.org/docs/9.0/functions-comparisons.html#AEN16964)
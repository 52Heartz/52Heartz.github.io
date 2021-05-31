---
title: 关于 PostgreSQL 排序
mathjax: true
date: 2021-05-23 00:19:03
updated:
categories:
tags:
urlname: about-postgresql-sorting
---



<!-- more -->

我们先来看一个奇怪的问题：

```sql
SELECT '*'
UNION ALL
SELECT '#'
UNION ALL
SELECT 'A'
UNION ALL
SELECT '*E'
UNION ALL
SELECT '*B'
UNION ALL
SELECT '#C'
UNION ALL
SELECT '#D'
ORDER BY 1 ASC;
```

执行上边的 SQL，你觉得排序是如何的？默认情况下排序是这样的：

```
*
#
A
*B
#C
#D
*E
```

你可能会觉得奇怪，为什么不是 `*` 和 `*` 排在一起，`#` 和 `#` 排在一起呢？实际上这是因为 PostgreSQL 对于字符串字段进行排序的时候，依赖于数据库的 `COLLATION`，有些数据库默认的 `COLLATION` 忽略了 `#` 和 `*`。

如果要排序的字符串中只有 `ASCII` 字符，我们可以使用 `COLLATION C` 进行排序，即在 `ORDER BY` 中指定 `COLLATE` 即可，参考下边的 SQL：

```sql
WITH t1 AS (
    SELECT '*' AS col1
    UNION ALL
    SELECT '#'
    UNION ALL
    SELECT 'A'
    UNION ALL
    SELECT '*E'
    UNION ALL
    SELECT '*B'
    UNION ALL
    SELECT '#C'
    UNION ALL
    SELECT '#D'
)
SELECT col1
FROM t1
ORDER BY col1 COLLATE "C" ASC;
```

这样，排序结果就变为了：

```
#
#C
#D
*
*B
*E
A
```



关于 `COLLATION C`，PostgreSQL 官方文档中是这么说的：

> On all platforms, the collations named `default`, `C`, and `POSIX` are available. Additional collations may be available depending on operating system support. The `default` collation selects the `LC_COLLATE` and `LC_CTYPE` values specified at database creation time. The `C` and `POSIX` collations both specify “traditional C” behavior, in which only the ASCII letters “`A`” through “`Z`” are treated as letters, and sorting is done strictly by character code byte values.
>
> ——[PostgreSQL: Documentation: 13: 23.2. Collation Support](https://www.postgresql.org/docs/current/collation.html)





# 参考资料

1. [sql - PostgreSQL incorrect sorting - Stack Overflow](https://stackoverflow.com/questions/22534484/postgresql-incorrect-sorting)
2. [PostgreSQL: Documentation: 13: 23.2. Collation Support](https://www.postgresql.org/docs/current/collation.html)
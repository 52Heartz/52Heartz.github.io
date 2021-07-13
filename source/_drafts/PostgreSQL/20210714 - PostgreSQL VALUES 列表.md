---
title: PostgreSQL VALUES 列表
mathjax: true
date: 2021-07-14 01:08:44
updated:
categories:
tags:
urlname: about-postgresql-values-list
---



<!-- more -->



通过 PostgreSQL 的 VALUES 语法，结合 WITH 语法，可以实现临时表的功能，

示例：

```sql
WITH TEMP_TABLE("col1", "col2", "col3") AS (
    VALUES ('OU20170313010', '2', NULL::integer), ('OU20170313012', '2', NULL::integer)
)
SELECT * FROM TEMP_TABLE;
```

这样就相当于生成了一张临时表 `TEMP_TABLE`，然后从临时表中查询出来数据。



# 注意事项

## 类型问题

> When `VALUES` is used in `INSERT`, the values are all automatically coerced to the data type of the corresponding destination column. When it's used in other contexts, it might be necessary to specify the correct data type. If the entries are all quoted literal constants, coercing the first is sufficient to determine the assumed type for all.
>
> ——[PostgreSQL: Documentation: 9.5: VALUES](https://www.postgresql.org/docs/9.5/sql-values.html)

如果 VALUES 是用在 INSERT 中，那么 VALUES 中的值会根据目标表列中的值做自动的类型转换，但是如果不是在 INSERT 中，那么就不会做类型转换，需要手动指明类型。



## 数量问题

> `VALUES` lists with very large numbers of rows should be avoided, as you might encounter out-of-memory failures or poor performance. `VALUES` appearing within `INSERT` is a special case (because the desired column types are known from the `INSERT`'s target table, and need not be inferred by scanning the `VALUES` list), so it can handle larger lists than are practical in other contexts.

如果 VALUES 中的值很多的话，可能会导致数据库服务器内存溢出（INSERT 语句除外），所以在非 INSERT 语句中使用的时候，需要注意数据量不要太大。





# 参考资料

1. [PostgreSQL: Documentation: 9.5: VALUES Lists](https://www.postgresql.org/docs/9.5/queries-values.html)
2. [PostgreSQL: Documentation: 9.5: VALUES](https://www.postgresql.org/docs/9.5/sql-values.html)


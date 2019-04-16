---
title: MySQL 的 ONLY_FULL_GROUP_BY
mathjax: true
date: 2019-04-14 09:45:41
updated:
categories:
tags:
urlname: mysql-only-full-group-by
---

关乎查询结果的稳定性。

<!-- more -->

[Why does MySQL add a feature that conflicts with SQL standards? - StackOverflow](https://stackoverflow.com/questions/7594865/why-does-mysql-add-a-feature-that-conflicts-with-sql-standards)

[SQL vs MySQL: Rules about aggregate operations and GROUP BY - StackOverflow](https://stackoverflow.com/questions/12843303/sql-vs-mysql-rules-about-aggregate-operations-and-group-by)



MySQL 官方文档对 ONLY_FULL_GROUP_BY 的说明：

> Reject queries for which the select list, `HAVING` condition, or `ORDER BY` list refer to nonaggregated columns that are not named in the `GROUP BY` clause.
>
> A MySQL extension to standard SQL permits references in the `HAVING` clause to aliased expressions in the select list. Enabling [`ONLY_FULL_GROUP_BY`](https://dev.mysql.com/doc/refman/5.6/en/sql-mode.html#sqlmode_only_full_group_by)disables this extension, thus requiring the `HAVING` clause to be written using unaliased expressions.
>
> For additional discussion and examples, see [Section 12.19.3, “MySQL Handling of GROUP BY”](https://dev.mysql.com/doc/refman/5.6/en/group-by-handling.html).
>
> ——[Server SQL Modes - MySQL :: MySQL 5.6 Reference Manual](https://dev.mysql.com/doc/refman/5.6/en/sql-mode.html#sqlmode_only_full_group_by)





# 查看和修改设置

ONLY_FULL_GROUP_BY 是在 `sql_node`  参数中设置的。

## 查看

查看 `sql_node` 的命令：

```sql
-- 查看全局设置
SELECT @@GLOBAL.sql_mode;
-- 或
SHOW GLOBAL VARIABLES LIKE "sql_mode";

-- 查看当前连接的设置
SELECT @@SESSION.sql_mode;
-- 或
SHOW SESSION VARIABLES LIKE "sql_mode";

-- 使用 SHOW VARIABLES 命令，不加 GLOBAL 和 SESSION 的话，默认是 SESSION
```

参考 [SHOW VARIABLES Syntax - MySQL :: MySQL 8.0 Reference Manual](https://dev.mysql.com/doc/refman/8.0/en/show-variables.html)

## 修改

修改之前记得先备份原来的参数值。

STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION



```sql
set sql_mode=ONLY_FULL_GROUP_BY;
```





在一个相关的知乎回答中，蚂蚁金服 OceanBase 数据库开发专家聿明提到：

> 在 SQL 标准里，出现在 select target list 中并且没有出现在聚集函数中的表达式必须出现在 GROUP BY 子句中，Oracle 是严格按照 SQL 标准来实现的。所以它的查询结果也是稳定的。
>
> MySQL 拓展了这个标准语义，不要求普通表达式必须出现在 GROUP BY 子句中。这有个问题就是可能带来查询结果的不稳定，所以 MySQL 有个系统变量可以控制这种行为：ONLY_FULL_GROUP_BY，关于这个系统变量的说明，可以参考...
>
> ——[《mysql的ONLY_FULL_GROUP_BY语义》](https://mp.weixin.qq.com/s?__biz=MzA4MzYxMjEwMg==&mid=401101783&idx=1&sn=194ce91d17fc08cbc23e31f7cb1aeaac&scene=1&srcid=0114bvnBVoYWBDjimo2mUS07&from=singlemessage&isappinstalled=0#wechat_redirect)
>
> 还有两篇在聿明的微博文章中：[链接](https://weibo.com/p/1005052905241741/wenzhang)

# 其他

MySQL 5.7 中好像默认开启了 ONLY_FULL_GROUP_BY，所以，之前在 MySQL 中可以使用的写法换到 5.7 就不能使用了，网上有很多相关的文章。



# 参考资料

1. [MySQL SQL GROUP BY是如何选择哪一条数据留下的?](https://www.zhihu.com/question/20863388)
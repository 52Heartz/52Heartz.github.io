---
title: GreenPlum 建表
mathjax: true
date: 2021-07-04 16:59:18
updated:
categories:
tags:
urlname: about-greenplum-create-table
---



<!-- more -->



# 复制表结构

## CREATE TABLE LIKE 语法

注意事项：`LIKE ...` 需要放在括号中，不然执行会报错。下边是正确的示例：

```sql
CREATE TABLE table1_copy (
    LIKE table1
);
```





# 参考资料

1. [Choosing the Table Storage Model | Pivotal Greenplum Docs](https://gpdb.docs.pivotal.io/6-3/admin_guide/ddl/ddl-storage.html#topic38)
2. [Best Practices Summary | Pivotal Greenplum Docs](https://gpdb.docs.pivotal.io/6-3/best_practices/summary.html)
3. [CREATE TABLE | Pivotal Greenplum Docs](https://gpdb.docs.pivotal.io/6-3/ref_guide/sql_commands/CREATE_TABLE.html)
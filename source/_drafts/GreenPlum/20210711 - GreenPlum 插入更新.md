---
title: GreenPlum 插入更新
mathjax: true
date: 2021-07-11 23:43:49
updated:
categories:
tags:
urlname: about-greenplum-upsert
---



<!-- more -->



# 测试

基于 Java 的 PreparedStatement 做测试：



```sql
INSERT INTO "fine_data_db"."peng_test"."07112205employees" ("emp_no", "birth_date", "first_name", "last_name", "gender",
                                                            "hire_date", "__ft_update_timestamp")
VALUES (130322, '1957-01-02 +08', 'Alagu', 'Schaad', 'M', '1986-09-02 +09', 1626017517399);
```

正常插入，没有报错。



```sql
WITH new_values ("emp_no", "birth_date", "first_name", "last_name", "gender", "hire_date", "__ft_update_timestamp")
         AS (VALUES (13037, '1957-01-02', 'Alagu', 'Schaad', 'M', '1986-09-02', 1626017517399)),
     updated
         AS (UPDATE "fine_data_db"."peng_test"."07112205employees" dest_table SET
         "birth_date" = nv."birth_date",
         "first_name" = nv."first_name",
         "last_name" = nv."last_name",
         "gender" = nv."gender",
         "hire_date" = nv."hire_date",
         "__ft_update_timestamp" = nv."__ft_update_timestamp"
         FROM new_values nv
         WHERE dest_table."emp_no" = nv."emp_no" RETURNING dest_table.*)
INSERT
INTO "fine_data_db"."peng_test"."07112205employees" ("emp_no", "birth_date", "first_name", "last_name", "gender",
                                                     "hire_date", "__ft_update_timestamp")
SELECT "emp_no", "birth_date", "first_name", "last_name", "gender", "hire_date", "__ft_update_timestamp"
FROM new_values
WHERE NOT EXISTS(SELECT 1 FROM updated WHERE updated."emp_no" = new_values."emp_no");
```

报错：

> [42804] ERROR: column "birth_date" is of type date but expression is of type text 建议：You will need to rewrite or cast the expression.

使用 WITH 生成的临时表的值必须要做格式转换才行，不然比较会出错，参考下边的示例：



```sql
WITH new_values ("emp_no", "birth_date", "first_name", "last_name", "gender", "hire_date", "__ft_update_timestamp")
         AS (VALUES (13037, '1957-01-02'::date, 'Alagu', 'Schaad', 'M', '1986-09-02'::date, 1626017517399),
                    (13038, '1957-01-02'::date, 'Alagu', 'Schaad', 'M', '1986-09-02'::date, 1626017517399)),
     updated
         AS (UPDATE "fine_data_db"."peng_test"."07112205employees" dest_table SET
         "birth_date" = nv."birth_date",
         "first_name" = nv."first_name",
         "last_name" = nv."last_name",
         "gender" = nv."gender",
         "hire_date" = nv."hire_date",
         "__ft_update_timestamp" = nv."__ft_update_timestamp"
         FROM new_values nv
         WHERE dest_table."emp_no" = nv."emp_no" RETURNING dest_table.*)
INSERT
INTO "fine_data_db"."peng_test"."07112205employees" ("emp_no", "birth_date", "first_name", "last_name", "gender",
                                                     "hire_date", "__ft_update_timestamp")
SELECT "emp_no", "birth_date", "first_name", "last_name", "gender", "hire_date", "__ft_update_timestamp"
FROM new_values
WHERE NOT EXISTS(SELECT 1 FROM updated WHERE updated."emp_no" = new_values."emp_no");
```

报错：

> [0A000] ERROR: writable CTE queries cannot be themselves writable
>
> 详细：Greenplum Database currently only support CTEs with one writable clause, called in a non-writable context.
>
> 建议：Rewrite the query to only include one writable clause.





# 参考资料


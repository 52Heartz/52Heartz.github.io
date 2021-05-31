---
title: 关于 GreenPlum
mathjax: true
date: 2020-09-13 16:28:57
updated:
categories:
tags:
urlname: about-greenplum
---



<!-- more -->



# 基本信息

[Pivotal Greenplum 6.0 Release Notes | Pivotal Greenplum Docs](https://gpdb.docs.pivotal.io/6-0/relnotes/gpdb-60-release-notes.html)



GreenPlum 6.x 是基于 PostgeSQL 9.4 开发的。

> Greenplum Database is based on PostgreSQL 9.4.
>
> ——[Summary of Greenplum Features | Pivotal Greenplum Docs](https://gpdb.docs.pivotal.io/6-7/ref_guide/feature_summary.html)



# 模式（Schema）

[Creating and Managing Schemas | Pivotal Greenplum Docs](https://gpdb.docs.pivotal.io/560/admin_guide/ddl/ddl-schema.html)



## 系统内置模式（System Schemas）

下列的系统模式在每个数据库中都有。

> - pg_catalog contains the system catalog tables, built-in data types, functions, and operators. It is always part of the schema search path, even if it is not explicitly named in the search path.
> - information_schema consists of a standardized set of views that contain information about the objects in the database. These views get system information from the system catalog tables in a standardized way.
> - pg_toast stores large objects such as records that exceed the page size. This schema is used internally by the Greenplum Database system.
> - pg_bitmapindex stores bitmap index objects such as lists of values. This schema is used internally by the Greenplum Database system.
> - pg_aoseg stores append-optimized table objects. This schema is used internally by the Greenplum Database system.
> - gp_toolkit is an administrative schema that contains external tables, views, and functions that you can access with SQL commands. All database users can access gp_toolkit to view and query the system log files and other system metrics.



## 创建数据表

[创建和管理表 | Greenplum数据库文档](https://gp-docs-cn.github.io/docs/admin_guide/ddl/ddl-table.html) | 英文版：[Creating and Managing Tables | Pivotal Greenplum Docs](https://gpdb.docs.pivotal.io/5250/admin_guide/ddl/ddl-table.html)

[CREATE TABLE | Greenplum数据库文档](https://gp-docs-cn.github.io/docs/ref_guide/sql_commands/CREATE_TABLE.html) | [CREATE TABLE | Pivotal Greenplum Docs](https://gpdb.docs.pivotal.io/5250/ref_guide/sql_commands/CREATE_TABLE.html)

[Choosing the Table Storage Model | Pivotal Greenplum Docs](https://gpdb.docs.pivotal.io/6-3/admin_guide/ddl/ddl-storage.html)



### 设置表和列约束



#### 外键

不支持外键。用户可以声明它们，但是参照完整性不会被实施。



### 选择表分布策略

所有的Greenplum数据库表都会被分布。当用户创建或者修改一个表时，用户可以有选择地指定DISTRIBUTED BY（哈希分布）或者 DISTRIBUTED RANDOMLY（循环分布）来决定该表的行分布。

[配置参数 - gp_create_table_random_default_distribution | Greenplum数据库文档](https://gp-docs-cn.github.io/docs/ref_guide/config_params/guc-list.html#gp_create_table_random_default_distribution)





#### 声明分布键

CREATE TABLE的可选子句DISTRIBUTED BY和DISTRIBUTED RANDOMLY指定一个表的分布策略。默认是使用PRIMARY KEY（如果表有主键）或者表的第一个列作为分布键的哈希分布策略。几何或者用户定义数据类型的列不能作为Greenplum分布键列。如果一个表没有符合要求的列，Greenplum会以随机或者循环方式分布行。

为了确保数据的均匀分布，应该选择对每个记录都唯一的分布键。如果做不到，可选择 DISTRIBUTED RANDOMLY。

主键总是表的分布键。如果不存在主键，但是存在唯一键，那么唯一键就是该表的分布键。

> 当创建一张表的时候，还有额外的子句来声明Greenplum数据库分布策略。如果没有提供 DISTRIBUTED BY 或者 DISTRIBUTED RANDOMLY 子句，则 Greenplum 使用 PRIMARY KEY（如果表有的话）或者将该表的第一列作为分布键，给表分配一种哈希分布策略。
>
> [创建和管理表 | Greenplum数据库文档](https://gp-docs-cn.github.io/docs/admin_guide/ddl/ddl-table.html)



测试0：不指定主键，仅指定分布列。

```sql
create table table_name10
(
    column_1 int,
    column_2 int
) distributed by (column_2);
```

测试结果：通过。

结论：没有指定主键时，分布列可以是任意列。



测试1：主键和分布列指定为不同的列

```sql
create table table_name1
(
    column_1 int,
    column_2 int,
    primary key(column_1)
) distributed by (column_2);
```

报错：

```
[42P16] ERROR: PRIMARY KEY and DISTRIBUTED BY definitions are incompatible 建议：When there is both a PRIMARY KEY and a DISTRIBUTED BY clause, the DISTRIBUTED BY clause must be a subset of the PRIMARY KEY.
```

结论：主键和分布键不能同步被指定，当主键被指定时，分布键只能是主键的子集。



测试2：

```sql
create table table_name2
(
	column_1 int,
	column_2 int,
	column_3 int,
	column_4 int,
	column_5 int,
	primary key (column_1, column_2, column_3)
) distributed by (column_1, column_2);
```

测试结果：通过。



测试2-1：同时指定主键和随机分布

```sql
create table table_name3
(
    column_1 int,
    column_2 int,
    column_3 int,
    column_4 int,
    column_5 int,
    primary key (column_1, column_2, column_3)
) distributed RANDOMLY;
```

测试结果：不通过。

报错：

```
[42P16] ERROR: PRIMARY KEY and DISTRIBUTED RANDOMLY are incompatible
```

结论：主键和 `DISTRIBUTED RANDOMLY` 是不兼容的。



测试3：

```sql
create table table_name
(
	column_1 int,
	column_2 date,
	column_3 int,
	column_4 int,
	column_5 int
) partition by range (column_2) (
    partition p1 
        START (date '2016-01-01') INCLUSIVE
        END (date '2017-01-01') EXCLUSIVE
        EVERY (INTERVAL '1 day')
    );
```

结果：[42P16] ERROR: cannot create partition inherited from temporary relation



测试4：

使用 EVERY 加上 PARTITION 名称。

```sql
create table table_name
(
    column_1 int,
    column_2 date,
    column_3 int,
    column_4 int,
    column_5 int
) partition by range (column_2) (
    partition p1
        START (date '2016-01-01') INCLUSIVE
            END (date '2017-01-01') EXCLUSIVE
            EVERY (INTERVAL '1 day')
    );
```



```
[2020-09-03 16:36:14] [00000] Table doesn't have 'DISTRIBUTED BY' clause -- Using column named 'column_1' as the Greenplum Database data distribution key for this table.
[2020-09-03 16:36:14] [00000] CREATE TABLE will create partition "table_name_1_prt_p1_1" for table "table_name"
[2020-09-03 16:36:14] [00000] CREATE TABLE will create partition "table_name_1_prt_p1_2" for table "table_name"
[2020-09-03 16:36:14] [00000] CREATE TABLE will create partition "table_name_1_prt_p1_3" for table "table_name"
[2020-09-03 16:36:14] [00000] CREATE TABLE will create partition "table_name_1_prt_p1_4" for table "table_name"
[2020-09-03 16:36:14] [00000] CREATE TABLE will create partition "table_name_1_prt_p1_5" for table "table_name"
```



测试5：使用 EVERY 不加 PARTITION 名称。

```sql
create table table_name
(
    column_1 int,
    column_2 date,
    column_3 int,
    column_4 int,
    column_5 int
) partition by range (column_2) (
        START (date '2016-01-01') INCLUSIVE
            END (date '2017-01-01') EXCLUSIVE
            EVERY (INTERVAL '1 month')
    );
```



结果：

```
[2020-09-03 16:39:22] [00000] Table doesn't have 'DISTRIBUTED BY' clause -- Using column named 'column_1' as the Greenplum Database data distribution key for this table.
[2020-09-03 16:39:22] [00000] CREATE TABLE will create partition "table_name_1_prt_1" for table "table_name"
[2020-09-03 16:39:22] [00000] CREATE TABLE will create partition "table_name_1_prt_2" for table "table_name"
[2020-09-03 16:39:22] [00000] CREATE TABLE will create partition "table_name_1_prt_3" for table "table_name"
[2020-09-03 16:39:22] [00000] CREATE TABLE will create partition "table_name_1_prt_4" for table "table_name"
[2020-09-03 16:39:22] [00000] CREATE TABLE will create partition "table_name_1_prt_5" for table "table_name"
[2020-09-03 16:39:22] [00000] CREATE TABLE will create partition "table_name_1_prt_6" for table "table_name"
[2020-09-03 16:39:22] [00000] CREATE TABLE will create partition "table_name_1_prt_7" for table "table_name"
[2020-09-03 16:39:22] [00000] CREATE TABLE will create partition "table_name_1_prt_8" for table "table_name"
[2020-09-03 16:39:22] [00000] CREATE TABLE will create partition "table_name_1_prt_9" for table "table_name"
[2020-09-03 16:39:22] [00000] CREATE TABLE will create partition "table_name_1_prt_10" for table "table_name"
[2020-09-03 16:39:22] [00000] CREATE TABLE will create partition "table_name_1_prt_11" for table "table_name"
[2020-09-03 16:39:22] [00000] CREATE TABLE will create partition "table_name_1_prt_12" for table "table_name"
```



测试6：两个分区子句中都使用 EVERY

```sql
create table table_name1
(
    column_1 int,
    column_2 date,
    column_3 int,
    column_4 int,
    column_5 int
) partition by range (column_2) (
        START (date '2016-01-01') INCLUSIVE END (date '2017-01-01') EXCLUSIVE EVERY (INTERVAL '6 month'),
        START (date '2017-01-01') INCLUSIVE END (date '2018-01-01') EXCLUSIVE EVERY (INTERVAL '6 month')
    );
```

结果：

```
[2020-09-03 16:47:30] [00000] Table doesn't have 'DISTRIBUTED BY' clause -- Using column named 'column_1' as the Greenplum Database data distribution key for this table.
[2020-09-03 16:47:30] [00000] CREATE TABLE will create partition "table_name1_1_prt_1" for table "table_name1"
[2020-09-03 16:47:30] [00000] CREATE TABLE will create partition "table_name1_1_prt_2" for table "table_name1"
[2020-09-03 16:47:30] [00000] CREATE TABLE will create partition "table_name1_1_prt_3" for table "table_name1"
[2020-09-03 16:47:30] [00000] CREATE TABLE will create partition "table_name1_1_prt_4" for table "table_name1"
```



测试7：PARTITION BY RANGE，范围冲突时：

```sql
create table table_name2
(
    column_1 int,
    column_2 date,
    column_3 int,
    column_4 int,
    column_5 int
) partition by range (column_2) (
        PARTITION p1 START (date '2016-01-01') INCLUSIVE END (date '2017-01-01') INCLUSIVE EVERY (INTERVAL '6 month'),
        PARTITION p2 START (date '2017-01-01') INCLUSIVE END (date '2018-01-01') EXCLUSIVE EVERY (INTERVAL '6 month')
    );
```



结果：

```
[2020-09-03 16:49:58] [42P16] ERROR: starting value of partition number 3 overlaps previous range
```





### 压缩

对于压缩的介绍：[Greenplum Database Tables and Compression – Greenplum Database](https://greenplum.org/greenplum-database-tables-compression/)



开启追加优化存储才能压缩。

行存储的时候可以开启表级压缩，列存储的时候可以开启列压缩。

| 表方向 | 可用的压缩类型 | 支持的算法                  |
| :----- | :------------- | :-------------------------- |
| 行     | 表             | ZLIB 以及 QUICKLZ           |
| 列     | 列和表         | RLE_TYPE、ZLIB 以及 QUICKLZ |



AO 表不支持指定主键或者 UNIQUE。

> A primary key constraint is simply a combination of a unique constraint and a not-null constraint.
>
> Greenplum Database automatically creates a UNIQUE index for each UNIQUE or PRIMARY KEY constraint to enforce uniqueness. Thus, it is not necessary to create an index explicitly for primary key columns. UNIQUE and PRIMARY KEY constraints are not allowed on append-optimized tables because the UNIQUE indexes that are created by the constraints are not allowed on append-optimized tables.



如果不指定主键，可能有重复数据，主要在以下场景：

1. 任务突然停止，任务重启时从最近一次保存的 kafka offfset 开始消费，会消费到重复数据。



#### 测试

测试1：

```sql
create table table_name4
(
    column_1 int,
    column_2 int,
    column_3 int,
    column_4 int ENCODING (compresstype = zlib, compresslevel =1, blocksize=65536),
    column_5 int,
    primary key (column_1)
)
    with (appendonly = true, orientation = column, compresstype = zlib, compresslevel = 1) distributed by (column_1);
```

测试结果：不通过。

```
[0A000] ERROR: append-only tables do not support unique indexes
```

结论：追加优化表不能设置主键或者唯一约束。



测试2：同时指定表压缩和列压缩。

```sql
create table table_name4
(
    column_1 int,
    column_2 int,
    column_3 int,
    column_4 int ENCODING (compresstype = zlib, compresslevel =1, blocksize=65536),
    column_5 int
)
    with (appendonly = true, orientation = column, compresstype = zlib, compresslevel = 1) distributed by (column_1);
```

测试结果：通过。

结论：可以同时指定表压缩和列压缩。



### 表分区

[GreenPlum分区表原理_hmxz2nn的博客-CSDN博客_greenplum 分区表](https://blog.csdn.net/hmxz2nn/article/details/83448182)



> **START** — 对于范围分区，定义分区的开始范围值。默认的是，开始值为 INCLUSIVE。 例如，如果用户声明了 '2016-01-01'的开始日期，则该分区会包含所有大于等于 '2016-01-01'的日期。通常， START 表达式的数据类型和分区键列的数据类型是一样的。如果不是这样，用户必须显式地转换为预期的数据类型。
>
> **END** — 对于范围分区，定义分区的结束范围值。默认的是，结束值是 EXCLUSIVE。 例如，如果用户定义了 '2016-02-01'的结束日期，则该分区将会包含所有小于该 '2016-02-01'的日期。通常， END 表达式的数据类型和分区键列的数据类型是一样的。如果不是这样，用户必须显式地转换为预期的数据类型。



测试8-1：

```sql
create table table_name5
(
    column_1 int,
    column_2 date,
    column_3 int,
    column_4 int,
    column_5 int
) partition by range (column_2) (
    START (date '2016-01-01') EXCLUSIVE END (date '2017-01-01') EXCLUSIVE EVERY (INTERVAL '6 month'),
    START (date '2017-01-01') INCLUSIVE END (date '2018-01-01') EXCLUSIVE EVERY (INTERVAL '6 month')
    );
```

测试结果：通过。

结论：不指定主键的情况下，分区键可以是任意列。（不考虑 UNIQUE 的情况下，如果有 UNIQUE，则分区键必须是 UNIQUE）



测试8-2：如果指定了主键，则分区列必须是主键的子集。

```sql
create table table_name3
(
    column_1 int,
    column_2 date,
    column_3 int,
    column_4 int,
    column_5 int,
    primary key (column_1)
) partition by range (column_2) (
        START (date '2016-01-01') EXCLUSIVE END (date '2017-01-01') EXCLUSIVE EVERY (INTERVAL '6 month'),
        START (date '2017-01-01') INCLUSIVE END (date '2018-01-01') EXCLUSIVE EVERY (INTERVAL '6 month')
    );
```

测试结果：不通过。

报错：

```
[2020-09-03 17:06:11] [42809] ERROR: PRIMARY KEY constraint must contain all columns in the partition key
[2020-09-03 17:06:11] 建议：Include column "column_2" in the PRIMARY KEY constraint or create a part-wise UNIQUE index after creating the table instead.
```

结论：主键必须包含所有分区键（即分区键必须是主键。）



测试8-3：

```sql
create table table_name15
(
    column_1 int,
    column_2 date ENCODING (compresstype = zlib, compresslevel =1, blocksize =65536),
    column_3 int,
    column_4 int,
    column_5 int
)
    with (appendonly = true, orientation = column, compresstype = zlib, compresslevel = 1, blocksize = 65536)
    distributed by (column_1)
    partition by range (column_2) (
        START (date '2016-01-01') EXCLUSIVE END (date '2017-01-01') EXCLUSIVE EVERY (INTERVAL '6 month'),
        START (date '2017-01-01') INCLUSIVE END (date '2018-01-01') EXCLUSIVE EVERY (INTERVAL '6 month')
        );
```

测试结果：通过。

结论：追加优化、列存、表压缩、列压缩、分布列、分区可以同时指定。



#### 按照日期分区

可以对类型为 `date` 或者 `timestamp` 类型的数据按照时间分区。

##### 依据 DATE 类型分区

示例1：

```sql
create table table_name18
(
    column_1 int,
    column_2 date
) partition by range (column_2) (
    START (date '2016-01-01') INCLUSIVE END (date '2017-01-01') EXCLUSIVE EVERY (INTERVAL '6 month')
    );
```



##### 依据 TIMESTAMP 类型分区

```sql
create table table_name18
(
    column_1 int,
    column_2 TIMESTAMP
) partition by range (column_2) (
    START (date '2016-01-01') INCLUSIVE END (date '2017-01-01') EXCLUSIVE EVERY (INTERVAL '6 month')
    );
```



#### 按照数字分区

示例1：

```sql
create table table_name19
(
    column_1 int,
    column_2 int
) partition by range (column_2) (
    START (2010) INCLUSIVE END (2020.0) EXCLUSIVE EVERY (5)
    );
```



#### 按照列表分区



示例1：字符串类型分区

```sql
create table table_name21
(
    column_1 int,
    column_2 VARCHAR
) partition by LIST (column_2) (
    PARTITION small VALUES ('S'),
    PARTITION medium VALUES ('M'),
    PARTITION large VALUES ('L'),
    DEFAULT PARTITION other
    );
```





#### 增加默认分区

> If incoming data does not match a partition's CHECK constraint and there is no default partition, the data is rejected. Default partitions ensure that incoming data that does not match a partition is inserted into the default partition.

如果写入的数据不满足任意一个分区的条件，那么这批数据会被拒绝写入。



# 最佳实践

[Best Practices Summary | Tanzu Greenplum Docs](https://gpdb.docs.pivotal.io/6-15/best_practices/summary.html)





# 找出数据库中的追加优化表

[pg_appendonly | Tanzu Greenplum Docs](https://gpdb.docs.pivotal.io/6-15/ref_guide/system_catalogs/pg_appendonly.html)

```sql
-- 查看所有 AO 表
SELECT b.nspname || '.' || a.relname as TableName,
       case c.columnstore
           when 'f' then 'Row Orientation'
           when 't' then 'Column Orientation'
           end                       as TableStorageType,
       case COALESCE(c.compresstype, '')
           when '' then 'No Compression'
           else c.compresstype
           end                       as CompressionType
FROM pg_class a,
     pg_namespace b,
     (select relid, segrelid, columnstore, compresstype
      from pg_appendonly) c
WHERE b.oid = a.relnamespace
  and a.oid = c.relid;
```







# UNIQUE 相关

测试9：主键和唯一索引的冲突

```sql
create table table_name3
(
    column_1 int,
    column_2 date,
    column_3 int unique,
    column_4 int,
    column_5 int,
    primary key (column_1, column_2)
) partition by range (column_2) (
        START (date '2016-01-01') EXCLUSIVE END (date '2017-01-01') EXCLUSIVE EVERY (INTERVAL '6 month'),
        START (date '2017-01-01') INCLUSIVE END (date '2018-01-01') EXCLUSIVE EVERY (INTERVAL '6 month')
    );
```

结果：

```
[2020-09-03 17:10:14] [42P16] ERROR: UNIQUE or PRIMARY KEY definitions are incompatible with each other
[2020-09-03 17:10:14] 建议：When there are multiple PRIMARY KEY / UNIQUE constraints, they must have at least one column in common.
```



测试10：主键和唯一索引重合

```sql
create table table_name3
(
    column_1 int,
    column_2 date,
    column_3 int unique,
    column_4 int,
    column_5 int,
    primary key (column_1, column_2, column_3)
) partition by range (column_2) (
        START (date '2016-01-01') EXCLUSIVE END (date '2017-01-01') EXCLUSIVE EVERY (INTERVAL '6 month'),
        START (date '2017-01-01') INCLUSIVE END (date '2018-01-01') EXCLUSIVE EVERY (INTERVAL '6 month')
    );
```



```
[2020-09-03 17:16:47] [42809] ERROR: UNIQUE constraint must contain all columns in the partition key
[2020-09-03 17:16:47] 建议：Include column "column_2" in the UNIQUE constraint or create a part-wise UNIQUE index after creating the table instead.
```



## 查看配置参数：

[查看服务器配置参数设置 | Greenplum数据库文档](https://gp-docs-cn.github.io/docs/admin_guide/topics/g-viewing-server-configuration-parameter-settings.html)

```sql
show all;
```



# 数据类型

[Data Types | Pivotal Greenplum Docs](https://gpdb.docs.pivotal.io/6-3/ref_guide/data_types.html)



GreenPlum/Postgesql 为什么不支持 unsigned 类型：

[sql server - Why aren't unsigned integer types available in the top database platforms? - Database Administrators Stack Exchange](https://dba.stackexchange.com/questions/53050/why-arent-unsigned-integer-types-available-in-the-top-database-platforms)

[PostgreSQL: Re: Unsigned integer types](https://www.postgresql.org/message-id/CAEcSYX+Arn7y4FeYPp6ZgbiiiMfZYmsn9aUyotZB-MA1n5hTOw@mail.gmail.com)



## 关于 VARCHAR 类型

[postgresql - Should I add an arbitrary length limit to VARCHAR columns? - Database Administrators Stack Exchange](https://dba.stackexchange.com/questions/20974/should-i-add-an-arbitrary-length-limit-to-varchar-columns)





# 数据装载



默认在遇到第一个错误的时候就会停止整批的数据装载。可以使用 `ERROR_LIMIT` 来启用单行隔离模式，指定一个阈值，只要没有达到阈值，那么就继续处理，失败的行会被舍弃。



[处理装载错误 | Greenplum数据库文档](https://gp-docs-cn.github.io/docs/admin_guide/load/topics/g-handling-load-errors.html) | [Handling Load Errors | Pivotal Greenplum Docs](https://gpdb.docs.pivotal.io/530/admin_guide/load/topics/g-handling-load-errors.html)

[gpload | Greenplum数据库文档](https://gp-docs-cn.github.io/docs/utility_guide/admin_utilities/gpload.html) | [gpload | Pivotal Greenplum Docs](https://gpdb.docs.pivotal.io/5280/utility_guide/admin_utilities/gpload.html)



## 表示 NULL

> NULL represents an unknown piece of data in a column or field. Within your data files you can designate a string to represent null values. The default string is \N (backslash-N) in TEXT mode, or an empty value with no quotations in CSV mode. You can also declare a different string using the NULL clause of COPY, CREATE EXTERNAL TABLE or gpload when defining your data format. For example, you can use an empty string if you do not want to distinguish nulls from empty strings. When using the Greenplum Database loading tools, any data item that matches the designated null string is considered a null value.
>
> [Representing NULL Values | Pivotal Greenplum Docs](https://gpdb.docs.pivotal.io/590/admin_guide/load/topics/g-representing-null-values.html)



GPLOAD 有一个 NULL_AS 的选项，用来指定 NULL 值。

一个相关的 BUG：[copy - invalid input syntax for integer: "\N" when gpload a text file - Stack Overflow](https://stackoverflow.com/questions/55593053/invalid-input-syntax-for-integer-n-when-gpload-a-text-file)



## COPY 装载

[用COPY装载数据 | Greenplum数据库文档](https://gp-docs-cn.github.io/docs/admin_guide/load/topics/g-loading-data-with-copy.html)

> COPY FROM 从一个文件或者标准输入把数据复制到一个表中并且把这些数据追加到表内容上。COPY是非并行的：数据在一个使用 Greenplum 的 Master 实例的单一进程中被装载。只对非常小的数据文件推荐使用 COPY。
>
> COPY的源文件必须对Master主机可访问。指定COPY源文件名称为相对于Master主机位置的路径。
>
> Greenplum使用客户端和Master服务器之间的连接从STDIN或者STDOUT复制数据。

[COPY | Pivotal Greenplum Database Docs](https://gpdb.docs.pivotal.io/43190/ref_guide/sql_commands/COPY.html) | [COPY | Greenplum数据库文档](https://gp-docs-cn.github.io/docs/ref_guide/sql_commands/COPY.html)



> When STDIN or STDOUT is specified, data is transmitted via the connection between the client and the master.

这句话的意思应该是说，如果语句中指定的是 `STDIN` 或者 `STDOUT`，那么会使用（JDBC）连接传输数据。



示例代码：

```java
public void copy(InputStream in, EntityInfo entityInfo, List<String> colNames) throws SQLException, IOException {
    Connection connection = this.getConnection();
    Throwable var5 = null;

    try {
        CopyManager cm = new CopyManager((BaseConnection)connection.unwrap(BaseConnection.class));
        InputStreamReader reader = new InputStreamReader(in, StandardCharsets.UTF_8);
        String copyCmd = String.format("COPY %s (%s) FROM STDIN CSV", entityInfo.getFullName(Quoter::doubleQuote), colNames.stream().map((column) -> {
            return "\"" + column + "\"";
        }).collect(Collectors.joining(", ")));
        cm.copyIn(copyCmd, reader);
    } catch (Throwable var16) {
        var5 = var16;
        throw var16;
    } finally {
        if (connection != null) {
            if (var5 != null) {
                try {
                    connection.close();
                } catch (Throwable var15) {
                    var5.addSuppressed(var15);
                }
            } else {
                connection.close();
            }
        }
    }
}
```



主键冲突时：

```
Exception in thread "main" org.postgresql.util.PSQLException: ERROR: duplicate key value violates unique constraint "peng-test2_pkey"
  详细：Key (id)=(1) already exists.
  在位置：COPY peng-test2, line 1
	at org.postgresql.core.v3.QueryExecutorImpl.receiveErrorResponse(QueryExecutorImpl.java:2412)
	at org.postgresql.core.v3.QueryExecutorImpl.processCopyResults(QueryExecutorImpl.java:1043)
	at org.postgresql.core.v3.QueryExecutorImpl.endCopy(QueryExecutorImpl.java:892)
	at org.postgresql.core.v3.CopyInImpl.endCopy(CopyInImpl.java:43)
	at org.postgresql.copy.CopyManager.copyIn(CopyManager.java:185)
	at org.postgresql.copy.CopyManager.copyIn(CopyManager.java:160)
```



# GPLoad 和 COPY 的对比

使用 GPLoad 方案可以插入和更新，但是不能执行删除。

使用 COPY 方案只能插入，不能更新和删除。



参考资料：

1. [MPP 二、Greenplum数据加载 - 堅持╅信念★ - 博客园](https://www.cnblogs.com/lanston/p/greenplum_data_loading.html#blog-comments-placeholder)



# 查看数据库

查看数据库列表：

> If you are working in the psql client program, you can use the \l meta-command to show the list of databases and templates in your Greenplum Database system. If using another client program and you are a superuser, you can query the list of databases from the pg_database system catalog table. For example:
>
> [Creating and Managing Databases | Pivotal Greenplum Docs](https://gpdb.docs.pivotal.io/6-3/admin_guide/ddl/ddl-database.html)

```sql
SELECT datname from pg_database;
```



# 设置时区



查看时区：

```
[gpadmin@fd-mdw root]$ gpconfig -s TimeZone
Values on all segments are consistent
GUC          : TimeZone
Master  value: PRC
Segment value: PRC
```



修改时区：

```
gpconfig -c TimeZone -v 'PRC'
```



[Pivotal Greenplum® 6.9-安装指南-配置时区和本地化设置_uddiqpl的专栏-CSDN博客](https://blog.csdn.net/uddiqpl/article/details/106974027)

[How to change the time zone on the Pivotal Greenplum Database](https://community.pivotal.io/s/article/How-to-Change-the-Time-Zone-on-the-Pivotal-Greenplum?language=en_US)



# 事务

[postgresql - How to check if the current connection is in a transaction? - Database Administrators Stack Exchange](https://dba.stackexchange.com/questions/208363/how-to-check-if-the-current-connection-is-in-a-transaction)

`SELECT now()` 获取到的是当前事务的开始时间，如果一个事务已经持续了很长时间，那么获取到的 now() 是较久之前的。



# 调试



## 查看当前执行的 query

[PostgreSQL: Documentation: 9.2: The Statistics Collector](https://www.postgresql.org/docs/9.2/monitoring-stats.html#PG-STAT-ACTIVITY-VIEW)

[What is the difference between xact_start and query_start in postgresql? - Database Administrators Stack Exchange](https://dba.stackexchange.com/questions/102859/what-is-the-difference-between-xact-start-and-query-start-in-postgresql)

[postgresql - SELECT 1 - idle in transaction - Database Administrators Stack Exchange](https://dba.stackexchange.com/questions/118922/select-1-idle-in-transaction)

[postgresql - Queries in pg_stat_activity are truncated? - Stack Overflow](https://stackoverflow.com/questions/1135266/queries-in-pg-stat-activity-are-truncated)



## 停止当前执行的 query

[PostgreSQL: Documentation: 9.3: System Administration Functions](https://www.postgresql.org/docs/9.3/functions-admin.html)

```sql
SELECT pg_cancel_backend(pid);
```



批量停止指定执行的 query：

```sql
select a.pid
from pg_locks a,
     pg_class b,
     pg_stat_activity c
where a.relation = b.oid
  and a.pid = c.pid
  and b.relname like '%dim_customer_dw%'
  AND granted = TRUE;
```



## 锁相关

[Inserting, Updating, and Deleting Data | Pivotal Greenplum Docs](https://gpdb.docs.pivotal.io/6-3/admin_guide/dml.html#topic11)

[pg_stat_activity | Pivotal Greenplum Docs](https://gpdb.docs.pivotal.io/6-3/ref_guide/system_catalogs/pg_stat_activity.html)







# 查询优化



[Determining the Query Optimizer that is Used | Tanzu Greenplum Docs](https://gpdb.docs.pivotal.io/6-15/admin_guide/query/topics/query-piv-opt-fallback.html)

[Query Profiling | Tanzu Greenplum Docs](https://gpdb.docs.pivotal.io/6-15/admin_guide/query/topics/query-profiling.html)



## 开启 GPORCA 查询优化器

[Enabling and Disabling GPORCA | Tanzu Greenplum Docs](https://gpdb.docs.pivotal.io/6-15/admin_guide/query/topics/query-piv-opt-enable.html#topic_pzr_3db_3r)

通过 `ALTER DATABASE db_name SET OPTIMIZER = ON;` 这种方式开启时，不影响已经建立的连接，新建立的数据库连接会受到影响。



# 常用命令

## gpconfig

使用 gpconfig 需要使用 gpadmin 用户





# GreenPlum 连接相关

[Troubleshooting Connection Problems | Greenplum Docs](https://docs.greenplum.org/6-6/admin_guide/access_db/topics/g-troubleshooting-connection-problems.html)

[linux下查看某一端口被哪个进程占用_Alan_Xiang的博客-CSDN博客_虚拟机查看端口占用](https://blog.csdn.net/xiangwanpeng/article/details/78804225) 



# GreenPlum 和 PostgreSQL 相关资料和网站

1. [PostgreSQL 中文网](https://postgres.fun/)



# 参考资料

1. [Greenplum性能优化之路 --（一）分区表 - 云+社区 - 腾讯云](https://cloud.tencent.com/developer/article/1374067)
2. [Greenplum性能优化之路 --（二）存储格式 - 云+社区 - 腾讯云](https://cloud.tencent.com/developer/article/1393372)
3. [Greenplum性能优化之路 --（三）ANALYZE - 云+社区 - 腾讯云](https://cloud.tencent.com/developer/article/1685910)
---
title: MySQL JDBC 相关
mathjax: true
date: 2020-09-04 11:09:58
updated:
categories:
tags:
urlname: about-mysql-jdbc
---



<!-- more -->

# JDBC 的基本介绍

JDBC 全称是 Java Database Connectivity。它是一种可以执行 SQL 语句的 Java API。程序可以通过 JDBC API 连接到关系数据库，并使用 SQL 语句来完成对数据库的查询、更新等操作。

> 最早的时候，Sun 公司希望自己开发一组 Java API，程序员通过这组 Java API 即可操作所有的数据库系统，但后来单发现这个目标具有不可实现性——因为数据库系统太多了，而且各数据库系统的内部特性又各不相同，后来 Sun 就制定了一组标准的 API，它们只是接口，没有提供实现类，这些实现类由各数据库厂商提供实现，这些实现类就是驱动程序，而程序员使用 JDBC 时，只要面向标准的 JDBC API 编程即可，当需要在数据库之间切换时，只需要更换不同的实现类（即更换数据库驱动程序）就行，这是面向接口编程的典型应用。
>
> ——《疯狂 Java》第4版

Sun 提供的 JDBC 可以完成以下三个基本操作：

- 建立于数据库的连接
- 执行 SQL 语句
- 获得 SQL 语句的执行结果



> 还有一种名为 ODBC 的技术，其全称是 Open Database Connectivity，即开放数据库连接，ODBC 和 JDBC 很像，严格来说应该是 JDBC 模仿了 ODBC 的设计，ODBC 也允许应用程序通过一组通用的 API 访问不同的数据库管理系统，从而使得基于 ODBC 的应用程序可以在不同的数据库之间切换，同样 ODBC 也需要g各数据库厂商提供相应的驱动程序，而 ODBC 则负责管理这些驱动程序。
>
> ——《疯狂 Java》第4版

# MySQL 基础

查看当前实例下包含多少个数据库：

```
show databases;
```

创建新数据库：

```
create database [IF NOT EXISTS] 数据库名;
```

删除指定数据库：

```
drop database 数据库名;
```

进入某个数据库：

```
use 数据库名;
```

进入某个数据库后，查看改数据库下包含多少个数据表：

```
show tables;
```

查看某个数据表的表结构（查看该表有多少列，每列的数据类型等信息）：

```
desc 表名;
```



## 语句类型

标准的 SQL 语句可以分为以下几种类型：

- 查询语句：主要由 SELECT 语句完成。

- DML（Data Manipulation Language，数据操作语言）主要由 INSERT、UPDATE、DELETE 三个关键字完成。
- DDL（Data Definition Language，数据定义语言）：主要由 CREATE、ALTER、DROP、TRUNCATE 四个关键字完成。
- DCL（Data Control Language，数据控制语言）：主要由 GRANT、REVOKE 两个关键字完成。
- 事务控制语句：主要由 COMMIT、ROLLBACK、SAVEPOINT 三个关键字完成。



## 标识符命名规则

标识符可以用于定义表名、列名、也可以用于定义变量等。

对标识符的命名要求有：

- 标识符必须以字母开头
- 标识符包括字母、数字和三个特殊字符（`#`、`_`、`$`）

- 不要使用当前数据库系统的关键字、保留字、
- 同一模式下的对象不应该同名，这里的模式指的是外模式



## DDL 语句

### 常见的数据库对象

| 对象名称 | 对应关键字 | 描述                                                         |
| -------- | ---------- | ------------------------------------------------------------ |
| 表       | table      |                                                              |
| 数据字典 |            | 就是系统表，存放数据库相关信息的表。系统表里的数据通常由数据库系统维护，程序员通常不应该手动修改系统表及系统表数据，只可查看系统表数据 |
| 约束     | constraint | 执行数据校验的规则，用于保证数据完整性的规则                 |
| 视图     | view       | 一个或者多个数据表里数据的逻辑显示，视图并不存储数据         |
| 索引     | index      | 用于提高查询性能                                             |
| 函数     | function   | 用于完成一次特定的计算，具有一个返回值                       |
| 存储过程 | procedure  | 用于完成依次完整的业务处理，没有返回值，但可以通过传出参数将多个值传给调用环境 |
| 触发器   | trigger    | 相当于一个事件监听器，当数据库发生特定事件后，触发器被触发，完成相应的处理 |



### 创建表

创建表的命令格式为：

```sql
CREATE TABLE [模式名.] 表名(
    columnName1 datatype [default expr],
    ...
)
```



创建表的语法示例：

```sql
CREATE TABLE test(
    id int,
    price decimal,
    test_name varchar(255) default 'xxx',
    test_desc text,
    img blob,
    test_date datetime 
);
```



MySQL 支持的列类型：

| 列类型                                             | 说明                                                         |
| -------------------------------------------------- | ------------------------------------------------------------ |
| tinyint/smallint/mediumint/<br>int(integer)/bigint | 1字节/2字节/3字节/4字节/8字节整数，又可分为有符号和无符号两种。这些整数类型的却别仅仅是表述范围不同 |
| float/double                                       | 单精度、双精度浮点型                                         |
| decimal(dec)                                       | 精确小鼠类型，相对于float和double不会产生精度丢失的问题      |
| date                                               | 日期类型，不能保存时间。把 java.util.Date 对象保存进 date 列时，时间部分将会丢失 |
| time                                               | 时间类型，不能保存日期。把 java.util.Date 对象保存进 time 列时，日期部分将会丢失 |
| datetime                                           | 日期、时间类型                                               |
| timestamp                                          | 时间戳类型                                                   |
| year                                               | 年类型，仅仅保存时间的年份                                   |
| char                                               | 定长字符串类型                                               |
| varchar                                            | 可变长度字符串类型                                           |
| binary                                             | 定长二进制字符串类型，它以二进制形式保存字符串               |
| varbinary                                          | 可变长度的二进制字符串类型，它以二进制保存字符串             |
| tinyblob/blob<br>mediumblob/longblob               | 1字节/2字节/3字节/4字节的二进制大对象，可用于存储图片、音乐等二进制数据，分别可以存储255B/64KB/16MB/4GB的大小 |
| tinytext/text<br>mediumtext/longtext               | 1字节/2字节/3字节/4字节的文本对象，可用于存储超长长度的字符串，分别可存储：255B/64KB/16MB/4GB的文本 |
| enum('value1','value2',...)                        | 枚举类型，该列的值只能是 enum 后面括号里多个值的其中之一     |
| set('value1','value2',...)                         | 集合类型，该列的之可以是 set 后括号里多个值的其中几个        |



#### 根据查询的结果建表

除了指定各个列的名称和类型来建表，还可以通过对已存在的表进行查询，根据查出的数据建表：

比如：

```sql
CREATE TABLE test
AS
SELECT * FROM user_inf;
```

这个语句就是使用 `SELECT * FROM user_inf;` 的查询结果来进行建表。



### 修改表

#### 增加列定义

修改表结构使用 `ALTER TABLE`，修改表结果包括增加列定义、修改列定义、删除列、重命名列等操作。

增加列定义的语法如下：

```sql
ALTER TABLE 表名
ADD (
    column_name1 datatype [default expr],
    ...
);
```

增加字段时需注意：如果数据表中已有数据记录。除非给新增的列指定了默认值，否则新增的数据列不可制定非空约束，因为那些已有的记录在新增列上肯定是空（实际上，修改表结构很容易失败，只要新增的约束与已有数据冲突，修改就会失败）。

#### 修改列定义

修改列定义就是指修改除了列名之外的其他信息，修改列名另有别的方式。

修改列定义的语法如下：

```sql
ALTER TABLE 表名 MODIFY column_name datatype [default expr] [first|after colname];
```

示例：

```sql
ALTER TABLE 表名 MODIFY test_desc longtext;
-- 把 test_desc 列改为 longtext 类型
```



#### 删除列

用法：

```sql
DROP TABLE 表名 DROP column_name;
```

#### MySQL 专有的

修改表名：

```sql
ALTER TABLE 表名 RENAME TO 新表名;
```

修改列名：

```sql
ALTER TABLE 表名 CHANGE old_column_name new column_name datatype [default expr] [first|after col_name];
```

`CHANGE` 关键字比 `MODIFY` 关键字多了修改列名的功能。



### 删除表

```sql
DROP TABLE 表名;
```

删除表会使表结构、表对象、表里的所有数据、表所有相关的索引、约束也被删除。



### TRUNCATE 表

`TRUNCATE` 被称作”截断“某个表，作用是删除表中所有数据，但是保留表结构。

用法：

```sql
TRUNCATE 表名;
```



## 数据库约束





# 不同数据库 JDBC



## JDBC 连接

MySQL：[MySQL :: Connectors and APIs Manual :: 3.5.2 Connection URL Syntax](https://dev.mysql.com/doc/connectors/en/connector-j-reference-jdbc-url-format.html)

MySQL 的数据连接可以不指定数据库，而且可以访问多个数据库，只要在 SQL 中加上数据库名称即可。



PotstgreSql：[Connecting to the Database](https://jdbc.postgresql.org/documentation/head/connect.html)

Postgre 必须指定一个数据库，而且一个数据连接只能访问一个数据库。

> Actually, the even more general syntax
>
> ```
> database.schema.table
> ```
>
> can be used too, but at present this is just for *pro forma* compliance with the SQL standard. If you write a database name, it must be the same as the database you are connected to.

PG 中，SQL 也可以带上数据库名称，但是带了也必须和连接的数据库名称一样。只是为了形式上符合SQL标准。

[postgresql - The infamous java.sql.SQLException: No suitable driver found - Stack Overflow](https://stackoverflow.com/questions/1911253/the-infamous-java-sql-sqlexception-no-suitable-driver-found)





## DatabaseMetaData#getTableTypes

PostgreSQL：

```
+--------------------+
|     TABLE_TYPE     |
+--------------------+
| FOREIGN TABLE      |
| INDEX              |
| MATERIALIZED VIEW  |
| SEQUENCE           |
| SYSTEM INDEX       |
| SYSTEM TABLE       |
| SYSTEM TOAST INDEX |
| SYSTEM TOAST TABLE |
| SYSTEM VIEW        |
| TABLE              |
| TEMPORARY INDEX    |
| TEMPORARY SEQUENCE |
| TEMPORARY TABLE    |
| TEMPORARY VIEW     |
| TYPE               |
| VIEW               |
+--------------------+
```



MySQL：

```
+------------------+
|    TABLE_TYPE    |
+------------------+
| LOCAL TEMPORARY  |
| SYSTEM TABLE     |
| SYSTEM VIEW      |
| TABLE            |
| VIEW             |
+------------------+
```





## DatabaseMetaData#getTables



### MySQL



```
+-----------+-------------+------------------------+------------+---------+
| TABLE_CAT | TABLE_SCHEM |       TABLE_NAME       | TABLE_TYPE | REMARKS |
+-----------+-------------+------------------------+------------+---------+
| fr_ds     | NULL        | dw_business_package    | TABLE      |         |
| fr_ds     | NULL        | dw_business_table      | TABLE      |         |
| fr_ds     | NULL        | dw_task_view1          | VIEW       |         |
+-----------+-------------+------------------------+------------+---------+
```





PS：

MySQL 的 information_schema 中的表的类型都是 `SYSTEM VIEW`

```java
metaData.getTables("information_schema", null, null, new String[]{"TABLE", "VIEW"})
```

这个是什么都获取不到的。



### PostgreSQL

```
+-----------+-------------+----------------------+------------+---------+
| table_cat | table_schem |      table_name      | table_type | remarks |
+-----------+-------------+----------------------+------------+---------+
| (unknown) | public      | dim_agent_list       | TABLE      | NULL    |
| (unknown) | public      | dw_example           | TABLE      | NULL    |
| (unknown) | public      | maxlength            | TABLE      | NULL    |
| (unknown) | public      | peng-test2           | TABLE      | NULL    |
| (unknown) | public      | peng_test_1          | TABLE      | NULL    |
| (unknown) | public      | person               | TABLE      | NULL    |
| (unknown) | public      | sales                | TABLE      | NULL    |
| (unknown) | public      | sales_col            | TABLE      | NULL    |
| (unknown) | public      | tab100w              | TABLE      | NULL    |
| (unknown) | public      | tab10w               | TABLE      | NULL    |
| (unknown) | public      | tab1w                | TABLE      | NULL    |
| (unknown) | public      | table_name           | TABLE      | NULL    |
| (unknown) | public      | table_name1          | TABLE      | NULL    |
| (unknown) | public      | table_name1_1_prt_1  | TABLE      | NULL    |
| (unknown) | public      | table_name1_1_prt_2  | TABLE      | NULL    |
| (unknown) | public      | table_name1_1_prt_3  | TABLE      | NULL    |
| (unknown) | public      | table_name1_1_prt_4  | TABLE      | NULL    |
| (unknown) | public      | test_kafka           | TABLE      | NULL    |
+-----------+-------------+----------------------+------------+---------+
```



PS：分区表也会和普通表一样被列出来。





## ResultSetMetaData#getColumnLabel 和 getColumnName

MySQL：

如果 select 的是原始列，那么 `getColumnName()` 是原始列名，如果 SQL 中有 `AS`，那么 `getColumnLabel()` 就是 AS 指定的名称。

如果 select 的是计算出来的列，比如 `count(*)`，那么两个方法返回结果一样。





# 类型映射关系



`com.mysql.cj.MysqlType` 中有 MySQL 数据库中各种类型和 Java 中各种类型的映射关系。



```java
public enum MysqlType implements SQLType {
    DECIMAL("DECIMAL", 3, BigDecimal.class, 64, true, 65L, "[(M[,D])] [UNSIGNED] [ZEROFILL]"),
    DECIMAL_UNSIGNED("DECIMAL UNSIGNED", 3, BigDecimal.class, 96, true, 65L, "[(M[,D])] [UNSIGNED] [ZEROFILL]"),
    TINYINT("TINYINT", -6, Integer.class, 64, true, 3L, "[(M)] [UNSIGNED] [ZEROFILL]"),
    TINYINT_UNSIGNED("TINYINT UNSIGNED", -6, Integer.class, 96, true, 3L, "[(M)] [UNSIGNED] [ZEROFILL]"),
    BOOLEAN("BOOLEAN", 16, Boolean.class, 0, false, 3L, ""),
    SMALLINT("SMALLINT", 5, Integer.class, 64, true, 5L, "[(M)] [UNSIGNED] [ZEROFILL]"),
    // ...
}
```





# 其他

## Utilities

[htorun/dbtableprinter: Database Table Printer - a Java utility class to print a pretty table to standard out.](https://github.com/htorun/dbtableprinter)

[Aliuken/JavaDbUtilities: Get metadata from a database using JDBC](







# 关键配置项

## allowMultiQueries

> Allow the use of ';' to delimit multiple queries during one statement (true/false), defaults to 'false', and does not affect the addBatch() and executeBatch() methods, which instead rely on rewriteBatchedStatements.
>
> Default: false

该配置项为 false，则 `Statement#execute()` 一次只能执行一条 SQL 语句。如果为 true，则可以一次执行多条 SQL 语句，语句之间使用 `;` 分隔即可。





# 参考资料

1. [MySQL :: MySQL Connector/J 5.1 Developer Guide :: 5.3 Configuration Properties for Connector/J](https://dev.mysql.com/doc/connector-j/5.1/en/connector-j-reference-configuration-properties.html)
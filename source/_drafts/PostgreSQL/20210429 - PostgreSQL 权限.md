---
title: PostgreSQL 权限
mathjax: true
date: 2021-04-29 00:14:26
updated:
categories:
tags:
urlname: about-postgresql-privileges
---



<!-- more -->



# 用户权限

# GRANT

允许访问全部表：

```sql
GRANT SELECT ON ALL TABLES IN SCHEMA schema_name TO role_name;
```



允许访问单张表：

```sql
GRANT SELECT ON schema_name.table_name TO role_name;
```



## 查看 GRANT

### 使用 SQL

```sql
WITH "names"("name") AS (
  SELECT n.nspname AS "name"
    FROM pg_catalog.pg_namespace n
      WHERE n.nspname !~ '^pg_'
        AND n.nspname <> 'information_schema'
) SELECT "name",
  pg_catalog.has_schema_privilege(current_user, "name", 'CREATE') AS "create",
  pg_catalog.has_schema_privilege(current_user, "name", 'USAGE') AS "usage"
    FROM "names";
```

参考：[sql - postgresql - view schema privileges - Stack Overflow](https://stackoverflow.com/questions/22715053/postgresql-view-schema-privileges)



### 使用 psql

> Use [psql](https://www.postgresql.org/docs/9.4/app-psql.html)'s `\dp` command to obtain information about existing privileges for tables and columns. For example:
>
> ——[PostgreSQL: Documentation: 9.4: GRANT](https://www.postgresql.org/docs/9.4/sql-grant.html)



# ALTER DEFAULT PRIVILEGES

`ALTER DEFAULT PRIVILEGES` 可以设置对于新创建的对象的默认权限，但不影响当前已经存在的对象的权限。



示例：

```sql
-- 允许 role2 读取 role1 以后在 schema_name 中新建的表
ALTER DEFAULT PRIVILEGES FOR USER role1 IN SCHEMA schema_name GRANT SELECT ON TABLES TO role2;
```



## 查看 DEFAULT PRIVILEGES

### 使用 SQL

```sql
SELECT 
  nspname,         -- schema name
  defaclobjtype,   -- object type
  defaclacl        -- default access privileges
FROM pg_default_acl a JOIN pg_namespace b ON a.defaclnamespace=b.oid;
```

[sql - Display default access privileges for relations, sequences and functions in Postgres - Stack Overflow](https://stackoverflow.com/questions/14555062/display-default-access-privileges-for-relations-sequences-and-functions-in-post)



### 使用 psql

> Use [psql](https://www.postgresql.org/docs/9.4/app-psql.html)'s `\ddp` command to obtain information about existing assignments of default privileges. The meaning of the privilege values is the same as explained for `\dp` under [GRANT](https://www.postgresql.org/docs/9.4/sql-grant.html).
>
> ——[PostgreSQL: Documentation: 9.4: ALTER DEFAULT PRIVILEGES](https://www.postgresql.org/docs/9.4/sql-alterdefaultprivileges.html)



# 其他

## GRANT SELECT ON ALL TABLES 时报错

`GRANT SELECT ON ALL TABLES ...` 可能会报错 `ERROR: tuple concurrently updated`。

一种原因可能是对应 schema 中正在删除表，导致 GRANT 对应表的权限的时候，因为表被删除，导致失败。



# 登录权限

```
The specified database user/password combination is rejected: [28000] FATAL: no pg_hba.conf entry for host "x.x.x.x", user "xxx", database "xxx"
```

[PostgreSQL: Documentation: 9.1: The pg_hba.conf File](https://www.postgresql.org/docs/9.1/auth-pg-hba-conf.html)

[程序链接PostgreSQL 时报错"no pg_hba.conf entry"_刘春明的博客-CSDN博客](https://blog.csdn.net/liuchunming033/article/details/44810899)

[PostgreSQL重新读取pg_hba.conf文件 - TIME_dy - 博客园](https://www.cnblogs.com/ldy-miss/p/10132138.html)

GreenPlum：[Configuring Client Authentication | Tanzu Greenplum Docs](https://gpdb.docs.pivotal.io/6-16/security-guide/topics/Authenticate.html)



# 参考资料

1. [PostgreSQL: Documentation: 9.4: GRANT](https://www.postgresql.org/docs/9.4/sql-grant.html)
2. [PostgreSQL: Documentation: 9.4: ALTER DEFAULT PRIVILEGES](https://www.postgresql.org/docs/9.4/sql-alterdefaultprivileges.html)
3. [sql - Grant privileges on future tables in PostgreSQL? - Stack Overflow](https://stackoverflow.com/questions/22684255/grant-privileges-on-future-tables-in-postgresql)

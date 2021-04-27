---
title: Java 操作 SQLite
mathjax: true
date: 2020-01-29 16:54:38
updated:
categories: Java
tags:
urlname: java-and-sqlite
---



<!-- more -->



SQLite 的 JDBC 库有：

[xerial/sqlite-jdbc: SQLite JDBC Driver](https://github.com/xerial/sqlite-jdbc)

Github 主页上也有基本的使用方法介绍。

还有一个专门的教程网站：[SQLite Tutorial](https://www.sqlitetutorial.net/)



# 插入 BLOB 数据

[SQLite Java: Write and Read BLOB](https://www.sqlitetutorial.net/sqlite-java/jdbc-read-write-blob/)



# 批量插入

JDBC 通用操作：

[JDBC Batch Insert Example | Examples Java Code Geeks - 2020](https://examples.javacodegeeks.com/core-java/sql/jdbc-batch-insert-example/)

```java
String sqlQuery = "insert into PERSONS values (?,?,?,?)";
try{
     PreparedStatement pstmt = connection.prepareStatement(sqlQuery);
     connection.autoCommit(false);
     for(int i=1; i<= 200;i++){
          pstmt.setString(1,"Java");
          pstmt.setString(2,"CodeGeeks");
          pstmt.setInt(3,i);
          pstmt.setInt(4,i);
          pstmt.addBatch();
     }
     int[] result = pstmt.executeBatch();
     System.out.println("The number of rows inserted: "+ result.length);
     connection.commit();
}catch(Exception e){
     e.printStackTrace();
     connection.rollBack();
} finally{
     if(pstmt!=null)
        pstmt.close();
if(connection!=null)
     connection.close();
}
```



# 获取上一条插入之后的自增 ID

```sql
SELECT LAST_INSERT_ROWID() FROM %s
```

[Last Insert Rowid](https://sqlite.org/c3ref/last_insert_rowid.html)





# 常见报错

场景：

多个线程中同时使用 `DriverManager.getConnection(url)` 获取 Connection，多个 Connection 同时执行写入操作时会报这个错误。

```
org.sqlite.SQLiteException: [SQLITE_BUSY]  The database file is locked (database is locked)
	at org.sqlite.core.DB.newSQLException(DB.java:1010)
	at org.sqlite.core.DB.newSQLException(DB.java:1022)
	at org.sqlite.core.DB.throwex(DB.java:987)
	at org.sqlite.core.NativeDB.prepare_utf8(Native Method)
	at org.sqlite.core.NativeDB.prepare(NativeDB.java:134)
	at org.sqlite.core.DB.prepare(DB.java:264)
	at org.sqlite.jdbc3.JDBC3Statement.execute(JDBC3Statement.java:52)
	at com.fr.plugin.test.database.sqlite.SqliteTest.lambda$concurrentReadWriteTest2$2(SqliteTest.java:94)
	at java.util.concurrent.Executors$RunnableAdapter.call(Executors.java:511)
	at java.util.concurrent.FutureTask.runAndReset(FutureTask.java:308)
	at java.util.concurrent.ScheduledThreadPoolExecutor$ScheduledFutureTask.access$301(ScheduledThreadPoolExecutor.java:180)
	at java.util.concurrent.ScheduledThreadPoolExecutor$ScheduledFutureTask.run(ScheduledThreadPoolExecutor.java:294)
	at java.util.concurrent.ThreadPoolExecutor.runWorker(ThreadPoolExecutor.java:1149)
	at java.util.concurrent.ThreadPoolExecutor$Worker.run(ThreadPoolExecutor.java:624)
	at java.lang.Thread.run(Thread.java:748)
```



> The SQLITE_BUSY result code indicates that the database file could not be written (or in some cases read) because of concurrent activity by some other [database connection](https://www.sqlite.org/c3ref/sqlite3.html), usually a database connection in a separate process.
>
> [Result and Error Codes](https://www.sqlite.org/rescode.html#busy)



# 参考资料

1. [SQLite – Java | 菜鸟教程](https://www.runoob.com/sqlite/sqlite-java.html)


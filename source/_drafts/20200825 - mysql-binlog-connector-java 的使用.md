---
title: mysql-binlog-connector-java 的使用
mathjax: true
date: 2020-08-25 21:07:02
updated:
categories:
tags:
urlname: about-mysql-binlog-connector-java
---



<!-- more -->

开源库地址

https://github.com/shyiko/mysql-binlog-connector-java（不维护）

https://github.com/osheroff/mysql-binlog-connector-java（维护中）







# 读取实时数据

## Tapping into MySQL replication stream

> PREREQUISITES: Whichever user you plan to use for the BinaryLogClient, he MUST have [REPLICATION SLAVE](http://dev.mysql.com/doc/refman/5.5/en/privileges-provided.html#priv_replication-slave) privilege. Unless you specify binlogFilename/binlogPosition yourself (in which case automatic resolution won't kick in), you'll need [REPLICATION CLIENT](http://dev.mysql.com/doc/refman/5.5/en/privileges-provided.html#priv_replication-client) granted as well.

```
BinaryLogClient client = new BinaryLogClient("hostname", 3306, "username", "password");
EventDeserializer eventDeserializer = new EventDeserializer();
eventDeserializer.setCompatibilityMode(
    EventDeserializer.CompatibilityMode.DATE_AND_TIME_AS_LONG,
    EventDeserializer.CompatibilityMode.CHAR_AND_BINARY_AS_BYTE_ARRAY
);
client.setEventDeserializer(eventDeserializer);
client.registerEventListener(new EventListener() {

    @Override
    public void onEvent(Event event) {
        ...
    }
});
client.connect();
```

> You can register a listener for `onConnect` / `onCommunicationFailure` / `onEventDeserializationFailure` / `onDisconnect` using `client.registerLifecycleListener(...)`.

> By default, BinaryLogClient starts from the current (at the time of connect) master binlog position. If you wish to kick off from a specific filename or position, use `client.setBinlogFilename(filename)` + `client.setBinlogPosition(position)`.

> `client.connect()` is blocking (meaning that client will listen for events in the current thread). `client.connect(timeout)`, on the other hand, spawns a separate thread.



使用：

```
client.setBinlogFilename();
client.setBinlogPosition();
```

如果指定了不存在的 binlog 文件名，那么 BinlogClient 的线程不会结束，但是什么反应也不会有。

如果传的参数是空字符串，会从第一个 binlog 文件开始解析。



如果指定了错误的 position，会自动调整：

```
警告: Binary log position adjusted from -100 to 4
```





# 参考资料

1. 
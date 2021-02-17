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





# 错误

## 1

```
2020-10-26 23:56:59.898  WARN 23080 --- [-localhost:3306] c.g.shyiko.mysql.binlog.BinaryLogClient  : com.fr.finetube.core.work.step.component.pipeline.binlog.PipelineTaskBinlogListener@4b655caa choked on Event{header=EventHeaderV4{timestamp=1603727819000, eventType=EXT_WRITE_ROWS, serverId=123, headerLength=19, dataLength=44, nextPosition=17168452, flags=0}, data=WriteRowsEventData{tableId=161, includedColumns={0, 1}, rows=[
    [2020-10-26 23:56:59, test]
]}}

java.lang.NullPointerException: null
	at com.fr.finetube.core.work.step.component.pipeline.binlog.PipelineTaskBinlogListener.generateEvents(PipelineTaskBinlogListener.java:249)
	at com.fr.finetube.core.work.step.component.pipeline.binlog.PipelineTaskBinlogListener.handleInsert(PipelineTaskBinlogListener.java:206)
	at com.fr.finetube.core.work.step.component.pipeline.binlog.PipelineTaskBinlogListener.onEvent(PipelineTaskBinlogListener.java:178)
	at com.github.shyiko.mysql.binlog.BinaryLogClient.notifyEventListeners(BinaryLogClient.java:1158)
	at com.github.shyiko.mysql.binlog.BinaryLogClient.listenForEventPackets(BinaryLogClient.java:1005)
	at com.github.shyiko.mysql.binlog.BinaryLogClient.connectWithTimeout(BinaryLogClient.java:517)
	at com.github.shyiko.mysql.binlog.BinaryLogClient.access$1100(BinaryLogClient.java:90)
	at com.github.shyiko.mysql.binlog.BinaryLogClient$7.run(BinaryLogClient.java:881)
	at java.lang.Thread.run(Thread.java:748)
```







## A slave with the same server_uuid/server_id as this slave

```
A slave with the same server_uuid/server_id as this slave has connected to the master...
```

[Same Error Code · Issue #208 · shyiko/mysql-binlog-connector-java](https://github.com/shyiko/mysql-binlog-connector-java/issues/208)

[SocketException when running multiple BinaryLogClient processes · Issue #185 · shyiko/mysql-binlog-connector-java](https://github.com/shyiko/mysql-binlog-connector-java/issues/185)

[Blocking Mode Problem · Issue #121 · shyiko/mysql-binlog-connector-java](https://github.com/shyiko/mysql-binlog-connector-java/issues/121#issuecomment-252321233)



每个 BinlogClient 都相当于是一个 MySQL slave，每个 slave server 都必须有一个唯一的 id，所以需要调用 `client.setServerId()` 为每一个 BinaryLogClient 设定 serverId，不然多个 client 之间会相互干扰。









# 参考资料


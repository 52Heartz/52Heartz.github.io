---
title: 关于 Kafka Connect
mathjax: true
date: 2020-08-16 17:44:32
updated:
categories:
tags:
urlname: about-kafka-connect
---



<!-- more -->

官方文档1：[Kafka Connect — Confluent Platform 5.5.1](https://docs.confluent.io/current/connect/index.html)

官方文档2：[Apache Kafka Connect](http://kafka.apache.org/documentation.html#connect)

官方收录的 Connector 列表：[Home | Confluent Hub](https://www.confluent.io/hub/)

[Introduction to Kafka Connectors | Baeldung](https://www.baeldung.com/kafka-connectors-guide)



# 基本概念

> - [Connectors](https://docs.confluent.io/current/connect/concepts.html#connect-connectors) – the high level abstraction that coordinates data streaming by managing tasks
> - [Tasks](https://docs.confluent.io/current/connect/concepts.html#connect-tasks) – the implementation of how data is copied to or from Kafka
> - [Workers](https://docs.confluent.io/current/connect/concepts.html#connect-workers) – the running processes that execute connectors and tasks
> - [Converters](https://docs.confluent.io/current/connect/concepts.html#connect-converters) – the code used to translate data between Connect and the system sending or receiving data
> - [Transforms](https://docs.confluent.io/current/connect/concepts.html#connect-transforms) – simple logic to alter each message produced by or sent to a connector
> - [Dead Letter Queue](https://docs.confluent.io/current/connect/concepts.html#dead-letter-queues) – how Connect handles connector errors



- Connector 不直接处理数据，只是保存配置和控制 task
- task 默认情况下，task 自身不保存状态信息，而是保存在 Kafka 中



# Converter



Kafka Connect 中规定了数据交换格式，即 `org.apache.kafka.connect.data.SchemaAndValue`，所有 SourceConnector 都需要把数据转换成这种格式，然后由 Kafka Connect 配置中指定的 Converter 对数据进行序列化，然后存储到 Kafka Topic 中。



> Kafka Connect takes a default converter configuration at the worker level, and it can also be overridden per connector.



推荐阅读：[Kafka Connect Deep Dive – Converters and Serialization Explained | Confluent](https://www.confluent.io/blog/kafka-connect-deep-dive-converters-serialization-explained/?_ga=2.15163766.1308796695.1600999602-798162560.1597424153&_gac=1.184156628.1601001378.CjwKCAjwh7H7BRBBEiwAPXjadkFVsEaNCLWYkqauS7mxLuCv8L7Peppftq43RxxjkBeKgNOPFgF9ThoCH4cQAvD_BwE)





# 配置保存

[Getting Started with Kafka Connect — Confluent Documentation 6.0.0](https://docs.confluent.io/current/connect/userguide.html#kconnect-internal-topics)

Kafka Connect 中的 Connector 会把配置保存在内部的 topic 中：

`config.storage.topic`、`offset.storage.topic`、`status.storage.topic`。



示例：

[Frequently Asked Questions · Debezium](https://debezium.io/documentation/faq/#how_to_change_the_offsets_of_the_source_database)





# 数据格式问题

> 另外，企业客户在做数据集成的时候，数据在很多应用场景下都要求有一定的格式，所以在Kafka Connect里用Schema Registry & Projector来解决数据格式验证和兼容性的问题。当数据源产生变化的时候，会生成新的Schema版本，通过不同的处理策略用Projector来完成对数据格式的兼容。
>
> ——[以Kafka Connect作为实时数据集成平台的基础架构有什么优势？ - 知乎](https://zhuanlan.zhihu.com/p/36136605)



# 任务暂停重启

## 进度管理



> 而任务恢复和状态保持方面，目的端任务的写入进度信息通过Kafka Connect框架自动管理、源端任务可以根据需要往Kafka里面放读取进度信息，节省很多精力去管理任务重启后的进度。
>
> ——[以Kafka Connect作为实时数据集成平台的基础架构有什么优势？ - 知乎](https://zhuanlan.zhihu.com/p/36136605)





> When a Kafka Connect connector runs, it reads information from the source and periodically records "offsets" that define how much of that information it has processed. Should the connector be restarted, it will use the last recorded offset to know where in the source information it should resume reading. Since connectors don’t know or care **how** the offsets are stored, it is up to the engine to provide a way to store and recover these offsets. The next few fields of our configuration specify that our engine should use the `FileOffsetBackingStore` class to store offsets in the `/path/to/storage/offset.dat` file on the local file system (the file can be named anything and stored anywhere). Additionally, although the connector records the offsets with every source record it produces, the engine flushes the offsets to the backing store periodically (in our case, once each minute). These fields can be tailored as needed for your application.
>
> ——[Debezium Engine :: Debezium Documentation](https://debezium.io/documentation/reference/development/engine.html)

debezium 中说，Connector 对于任务状态和 offset 的保存是没有感知的。





查看了 Kafka 的源代码，发现是根据 `KafkaStatusBackingStore`、`KafkaOffsetBackingStore` 来处理的。



同时 Kafka Connect 的 internal topics，比如 `offset.storage.topic`，创建 topic 的时候会使用 `cleanup.policy=compact`，从而保证所有 connector 的配置至少会保留一份。



# Kafka Connect Connector 开发

[Connector Developer Guide — Confluent Documentation](https://docs.confluent.io/platform/current/connect/devguide.html)

[4 Steps to Creating Apache Kafka Connectors with the Kafka Connect API](https://www.confluent.io/blog/create-dynamic-kafka-connect-source-connectors/?_ga=2.6838711.447018570.1606824776-798162560.1597424153)



# Connector 示例

## Debezium MySQL CDC Connector

[Debezium MySQL CDC Connector | Confluent Hub](https://www.confluent.io/hub/debezium/debezium-connector-mysql)

[Debezium Connector for MySQL :: Debezium Documentation](https://debezium.io/documentation/reference/1.2/connectors/mysql.html)



# 部署





# 参考资料

1. [Kafka Connect — Confluent Platform 5.5.1](https://docs.confluent.io/current/connect/index.html)
2. [Kafka Connect Deep Dive – JDBC Source Connector | Confluent](https://www.confluent.io/blog/kafka-connect-deep-dive-jdbc-source-connector/)
3. [Kafka Connect 实现MySQL增量同步 - 简书](https://www.jianshu.com/p/46b6fa53cae4)
4. [基于Kafka Connect的流数据同步服务实现和监控体系搭建 - InfoQ](https://www.infoq.cn/article/zxsT2zq8rWSAMQJuSQBg)
5. [以Kafka Connect作为实时数据集成平台的基础架构有什么优势？ - 知乎](https://zhuanlan.zhihu.com/p/36136605)


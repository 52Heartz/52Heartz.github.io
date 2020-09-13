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



# 数据格式问题

> 另外，企业客户在做数据集成的时候，数据在很多应用场景下都要求有一定的格式，所以在Kafka Connect里用Schema Registry & Projector来解决数据格式验证和兼容性的问题。当数据源产生变化的时候，会生成新的Schema版本，通过不同的处理策略用Projector来完成对数据格式的兼容。
>
> ——[以Kafka Connect作为实时数据集成平台的基础架构有什么优势？ - 知乎](https://zhuanlan.zhihu.com/p/36136605)



# 任务暂停重启

> 而任务恢复和状态保持方面，目的端任务的写入进度信息通过Kafka Connect框架自动管理、源端任务可以根据需要往Kafka里面放读取进度信息，节省很多精力去管理任务重启后的进度。
>
> ——[以Kafka Connect作为实时数据集成平台的基础架构有什么优势？ - 知乎](https://zhuanlan.zhihu.com/p/36136605)



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
---
title: 20201026 - 关于 TranferQueue
mathjax: true
date: 2020-10-29 15:43:19
updated:
categories:
tags:
urlname: about-java-transfer-queue
---



<!-- more -->



> TransferQueue则更进一步，生产者会一直阻塞直到所添加到队列的元素被某一个消费者所消费（不仅仅是添加到队列里就完事）。新添加的transfer方法用来实现这种约束。顾名思义，阻塞就是发生在元素从一个线程transfer到另一个线程的过程中，它有效地实现了元素在线程之间的传递（以建立Java内存模型中的happens-before关系的方式）。



Java 中还有一个队列实现类是 `SynchronousQueue`。TransferQueue 和这个是类似的，不过性能更好。







# 参考资料

1. [Java 7中的TransferQueue | 并发编程网 – ifeve.com](http://ifeve.com/java-transfer-queue/)
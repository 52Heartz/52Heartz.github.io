---
title: 关于 Java volatile
mathjax: true
date: 2020-07-12 14:32:08
updated:
categories:
tags:
urlname: about-java-volatile
---



<!-- more -->



Q：为什么 `volatile` 不能保证线程安全？

A：`volatile` 只能保证线程可见性，而且其规则是有所限制的。即

> A write to a volatile field happens-before every subsequent read of that volatile.

只能保证如果一个线程更新了 volatile 变量的值，那其他线程后续对这个 volatile 变量的读操作会反映出之前的修改。但是不能保证不同线程的写操作遵循 `happens-before` 原则，所以如果两个线程接连读取了 volatile 变量的值，然后接连写了 volatile 的值，那么只有后写的那个线程写的值会生效。

示例：

我们假设整形变量 a 是一个 volatile 变量，两个线程同时对这个变量加 1。

| 线程A        | 线程B        |
| ------------ | ------------ |
| read a(a=1)  |              |
|              | read a(a=1)  |
|              | a++(a=2)     |
| a++(a=2)     |              |
| write a(a=2) |              |
|              | write a(a=2) |





# 参考资料

1. [再有人问你volatile是什么，把这篇文章也发给他。-HollisChuang's Blog](https://www.hollischuang.com/archives/2673)
2. [既生synchronized，何生volatile-HollisChuang's Blog](https://www.hollischuang.com/archives/3928)
3. [深入理解Java中的volatile关键字-HollisChuang's Blog](https://www.hollischuang.com/archives/2648)
4. [【死磕Java并发】-深入分析volatile的实现原理 - Java 技术驿站-Java 技术驿站](http://cmsblogs.com/?p=2092)
5. [【死磕Java并发】-----Java内存模型之happens-before - chenssy - 博客园](https://www.cnblogs.com/chenssy/p/6393321.html)
6. [happens-before俗解 | 并发编程网 – ifeve.com](http://ifeve.com/easy-happens-before/)
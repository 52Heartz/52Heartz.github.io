---
title: Java ThreadLocal 相关
mathjax: true
date: 2019-10-26 22:49:41
updated:
categories: Java
tags:
urlname: about-java-threadlocal
---

Java ThreadLocal.

<!-- more -->

《阿里巴巴 Java 开发手册》中对 ThreadLocal 的使用有如下规定：

> 【强制】必须回收自定义的 ThreadLocal 变量，尤其在线程池场景下，线程经常会被复用，如果不清理自定义的 ThreadLocal 变量，可能会影响后续业务逻辑和造成内存泄露等问题。尽量在代理中使用 try-finally 块进行回收。
>
> 正例：
>
> ```java
> objectThreadLocal.set(userInfo);
> try {
>     // ...
> } finally {
>     objectThreadLocal.remove();
> }
> ```



> 【参考】ThreadLocal 对象使用 static 修饰，ThreadLocal 无法解决共享对象的更新问题。
>
> 说明：这个变量是针对一个线程内所有操作共享的，所以设置为静态变量，所有此类实例共享此静态变量，也就是说在类第一次被使用时装载，只分配一块存储空间，所有此类的对象(只要是这个线程内定义的)都可以操控这个变量。



ThreadLocal 中有一个内部类 `ThreadLocalMap`



# 可能的内存泄漏问题

其实 `ThreadLocal` 这个类已经考虑到了可能的内存泄漏问题。所以其内部使用到了弱引用。在好几个操作中也会对进行操作防止内存泄漏。



# InheritableThreadLocal

ThreadLocal 的一个子类，用于子线程获取父线程的 ThreadLocal 变量。







# 参考资料

1. [MemoryLeakProtection - Apache Tomcat](https://cwiki.apache.org/confluence/display/tomcat/MemoryLeakProtection#MemoryLeakProtection-customThreadLocal)【自定义继承了 ThreadLocal 的类可能导致内存泄漏（已修复）】
2. [使用ThreadLocal不当可能会导致内存泄露 | 并发编程网](http://ifeve.com/%E4%BD%BF%E7%94%A8threadlocal%E4%B8%8D%E5%BD%93%E5%8F%AF%E8%83%BD%E4%BC%9A%E5%AF%BC%E8%87%B4%E5%86%85%E5%AD%98%E6%B3%84%E9%9C%B2/)
3. [Java 理论与实践: 用弱引用堵住内存泄漏 - IBM Developer](https://www.ibm.com/developerworks/cn/java/j-jtp11225/index.html)
4. [【死磕 Java 并发】—– 深入分析 ThreadLocal - 芋道源码](http://www.iocoder.cn/JUC/sike/ThreadLocal/)
5. [ThreadLocal 内存泄露的实例分析](https://blog.xiaohansong.com/ThreadLocal-leak-analyze.html)
6. [深入分析 ThreadLocal 内存泄漏问题](https://blog.xiaohansong.com/ThreadLocal-memory-leak.html)
7. [Java多线程父子线程关系 多线程中篇（六） - noteless - 博客园](https://www.cnblogs.com/noteless/p/10371174.html)
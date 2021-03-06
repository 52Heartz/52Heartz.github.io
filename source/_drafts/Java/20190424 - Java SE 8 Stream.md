---
title: Java 8 Stream
mathjax: true
date: 2019-04-24 19:49:40
updated:
categories:
- Java
tags:
urlname: java-8-stream-library
---

Java SE 8 流库。

<!-- more -->

Java SE 8 中的流库和 Lambda 表达式是同时在 Java SE 8 中引入的内容。两者常常需要配合使用。



# List 转换为数组

```java
List<Integer> list = new ArrayList<>();
list.add(0);
list.add(1);
list.stream().parallel().mapToInt(Integer::intValue).toArray();
```





# 参考资料

1. [Java Stream API性能测试 - CarpenterLee](https://github.com/CarpenterLee/JavaLambdaInternals/blob/master/8-Stream%20Performance.md)
2. [流操作使用不当可能让你的代码变慢5倍](http://www.importnew.com/17262.html)
3. [深入理解Java函数式编程和Streams API - CarpenterLee](https://github.com/CarpenterLee/JavaLambdaInternals)
4. [Java8中Stream原理分析 - S.L's Blog | S.L Blog](https://elsef.com/2019/09/16/Java8中Stream的原理分析/)
5. [Java8-Collect收集Stream - Ryan.Miao - 博客园](https://www.cnblogs.com/woshimrf/p/java8-collect-stream.html)
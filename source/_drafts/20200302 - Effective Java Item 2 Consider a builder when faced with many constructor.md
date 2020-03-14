---
title: Effective Java Item 2 Consider a builder when faced with many constructor
mathjax: true
date: 2020-03-02 22:34:49
updated:
categories:
tags:
urlname: Effective-Java-Item-2-Consider-a-builder-when-faced-with-many-constructor
---



<!-- more -->

考虑因素：Mutability（可变性），是否期望创建对象之后对象可以发生改变。比如 String 就是不可变类。

比如你不希望一个对象在使用中途被改变。





## telescoping constructor（重叠构造器）

1. 代码可读性不强
   - 在某些智能的 IDE 中有所改善，但是在没有 IDE 加持的情况下，比如 Code Review 平台，代码搜索工具中，可读性还是不强。
2. 有时候为了创建一个类，你不得不传入 `null`、`0` 这种参数。因为缺少对应签名的构造器。



## Java Bean Pattern

即使用 “Getter” 和 “Setter”。灵活性更强，但是也强制了类必须是可变的。





## Builder Pattern

适合的场景：

1. 有较多可选参数





优点：

Buider 类中可以加入参数检查

Fluent API，代码可读性更强。



### 内部类 VS 外部类

|        | 优点 | 缺点 |
| ------ | ---- | ---- |
| 内部类 |      |      |
| 外部类 |      |      |





# 对比其他语言

Builder Pattern 和 Python 和 Scala 中的 named optional parameters 类似。







# 业界实际应用

## Apache HttpClient

示例：

```java
HttpClients.custom()
                .setSSLSocketFactory(sslConnectionSocketFactory)
                .setConnectionManager(poolingHttpClientConnectionManager)
                .setConnectionManagerShared(true)
    			.build();
```

`HttpClients.custom()` 返回一个 `HttpClientBuilder` 类的实例。在 `HttpClientBuilder` 的 `build()` 方法中有大量对参数进行检查的内容。



## Guava 的 MapMaker



## java.util.Locale

https://docs.oracle.com/javase/8/docs/api/java/util/Locale.Builder.html



## java.util.Calendar





# 参考资料

1. [Example of Builder Pattern in Java API?](https://stackoverflow.com/questions/2169190/example-of-builder-pattern-in-java-api)
2. [Builder Pattern](https://springframework.guru/gang-of-four-design-patterns/builder-pattern/)
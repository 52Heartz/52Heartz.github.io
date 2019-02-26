---
title: JAVA使用System.out.print输出数组
date: 2019-02-25 12:01:46
updated:
categories:
tags:
urlname: java-System-out-print-arrays
---

```java
int[] array = {5, 4, 3, 2, 1};
System.out.print(array);
```

今天在执行这段代码的时候，输出竟然是

```
[I@1b6d3586
```

之前用Python用习惯了，没意识到Java不能这样输出数组。今天来剖析一下深层次的原因。

<!-- more -->

来分析一下 `System.out.print`。

[java.lang.System](https://docs.oracle.com/javase/8/docs/api/java/lang/System.html) 是一个类。我们先来看一下 `System` 类的源代码。

```java
public final class System extends Object {
    ...
    static PrintStream out;
    ...
}
```

这里能看出，`out` 其实是 `System` 的一个静态成员变量，其类型是 [PrintStream](https://docs.oracle.com/javase/8/docs/api/java/io/PrintStream.html)。而 `print()` 是 `PrintStream` 类的一个方法。

通过查看Java Docs我们可以看到有很多重载的 `print()` 方法。

![print_overload_list](print_overload_list.png)

可以看到，有很多重载的 `print()` 函数，但是没有专门支持 `int[]`、`long[]`、`double[]` 这种类型数组输出的 `print()` 方法。

因此，`int[]`、`long[]`、`double[]` 类型的数组对象会被当做 `Object` 对象来处理。

我们来看一下 `print(Object obj)`

```java
public void print(Object obj) {
    write(String.valueOf(obj));
}
```

其实相当于对数组调用了 `toString()` 方法。而Java中数组的 `toString()` 方法只会返回“对象类型@对象地址”。

#  `System.out` 的初始化

```java
public final class System extends Object {
    ...
    static PrintStream out;
    ...
}
```

当JVM启动的时候，JVM会通过 `initializeSystemClass()` 方法对 `out` 进行初始化。

# 参考资料

1. [java - out in System.out.println() - Stack Overflow](https://stackoverflow.com/questions/9454866/out-in-system-out-println)
2. [How System.out.println() really works – Lucky's Notes](https://luckytoilet.wordpress.com/2010/05/21/how-system-out-println-really-works/)
3. [System.out.println - Javapapers](http://javapapers.com/core-java/system-out-println/)
4. [JAVA中的数组是对象吗？ - 知乎](https://www.zhihu.com/question/26297216)


---
title: 诊断工具 Alibaba arthas 使用
mathjax: true
date: 2021-06-11 17:39:22
updated:
categories:
tags:
urlname: about-alibaba-arthas
---



<!-- more -->

官方网站：[arthas 官方网站](https://arthas.aliyun.com/en-us/)

arthas 是一款通过字节码增强技术开发的一个用于线上问题诊断的程序。



# 下载使用

```
curl -O https://arthas.aliyun.com/arthas-boot.jar
java -jar arthas-boot.jar
```





# 常用功能

## 观察方法入参、出参（watch）

可以基于 [watch]([watch — Arthas 3.5.1 文档](https://arthas.aliyun.com/doc/watch.html)) 实现。

示例：

```
$ watch demo.MathGame primeFactors "{params,returnObj}" -x 2
Press Ctrl+C to abort.
Affect(class-cnt:1 , method-cnt:1) cost in 44 ms.
ts=2018-12-03 19:16:51; [cost=1.280502ms] result=@ArrayList[
    @Object[][
        @Integer[1],
    ],
    @ArrayList[
        @Integer[3],
        @Integer[19],
        @Integer[191],
        @Integer[49199],
    ],
]
```



其中的 `params, returnObj` 其实就是核心变量中的成员变量名称，参考下边【进阶】-【核心变量】中的内容。

`-x 2` 表示返回的内容，向下遍历多少个层级，因为有些变量可能嵌套层次比较深。

如果想看到方法对应的对象，可以使用 `"{target}"`，通过还可以引用对象中的成员变量。



### 添加观察条件

```
$ watch demo.MathGame primeFactors "{params[0],target}" "params[0]<0"
Press Ctrl+C to abort.
Affect(class-cnt:1 , method-cnt:1) cost in 68 ms.
ts=2018-12-03 19:36:04; [cost=0.530255ms] result=@ArrayList[
    @Integer[-18178089],
    @MathGame[demo.MathGame@41cf53f9],
]
```

- 只有满足条件的调用，才会有响应。



### 当抛出异常的时候才记录

```
$ watch demo.MathGame primeFactors "{params[0],throwExp}" -e -x 2
Press Ctrl+C to abort.
Affect(class-cnt:1 , method-cnt:1) cost in 62 ms.
ts=2018-12-03 19:38:00; [cost=1.414993ms] result=@ArrayList[
    @Integer[-1120397038],
    java.lang.IllegalArgumentException: number is: -1120397038, need >= 2
	at demo.MathGame.primeFactors(MathGame.java:46)
	at demo.MathGame.run(MathGame.java:24)
	at demo.MathGame.main(MathGame.java:16)
,
]
```

- `-e` 表示抛出异常时才触发
- express中，表示异常信息的变量是 `throwExp`





## 性能调优/观察调用树耗时

[trace — Arthas 3.5.2 文档](https://arthas.aliyun.com/doc/trace.html)

调用示例：

```
trace demo.MathGame run -n 1
```



# 进阶

## 核心变量

> 无论是匹配表达式也好、观察表达式也罢，他们核心判断变量都是围绕着一个 Arthas 中的通用通知对象 `Advice` 进行。
>
> 它的简略代码结构如下：
>
> ```java
> public class Advice {
>  
>     private final ClassLoader loader;
>     private final Class<?> clazz;
>     private final ArthasMethod method;
>     private final Object target;
>     private final Object[] params;
>     private final Object returnObj;
>     private final Throwable throwExp;
>     private final boolean isBefore;
>     private final boolean isThrow;
>     private final boolean isReturn;
>     
>     // getter/setter  
> }  
> ```
>
> [表达式核心变量 — Arthas 3.5.1 文档](https://arthas.aliyun.com/doc/advice-class.html)



# 参考资料

1. [watch — Arthas 3.5.2 文档](https://arthas.aliyun.com/doc/watch.html)


---
title: Java CountDownLatch 和 CyclicBarrier
mathjax: true
date: 2020-07-13 22:34:42
updated:
categories:
tags:
urlname: about-Java-CountDownLatch-CyclicBarrier
---



<!-- more -->



CountDownLatch 是一个线程等待多个线程到达某个状态之后才继续执行。

CyclicBarrier 是多个线程之间相互等待对方到达某个状态之后才一起继续执行。



# 使用场景

> 实际工作中，CountDownLatch适用于如下使用场景：
> 客户端的一个同步请求查询用户的风险等级，服务端收到请求后会请求多个子系统获取数据，然后使用风险评估规则模型进行风险评估。如果使用单线程去完成这些操作，这个同步请求超时的可能性会很大，因为服务端请求多个子系统是依次排队的，请求子系统获取数据的时间是线性累加的。此时可以使用CountDownLatch，让多个线程并发请求多个子系统，当获取到多个子系统数据之后，再进行风险评估，这样请求子系统获取数据的时间就等于最耗时的那个请求的时间，可以大大减少处理时间。
>
> ——[高并发编程-CountDownLatch深入解析 - 知乎](https://zhuanlan.zhihu.com/p/41459021)





# 参考资料

1. [大白话说java并发工具类-CountDownLatch，CyclicBarrier - 掘金](https://juejin.im/post/5aeec3ebf265da0ba76fa327#heading-0)
2. [高并发编程-CountDownLatch深入解析 - 知乎](https://zhuanlan.zhihu.com/p/41459021)
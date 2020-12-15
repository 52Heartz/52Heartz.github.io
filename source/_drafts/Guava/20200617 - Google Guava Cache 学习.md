---
title: Google Guava Cache 学习
mathjax: true
date: 2020-06-17 12:50:40
updated:
categories:
tags:
urlname: google-guava-cache-learning
---



<!-- more -->

[CachesExplained · google/guava Wiki](https://github.com/google/guava/wiki/CachesExplained)







# 缓存失效提醒 Removal Listeners

> You may specify a removal listener for your cache to perform some operation when an entry is removed, via [`CacheBuilder.removalListener(RemovalListener)`](https://guava.dev/releases/snapshot/api/docs/com/google/common/cache/CacheBuilder.html#removalListener-com.google.common.cache.RemovalListener-). The [`RemovalListener`](https://guava.dev/releases/snapshot/api/docs/com/google/common/cache/RemovalListener.html) gets passed a [`RemovalNotification`](https://guava.dev/releases/snapshot/api/docs/com/google/common/cache/RemovalNotification.html), which specifies the [`RemovalCause`](https://guava.dev/releases/snapshot/api/docs/com/google/common/cache/RemovalCause.html), key, and value.







# 其他

1. [java - Does RemovalListener callback in guava caching api make sure that no one is using the object - Stack Overflow](https://stackoverflow.com/questions/11563848/does-removallistener-callback-in-guava-caching-api-make-sure-that-no-one-is-usin)





# 参考资料

1. [Guava](https://guava.dev/)
2. [com.google.common.cache (Guava: Google Core Libraries for Java HEAD-jre-SNAPSHOT API)](https://guava.dev/releases/snapshot-jre/api/docs/)【Cache API javadoc】
3. [Guava Cache内存缓存使用实践-定时异步刷新及简单抽象封装_Zorrooooo的博客-CSDN博客](https://blog.csdn.net/u012859681/article/details/75220605)
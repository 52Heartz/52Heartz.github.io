---
title: Linux 误删 libc.so.6 导致所有命令不能用的解决方案
mathjax: true
date: 2021-04-27 19:22:58
updated:
categories:
tags:
urlname: linux-deleting-libc.so.6-handling
---



<!-- more -->



Linux 中的很多命令都依赖于 `/lib64/libc.so.6`，误删之后可能会导致绝大部分命令，比如 `ls`、`rm`、`ln` 等基础命令都不能使用。

`libc.so.6` 实际上是一个软链接

```
[root@fd-bash-master lib64]# ll | grep libc.so.6
lrwxrwxrwx   1 root root        12 4月  27 19:18 libc.so.6 -> libc-2.17.so
```



如何解决呢？

可以通过设置 `LD_PRELOAD` 来解决：

```
export LD_PRELOAD="/lib64/libc-2.17.so"
```

但是前提是你要知道 `libc-2.17.so` 的位置和版本，如果不知道的话就悲剧了，我是因为恰好知道 `/lib64` 下有 `libc-2.17.so` 所以才解决的。





# 参考资料

1. [centos linux大坑处理办法，libc.so.6: cannot open shared object file: No such file or directory_巨魔战将-CSDN博客](https://blog.csdn.net/myhes/article/details/106923039)
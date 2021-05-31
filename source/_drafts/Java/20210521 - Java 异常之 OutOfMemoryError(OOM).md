---
title: Java 异常之 OutOfMemoryError
mathjax: true
date: 2021-05-21 16:07:33
updated:
categories:
tags:
urlname: about-java-out-of-memory-error
---



<!-- more -->





# 不同类型的报错



## java.lang.OutOfMemoryError: GC overhead limit exceeded







# 异常分析

## 确认当前虚拟机内存分配情况

使用

```
jmap -heap <pid>
```

获取当前虚拟机的内存分配概要情况，可以分析一下是否本身分配的内存太小。

输出的格式为：

```
Attaching to process ID 19416, please wait...
Debugger attached successfully.
Server compiler detected.
JVM version is 25.292-b10

using thread-local object allocation.
Parallel GC with 10 thread(s)

Heap Configuration:
   MinHeapFreeRatio         = 0
   MaxHeapFreeRatio         = 100
   MaxHeapSize              = 734003200 (700.0MB)
   NewSize                  = 178257920 (170.0MB)
   MaxNewSize               = 244318208 (233.0MB)
   OldSize                  = 356515840 (340.0MB)
   NewRatio                 = 2
   SurvivorRatio            = 8
   MetaspaceSize            = 21807104 (20.796875MB)
   CompressedClassSpaceSize = 1073741824 (1024.0MB)
   MaxMetaspaceSize         = 17592186044415 MB
   G1HeapRegionSize         = 0 (0.0MB)

Heap Usage:
PS Young Generation
Eden Space:
   capacity = 134217728 (128.0MB)
   used     = 2711320 (2.5857162475585938MB)
   free     = 131506408 (125.4142837524414MB)
   2.0200908184051514% used
From Space:
   capacity = 22020096 (21.0MB)
   used     = 0 (0.0MB)
   free     = 22020096 (21.0MB)
   0.0% used
To Space:
   capacity = 22020096 (21.0MB)
   used     = 0 (0.0MB)
   free     = 22020096 (21.0MB)
   0.0% used
PS Old Generation
   capacity = 142082048 (135.5MB)
   used     = 7294256 (6.9563446044921875MB)
   free     = 134787792 (128.5436553955078MB)
   5.133833656451799% used

6160 interned Strings occupying 541440 bytes.
```



## 查找最耗内存的对象





# 工具

VisualVM：[VisualVM: Home](https://visualvm.github.io/)

Eclipse MAT：[Eclipse Memory Analyzer Open Source Project | The Eclipse Foundation](https://www.eclipse.org/mat/)



# 参考资料

1. [Understand the OutOfMemoryError Exception](https://docs.oracle.com/javase/8/docs/technotes/guides/troubleshoot/memleaks002.html)
2. [jmap - Doc](https://docs.oracle.com/javase/8/docs/technotes/tools/unix/jmap.html)
3. [Java服务，内存OOM问题如何快速定位？ - 51CTO.COM](https://zhuanlan.51cto.com/art/201911/605390.htm)
4. [OutOfMemoryError系列（2）: GC overhead limit exceeded_铁锚的CSDN博客-CSDN博客](https://blog.csdn.net/renfufei/article/details/77585294)
5. [教你分析9种 OOM 常见原因及解决方案 - 云+社区 - 腾讯云](https://cloud.tencent.com/developer/article/1480668)




---
title: Java HashMap相关
date: 2019-02-25 10:29:33
updated:
categories: Java
tags:
mathjax: true
urlname: java-hash-map
---

# JDK7中的HashMap

[HashMap](https://docs.oracle.com/javase/8/docs/api/index.html)是Java中常用的一个数据结构。

## 什么时候resize()

当 HashMap 的 `size` 大于 `threshold` 的时候，也就是 HashMap 的元素数量大于 `threshlod` 的时候。

<!-- more -->

# JDK8中的HashMap




# JDK7中的ConcurrentHashMap





# JDK8中的ConcurrentHashMap



# ConcurrentHashMap 的应用

## 接口限流，统计访问次数

ConcurrentHashMap 中每个单独的方法都是原子操作，但是如果我们使用 ConcurrentHashMap 的时候可能需要在外层再加一些逻辑的操作，那么这些操作有可能就不是原子操作，从而可能导致并发带来的不一致性。

所以有些时候，我们需要使用CAS（Compare And Swap）操作来保证整体操作的原子性。而 ConcurrentHashMap 的 `replace()` 和 `putIfAbsent()` 就是这样的操作。



测试代码

```java
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.CountDownLatch;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

public class CounterDemo1 {

    private final Map<String, Long> urlCounter = new ConcurrentHashMap<>();

    //接口调用次数+1
    public long increase(String url) {
        Long oldValue = urlCounter.get(url);
        Long newValue = (oldValue == null) ? 1L : oldValue + 1;
        urlCounter.put(url, newValue);
        return newValue;
    }

    public long increase2(String url) {
        Long oldValue, newValue;
        while (true) {
            oldValue = urlCounter.get(url);
            if (oldValue == null) {
                newValue = 1L;
                //初始化成功，退出循环
                if (urlCounter.putIfAbsent(url, 1L) == null) {
                    break;
                }else{
                    System.out.println("初始化失败");
                }
                //如果初始化失败，说明其他线程已经初始化过了
            } else {
                newValue = oldValue + 1;
                //+1成功，退出循环
                if (urlCounter.replace(url, oldValue, newValue)) {
                    break;
                }else {
                    System.out.println("+1失败");
                }
                //如果+1失败，说明其他线程已经修改过了旧值
            }
        }
        return newValue;
    }

    //获取调用次数
    public Long getCount(String url){
        return urlCounter.get(url);
    }

    public static void main(String[] args) {
        ExecutorService executor = Executors.newFixedThreadPool(10);
        final CounterDemo1 counterDemo = new CounterDemo1();
        int callTime = 100000;
        final String url = "http://localhost:8080/hello";
        CountDownLatch countDownLatch = new CountDownLatch(callTime);
        //模拟并发情况下的接口调用统计
        for(int i=0;i<callTime;i++){
            executor.execute(new Runnable() {
                @Override
                public void run() {
                    counterDemo.increase2(url);
                    countDownLatch.countDown();
                }
            });
        }
        try {
            countDownLatch.await();
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        executor.shutdown();
        //等待所有线程统计完成后输出调用次数
        System.out.println("调用次数："+counterDemo.getCount(url));
    }
}

//TODO 还可以采用 atomicLong 类来实现
```

参考:[Java 并发实践 — ConcurrentHashMap 与 CAS](http://www.importnew.com/26035.html)



# HashTable



# 参考资料

## HashMap相关

1. [Java HashMap工作原理及实现  - Yikun的博客](https://yikun.github.io/2015/04/01/Java-HashMap%E5%B7%A5%E4%BD%9C%E5%8E%9F%E7%90%86%E5%8F%8A%E5%AE%9E%E7%8E%B0/)
2. [HashMap完全解读 -Hollis](https://www.hollischuang.com/archives/82)
3. [天下无难试之HashMap面试刁难大全](https://zhuanlan.zhihu.com/p/32355676)
4. [HashMap? ConcurrentHashMap? 相信看完这篇没人能难住你！ - crossoverJie的博客](https://crossoverjie.top/2018/07/23/java-senior/ConcurrentHashMap/)
5. [【java集合】HashMap常见面试题 - CSDN博客](https://blog.csdn.net/u012512634/article/details/72735183)
6. [HashMap 相关面试题及其解答](https://www.jianshu.com/p/75adf47958a7)
7. [HashMap面试题：90%的人回答不上来](https://www.jianshu.com/p/7af5bb1b57e2)
8. [HashMap的实现原理+阿里HasMap面试题 - CSDN博客](https://blog.csdn.net/lizhen1114/article/details/79001257)
9. [JDK7与JDK8中HashMap的实现 - 开源中国](https://my.oschina.net/hosee/blog/618953)
10. [全网把Map中的hash()分析的最透彻的文章，别无二家 - Hollis的博客](https://www.hollischuang.com/archives/2091)【确实写的很好！】
11. [红黑树 - 开源中国](https://my.oschina.net/hosee/blog/618828)
12. [谈谈HashMap线程不安全的体现 - ImportNew](http://www.importnew.com/22011.html)
13. [HashMap的loadFactor为什么是0.75？](https://www.jianshu.com/p/64f6de3ffcc1)【分析的很深入了，还分析了数学原理】
14. [HashMap初始容量与负载因子设置如何影响HashMap性能](https://blog.csdn.net/woaiwym/article/details/80622804)
15. [Java 8系列之重新认识HashMap - 美团技术团队](https://tech.meituan.com/2016/06/24/java-hashmap.html)
16. [【不做标题党，只做纯干货】HashMap在Jdk1.7和1.8中的实现](http://www.yuanrengu.com/index.php/20181106.html)
17. [老生常谈，HashMap的死循环 - 占小狼的简书](https://www.jianshu.com/p/1e9cf0ac07f4)

## ConcurrentHashMap相关

1. [ConcurrentHashMap原理分析 - ImportNew](http://www.importnew.com/16142.html)
2. [面试题： HashMap与ConcurrentHashMap - 开源中国](https://my.oschina.net/keyven/blog/1831704)
3. [关于Java面试，你应该准备这些知识点](https://www.jianshu.com/p/1b2f63a45476)
4. [HashMap、HashTable、ConcurrentHashMap的原理与区别](http://www.yuanrengu.com/index.php/2017-01-17.html)
5. [十大Java ConcurrentHashMap面试问题与解 - CSDN](https://blog.csdn.net/qq_41790443/article/details/79727915)
6. [Java数据结构笔试面试知识集合之ConcurrentHashMap](https://zhuanlan.zhihu.com/p/35853397)
7. [这几道Java集合框架面试题在面试中几乎必问](https://segmentfault.com/a/1190000016127895)


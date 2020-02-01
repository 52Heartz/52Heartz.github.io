---
title: 了解一下 Project Lombok
mathjax: true
date: 2020-01-28 18:39:37
updated:
categories:
tags:
urlname: about-project-lombok
---



<!-- more -->

项目官网：[Project Lombok](https://projectlombok.org/)

简而言之，这个类库通过一些注解，可以在编译期为你的代码加上一些额外的代码，比如 Getter 和 Setter 等。但是因为是在编译期加上的，只有 class 文件中有相关代码，源代码中是没有的。所以如果要想 IDE 不报错，还需要配合 IDE 插件来使用。



# 拓展

虽然有些不太支持，但是这个思想还是可以借鉴的。比如打日志，有些时候我们只是想临时记录一下某个值来帮助 debug，这个时候使用注解就会很方便。



# 参考资料

1. [To Lombok, or not to Lombok](https://blogg.itverket.no/to-lombok-or-not-to-lombok/)
2. [Is it safe to use Project Lombok? - Stack Overflow](https://stackoverflow.com/questions/3852091/is-it-safe-to-use-project-lombok)
3. [十分钟搞懂Lombok使用与原理
   1 简介 - 掘金](https://juejin.im/post/5a6eceb8f265da3e467555fe)
4. [为什么你不应该使用Lombok - Enix Jin 的博客](http://blog.enixjin.net/why-you-should-not-use-lombok/)
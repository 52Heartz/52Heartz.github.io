---
title: 关于 Java 的 final
mathjax: true
date: 2020-07-18 17:21:59
updated:
categories:
tags:
urlname: about-java-final
---



<!-- more -->

final 可以用于类、方法、变量（成员变量、局部变量），不能用于修饰接口。



## final 修饰类

表示该类不允许继承。

例如 `java.lang.String` 类就是一个 final 修饰的类。



Q：在 Java 中 String 类为什么要设计成 final？

A：Java 中对于 String 的设定为不可变类，如果可以继承，那么子类就可以设计为可变类，这样就打破了 String 是不可变类的设定，一个 String 类的引用有可能指向一个 String 的子类的对象，从而可能导致一些依赖于 String 不可变特性的场景出现问题。

[在java中String类为什么要设计成final？ - 知乎](https://www.zhihu.com/question/31345592)



## final 修饰方法

表示该方法不允许重写（override）

例如 `java.lang.Object` 类的 `getClass()` 方法就是一个 final 修饰的方法。



## final 修饰变量



### 修饰成员变量

如果该成员变量是原生类型，表示该变量的值不能变化。

如果该成员变量是引用类型，表示该变量的引用不能变化。



#### 和 static 的配合

如果变量类型是原始类型或者 String 类型，会触发 Java 编译器的常量折叠机制。

> **Note:** If a primitive type or a string is defined as a constant and the value is known at compile time, the compiler replaces the constant name everywhere in the code with its value. This is called a *compile-time constant*. If the value of the constant in the outside world changes (for example, if it is legislated that pi actually should be 3.975), you will need to recompile any classes that use this constant to get the current value.
>
> ——[Understanding Class Members (The Java™ Tutorials > Learning the Java Language > Classes and Objects)](https://docs.oracle.com/javase/tutorial/java/javaOO/classvars.html)

[编译期常量与运行时常量_Rhine-CSDN博客_编译期常量](https://blog.csdn.net/qq_34802416/article/details/83548369)





### 修饰本地变量





#### effectively final

Java 8 增加的功能。

[java - Difference between final and effectively final - Stack Overflow](https://stackoverflow.com/questions/20938095/difference-between-final-and-effectively-final)

[Java Final与Effectively Final - 知乎](https://zhuanlan.zhihu.com/p/109714821)

[Chapter 8. Classes](https://docs.oracle.com/javase/specs/jls/se8/html/jls-8.html#jls-8.1.3)





# 和接口相关

接口中定义的成员变量，类型默认是 `public static final` 类型的。





# 和 final 相关的重排序

[你以为你真的了解final吗？ - 掘金](https://juejin.im/post/5ae9b82c6fb9a07ac3634941#heading-9)



# 参考资料

1. [你以为你真的了解final吗？ - 掘金](https://juejin.im/post/5ae9b82c6fb9a07ac3634941#heading-9)
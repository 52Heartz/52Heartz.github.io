---
title: 关于 Apache Ant
mathjax: true
date: 2020-04-10 18:24:54
updated:
categories:
tags:
urlname: about-apache-ant
---



<!-- more -->

官方网站：[Apache Ant](https://ant.apache.org/)



# Tasks

## Property

[Property Task](https://ant.apache.org/manual/Tasks/property.html)



## XmlProperty

[XmlProperty Task](https://ant.apache.org/manual/Tasks/xmlproperty.html)





## BuildNumber

[BuildNumber Task](http://ant.apache.org/manual/Tasks/buildnumber.html)

> This is a basic task that can be used to track build numbers.
>
> It will first attempt to read a build number from a file (by default, build.number in the current directory), then set the property `build.number` to the value that was read in (or to 0, if no such value). It will then increment the number by one and write it back out to the file. (See the [PropertyFile](http://ant.apache.org/manual/Tasks/propertyfile.html) task if you need finer control over things such as the property name or the number format.)



## PropertyFile

[PropertyFile Task](http://ant.apache.org/manual/Tasks/propertyfile.html)

> Apache Ant provides an optional task for editing property files. This is very useful when wanting to make unattended modifications to configuration files for application servers and applications. Currently, the task maintains a working property file with the ability to add properties or make changes to existing ones. *Since Ant 1.8.0* comments and layout of the original properties file are preserved.
>
> *Since Ant 1.8.2* the linefeed-style of the original file will be preserved as well, as long as style used to be consistent. In general, linefeeds of the updated file will be the same as the first linefeed found when reading it.



## Input

[Input Task](https://ant.apache.org/manual/Tasks/input.html)

可以等待用户在命令行输入数据，指定一个参数的值。

示例：

```xml
<input message="Please enter the build version number:" addproperty="build.version"/>
```



# 小知识

1. `<javac>` 标签中如果有了嵌套的 `<src>` 标签，那么 `<javac>` 标签中可以不要 `srcdir` 属性。



# 参考资料

1. [TStamp Task - Apache Ant Manual](http://ant.apache.org/manual/Tasks/tstamp.html) | [java - Embedding build time into JAR Manifest using Ant - Stack Overflow](https://stackoverflow.com/questions/4143468/embedding-build-time-into-jar-manifest-using-ant)【关于时间戳的使用】
2. [Ant configurations - Meaning of debuglevel attributes var lines and source](https://stackoverflow.com/questions/22647392/ant-configurations-meaning-of-debuglevel-attributes-var-lines-and-source)【编译时开启调试模式】
3. [Typedef Task](https://ant.apache.org/manual/Tasks/typedef.html) | [TaskDef Task](https://ant.apache.org/manual/Tasks/taskdef.html)
4. [XMLTask - OOPS Consultancy Ltd](http://www.oopsconsultancy.com/software/xmltask/)
5. [java - Can you use Ant to Build/Modify XML files? - Stack Overflow](https://stackoverflow.com/questions/3064720/can-you-use-ant-to-build-modify-xml-files)
6. [BuildNumber Task](http://ant.apache.org/manual/Tasks/buildnumber.html)
7. [PropertyFile Task](http://ant.apache.org/manual/Tasks/propertyfile.html)
8. [Use ANT to update build number and inject into source code - Stack Overflow](https://stackoverflow.com/questions/3439876/use-ant-to-update-build-number-and-inject-into-source-code)
9. [Build and Version Numbering for Java Projects (ant, cvs, hudson) - Stack Overflow](https://stackoverflow.com/questions/690419/build-and-version-numbering-for-java-projects-ant-cvs-hudson)
10. [java - Build numbers: major.minor.revision - Stack Overflow](https://stackoverflow.com/questions/1431315/build-numbers-major-minor-revision)
11. [Software versioning - Wikipedia](https://en.wikipedia.org/wiki/Software_versioning)
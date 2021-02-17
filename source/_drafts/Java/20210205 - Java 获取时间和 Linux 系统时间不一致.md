---
title: 20210205 - Java 获取时间和 Linux 系统时间不一致
mathjax: true
date: 2021-02-03 10:28:20
updated:
categories:
tags:
urlname: about-java-time-different-with-linux-system
---



<!-- more -->



问题描述：Java 获取到的时间和 Linux 系统中使用 `date` 命令获取到的时间相差 8 小时。

Linux 系统为 `CentOS Linux release 7.5.1804 (Core)`

Linux 中的时区为 `UTC (CST, +0800)`，但是 Java 中获取到的时区却是 `UTC`。其中一种解决方案是修改 Linux（CentOS）的时区设置。

为什么 Linux 的时区是 `UTC (CST, +0800)`，但是 Java 获取到的却是 `UTC`，这个问题还没有深究。





下边是解决过程记录。



# Linux



```
> date
Fri Feb  5 17:05:45 CST 2021

> timedatectl
      Local time: Fri 2021-02-05 17:05:45 CST
  Universal time: Fri 2021-02-05 09:05:45 UTC
        RTC time: Fri 2021-02-05 09:05:45
       Time zone: UTC (CST, +0800)
     NTP enabled: yes
NTP synchronized: yes
 RTC in local TZ: no
      DST active: n/a
      
> hwclock --show
Fri 05 Feb 2021 05:05:30 PM CST  -1.023153 seconds
```



## CentOS 查看和修改时区



[How To Change Timezone on a CentOS 6 and 7 - nixCraft](https://www.cyberciti.biz/faq/centos-linux-6-7-changing-timezone-command-line/)



查看当前的 timezone

```
> date
Wed Feb 17 12:50:32 CST 2021

> ls -l /etc/localtime
lrwxrwxrwx. 1 root root 25 Oct  6  2018 /etc/localtime -> ../usr/share/zoneinfo/UTC

> timedatectl | grep -i 'time zone'
       Time zone: UTC (CST, +0800)
```



修改 timezone

```
> timedatectl set-timezone Asia/Shanghai
```



# Java

```java
LocalDateTime.now().toString();
// 2021-02-05T09:05:45.378

new Date().toString();
// Fri Feb 05 09:05:45 UTC 2021
```



```java
TimeZone.getDefault().toString()
// sun.util.calendar.ZoneInfo[id="UTC",offset=0,dstSavings=0,useDaylight=false,transitions=0,lastRule=null]
   
ZoneId.systemDefault().toString();
// UTC

System.getProperty("user.timezone");
// UTC
```


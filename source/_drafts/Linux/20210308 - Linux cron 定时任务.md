---
title: Linux cron 定时任务
mathjax: true
date: 2021-03-08 09:28:34
updated:
categories:
tags:
urlname: about-linux-cron
---



<!-- more -->



注意区分 cron 和 crontab，两种表达式不太一样。

Linux 中的 crontab 中的定时任务使用的是 crontab，一共有 5 位。





# 常见场景

## 提取出 df 命令中输出的磁盘使用率



```
df /home | awk '{ print $5 }' | sed 's/%//'
```

这个命令输出的内容格式如下：

```
Use
9
```

如果系统语言是中文的话，输出的是：

```
使用
9
```



如果不想要加表头，可以在中间加上 `tail -n 1`，即：

```sh
df /home | awk '{ print $5 }' | tail -n 1 | sed 's/%//'
```





# 参考资料

1. [Crontab.guru - The cron schedule expression editor](https://crontab.guru/#0_22_*_*_1-5)


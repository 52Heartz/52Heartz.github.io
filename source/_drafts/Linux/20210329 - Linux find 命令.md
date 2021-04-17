---
title: Linux find 命令
mathjax: true
date: 2021-03-03 16:37:00
updated:
categories:
tags:
urlname: about-linux-find-command
---



<!-- more -->





```sh

-- 查找48天之前的文件
find . -name "*" -type f -mtime +48 -exec stat  -c "%n %y" {} \;


-- 查找一小时之前的文件
find . -name "*" -type f -mmin +60 -exec stat  -c "%n %y" {} \;


-- 删除1小时之前的文件
find . -name "*" -type f -mmin +60 -delete

-- 查找时间段之间的文件
find . -newermt "2021-03-22 16:04:00" ! -newermt "2021-03-22 16:04:12" -exec stat  -c "%n %y" {} \;

```



# 使用场景

## 查找大文件

```sh
find / -xdev -size +100M -exec ls -l {} \;
```













# 参考资料

1. [bash - Find files based on modified date(specifying the exact hour) - Unix & Linux Stack Exchange](https://unix.stackexchange.com/questions/185897/find-files-based-on-modified-datespecifying-the-exact-hour)
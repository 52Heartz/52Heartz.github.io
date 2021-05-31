---
title: Linux watch 命令.md
mathjax: true
date: 2021-05-11 19:56:27
updated:
categories:
tags:
urlname: about-linux-watch-command
---



<!-- more -->





# 使用



```sh
watch "ps ax | grep sh"
```

默认是 2s 执行一次。可以通过 `-n` 调整频率



```sh
# 1s 执行一次
watch -n 1 "ps ax | grep sh"

# 0.1s 执行一次
watch -n 0.1 "ps ax | grep sh"
```







# 参考资料

1. [使用watch帮你重复执行命令 - 暗无天日](http://blog.lujun9972.win/blog/2018/05/10/使用watch帮你重复执行命令/index.html)


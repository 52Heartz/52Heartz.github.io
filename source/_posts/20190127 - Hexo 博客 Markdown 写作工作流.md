---
title: Hexo 博客 Markdown 写作工作流
date: 2019-01-27 19:39:50
updated:
categories:
tags:
urlname: hexo-blog-markdown-writing-workflow
---

# 关于图片的问题

## 图片调整大小

markdown中插入的图片是不支持调整大小的，如果想要博客最后呈现出来的图片是调整了大小的。可以在markdown文本中使用HTML的 `<img>` 标签，自己加上 `width` 等属性。

## 图片预览问题（打草稿过程中）

我目前（2018年12月-2019年1月）的博客URL方案。

打草稿时，使用Typora写作。如果直接使用 `<img>` 标签，

相关代码：

```html
<img src="xxx.png" alt="xxx" width="300px">
```

居中显示的图注：

```html
<p align="center">xxx</p>
```





# 参考资料

1. [Hexo常见问题解决方案](https://xuanwo.io/2014/08/14/hexo-usual-problem/)
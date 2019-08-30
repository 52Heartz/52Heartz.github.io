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



# 表格

## 粘贴与复制表格

### 直接从 Excel 复制到 Typora

从 Excel 复制内容，然后直接粘贴到 Typora 中，会自动转换为 Markdown 格式的表格。但是从 Excel 中复制数据，然后粘贴到 Typora 中已经存在的表格中，Typora 不会自动转换，只会粘贴从 Excel 复制的第一行。

缺点：表格中的内容有一些位置的一个空格会变成三个空格。

### 借助第三方工具

[tableconvert](https://tableconvert.com/)

## Markdown 表格中换行

使用 HTML 的 `<br>` 标签



# 排查错误

有时候可能忘记了为某些文章指定 urlname，这种情况如何排查呢。在本地执行 `hexo g` 之后，到根目录下的 `public` 文件夹下找找看有没有名字为 `null` 的文件夹，如果有，那么其中放的就是没有指定 `urlname` 的文章渲染出来的 HTML 文件。

# _posts 文件夹中文件太多怎么办

文章太多都放在一个文件，找起来也不方便。

其实可以在 _posts 问价夹下建立分类文件夹，比如所有写 LeetCode 的文章都放 LeetCode 文件夹下。如果有使用到图片的文章，只需要把图片放在和文件名完全相同的文件夹中，然后把这个文件夹和文件放在同一个目录下即可。

已经实际测试过，虽然是放在子文件夹中，但是渲染之后，hexo 会为每篇文章在 public 文件夹中建立唯一的一个文件夹，也就是说，虽然在 _posts 中是有层级结构的，但是渲染之后实际上是看不出来层级结构的。在 _posts 中建立文件夹只是方便我们更好地管理文章。

# 参考资料

1. [Hexo常见问题解决方案](https://xuanwo.io/2014/08/14/hexo-usual-problem/)
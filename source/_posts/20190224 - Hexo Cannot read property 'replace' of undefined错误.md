---
title: Hexo Cannot read property 'replace' of undefined错误
date: 2019-02-24 18:43:35
updated:
categories:
tags:
urlname: hexo-Cannot-read-property-'replace'-of-undefined-error
---

执行 `hexo g` 的时候提示 `hexo Cannot read property 'replace' of undefined` 错误。

经过排查发现是因为一篇文章中包含 `<img>` 这个字符串导致的。

<!-- more -->

Hexo在处理文章的时候，会把HTML标签识别出来，所以 `<img>` 被识别为HTML标签，但是标签中却是空的，所以导致报错。

只要在 `<img>` 旁边加上字符：`。将其转换成代码块即可。

另外，还会有其他情况引起错误。参考这篇文章：[Hexo 出现 Cannot read property '1' of undefined](http://jintaoliang.github.io/2015/01/11/Hexo-TypeError-Cannot-read-property-1-of-undefined/)
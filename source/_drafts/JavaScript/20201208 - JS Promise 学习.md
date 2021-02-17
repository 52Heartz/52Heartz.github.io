---
title: JS Promise 学习
mathjax: true
date: 2020-11-14 18:08:38
updated:
categories:
tags:
urlname: about-js-promise
---



<!-- more -->



# 状态

> A `Promise` is in one of these states:
>
> - *pending*: initial state, neither fulfilled nor rejected.
> - *fulfilled*: meaning that the operation was completed successfully.
> - *rejected*: meaning that the operation failed.



# Promise.all()

[Promise.all() - JavaScript | MDN](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/Promise/all)

这个函数接受一个 Promise 数组，返回一个 Promise。Promise 数组中只要有一个 reject 了，这个 Promise 也会 reject。

















# 参考资料

1. [使用 Promise - JavaScript | MDN](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Guide/Using_promises) | [Using Promises - JavaScript | MDN](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide/Using_promises)【使用说明】
2. [Promise - JavaScript | MDN](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/Promise) | [Promise - JavaScript | MDN](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise)【正式介绍】
3. [异步函数 - 提高 Promise 的易用性  | Web  | Google Developers](https://developers.google.com/web/fundamentals/primers/async-functions)
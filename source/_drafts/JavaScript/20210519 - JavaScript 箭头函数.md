---
title: JavaScript 箭头函数
mathjax: true
date: 2021-05-19 13:54:22
updated:
categories:
tags:
urlname: about-javascript-arrow-function
---



<!-- more -->

[箭头函数 - JavaScript | MDN](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Functions/Arrow_functions)

> 箭头函数表达式更适用于那些本来需要匿名函数的地方，并且它不能用作构造函数。



```js
(state) => (id) => {
    return state.todos.find(todo => todo.id === id)
}
```

上边的写法也是合法的，具体可以参考：

[js 中的多个连续的箭头函数与柯里化 - 知乎](https://zhuanlan.zhihu.com/p/26794822)


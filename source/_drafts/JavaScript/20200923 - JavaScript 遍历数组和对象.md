---
title: 20200923 - JavaScript 遍历数组和对象
mathjax: true
date: 2020-09-23 23:15:51
updated:
categories:
tags:
urlname: about-javascript-iteration
---



<!-- more -->



# 遍历数组



## for...of

[for...of - JavaScript | MDN](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/for...of)

> The [`for...of`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/statements/for...of) statement creates a loop Iterating over [iterable objects](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide/iterable) (including [`Array`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array), [`Map`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Map), [`Set`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Set), [`arguments`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/functions/arguments) object and so on), invoking a custom iteration hook with statements to be executed for the value of each distinct property.



```js
const arr = [3, 5, 7];
arr.foo = 'hello';

for (let i in arr) {
   console.log(i); // logs "0", "1", "2", "foo"
}

for (let i of arr) {
   console.log(i); // logs 3, 5, 7
}
```





# 遍历对象

## for...in

[for...in - JavaScript | MDN](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/for...in)

> The [`for...in`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/statements/for...in) statement iterates a specified variable over all the enumerable properties of an object. For each distinct property, JavaScript executes the specified statements. A `for...in` statement looks as follows:

for...in 方式会遍历对象中的所有可枚举属性。

```js
let obj = {
    p1: 1,
    p2: 2
}

for(key in obj) {
    console.log("key:" + key + ", obj[key]:" + obj[key]);
}
```

输出：

```
key:p1, obj[key]:1
key:p2, obj[key]:2
```



参考：[属性的可枚举性和所有权 - JavaScript | MDN](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Enumerability_and_ownership_of_properties) | [Enumerability and ownership of properties - JavaScript | MDN](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Enumerability_and_ownership_of_properties)













# 对象转数组







# 参考资料

1. [循环与迭代 - JavaScript | MDN](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Guide/Loops_and_iteration) | [Loops and iteration - JavaScript | MDN](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide/Loops_and_iteration)
2. [迭代器和生成器 - JavaScript | MDN](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Guide/Iterators_and_Generators) | [Iterators and generators - JavaScript | MDN](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide/Iterators_and_Generators)
3. [迭代协议 - JavaScript | MDN](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Iteration_protocols) | [Iteration protocols - JavaScript | MDN](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Iteration_protocols)
4. [javaScript遍历对象、数组总结 - 抖音2020 - 博客园](https://www.cnblogs.com/chenyablog/p/6477866.html)

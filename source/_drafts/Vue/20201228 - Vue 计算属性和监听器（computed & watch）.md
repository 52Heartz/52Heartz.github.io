---
title: Vue 计算属性和监听器（computed & watch）
mathjax: true
date: 2020-12-28 13:49:38
updated:
categories:
tags:
urlname: about-vue-computed-and-watch
---



<!-- more -->



# 计算属性



> 计算属性默认只有 getter，不过在需要时你也可以提供一个 setter。





# 监听器（watch）



## deep

> 为了发现对象内部值的变化，可以在选项参数中指定 `deep: true`。注意监听数组的变更不需要这么做。



## watch 数组的问题

> Vue 将被侦听的数组的变更方法进行了包裹，所以它们也将会触发视图更新。这些被包裹过的方法包括：
>
> - `push()`
> - `pop()`
> - `shift()`
> - `unshift()`
> - `splice()`
> - `sort()`
> - `reverse()`
>
> ——[列表渲染 - 数组更新检测 — Vue.js](https://cn.vuejs.org/v2/guide/list.html#数组更新检测)





> Vue 不能检测以下数组的变动：
>
> 1. 当你利用索引直接设置一个数组项时，例如：`vm.items[indexOfItem] = newValue`
> 2. 当你修改数组的长度时，例如：`vm.items.length = newLength`
>
> ——[深入响应式原理 - 检测变化的注意事项 — Vue.js](https://cn.vuejs.org/v2/guide/reactivity.html#检测变化的注意事项)



## vm.$watch API

[vm.$watch - API — Vue.js](https://cn.vuejs.org/v2/api/#vm-watch)



# 参考资料

1. [列表渲染 — Vue.js](https://cn.vuejs.org/v2/guide/list.html#数组更新检测)
2. [计算属性和侦听器 — Vue.js](https://cn.vuejs.org/v2/guide/computed.html)
3. [深入响应式原理 - 检测变化的注意事项 — Vue.js](https://cn.vuejs.org/v2/guide/reactivity.html#检测变化的注意事项)
4. [vue watch数组引发的血案](https://juejin.im/post/6844903699425263629)
5. [javascript - Vue.js - How to properly watch for nested data - Stack Overflow](https://stackoverflow.com/questions/42133894/vue-js-how-to-properly-watch-for-nested-data)【这篇文章主要是关于 watch nested value 的，比如使用 watch "obj.prop1" 这种形式。】
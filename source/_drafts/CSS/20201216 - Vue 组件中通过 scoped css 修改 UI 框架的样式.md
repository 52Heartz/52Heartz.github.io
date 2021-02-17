---
title: Vue 组件中通过 scoped css 修改 UI 框架的样式
mathjax: true
date: 2020-12-15 22:00:36
updated:
categories:
tags:
urlname: vue-css-scoped-modify-ui-framework-style
---



<!-- more -->

> 当 `<style>` 标签有 `scoped` 属性时，它的 CSS 只作用于当前组件中的元素。
>
> 





# 影响子组件

> 如果你希望 `scoped` 样式中的一个选择器能够作用得“更深”，例如影响子组件，你可以使用 `>>>` 操作符：
>
> ```html
> <style scoped>
> .a >>> .b { /* ... */ }
> </style>
> ```
>
> 上述代码将会编译成：
>
> ```css
> .a[data-v-f3f3eg9] .b { /* ... */ }
> ```
>
> 有些像 Sass 之类的预处理器无法正确解析 `>>>`。这种情况下你可以使用 `/deep/` 或 `::v-deep` 操作符取而代之——两者都是 `>>>` 的别名，同样可以正常工作。











# 参考资料

1. [Scoped CSS | Vue Loader](https://vue-loader.vuejs.org/zh/guide/scoped-css.html#混用本地和全局样式)
2. [vue（scoped）修改UI库组件样式_xiasohuai的博客-CSDN博客](https://blog.csdn.net/xiasohuai/article/details/105557353)
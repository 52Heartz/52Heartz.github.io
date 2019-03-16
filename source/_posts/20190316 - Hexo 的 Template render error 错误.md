---
title: Hexo 的 Template render error 错误
date: 2019-03-16 22:46:37
updated:
categories:
tags:
urlname: hexo-template-render-error
---

Hexo 的 Template render error 错误探究。

<!-- more -->

使用 Hexo 生成文档的时候，可能会如果如下错误：

```
FATAL Something's wrong. Maybe you can find the solution here: http://hexo.io/docs/troubleshooting.html
Template render error: (unknown path) [Line 181, Column 81]
  unexpected token: /
    at Object._prettifyError (E:\MyBlog\node_modules\hexo\node_modules\nunjucks\src\lib.js:36:11)
    at Template.render 
...
```

原因可能有如下两种:

1. 在 `.md` 源文件中出现了没有闭合的双括号，如单独的 `{% raw %}{{{% endraw %}` 或者单独的 `{% raw %}}}{% endraw %}`，或者出现了闭合的但是中间为空的双括号，如 `{% raw %}{{}}{% endraw %}` 。
2. 在 `.md` 源文件中出现了没有闭合的标签插件（Tag Plugins）。如只有 `{% raw %}{% xxx %}{% endraw %}`，但却没有 `{% raw %}{% endxxx %}{% endraw %}`。

更深层的原因是，{% raw %} {{ 和 }} {% endraw %}，以及 {% raw %}{% %}{% endraw %} 是 Hexo 模板中的标签，Hexo 处理源文件的时候会对这些标签进行解析，但是单独写的或者使用不支持的标签就会导致解析错误。

如果确实需要在文章中呈现出双括号或者括号加百分号这样的文字，可以直接在源文件中使用
```
{% raw %}
```
和
```
{% endraw %}
```
把要显示的文字括起来就好了。如下所示：

```
{% raw %}
包括 {{ 或 }} 或 {% %} 的文字
{% endraw %}
```

上边两个标签之间加了换行，不换行也可以的，只要把内容放在两个标签中间就可以了。另外，多个 `{% raw %}{% raw %}{% endraw %}{% endraw %}` 连续使用，可能会有非预期的效果，因为有些情况下为贪婪匹配模式，最远的两个匹配上，中间的所有内容都被设定为 raw 类型，不再有渲染效果。

另外，标签插件是只有 Hexo 已经规定的才能使用，如果自己随便写一个名字，会产生 `unknown block tag: xxx` 错误。可以使用的标签插件请参考：[标签插件（Tag Plugins）](https://hexo.io/zh-cn/docs/tag-plugins.html)

# 参考文章
1. [标签插件（Tag Plugins）](https://hexo.io/zh-cn/docs/tag-plugins.html)
1. [Hexo 异常 - Template render error unexpected token](https://hoxis.github.io/hexo-unexpected-token.html)
2. [Hexo博客Bug：“{% raw %}{{{% endraw %}”符号引起的生成报错](http://note.chenteng.me/2016/05/24/HexoBug/)
3. [Hexo的一个小BUG(Template render error)](https://www.jianshu.com/p/738ebe02029b)
4. [hexo 在markdown文档中出现 {% raw %}{% %}{% endraw %} 语法会报错，提示“Template render error: (unknown path) ” #3346 - Github Issues](https://github.com/hexojs/hexo/issues/3346)
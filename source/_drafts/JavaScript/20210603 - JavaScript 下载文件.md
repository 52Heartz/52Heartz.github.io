---
title: JavaScript 下载文件
mathjax: true
date: 2021-06-03 14:16:29
updated:
categories:
tags:
urlname: about-javascript-download-file
---



<!-- more -->

一个开源项目：

[kennethjiang/js-file-download](https://github.com/kennethjiang/js-file-download)

[rndme/download: file downloading using client-side javascript](https://github.com/rndme/download)



# 关于 axios

[Error Response for blob type · Issue #815 · axios/axios](https://github.com/axios/axios/issues/815)

[Missing documentation for downloading binary files · Issue #448 · axios/axios](https://github.com/axios/axios/issues/448)



[使用axios如何下载文件 - SegmentFault 思否](https://segmentfault.com/a/1190000022423204)

[Download files with AJAX (axios)](https://gist.github.com/javilobo8/097c30a233786be52070986d8cdb1743)



## 错误处理的情况

请求成功的情况下，下载文件。

请求失败的情况下，后端返回的是 JSON，需要正常展示之类的。

[javascript - Handling error messages when retrieving a blob via AJAX - Stack Overflow](https://stackoverflow.com/questions/29023509/handling-error-messages-when-retrieving-a-blob-via-ajax/29039823#29039823)【手动控制 XMLHttpRequest 的状态变化，然后修改 responseType】



# 参考资料

1. [XMLHttpRequest.responseType - Web API 接口参考 | MDN](https://developer.mozilla.org/zh-CN/docs/Web/API/XMLHttpRequest/responseType)
2. [MIME 类型 - HTTP | MDN](https://developer.mozilla.org/zh-CN/docs/Web/HTTP/Basics_of_HTTP/MIME_types)
3. [javascript - Handling error messages when retrieving a blob via AJAX - Stack Overflow](https://stackoverflow.com/questions/29023509/handling-error-messages-when-retrieving-a-blob-via-ajax/29039823#29039823)


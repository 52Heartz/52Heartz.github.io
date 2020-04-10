---
title: SendRedirect 和重定向问题
mathjax: true
date: 2020-04-10 15:57:38
updated:
categories:
tags:
urlname: about-send-redirect
---



<!-- more -->



之前遇到过一个问题，就是在后端调用 `request.sendRedirect()` 的时候，如果同时设置了 Cookie，那么 Cookie 是不生效的。

但是20200410测试的时候，不管是 Chrome 还是 Firefox 都是生效的。

但是 Chromium 系的浏览器确实是有这个历史 BUG 的，参考：

[696204 - Cookies are ignored on 302 redirects - chromium](https://bugs.chromium.org/p/chromium/issues/detail?id=696204)

[150066 - Set-cookie ignored for HTTP response with status 302 - chromium](https://bugs.chromium.org/p/chromium/issues/detail?id=150066)

[Issue 150066 in chromium: Set-cookie ignored for HTTP response with status 302 - Google 网上论坛](https://groups.google.com/a/chromium.org/forum/#!topic/chromium-bugs/Lp7_GvNTdlg)



# 参考资料

1. [HttpServletResponse.sendRedirect重定向与Cookie失效_Java_Nothing is difficult if you put your heart into it-CSDN博客](https://blog.csdn.net/quliangmao/article/details/80253392)
2. [解决重定向丢失cookie问题_Java_yanjianpeng_2018的博客-CSDN博客](https://blog.csdn.net/yanjianpeng_2018/article/details/79425948)
3. [HttpServletResponse添加cookie后，不生效_Java_weixin_42213903的博客-CSDN博客](https://blog.csdn.net/weixin_42213903/article/details/98485387)
4. [java - How to send a cookie after response.sendRedirect()? - Stack Overflow](https://stackoverflow.com/questions/11872896/how-to-send-a-cookie-after-response-sendredirect)
5. [java - response.addCookie() then RequestDispatcher forward but no cookie - Stack Overflow](https://stackoverflow.com/questions/30241188/response-addcookie-then-requestdispatcher-forward-but-no-cookie)
6. [Adding cookie in java and then HTTP redirect doesnt show cookie in client side - Stack Overflow](https://stackoverflow.com/questions/4456454/adding-cookie-in-java-and-then-http-redirect-doesnt-show-cookie-in-client-side)
7. [http - Sending browser cookies during a 302 redirect - Stack Overflow](https://stackoverflow.com/questions/4694089/sending-browser-cookies-during-a-302-redirect)
8. [java - Is there a solution to keep a cookie on browser while redirect the response? - Stack Overflow](https://stackoverflow.com/questions/28788736/is-there-a-solution-to-keep-a-cookie-on-browser-while-redirect-the-response)




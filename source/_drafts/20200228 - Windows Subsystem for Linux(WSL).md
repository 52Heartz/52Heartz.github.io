---
title: Windows Subsystem for Linux(WSL)
mathjax: true
date: 2020-02-28 23:44:52
updated:
categories:
tags:
urlname: Windows-Subsystem-for-Linux
---



<!-- more -->



# 查看 WSL 的版本

```
wsl --list --verbose
```

示例输出：

```
  NAME      STATE           VERSION
* Ubuntu    Stopped         1
```





# WSL 存储的位置

以 ubuntu 为例，文件都存储在：

```
C:\Users\[username]\AppData\Local\Packages\CanonicalGroupLimited.UbuntuonWindows_79rhkp1fndgsc
```

其中 `[username]` 指本机的用户。



# 安装 Java

因为不需要在服务器上进行开发，所以服务器上只需要安装 JRE。



顺便，了解一下 Java 8 之后的收费策略：[Oracle如何对JDK收费](https://zhuanlan.zhihu.com/p/64731331)

如果想要免费，只能用 Java8u202 之前的版本。

查看 Linux 版本：

```shell
peng@DESKTOP-VUB939L:~$ sudo lsb_release -a
No LSB modules are available.
Distributor ID: Ubuntu
Description:    Ubuntu 18.04.2 LTS
Release:        18.04
Codename:       bionic
```



[Java Archive Downloads - Java SE 8](https://www.oracle.com/java/technologies/javase/javase8-archive-downloads.html)

[8 Server JRE 8 Installation for Linux Platforms](https://docs.oracle.com/javase/8/docs/technotes/guides/install/linux_server_jre.html)【Linux 安装 Java 步骤】



wget 下载

```
wget https://download.oracle.com/otn/java/jdk/8u202-b08/1961070e4c9b4e26a04e7f5a083f551e/server-jre-8u202-linux-x64.tar.gz?AuthParam=1582959723_365cef16ac9fce2e8ac532e0c48ed2c5
```

这个链接是在浏览器中下载然后拷贝过来的链接，现在 Oracle 做了限制，一个链接好像有一定的有效期，不能无限次重复使用。



```
tar zxvf server-jre-8uversion-linux-x64.tar.gz
```



配置环境变量：

[Linux环境变量配置全攻略](https://www.cnblogs.com/youyoui/p/10680329.html)



```
vim ~/.bashrc
```



加入以下内容：

```
export JAVA_HOME=/path/to/jre
export JRE_HOME=${JAVA_HOME}/jre
export CLASSPATH=.:${JAVA_HOME}/lib:${JRE_HOME}/lib
export PATH=.:${JAVA_HOME}/bin:$PATH
```



使生效

```
source ~/.bashrc
```





从最末尾开始查看日志：

```
less XXX.log
```

然后按 `Shift` + `G` 或者输入 `:G` 跳到最末尾

其他快捷键：

`g`：跳转到最开头

`b`：前翻一页

`(SPACE)`：后翻一页

`u`：前翻半页

`d`：后翻半页



```
java.lang.ExceptionInInitializerError
        at com.fr.form.ui.container.cardlayout.WCardTagLayout.<init>(Unknown Source)
        at sun.reflect.NativeConstructorAccessorImpl.newInstance0(Native Method)
        at sun.reflect.NativeConstructorAccessorImpl.newInstance(NativeConstructorAccessorImpl.java:62)
        at sun.reflect.DelegatingConstructorAccessorImpl.newInstance(DelegatingConstructorAccessorImpl.java:45)
        at java.lang.reflect.Constructor.newInstance(Constructor.java:423)
        at java.lang.Class.newInstance(Class.java:442)
        at com.fr.form.ui.WidgetXmlUtils.readWidget(Unknown Source)
        at com.fr.form.ui.container.WBorderLayout$5.readXML(Unknown Source)
        at com.fr.stable.xml.XMLableReader.readXMLObject(Unknown Source)
        at com.fr.form.ui.container.WBorderLayout.readXML(Unknown Source)
        at com.fr.form.ui.container.cardlayout.WCardTitleLayout.readXML(Unknown Source)
        at com.fr.stable.xml.XMLableReader.readXMLObject(Unknown Source)
        at com.fr.form.ui.WidgetXmlUtils.readWidget(Unknown Source)
        at com.fr.form.ui.container.WBorderLayout$1.readXML(Unknown Source)
        at com.fr.stable.xml.XMLableReader.readXMLObject(Unknown Source)
        at com.fr.form.ui.container.WBorderLayout.readXML(Unknown Source)
        at com.fr.stable.xml.XMLableReader.readXMLObject(Unknown Source)
        at com.fr.form.ui.WidgetXmlUtils.readWidget(Unknown Source)
        at com.fr.form.ui.widget.CRBoundsWidget.readXML(Unknown Source)
        at com.fr.stable.xml.XMLableReader.readXMLObject(Unknown Source)
        at com.fr.form.ui.WidgetXmlUtils.readWidget(Unknown Source)
        at com.fr.form.ui.container.WLayout.readXML(Unknown Source)
        at com.fr.form.ui.container.WSortLayout.readXML(Unknown Source)
        at com.fr.form.ui.container.WAbsoluteLayout.readXML(Unknown Source)
        at com.fr.form.ui.container.WAbsoluteBodyLayout.readXML(Unknown Source)
        at com.fr.stable.xml.XMLableReader.readXMLObject(Unknown Source)
        at com.fr.form.ui.WidgetXmlUtils.readWidget(Unknown Source)
        at com.fr.form.ui.widget.CRBoundsWidget.readXML(Unknown Source)
        at com.fr.stable.xml.XMLableReader.readXMLObject(Unknown Source)
        at com.fr.form.ui.WidgetXmlUtils.readWidget(Unknown Source)
        at com.fr.form.ui.container.WLayout.readXML(Unknown Source)
        at com.fr.form.ui.container.WSortLayout.readXML(Unknown Source)
        at com.fr.form.ui.container.WFitLayout.readXML(Unknown Source)
        at com.fr.stable.xml.XMLableReader.readXMLObject(Unknown Source)
        at com.fr.form.ui.WidgetXmlUtils.readWidget(Unknown Source)
        at com.fr.form.ui.container.WBorderLayout$5.readXML(Unknown Source)
        at com.fr.stable.xml.XMLableReader.readXMLObject(Unknown Source)
        at com.fr.form.ui.container.WBorderLayout.readXML(Unknown Source)
        at com.fr.stable.xml.XMLableReader.readXMLObject(Unknown Source)
        at com.fr.form.ui.WidgetXmlUtils.readWidget(Unknown Source)
        at com.fr.form.main.Form.compatibleOldParameter(Unknown Source)
        at com.fr.form.main.Form.readXML(Unknown Source)
        at com.fr.stable.xml.XMLableReader.readXMLObject(Unknown Source)
        at com.fr.form.main.Form.readStream(Unknown Source)
        at com.fr.form.main.FormIO.readForm(Unknown Source)
        at com.fr.form.main.FormIO.readForm(Unknown Source)
        at com.fr.web.weblet.cache.FormEntry.readForm(Unknown Source)
        at com.fr.web.weblet.cache.FormEntry.getForm(Unknown Source)
        at com.fr.web.weblet.cache.FormEntryManager.getFormFromCache(Unknown Source)
        at com.fr.web.weblet.TemplateFormlet.createForm(Unknown Source)
        at com.fr.web.weblet.Formlet.createSessionIDInfor(Unknown Source)
        at com.fr.web.core.SessionPoolManager.generateSessionID(Unknown Source)
        at com.fr.web.core.reserve.FormletDealWith.dealWithFormlet(Unknown Source)
        at com.fr.web.weblet.Formlet.dealWeblet(Unknown Source)
        at com.fr.web.core.ReportDispatcher.dealWeblet(Unknown Source)
        at com.fr.web.core.ReportDispatcher.dealWithRequest(Unknown Source)
        at com.fr.web.controller.BaseRequestService.preview(Unknown Source)
        at com.fr.web.controller.FormRequestService.preview(Unknown Source)
        at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)
        at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)
        at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)
        at java.lang.reflect.Method.invoke(Method.java:498)
        at com.fr.third.springframework.web.method.support.InvocableHandlerMethod.doInvoke(InvocableHandlerMethod.java:221)
        at com.fr.third.springframework.web.method.support.InvocableHandlerMethod.invokeForRequest(InvocableHandlerMethod.java:137)
        at com.fr.third.springframework.web.servlet.mvc.method.annotation.ServletInvocableHandlerMethod.invokeAndHandle(ServletInvocableHandlerMethod.java:104)
        at com.fr.third.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerAdapter.invokeHandleMethod(RequestMappingHandlerAdapter.java:747)
        at com.fr.third.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerAdapter.handleInternal(RequestMappingHandlerAdapter.java:676)
        at com.fr.third.springframework.web.servlet.mvc.method.AbstractHandlerMethodAdapter.handle(AbstractHandlerMethodAdapter.java:85)
        at com.fr.third.springframework.web.servlet.DispatcherServlet.doDispatch(DispatcherServlet.java:938)
        at com.fr.third.springframework.web.servlet.DispatcherServlet.doService(DispatcherServlet.java:870)
        at com.fr.third.springframework.web.servlet.FrameworkServlet.processRequest(FrameworkServlet.java:961)
        at com.fr.third.springframework.web.servlet.FrameworkServlet.doGet(FrameworkServlet.java:852)
        at javax.servlet.http.HttpServlet.service(HttpServlet.java:634)
        at com.fr.third.springframework.web.servlet.FrameworkServlet.service(FrameworkServlet.java:837)
        at javax.servlet.http.HttpServlet.service(HttpServlet.java:741)
        at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:231)
        at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)
        at com.fr.third.springframework.web.filter.CharacterEncodingFilter.doFilterInternal(CharacterEncodingFilter.java:88)
        at com.fr.third.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:107)
        at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)
        at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)
        at org.apache.tomcat.websocket.server.WsFilter.doFilter(WsFilter.java:52)
        at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)
        at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)
        at com.fr.decision.base.DecisionServletInitializer$6.doFilterInternal(DecisionServletInitializer.java:209)
        at com.fr.third.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:107)
        at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)
        at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)
        at com.fr.decision.base.DecisionServletInitializer$4.doFilter(DecisionServletInitializer.java:141)
        at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)
        at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)
        at org.apache.catalina.core.StandardWrapperValve.invoke(StandardWrapperValve.java:199)
        at org.apache.catalina.core.StandardContextValve.invoke(StandardContextValve.java:96)
        at org.apache.catalina.authenticator.AuthenticatorBase.invoke(AuthenticatorBase.java:543)
        at org.apache.catalina.core.StandardHostValve.invoke(StandardHostValve.java:139)
        at org.apache.catalina.valves.ErrorReportValve.invoke(ErrorReportValve.java:81)
        at org.apache.catalina.valves.AbstractAccessLogValve.invoke(AbstractAccessLogValve.java:688)
        at org.apache.catalina.core.StandardEngineValve.invoke(StandardEngineValve.java:87)
        at org.apache.catalina.connector.CoyoteAdapter.service(CoyoteAdapter.java:343)
        at org.apache.coyote.http11.Http11Processor.service(Http11Processor.java:609)
        at org.apache.coyote.AbstractProcessorLight.process(AbstractProcessorLight.java:65)
        at org.apache.coyote.AbstractProtocol$ConnectionHandler.process(AbstractProtocol.java:818)
        at org.apache.tomcat.util.net.NioEndpoint$SocketProcessor.doRun(NioEndpoint.java:1623)
        at org.apache.tomcat.util.net.SocketProcessorBase.run(SocketProcessorBase.java:49)
        at java.util.concurrent.ThreadPoolExecutor.runWorker(ThreadPoolExecutor.java:1149)
        at java.util.concurrent.ThreadPoolExecutor$Worker.run(ThreadPoolExecutor.java:624)
        at org.apache.tomcat.util.threads.TaskThread$WrappingRunnable.run(TaskThread.java:61)
        at java.lang.Thread.run(Thread.java:748)
Caused by: java.lang.NullPointerException
        at sun.awt.FontConfiguration.getVersion(FontConfiguration.java:1264)
        at sun.awt.FontConfiguration.readFontConfigFile(FontConfiguration.java:219)
        at sun.awt.FontConfiguration.init(FontConfiguration.java:107)
        at sun.awt.X11FontManager.createFontConfiguration(X11FontManager.java:774)
        at sun.font.SunFontManager$2.run(SunFontManager.java:431)
        at java.security.AccessController.doPrivileged(Native Method)
        at sun.font.SunFontManager.<init>(SunFontManager.java:376)
        at sun.awt.FcFontManager.<init>(FcFontManager.java:35)
        at sun.awt.X11FontManager.<init>(X11FontManager.java:57)
        at sun.reflect.NativeConstructorAccessorImpl.newInstance0(Native Method)
        at sun.reflect.NativeConstructorAccessorImpl.newInstance(NativeConstructorAccessorImpl.java:62)
```

这个报错是因为使用 OpenJDK 导致的（和操作系统也有一定关系），换成 Oracle JDK 就不会有问题了。

同时这个报错第一次是这样的，后边还会导致 

```
Could not initialize class com.fr.general.cardtag.mobile.DefaultMobileTemplateStyle
java.lang.NoClassDefFoundError: Could not initialize class com.fr.general.cardtag.mobile.DefaultMobileTemplateStyle
```



如果想要修复，可以参考：

[apline-tomcat镜像 "sun.awt.FontConfiguration.getVersion NullPointerException"问题解决](https://blog.csdn.net/hongweigg/article/details/79867386)

[类静态字段初始化错误导致的ExceptionInInitializerError和NoClassDefFoundError](https://blog.csdn.net/lzufeng/article/details/90373569)

[NPE at sun.awt.FontConfiguration.getVersion(FontConfiguration.java:1264) when using install4j caused by font config missing](https://github.com/AdoptOpenJDK/openjdk-build/issues/693)



修改 Tomcat 使用的 JRE，修改 `setclasspath.sh`

```
export JAVA_HOME='/home/peng/jdk1.8.0_202'
export JRE_HOME='/home/peng/jdk1.8.0_202/jre'
```



Java 8 的官方文档

[Java Platform Standard Edition 8 Documentation](https://docs.oracle.com/javase/8/docs/index.html)



[Understanding the Server JRE](https://blogs.oracle.com/java-platform-group/understanding-the-server-jre)【关于 Server JRE 和 JRE 的区别】，也可参考[JDK 7 and JRE 7 Installation Guide](https://docs.oracle.com/javase/7/docs/webnotes/install/index.html)

JDK 中包含了开发常用的所有模块，包括 javac、javap、javadoc 等。

JRE 中只有运行 Java 程序所需要的模块。

Server JRE 在 JRE 的基础上加入了一些 JDK 中的东西。

总体来讲，从包含模块的范围来讲 JRE < Server JRE < JDK





# 卸载 WSL



参考资料

1. [Windows 10 子系统Linux重启(不重启Win10)_weixin_34293911的博客-CSDN博客_windows linux子系统重启](https://blog.csdn.net/weixin_34293911/article/details/89592278)
2. [Overview - Process Hacker](https://wj32.org/processhacker/index.php)
3. [WSL is unkillable without rebooting (permissions/security problems for admins) · Issue #1086 · microsoft/WSL](https://github.com/microsoft/WSL/issues/1086)
4. [windows 10 - WSL Ubuntu hangs, how to restart? - Stack Overflow](https://stackoverflow.com/questions/48407070/wsl-ubuntu-hangs-how-to-restart)



# 参考资料

1. [Frequently Asked Questions (FAQ) | Microsoft Docs](https://docs.microsoft.com/en-us/windows/wsl/faq#what-is-windows-subsystem-for-linux-wsl)
2. [Windows 10生产力提升之WSL实践](https://iyaozhen.com/windows10-wsl-ubuntu.html)
3. [WSL 使用指南——03 避免的坑](https://zhuanlan.zhihu.com/p/34885187)
4. [为什么 Windows 的 Linux 子系统的文件同步和 Windows 不是实时的？ - 知乎](https://www.zhihu.com/question/318832524)
5. [在Windows下将文件放到Ubuntu子系统的目录下，为何在bash下看不见？ - 知乎](https://www.zhihu.com/question/62177866)
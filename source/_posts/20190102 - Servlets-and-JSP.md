---
title: Servlets and JSP
date: 2019-01-02 23:14:57
updated:
categories:
- 技术
tags:
- Java
urlname: Java-servlets-and-JSP
---

# Web App 架构概览

`Servlet` 要发挥作用，还需要容器的帮助，`Tomcat` 就是一个容器。通过容器来调用 `Servlet`。容器负责处理建立线程、套接字、网络等功能，这样你就不用自己编写这些这些代码，可以把经理集中到编写业务逻辑代码上。

## 容器的主要功能

- 通信功能支持
- Servlets生命周期管理
- 多线程支持
- 声明式安全管理
- JSP支持

<!-- more -->

## 容器是如何处理HTTP请求的

1. 容器收到HTTP请求，创建两个对象 `HttpServletResponse` 和 `HttpServletRequest`。
2. 容器识别出HTTP请求的 `Servlet`，并创建这个 `Servlet` 的线程。
3. 容器调用 `Servlet` 的 `service()` 方法， `Servlet` 运行结束之后生成一个response。
4. 容器把这个response转换成 `HTTP response`。发送回客户端。

## 一个 `Servlet` 可以有三个名字

一个 `Servlet` 可以有三个名字：

1. 一个面向客户的名字，编写在实际的网页代码中。称公开名（`public URL name`）
2. 一个面向部署者的名字，称为内部名（`internal name`）
3. 一个 `Servlet` 真实的名字。称为真实名（`fully-qualified class name`）

这种机制可以改善你的程序的 `灵活性` 和 `安全性`。

## 使用部署描述符（`Deployment descriptor`）做三个名字之间的映射

使用两个 `xml` 文件完成这个映射，一个从公开名映射到内部名，一个从内部名映射到真实名。

```xml
<web-app ...>
  <servlet>
    <servlet-name>Internal name 1</servlet-name>
    <servlet-class>foo.Servlet1</servlet-class>
  </servlet>

  <servlet>
    <servlet-name>Internal name 2</servlet-name>
    <servlet-class>foo.Servlet2</servlet-class>
  </servlet>

  <servlet-mapping>
    <servlet-name>Internal name 1</servlet-name>
    <url-pattern>/Public1</url-pattern>
  </servlet-mapping>

  <servlet-mapping>
    <servlet-name>Internal name 2</servlet-name>
    <url-pattern>/Public2</url-pattern>
  </servlet-mapping>
</web-app>
```

`<url-pattern>` 对应公开名

`<servlet-name>` 对应内部名

`<servlet-class>` 对应真实名

一个 `<servlet-name>` 和唯一的 `<servlet-mapping>` 相对应。

## MVC 模式的使用

业务逻辑代码要和视图相分离，业务逻辑代码甚至不应该知道是否有视图代码的存在，也就是说业务逻辑代码完全不涉及主动更新视图的代码。

不要直接把业务逻辑代码放在 `Servlet` 中，把业务逻辑代码独立出来。

`Servlet` 相当于 `Controller`

`JSP` 相当于 `View`

业务逻辑代码（`Plain old Java`）相当于 `Model`

## 关于容器

Tomcat本身也可以做为HTTP服务器来使用，但是它作为HTTP服务器，不够健壮，不如Apache，所以一般是两者配合使用，使用Apache来做HTTP服务器，Tomcat作为Web container。

# 迷你MVC教程

开发环境架构

<img src="development-environment-architecture.png" alt="development-environment-architecture">

部署环境架构

<img src="deployment-environment-architecture.png" alt="deployment-environment-architecture">
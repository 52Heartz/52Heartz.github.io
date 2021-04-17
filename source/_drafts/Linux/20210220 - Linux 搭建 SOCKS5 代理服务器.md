---
title: Linux 搭建 SOCKS5 代理服务器
mathjax: true
date: 2021-02-20 18:21:00
updated:
categories:
tags:
urlname: about-linux-socks5-proxy
---



<!-- more -->



# FDLoad 对 Linux 系统本身的影响



## 对于动态链接库的影响



```
[root@1591927352563 FDLoad]# echo $LD_LIBRARY_PATH
/opt/fanruan/gpload/FDLoad/lib:/opt/fanruan/gpload/FDLoad/ext/python/lib:
```





安装完 FDLOAD 之后，python 版本变化了，原因是 LD_LIBRARY_PATH 被修改了。把 LD_LIBRARY_PATH 的值设置为空即可恢复：

```
// 修改为没有安装 fdload 的状态
export LD_LIBRARY_PATH=

// 恢复成刚刚安装完 fdload 的状态
export LD_LIBRARY_PATH=/opt/fanruan/gpload/FDLoad/lib:/opt/fanruan/gpload/FDLoad/ext/python/lib:
```





Linux 符号链接

```
curl: symbol lookup error: /lib64/libldap-2.4.so.2: undefined symbol: ber_sockbuf_io_udp

[root@1591927352563 opt]# ldd /lib64/libldap-2.4.so.2
	linux-vdso.so.1 =>  (0x00007fff7c3f1000)
	liblber-2.4.so.2 => /opt/fanruan/gpload/FDLoad/lib/liblber-2.4.so.2 (0x00007f39a7369000)
	libresolv.so.2 => /lib64/libresolv.so.2 (0x00007f39a7150000)
	libsasl2.so.3 => /lib64/libsasl2.so.3 (0x00007f39a6f33000)
	libssl.so.10 => /lib64/libssl.so.10 (0x00007f39a6cc1000)
	libcrypto.so.10 => /lib64/libcrypto.so.10 (0x00007f39a6860000)
	libssl3.so => /lib64/libssl3.so (0x00007f39a660e000)
	libsmime3.so => /lib64/libsmime3.so (0x00007f39a63e7000)
	libnss3.so => /lib64/libnss3.so (0x00007f39a60ba000)
	libnssutil3.so => /lib64/libnssutil3.so (0x00007f39a5e8b000)
	libplds4.so => /lib64/libplds4.so (0x00007f39a5c87000)
	libplc4.so => /lib64/libplc4.so (0x00007f39a5a82000)
	libnspr4.so => /lib64/libnspr4.so (0x00007f39a5844000)
	libpthread.so.0 => /lib64/libpthread.so.0 (0x00007f39a5628000)
	libdl.so.2 => /lib64/libdl.so.2 (0x00007f39a5424000)
	libc.so.6 => /lib64/libc.so.6 (0x00007f39a5057000)
	libcrypt.so.1 => /lib64/libcrypt.so.1 (0x00007f39a4e20000)
	libgssapi_krb5.so.2 => /opt/fanruan/gpload/FDLoad/lib/libgssapi_krb5.so.2 (0x00007f39a4bf6000)
	libkrb5.so.3 => /opt/fanruan/gpload/FDLoad/lib/libkrb5.so.3 (0x00007f39a496c000)
	libk5crypto.so.3 => /opt/fanruan/gpload/FDLoad/lib/libk5crypto.so.3 (0x00007f39a4748000)
	libcom_err.so.2 => /lib64/libcom_err.so.2 (0x00007f39a4544000)
	libkrb5support.so.0 => /opt/fanruan/gpload/FDLoad/lib/libkrb5support.so.0 (0x00007f39a433d000)
	libz.so.1 => /lib64/libz.so.1 (0x00007f39a4127000)
	librt.so.1 => /lib64/librt.so.1 (0x00007f39a3f1f000)
	/lib64/ld-linux-x86-64.so.2 (0x00007f39a77cc000)
	libfreebl3.so => /lib64/libfreebl3.so (0x00007f39a3d1c000)
	libcom_err.so.3 => /opt/fanruan/gpload/FDLoad/lib/libcom_err.so.3 (0x00007f39a3b17000)
```

上边有些库被链接到了 `/opt/fanruan/gpload/FDLoad/lib/`，就是因为 LD_LIBRARY_PATH 被修改的原因，具体可参考：



[dynamic linking - How to change the path of shared libraries shown by ldd? - Unix & Linux Stack Exchange](https://unix.stackexchange.com/questions/304140/how-to-change-the-path-of-shared-libraries-shown-by-ldd)





```
export PYTHONHOME=/usr/lib/python2.7


echo $PYTHONPATH

export PYTHONPATH=$PYTHONPATH:/usr/lib64/python2.7:/usr/lib/python2.7/site-packages
```



Could not find platform independent libraries

解决方法：设置 PYTHONPATH 把 site-package 的路径加上去。





# 安装 WGET

TODO

rpm 下载源地址：http://mirrors.163.com/centos/6.2/os/x86_64/Packages/

下载wget的RPM包：http://mirrors.163.com/centos/6.2/os/x86_64/Packages/wget-1.12-1.4.el6.x86_64.rpm

rpm ivh wget-1.12-1.4.el6.x86_64.rpm 安装即可。



```
rpm ivh wget-1.12-1.4.el6.x86_64.rpm
```



http://mirrors.163.com/centos/7/os/x86_64/Packages/







# 重新安装 yum

[CentOS7 重装yum并且配置163国内镜像源](https://juejin.cn/post/6844903780731863048)

http://mirrors.163.com/centos/7/os/x86_64/Packages/



```
wget http://mirrors.163.com/centos/7/os/x86_64/Packages/yum-3.4.3-168.el7.centos.noarch.rpm
wget http://mirrors.163.com/centos/7/os/x86_64/Packages/yum-metadata-parser-1.1.4-10.el7.x86_64.rpm
wget http://mirrors.163.com/centos/7/os/x86_64/Packages/yum-plugin-fastestmirror-1.1.31-54.el7_8.noarch.rpm
wget http://mirrors.163.com/centos/7/os/x86_64/Packages/python-iniparse-0.4-9.el7.noarch.rpm
```



[directory structure - Difference between lib, lib32, lib64, libx32, and libexec - Unix & Linux Stack Exchange](https://unix.stackexchange.com/questions/74646/difference-between-lib-lib32-lib64-libx32-and-libexec)







报错：No module named time 或者 No module named time

```
[root@1591927352563 site-packages]# yum
There was a problem importing one of the Python modules
required to run yum. The error leading to this problem was:

   No module named time

Please install a package which provides this module, or
verify that the module is installed correctly.

It's possible that the above module doesn't match the
current version of Python, which is:
2.7.5 (default, Jul 13 2018, 13:06:57) 
[GCC 4.8.5 20150623 (Red Hat 4.8.5-28)]

If you cannot solve this problem yourself, please go to 
the yum faq at:
  http://yum.baseurl.org/wiki/Faq
```

原因：PYTHONPATH 没有设置好

设置为：

```
export PYTHONPATH=/usr/lib64/python2.7:/usr/lib64/python2.7/site-packages:/usr/lib64/python2.7/lib-dynload/
```

可以解决。





参考

[python 2.7 - ImportError: No module named time - Stack Overflow](https://stackoverflow.com/questions/35514703/importerror-no-module-named-time)





```
[root@1591927352563 site-packages]# echo $PYTHONPATH
/usr/lib/python2.7/site-packages:/usr/lib64/python2.7


[root@1591927352563 site-packages]# echo $PYTHONHOME
/usr/lib/python2.7

export PYTHONPATH=

export PYTHONHOME=


// 恢复
export PYTHONPATH=/usr/lib64/python2.7:/usr/lib64/python2.7/site-packages:/usr/lib64/python2.7/lib-dynload/
```





# 参考资料

1. [Python 安装 - binarylei - 博客园](https://www.cnblogs.com/binarylei/p/8792902.html)


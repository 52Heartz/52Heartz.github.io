---
title: Java keytool 相关
mathjax: true
date: 2020-07-14 17:58:14
updated:
categories:
tags:
urlname: about-java-keytool
---



<!-- more -->



# certreq

> Generates a Certificate Signing Request (CSR) using the PKCS #10 format.
>
> A CSR is intended to be sent to a certificate authority (CA). The CA authenticates the certificate requestor (usually off-line) and will return a certificate or certificate chain, used to replace the existing certificate chain (which initially consists of a self-signed certificate) in the keystore.
>
> The private key associated with alias is used to create the PKCS #10 certificate request. To access the private key, the correct password must be provided. If `keypass` is not provided at the command line and is different from the password used to protect the integrity of the keystore, then the user is prompted for it. If `dname` is provided, then it is used as the subject in the CSR. Otherwise, the X.500 Distinguished Name associated with alias is used.
>
> The `sigalg` value specifies the algorithm that should be used to sign the CSR.The CSR is stored in the file certreq_file. If no file is specified, then the CSR is output to `stdout`.
>
> Use the `importcert` command to import the response from the CA.





# 测试



```
keytool -list -v -keystore /xxx.jks -storepass 1234
```



# 一个例子

```
"C:\Program Files\Java\jdk1.8.0_221\bin\keytool.exe" -list -v -keystore ./test.app.siam.sinopec.com.jks -storepass test@2018
```



部分输出：

```
您的密钥库包含 3 个条目

别名: ca
创建日期: 2018-11-14
条目类型: trustedCertEntry

所有者: CN=CA, O=SINOPEC, C=CN
发布者: CN=SINOPEC RSA Root CA, O=SINOPEC, C=CN
序列号: 4330303230303030303030303937
有效期为 Thu Oct 09 15:23:19 CST 2008 至 Wed Oct 09 15:23:19 CST 2058
证书指纹:
         MD5:  81:A8:68:80:B6:21:FF:98:24:17:A9:B0:03:62:3B:8C
         SHA1: F3:10:1B:B4:8B:DB:AD:CD:6D:59:BA:E0:77:35:8E:09:F0:15:1C:29
         SHA256: CF:95:DD:41:5F:F8:BE:3D:FE:2C:DA:98:63:F2:F8:03:96:0B:C5:14:EB:63:CC:25:AC:1A:5A:A9:13:62:C9:5D
签名算法名称: SHA256withRSA
主体公共密钥算法: 1024 位 RSA 密钥
版本: 3

别名: test.app.siam.sinopec.com
创建日期: 2018-11-14
条目类型: PrivateKeyEntry
证书链长度: 3
证书[1]:
所有者: CN=test.app.siam.sinopec.com, OU=SINOPEC, O=SINOPEC, L=beijing, C=CN
发布者: CN=CA, O=SINOPEC, C=CN
序列号: 4330303130303030303037303335
有效期为 Wed Nov 14 08:00:00 CST 2018 至 Tue Nov 14 08:00:00 CST 2023
证书指纹:
         MD5:  2C:8A:A4:13:E4:2F:B9:65:62:CD:83:02:63:E3:3E:C3
         SHA1: 9D:3D:CF:39:BA:6B:96:1A:5D:E7:DC:74:37:F6:6E:DA:51:19:9B:E8
         SHA256: B9:09:CA:AA:25:53:34:D2:B6:ED:4F:75:8D:FE:36:5F:3E:95:D1:91:A2:B0:F9:2B:85:C2:4E:D6:76:70:B7:E9
签名算法名称: SHA256withRSA
主体公共密钥算法: 2048 位 RSA 密钥
版本: 3

别名: rca
创建日期: 2018-11-14
条目类型: trustedCertEntry

所有者: CN=SINOPEC RSA Root CA, O=SINOPEC, C=CN
发布者: CN=SINOPEC RSA Root CA, O=SINOPEC, C=CN
序列号: 4330303230303030303030303231
有效期为 Thu Oct 09 15:23:19 CST 2008 至 Wed Oct 09 15:23:19 CST 2058
证书指纹:
         MD5:  7A:0B:29:FF:6C:3A:56:19:23:D4:34:C4:A6:B0:91:CA
         SHA1: 93:3C:4B:BF:40:77:44:56:BB:83:D3:B0:96:E8:F4:26:B4:AC:55:1C
         SHA256: 35:48:AE:67:81:8A:BF:B2:3B:12:CE:CB:DF:9A:07:AA:6A:60:5B:4A:0C:75:2F:2F:D3:8A:51:18:F7:7B:00:4B
签名算法名称: SHA256withRSA
主体公共密钥算法: 2048 位 RSA 密钥
版本: 3
```





# 其他



> Once you've imported a certificate authenticating the public key of the CA you submitted your certificate signing request to (or there's already such a certificate in the "cacerts" file), you can import the certificate reply and thereby replace your self-signed certificate with a certificate chain. This chain is the one returned by the CA in response to your request (if the CA reply is a chain), or one constructed (if the CA reply is a single certificate) using the certificate reply and trusted certificates that are already available in the keystore where you import the reply or in the "cacerts" keystore file.
>
> ——[Importing the Certificate Reply from the CA](https://www.ibm.com/support/knowledgecenter/en/SSYKE2_8.0.0/com.ibm.java.security.component.80.doc/security-component/keytoolDocs/ex_importcertreply.html)





# 参考资料

1. [Chain of trust - Wikipedia](https://en.wikipedia.org/wiki/Chain_of_trust)
2. [keytool - Java Platform, Standard Edition Tools Reference](https://docs.oracle.com/javase/8/docs/technotes/tools/unix/keytool.html)
3. [Difference between .keystore file and .jks file - Stack Overflow](https://stackoverflow.com/questions/8985685/difference-between-keystore-file-and-jks-file)
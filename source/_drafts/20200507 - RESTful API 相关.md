---
title: RESTful API 相关
mathjax: true
date: 2020-05-07 22:56:55
updated:
categories:
tags:
urlname: about-restful-api
---



<!-- more -->



个人理解，REST 的设计思想，是把 Web 应用的所有可操作的内容都当作资源。和 Web 应用交互的过程就是对 Web 服务器的资源进行状态转移的操作。

知乎上有个回答，很形象：

> 看Url就知道要什么
> 看http method就知道干什么
> 看http status code就知道结果如何





# 一些评价

## 正面

> 两者没有高下之分，无非是一种约定俗成的标准。习惯用RPC就用RPC，能理解REST就用REST。
>
> JSON-RPC比较符合直观，格式也相对宽松； 
>
> REST最近正流行，有自己的一套设计规范。 
>
> 
>
> REST面对的疑问跟当年刚开始流行面向对象时的情况是一样的。 
>
> 它适合很多情况，但并不适合所有情况。 
>
> 最差的结果就是盲目跟风，又对REST的概念和理念一知半解，最后搞出一个半吊子的怪胎，还自我标榜用了流行的RESTful API。 
>
> 
>
> REST是一种设计风格，它的很多思维方式与RPC是完全冲突的。 
>
> RPC的思想是把本地函数映射到API，也就是说一个API对应的是一个function，我本地有一个getAllUsers，远程也能通过某种约定的协议来调用这个getAllUsers。至于这个协议是Socket、是HTTP还是别的什么并不重要； 
>
> RPC中的主体都是动作，是个动词，表示我要做什么。 
>
> 而REST则不然，它的URL主体是资源，是个名词。而且也仅支持HTTP协议，规定了使用HTTP Method表达本次要做的动作，类型一般也不超过那四五种。这些动作表达了对资源仅有的几种转化方式。 
>
> 
>
> 这种设计思路是反程序员直觉的，因为在本地业务代码中仍然是一个个的函数，是动作，但表现在接口形式上则完全是资源的形式。 
>
> 就像面向对象的「万物皆对象」理论在习惯了纯粹面向过程开发的程序员眼里显得十分别扭一样：我的代码本来就是按顺序、循环、分支这么运行的啊，为啥非得在很明确的结构上封装一层一层的基类子类接口，还要故意给两个函数起同一个名字，调用时才选择用哪一个呢？ 
>
> 
>
> 使用「万物皆资源」的思想编写实际项目中的API接口时，最常见的问题就是「这玩意到底是个什么资源？………………算了，我就直接写吧，不管什么风格了」 
>
> - 比如，login和logout应该怎么REST化？ 
> - 比如，多条件复合搜索在GET里写不下怎么办？ 
> - 比如，大量资源的删除难道要写几千个DELETE？  
>
> 其实在理解了REST后，这些都不是什么无解的难题，只是思维方式要转换一下： 
>
> - login 和 logout 其实只是对 session 资源的创建和删除； 
> - search 本身就是个资源，使用POST创建，如果不需持久化，可以直接在Response中返回结果，如果需要（如翻页、长期缓存等），直接保存搜索结果并303跳转到资源地址就行了； 
> - id多到连url都写不下的请求，应该创建task，用GET返回task状态甚至执行进度； 
>
> ……等等等。 
>
> 
>
> 如果只是规定了一种规范，却不理解它表相下面的思维方式，实施中又按照自己的理解随意变动，那结果肯定是混乱不堪的。 
>
> 当然，API怎么写是开发者的自由。但如果一个API在url里放一堆动词、资源设计混乱、各种乱用HTTP Method和Status Code，还自称RESTful API的话，那就像你养了一条狗，还管它叫猫一样。 
>
> 这种混搭产物，不如叫它REFU吧。 
>
> （Remove Extension From Url：从url里去掉文件扩展名） 
>
> 
>
> 前面说了半天REST的理念和不懂REST造成的问题，但是，这并不代表REST比RPC更「高等」，更不是说不理解REST的人是落伍的。 
>
> 所谓代码风格、接口形式、各种林林总总的格式规定，其实都是为了在团队内部形成共识、防止个人习惯差异引起的混乱。JSON-RPC当然也是有规范的，但相比REST实在宽松太多了。 
>
> 如果一个开发团队规定必须在url里写action，所有请求都是POST，可以吗？当然也没问题，只是不要拿出去标榜自己写的是RESTful API就行。 
>
> 规范最终还是为了开发者和软件产品服务的，如果它能带来便利、减少混乱，就值得用；反之，如果带来的麻烦比解决的还多，那就犯不上纯粹跟风追流行了。
>
> 
>
> 作者：Vincross
> 链接：https://www.zhihu.com/question/28570307/answer/163638731
> 来源：知乎
> 著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。



## 负面







> 我厌恶restful API如同我厌恶OOP；但与其说我厌恶restful，倒不如说我厌恶鼓吹restful API的一些伪·程序员。
>
> 很多鼓吹restful API的程序员，实际上并不理解restful的设计理念，纯粹是在人言亦言，随便看了几篇网文在说restful，自己便也更着鼓吹。
>
> 做为一个合格的技术人员，最基础的要求是要对自己所使用的技术有了解，明白各种技术的适用场景，然后因地制宜。
>
> restful首先是要求必须把所有的应用定义成为“resource”，然后只能针对资源做有限的四种操作。
>
> 这是对API一个非常糟糕的抽象，有太多现实中需要的API，无法顺当的融入到restful所定义的规范中。
>
> 比方说，user login / resetpassword等等。
>
> restful的信徒，他们会说可以根据这个那个规范，把login / password等也纳入为某种资源，然后进行增删改查。这在我看来，纯粹是在解决一些原本不存在，根本不需要解决的问题，纯浪费。
>
> 所有的接口，服务器端原本就存在有相应的函数，它们本来就有自身的命名空间，接受的参数、返回值、异常等等。
>
> 采用轻便的方式暴露出来即可。
>
> 无需把一堆函数重新归纳到“资源”，再削减脑袋把所有的操作都映射为“增删改查”。
>
> 
>
> 作者：玩家翁伟
> 链接：https://www.zhihu.com/question/28570307/answer/47876255
> 来源：知乎
> 著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。







# 参考资料

1. [怎样用通俗的语言解释REST，以及RESTful？ - 知乎](https://www.zhihu.com/question/28557115)
2. [aisuhua/restful-api-design-references: RESTful API 设计参考文献列表，可帮助你更加彻底的了解REST风格的接口设计。](https://github.com/aisuhua/restful-api-design-references)
3. [api-guidelines/Guidelines.md at vNext · microsoft/api-guidelines](https://github.com/Microsoft/api-guidelines/blob/vNext/Guidelines.md#711-http-status-codes)
4. [数据库没有找到，restful的返回值statusCode应该是多少？ - 知乎](https://www.zhihu.com/question/310737821)
5. [api - Is HTTP 404 an appropriate response for a PUT operation where some linked resource is not found? - Stack Overflow](https://stackoverflow.com/questions/10727699/is-http-404-an-appropriate-response-for-a-put-operation-where-some-linked-resour)
6. [RESTful API 中的 Status code 是否要遵守规范 - 知乎](https://zhuanlan.zhihu.com/p/57367932)
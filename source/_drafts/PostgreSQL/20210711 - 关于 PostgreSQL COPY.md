---
title: 关于 PostgreSQL COPY
mathjax: true
date: 2021-07-11 02:28:40
updated:
categories:
tags:
urlname: about-postgresql-copy
---



<!-- more -->

官方文档：[PostgreSQL: Documentation: 13: COPY](https://www.postgresql.org/docs/13/sql-copy.html)



# 性能

> Use [COPY](https://www.postgresql.org/docs/9.4/sql-copy.html) to load all the rows in one command, instead of using a series of `INSERT` commands. The `COPY` command is optimized for loading large numbers of rows; it is less flexible than `INSERT`, but incurs significantly less overhead for large data loads. Since `COPY` is a single command, there is no need to disable autocommit if you use this method to populate a table.
>
> ——[PostgreSQL: Documentation: 9.4: Populating a Database](https://www.postgresql.org/docs/9.4/populate.html)





# 如何做 UPDATE？

`COPY FROM` 等同于 `INSERT`，不能做 `UPDATE`，如果要做 `UPDATE`，可以使用 `COPY FROM` 把数据写入一张临时表，然后通过临时表去 UPDATE 对应的目标表。



参考：

[python - How does COPY work and why is it so much faster than INSERT? - Stack Overflow](https://stackoverflow.com/questions/46715354/how-does-copy-work-and-why-is-it-so-much-faster-than-insert)



# 装载失败

> `COPY` stops operation at the first error. This should not lead to problems in the event of a `COPY TO`, but the target table will already have received earlier rows in a `COPY FROM`. These rows will not be visible or accessible, but they still occupy disk space. This might amount to a considerable amount of wasted disk space if the failure happened well into a large copy operation. You might wish to invoke `VACUUM` to recover the wasted space.

`COPY FROM` 在遇到第一个报错的时候就会停止装数，但是已经写入的数据，虽然不会生效，但是仍然会占据表空间，所以如果执行的是一个很大的 COPY FROM 操作，在中间出现问题的话，可能会浪费很多空间，可以通过 `VACUUM` 回收表空间。





# 参考资料


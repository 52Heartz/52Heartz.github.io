---
title: Google Guava Table 数据结构使用
mathjax: true
date: 2020-10-13 15:43:19
updated:
categories:
tags:
urlname: about-google-guava-table
---



<!-- more -->

[HashBasedTable (Guava: Google Core Libraries for Java 19.0 API)](https://guava.dev/releases/19.0/api/docs/com/google/common/collect/HashBasedTable.html)

官方 doc：

> ```
> Table<Vertex, Vertex, Double> weightedGraph = HashBasedTable.create();
> weightedGraph.put(v1, v2, 4);
> weightedGraph.put(v1, v3, 20);
> weightedGraph.put(v2, v3, 5);
> 
> weightedGraph.row(v1); // returns a Map mapping v2 to 4, v3 to 20
> weightedGraph.column(v3); // returns a Map mapping v1 to 20, v2 to 5
> ```
>
> Typically, when you are trying to index on more than one key at a time, you will wind up with something like `Map<FirstName, Map<LastName, Person>>`, which is ugly and awkward to use. Guava provides a new collection type, [`Table`](https://guava.dev/releases/snapshot/api/docs/com/google/common/collect/Table.html), which supports this use case for any "row" type and "column" type. `Table` supports a number of views to let you use the data from any angle, including
>
> - [`rowMap()`](https://guava.dev/releases/snapshot/api/docs/com/google/common/collect/Table.html#rowMap--), which views a `Table<R, C, V>` as a `Map<R, Map<C, V>>`. Similarly, [`rowKeySet()`](https://guava.dev/releases/snapshot/api/docs/com/google/common/collect/Table.html#rowKeySet--) returns a `Set<R>`.
> - [`row(r)`](https://guava.dev/releases/snapshot/api/docs/com/google/common/collect/Table.html#row-R-) returns a non-null `Map<C, V>`. Writes to the `Map` will write through to the underlying `Table`.
> - Analogous column methods are provided: [`columnMap()`](https://guava.dev/releases/snapshot/api/docs/com/google/common/collect/Table.html#columnMap--), [`columnKeySet()`](https://guava.dev/releases/snapshot/api/docs/com/google/common/collect/Table.html#columnKeySet--), and [`column(c)`](https://guava.dev/releases/snapshot/api/docs/com/google/common/collect/Table.html#column-C-). (Column-based access is somewhat less efficient than row-based access.)
> - [`cellSet()`](https://guava.dev/releases/snapshot/api/docs/com/google/common/collect/Table.html#cellSet--) returns a view of the `Table` as a set of [`Table.Cell`](https://guava.dev/releases/snapshot/api/docs/com/google/common/collect/Table.Cell.html). `Cell` is much like `Map.Entry`, but distinguishes the row and column keys.
>
> Several `Table` implementations are provided, including:
>
> - [`HashBasedTable`](https://guava.dev/releases/snapshot/api/docs/com/google/common/collect/HashBasedTable.html), which is essentially backed by a `HashMap<R, HashMap<C, V>>`.
> - [`TreeBasedTable`](https://guava.dev/releases/snapshot/api/docs/com/google/common/collect/TreeBasedTable.html), which is essentially backed by a `TreeMap<R, TreeMap<C, V>>`.
> - [`ImmutableTable`](https://guava.dev/releases/snapshot/api/docs/com/google/common/collect/ImmutableTable.html)
> - [`ArrayTable`](https://guava.dev/releases/snapshot/api/docs/com/google/common/collect/ArrayTable.html), which requires that the complete universe of rows and columns be specified at construction time, but is backed by a two-dimensional array to improve speed and memory efficiency when the table is dense. `ArrayTable` works somewhat differently from other implementations; consult the Javadoc for details.
>
> [NewCollectionTypesExplained · google/guava Wiki](https://github.com/google/guava/wiki/NewCollectionTypesExplained#table)



# 几种实现类的介绍

## HashBasedTable





# 用法







# 参考资料


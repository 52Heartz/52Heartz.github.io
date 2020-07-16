---
title: Java HashMap相关
date: 2019-02-25 10:29:33
updated:
categories: Java
tags:
mathjax: true
urlname: java-hash-map
---





# JDK 8 中的 HashMap 的 Javadoc 解读

> Hash table based implementation of the `Map` interface. This implementation provides all of the optional map operations, and permits `null` values and the `null` key. (The `HashMap` class is roughly equivalent to `Hashtable`, except that it is unsynchronized and permits nulls.) This class makes no guarantees as to the order of the map; in particular, it does not guarantee that the order will remain constant over time.

HashMap 是 Map 接口的一个实现类，基于哈希表实现。这个实现提供了所有可选的 map 操作，同时允许键和值为 null。（HashMap 和 HashTable 大致相同，只是 HashMap 不是同步的，而且允许键和值为 null。）这个类不能保证 map 中的元素和插入顺序一致，也不能保证元素间的顺序保持不变。

> This implementation provides constant-time performance for the basic operations (`get` and `put`), assuming the hash function disperses the elements properly among the buckets. Iteration over collection views requires time proportional to the "capacity" of the `HashMap` instance (the number of buckets) plus its size (the number of key-value mappings). Thus, it's very important not to set the initial capacity too high (or the load factor too low) if iteration performance is important.

这个实现对于 get 和 put 这种基本操作，可以保证常数级别性能表现，可以认为采用的哈希函数把元素均匀地分布到了所有的桶中。

> An instance of `HashMap` has two parameters that affect its performance: *initial capacity* and *load factor*. The *capacity* is the number of buckets in the hash table, and the initial capacity is simply the capacity at the time the hash table is created. The *load factor* is a measure of how full the hash table is allowed to get before its capacity is automatically increased. When the number of entries in the hash table exceeds the product of the load factor and the current capacity, the hash table is *rehashed* (that is, internal data structures are rebuilt) so that the hash table has approximately twice the number of buckets.



> As a general rule, the default load factor (.75) offers a good tradeoff between time and space costs. Higher values decrease the space overhead but increase the lookup cost (reflected in most of the operations of the `HashMap` class, including `get` and `put`). The expected number of entries in the map and its load factor should be taken into account when setting its initial capacity, so as to minimize the number of rehash operations. If the initial capacity is greater than the maximum number of entries divided by the load factor, no rehash operations will ever occur.



> If many mappings are to be stored in a `HashMap` instance, creating it with a sufficiently large capacity will allow the mappings to be stored more efficiently than letting it perform automatic rehashing as needed to grow the table. Note that using many keys with the same `hashCode()` is a sure way to slow down performance of any hash table. To ameliorate impact, when keys are [`Comparable`](https://docs.oracle.com/javase/8/docs/api/java/lang/Comparable.html), this class may use comparison order among keys to help break ties.



> **Note that this implementation is not synchronized.** If multiple threads access a hash map concurrently, and at least one of the threads modifies the map structurally, it *must* be synchronized externally. (A structural modification is any operation that adds or deletes one or more mappings; merely changing the value associated with a key that an instance already contains is not a structural modification.) This is typically accomplished by synchronizing on some object that naturally encapsulates the map. If no such object exists, the map should be "wrapped" using the [`Collections.synchronizedMap`](https://docs.oracle.com/javase/8/docs/api/java/util/Collections.html#synchronizedMap-java.util.Map-) method. This is best done at creation time, to prevent accidental unsynchronized access to the map:
>
> ```java
> Map m = Collections.synchronizedMap(new HashMap(...));
> ```



> The iterators returned by all of this class's "collection view methods" are *fail-fast*: if the map is structurally modified at any time after the iterator is created, in any way except through the iterator's own `remove` method, the iterator will throw a [`ConcurrentModificationException`](https://docs.oracle.com/javase/8/docs/api/java/util/ConcurrentModificationException.html). Thus, in the face of concurrent modification, the iterator fails quickly and cleanly, rather than risking arbitrary, non-deterministic behavior at an undetermined time in the future.
>
> Note that the fail-fast behavior of an iterator cannot be guaranteed as it is, generally speaking, impossible to make any hard guarantees in the presence of unsynchronized concurrent modification. Fail-fast iterators throw `ConcurrentModificationException` on a best-effort basis. Therefore, it would be wrong to write a program that depended on this exception for its correctness: *the fail-fast behavior of iterators should be used only to detect bugs.*



## Implementation notes

> This map usually acts as a binned (bucketed) hash table, but when bins get too large, they are transformed into bins of TreeNodes, each structured similarly to those in java.util.TreeMap. Most methods try to use normal bins, but relay to TreeNode methods when applicable (simply by checking instanceof a node).  Bins of TreeNodes may be traversed and used like any others, but additionally support faster lookup when overpopulated. However, since the vast majority of bins in normal use are not overpopulated, checking for existence of tree bins may be delayed in the course of table methods.



> Tree bins (i.e., bins whose elements are all TreeNodes) are ordered primarily by hashCode, but in the case of ties, if two elements are of the same "class C implements Comparable\<C\>", type then their compareTo method is used for ordering. (We conservatively check generic types via reflection to validate this -- see method comparableClassFor).  The added complexity of tree bins is worthwhile in providing worst-case O(log n) operations when keys either have distinct hashes or are orderable, Thus, performance degrades gracefully under accidental or malicious usages in which hashCode() methods return values that are poorly distributed, as well as those in which many keys share a hashCode, so long as they are also Comparable. (If neither of these apply, we may waste about a factor of two in time and space compared to taking no precautions. But the only known cases stem from poor user programming practices that are already so slow that this makes little difference.)



> Because TreeNodes are about twice the size of regular nodes, we use them only when bins contain enough nodes to warrant use (see TREEIFY_THRESHOLD). And when they become too small (due to removal or resizing) they are converted back to plain bins.  In usages with well-distributed user hashCodes, tree bins are rarely used.  Ideally, under random hashCodes, the frequency of nodes in bins follows a Poisson distribution (http://en.wikipedia.org/wiki/Poisson_distribution) with a parameter of about 0.5 on average for the default resizing threshold of 0.75, although with a large variance because of resizing granularity. Ignoring variance, the expected occurrences of list size k are (exp(-0.5) pow(0.5, k) / factorial(k)). The first values are:
>
> 0:    0.60653066
> 1:    0.30326533
> 2:    0.07581633
> 3:    0.01263606
> 4:    0.00157952
> 5:    0.00015795
> 6:    0.00001316
> 7:    0.00000094
> 8:    0.00000006
> more: less than 1 in ten million



> The root of a tree bin is normally its first node.  However, sometimes (currently only upon Iterator.remove), the root might be elsewhere, but can be recovered following parent links (method TreeNode.root()).



> All applicable internal methods accept a hash code as an argument (as normally supplied from a public method), allowing them to call each other without recomputing user hashCodes. Most internal methods also accept a "tab" argument, that is normally the current table, but may be a new or old one when resizing or converting.



> When bin lists are treeified, split, or untreeified, we keep them in the same relative access/traversal order (i.e., field Node.next) to better preserve locality, and to slightly simplify handling of splits and traversals that invoke iterator.remove. When using comparators on insertion, to keep a total ordering (or as close as is required here) across rebalancings, we compare classes and identityHashCodes as tie-breakers.



> The use and transitions among plain vs tree modes is complicated by the existence of subclass LinkedHashMap. See below for hook methods defined to be invoked upon insertion, removal and access that allow LinkedHashMap internals to otherwise remain independent of these mechanics. (This also requires that a map instance be passed to some utility methods that may create new nodes.)



> The concurrent-programming-like SSA-based coding style helps avoid aliasing errors amid all of the twisty pointer operations.



















# ConcurrentHashMap 的应用

## 接口限流，统计访问次数

ConcurrentHashMap 中每个单独的方法都是原子操作，但是如果我们使用 ConcurrentHashMap 的时候可能需要在外层再加一些逻辑的操作，那么这些操作有可能就不是原子操作，从而可能导致并发带来的不一致性。

所以有些时候，我们需要使用CAS（Compare And Swap）操作来保证整体操作的原子性。而 ConcurrentHashMap 的 `replace()` 和 `putIfAbsent()` 就是这样的操作。



测试代码

```java
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.CountDownLatch;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

public class CounterDemo1 {

    private final Map<String, Long> urlCounter = new ConcurrentHashMap<>();

    //接口调用次数+1
    public long increase(String url) {
        Long oldValue = urlCounter.get(url);
        Long newValue = (oldValue == null) ? 1L : oldValue + 1;
        urlCounter.put(url, newValue);
        return newValue;
    }

    public long increase2(String url) {
        Long oldValue, newValue;
        while (true) {
            oldValue = urlCounter.get(url);
            if (oldValue == null) {
                newValue = 1L;
                //初始化成功，退出循环
                if (urlCounter.putIfAbsent(url, 1L) == null) {
                    break;
                }else{
                    System.out.println("初始化失败");
                }
                //如果初始化失败，说明其他线程已经初始化过了
            } else {
                newValue = oldValue + 1;
                //+1成功，退出循环
                if (urlCounter.replace(url, oldValue, newValue)) {
                    break;
                }else {
                    System.out.println("+1失败");
                }
                //如果+1失败，说明其他线程已经修改过了旧值
            }
        }
        return newValue;
    }

    //获取调用次数
    public Long getCount(String url){
        return urlCounter.get(url);
    }

    public static void main(String[] args) {
        ExecutorService executor = Executors.newFixedThreadPool(10);
        final CounterDemo1 counterDemo = new CounterDemo1();
        int callTime = 100000;
        final String url = "http://localhost:8080/hello";
        CountDownLatch countDownLatch = new CountDownLatch(callTime);
        //模拟并发情况下的接口调用统计
        for(int i=0;i<callTime;i++){
            executor.execute(new Runnable() {
                @Override
                public void run() {
                    counterDemo.increase2(url);
                    countDownLatch.countDown();
                }
            });
        }
        try {
            countDownLatch.await();
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        executor.shutdown();
        //等待所有线程统计完成后输出调用次数
        System.out.println("调用次数："+counterDemo.getCount(url));
    }
}

//TODO 还可以采用 atomicLong 类来实现
```

参考：[Java 并发实践 — ConcurrentHashMap 与 CAS](http://www.importnew.com/26035.html)



# 常见坑点

## 遍历时不能 put

使用迭代器遍历的时候如果调用 put 会导致 ConcurrentModificationException。

[iterator - Java HashMap add new entry while iterating - Stack Overflow](https://stackoverflow.com/questions/27753184/java-hashmap-add-new-entry-while-iterating)

[HashMap中ConcurrentModificationException异常解读 - yehx - 博客园](https://www.cnblogs.com/handsomeye/p/9138908.html)



# 常见关联问题

1. 为什么重写 `equals()` 就必须要重写 `hashCode()`?

我们来看一下 `Object` 类的 `equals()` 方法和 `hashCode()` 方法的 Javadoc：

> equals()：
>
> Indicates whether some other object is "equal to" this one.
>
> The `equals` method implements an equivalence relation on non-null object references:
>
> - It is *reflexive*: for any non-null reference value `x`, `x.equals(x)` should return `true`.
> - It is *symmetric*: for any non-null reference values `x` and `y`, `x.equals(y)` should return `true` if and only if `y.equals(x)` returns `true`.
> - It is *transitive*: for any non-null reference values `x`, `y`, and `z`, if `x.equals(y)` returns `true` and `y.equals(z)` returns `true`, then `x.equals(z)` should return `true`.
> - It is *consistent*: for any non-null reference values `x` and `y`, multiple invocations of `x.equals(y)` consistently return `true` or consistently return `false`, provided no information used in `equals` comparisons on the objects is modified.
> - For any non-null reference value `x`, `x.equals(null)` should return `false`.
>
> The `equals` method for class `Object` implements the most discriminating possible equivalence relation on objects; that is, for any non-null reference values `x` and `y`, this method returns `true` if and only if `x` and `y` refer to the same object (`x == y` has the value `true`).
>
> Note that it is generally necessary to override the `hashCode` method whenever this method is overridden, so as to maintain the general contract for the `hashCode` method, which states that equal objects must have equal hash codes.





> hashCode()：
>
> Returns a hash code value for the object. This method is supported for the benefit of hash tables such as those provided by [`HashMap`](https://docs.oracle.com/javase/8/docs/api/java/util/HashMap.html).
>
> The general contract of `hashCode` is:
>
> - Whenever it is invoked on the same object more than once during an execution of a Java application, the `hashCode` method must consistently return the same integer, provided no information used in `equals` comparisons on the object is modified. This integer need not remain consistent from one execution of an application to another execution of the same application.
> - If two objects are equal according to the `equals(Object)` method, then calling the `hashCode` method on each of the two objects must produce the same integer result.
> - It is *not* required that if two objects are unequal according to the [`equals(java.lang.Object)`](https://docs.oracle.com/javase/8/docs/api/java/lang/Object.html#equals-java.lang.Object-) method, then calling the `hashCode` method on each of the two objects must produce distinct integer results. However, the programmer should be aware that producing distinct integer results for unequal objects may improve the performance of hash tables.
>
> As much as is reasonably practical, the hashCode method defined by class `Object` does return distinct integers for distinct objects. (This is typically implemented by converting the internal address of the object into an integer, but this implementation technique is not required by the Java™ programming language.)









# ConcurrentHashMap



## ConcurrentHashMap Javadoc 研读

Javadoc：[ConcurrentHashMap (Java Platform SE 8 )](https://docs.oracle.com/javase/8/docs/api/java/util/concurrent/ConcurrentHashMap.html)

> A hash table supporting full concurrency of retrievals and high expected concurrency for updates. This class obeys the same functional specification as [`Hashtable`](https://docs.oracle.com/javase/8/docs/api/java/util/Hashtable.html), and includes versions of methods corresponding to each method of `Hashtable`. However, even though all operations are thread-safe, retrieval operations do *not* entail locking, and there is *not* any support for locking the entire table in a way that prevents all access. This class is fully interoperable with `Hashtable` in programs that rely on its thread safety but not on its synchronization details.
>
> Retrieval operations (including `get`) generally do not block, so may overlap with update operations (including `put` and `remove`). Retrievals reflect the results of the most recently *completed* update operations holding upon their onset. (More formally, an update operation for a given key bears a *happens-before* relation with any (non-null) retrieval for that key reporting the updated value.) For aggregate operations such as `putAll` and `clear`, concurrent retrievals may reflect insertion or removal of only some entries. Similarly, Iterators, Spliterators and Enumerations return elements reflecting the state of the hash table at some point at or since the creation of the iterator/enumeration. They do *not* throw [`ConcurrentModificationException`](https://docs.oracle.com/javase/8/docs/api/java/util/ConcurrentModificationException.html). However, iterators are designed to be used by only one thread at a time. Bear in mind that the results of aggregate status methods including `size`, `isEmpty`, and `containsValue` are typically useful only when a map is not undergoing concurrent updates in other threads. Otherwise the results of these methods reflect transient states that may be adequate for monitoring or estimation purposes, but not for program control.
>
> The table is dynamically expanded when there are too many collisions (i.e., keys that have distinct hash codes but fall into the same slot modulo the table size), with the expected average effect of maintaining roughly two bins per mapping (corresponding to a 0.75 load factor threshold for resizing). There may be much variance around this average as mappings are added and removed, but overall, this maintains a commonly accepted time/space tradeoff for hash tables. However, resizing this or any other kind of hash table may be a relatively slow operation. When possible, it is a good idea to provide a size estimate as an optional `initialCapacity` constructor argument. An additional optional `loadFactor` constructor argument provides a further means of customizing initial table capacity by specifying the table density to be used in calculating the amount of space to allocate for the given number of elements. Also, for compatibility with previous versions of this class, constructors may optionally specify an expected `concurrencyLevel` as an additional hint for internal sizing. Note that using many keys with exactly the same `hashCode()` is a sure way to slow down performance of any hash table. To ameliorate impact, when keys are [`Comparable`](https://docs.oracle.com/javase/8/docs/api/java/lang/Comparable.html), this class may use comparison order among keys to help break ties.
>
> A [`Set`](https://docs.oracle.com/javase/8/docs/api/java/util/Set.html) projection of a ConcurrentHashMap may be created (using [`newKeySet()`](https://docs.oracle.com/javase/8/docs/api/java/util/concurrent/ConcurrentHashMap.html#newKeySet--) or [`newKeySet(int)`](https://docs.oracle.com/javase/8/docs/api/java/util/concurrent/ConcurrentHashMap.html#newKeySet-int-)), or viewed (using [`keySet(Object)`](https://docs.oracle.com/javase/8/docs/api/java/util/concurrent/ConcurrentHashMap.html#keySet-V-) when only keys are of interest, and the mapped values are (perhaps transiently) not used or all take the same mapping value.
>
> A ConcurrentHashMap can be used as scalable frequency map (a form of histogram or multiset) by using [`LongAdder`](https://docs.oracle.com/javase/8/docs/api/java/util/concurrent/atomic/LongAdder.html) values and initializing via [`computeIfAbsent`](https://docs.oracle.com/javase/8/docs/api/java/util/concurrent/ConcurrentHashMap.html#computeIfAbsent-K-java.util.function.Function-). For example, to add a count to a `ConcurrentHashMap<String,LongAdder> freqs`, you can use `freqs.computeIfAbsent(k -> new LongAdder()).increment();`
>
> This class and its views and iterators implement all of the *optional* methods of the [`Map`](https://docs.oracle.com/javase/8/docs/api/java/util/Map.html) and [`Iterator`](https://docs.oracle.com/javase/8/docs/api/java/util/Iterator.html) interfaces.
>
> Like [`Hashtable`](https://docs.oracle.com/javase/8/docs/api/java/util/Hashtable.html) but unlike [`HashMap`](https://docs.oracle.com/javase/8/docs/api/java/util/HashMap.html), this class does *not* allow `null` to be used as a key or value.
>
> ConcurrentHashMaps support a set of sequential and parallel bulk operations that, unlike most [`Stream`](https://docs.oracle.com/javase/8/docs/api/java/util/stream/Stream.html) methods, are designed to be safely, and often sensibly, applied even with maps that are being concurrently updated by other threads; for example, when computing a snapshot summary of the values in a shared registry. There are three kinds of operation, each with four forms, accepting functions with Keys, Values, Entries, and (Key, Value) arguments and/or return values. Because the elements of a ConcurrentHashMap are not ordered in any particular way, and may be processed in different orders in different parallel executions, the correctness of supplied functions should not depend on any ordering, or on any other objects or values that may transiently change while computation is in progress; and except for forEach actions, should ideally be side-effect-free. Bulk operations on [`Map.Entry`](https://docs.oracle.com/javase/8/docs/api/java/util/Map.Entry.html) objects do not support method `setValue`.
>
> - forEach: Perform a given action on each element. A variant form applies a given transformation on each element before performing the action.
> - search: Return the first available non-null result of applying a given function on each element; skipping further search when a result is found.
> - reduce: Accumulate each element. The supplied reduction function cannot rely on ordering (more formally, it should be both associative and commutative). There are five variants:
>   - Plain reductions. (There is not a form of this method for (key, value) function arguments since there is no corresponding return type.)
>   - Mapped reductions that accumulate the results of a given function applied to each element.
>   - Reductions to scalar doubles, longs, and ints, using a given basis value.
>
> These bulk operations accept a `parallelismThreshold` argument. Methods proceed sequentially if the current map size is estimated to be less than the given threshold. Using a value of `Long.MAX_VALUE` suppresses all parallelism. Using a value of `1` results in maximal parallelism by partitioning into enough subtasks to fully utilize the [`ForkJoinPool.commonPool()`](https://docs.oracle.com/javase/8/docs/api/java/util/concurrent/ForkJoinPool.html#commonPool--) that is used for all parallel computations. Normally, you would initially choose one of these extreme values, and then measure performance of using in-between values that trade off overhead versus throughput.
>
> The concurrency properties of bulk operations follow from those of ConcurrentHashMap: Any non-null result returned from `get(key)` and related access methods bears a happens-before relation with the associated insertion or update. The result of any bulk operation reflects the composition of these per-element relations (but is not necessarily atomic with respect to the map as a whole unless it is somehow known to be quiescent). Conversely, because keys and values in the map are never null, null serves as a reliable atomic indicator of the current lack of any result. To maintain this property, null serves as an implicit basis for all non-scalar reduction operations. For the double, long, and int versions, the basis should be one that, when combined with any other value, returns that other value (more formally, it should be the identity element for the reduction). Most common reductions have these properties; for example, computing a sum with basis 0 or a minimum with basis MAX_VALUE.
>
> Search and transformation functions provided as arguments should similarly return null to indicate the lack of any result (in which case it is not used). In the case of mapped reductions, this also enables transformations to serve as filters, returning null (or, in the case of primitive specializations, the identity basis) if the element should not be combined. You can create compound transformations and filterings by composing them yourself under this "null means there is nothing there now" rule before using them in search or reduce operations.
>
> Methods accepting and/or returning Entry arguments maintain key-value associations. They may be useful for example when finding the key for the greatest value. Note that "plain" Entry arguments can be supplied using `new AbstractMap.SimpleEntry(k,v)`.
>
> Bulk operations may complete abruptly, throwing an exception encountered in the application of a supplied function. Bear in mind when handling such exceptions that other concurrently executing functions could also have thrown exceptions, or would have done so if the first exception had not occurred.
>
> Speedups for parallel compared to sequential forms are common but not guaranteed. Parallel operations involving brief functions on small maps may execute more slowly than sequential forms if the underlying work to parallelize the computation is more expensive than the computation itself. Similarly, parallelization may not lead to much actual parallelism if all processors are busy performing unrelated tasks.
>
> All arguments to all task methods must be non-null.
>
> This class is a member of the [Java Collections Framework](https://docs.oracle.com/javase/8/docs/technotes/guides/collections/index.html).









### 翻译

> A hash table supporting full concurrency of retrievals and high expected concurrency for updates. This class obeys the same functional specification as [`Hashtable`](https://docs.oracle.com/javase/8/docs/api/java/util/Hashtable.html), and includes versions of methods corresponding to each method of `Hashtable`. However, even though all operations are thread-safe, retrieval operations do *not* entail locking, and there is *not* any support for locking the entire table in a way that prevents all access. This class is fully interoperable with `Hashtable` in programs that rely on its thread safety but not on its synchronization details.

。。。但是，虽然所有的操作都是线程安全的，但是读操作都没有加锁，而且不支持整个表进行加锁，因此无法做到对整张表加锁从而禁止一切访问操作。



> Retrieval operations (including `get`) generally do not block, so may overlap with update operations (including `put` and `remove`). Retrievals reflect the results of the most recently *completed* update operations holding upon their onset. (More formally, an update operation for a given key bears a *happens-before* relation with any (non-null) retrieval for that key reporting the updated value.) For aggregate operations such as `putAll` and `clear`, concurrent retrievals may reflect insertion or removal of only some entries. Similarly, Iterators, Spliterators and Enumerations return elements reflecting the state of the hash table at some point at or since the creation of the iterator/enumeration. They do *not* throw [`ConcurrentModificationException`](https://docs.oracle.com/javase/8/docs/api/java/util/ConcurrentModificationException.html). However, iterators are designed to be used by only one thread at a time. Bear in mind that the results of aggregate status methods including `size`, `isEmpty`, and `containsValue` are typically useful only when a map is not undergoing concurrent updates in other threads. Otherwise the results of these methods reflect transient states that may be adequate for monitoring or estimation purposes, but not for program control.

读操作（包括 `get`）通常不会阻塞，所以可能会和更新操作（报错 `put` 和 `remove`）同时发生。读操作获取到的是对应数据最近的一次更新后的数据。







# 参考资料

## HashMap相关

1. [HashMap Javadoc (Java Platform SE 8 )](https://docs.oracle.com/javase/8/docs/api/java/util/HashMap.html)
2. [Hashtable Javadoc  (Java Platform SE 8 )](https://docs.oracle.com/javase/8/docs/api/java/util/Hashtable.html)
3. [Java HashMap工作原理及实现  - Yikun的博客](https://yikun.github.io/2015/04/01/Java-HashMap%E5%B7%A5%E4%BD%9C%E5%8E%9F%E7%90%86%E5%8F%8A%E5%AE%9E%E7%8E%B0/)
4. [HashMap完全解读 -Hollis](https://www.hollischuang.com/archives/82)
5. [有关 HashMap 面试会问的一切](https://mp.weixin.qq.com/s/Zjh17yXJ692_uzcKYSbQ_g)
6. [天下无难试之HashMap面试刁难大全](https://zhuanlan.zhihu.com/p/32355676)
7. [HashMap? ConcurrentHashMap? 相信看完这篇没人能难住你！ - crossoverJie的博客](https://crossoverjie.top/2018/07/23/java-senior/ConcurrentHashMap/)
8. [【java集合】HashMap常见面试题 - CSDN博客](https://blog.csdn.net/u012512634/article/details/72735183)
9. [HashMap 相关面试题及其解答](https://www.jianshu.com/p/75adf47958a7)
10. [HashMap面试题：90%的人回答不上来](https://www.jianshu.com/p/7af5bb1b57e2)
11. [HashMap的实现原理+阿里HasMap面试题 - CSDN博客](https://blog.csdn.net/lizhen1114/article/details/79001257)
12. [JDK7与JDK8中HashMap的实现 - 开源中国](https://my.oschina.net/hosee/blog/618953)
13. [全网把Map中的hash()分析的最透彻的文章，别无二家 - Hollis的博客](https://www.hollischuang.com/archives/2091)【确实写的很好！】
14. [红黑树 - 开源中国](https://my.oschina.net/hosee/blog/618828)
15. [谈谈HashMap线程不安全的体现 - ImportNew](http://www.importnew.com/22011.html)
16. [HashMap的loadFactor为什么是0.75？](https://www.jianshu.com/p/64f6de3ffcc1)【分析的很深入了，还分析了数学原理】
17. [HashMap初始容量与负载因子设置如何影响HashMap性能](https://blog.csdn.net/woaiwym/article/details/80622804)
18. [Java 8系列之重新认识HashMap - 美团技术团队](https://tech.meituan.com/2016/06/24/java-hashmap.html)
19. [【不做标题党，只做纯干货】HashMap在Jdk1.7和1.8中的实现](http://www.yuanrengu.com/index.php/20181106.html)
20. [老生常谈，HashMap的死循环 - 占小狼的简书](https://www.jianshu.com/p/1e9cf0ac07f4)
21. [HashMap的实现与优化](http://www.importnew.com/21294.html)



## ConcurrentHashMap相关

1. [ConcurrentHashMap (Java Platform SE 8 )](https://docs.oracle.com/javase/8/docs/api/java/util/concurrent/ConcurrentHashMap.html)
2. [ConcurrentHashMap原理分析 - ImportNew](http://www.importnew.com/16142.html)
3. [面试题： HashMap与ConcurrentHashMap - 开源中国](https://my.oschina.net/keyven/blog/1831704)
4. [关于Java面试，你应该准备这些知识点](https://www.jianshu.com/p/1b2f63a45476)
5. [HashMap、HashTable、ConcurrentHashMap的原理与区别](http://www.yuanrengu.com/index.php/2017-01-17.html)
6. [十大Java ConcurrentHashMap面试问题与解 - CSDN](https://blog.csdn.net/qq_41790443/article/details/79727915)
7. [Java数据结构笔试面试知识集合之ConcurrentHashMap](https://zhuanlan.zhihu.com/p/35853397)
8. [这几道Java集合框架面试题在面试中几乎必问](https://segmentfault.com/a/1190000016127895)


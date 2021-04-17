---
title: Kafka Connect 源码研读
mathjax: true
date: 2020-12-06 17:44:32
updated:
categories:
tags:
urlname: kafka-connect-source-code-learning
---



<!-- more -->



Kafka Connect 的源代码是和 Kafka 主题的源代码放在一起的。

Kafka 源代码地址：[apache/kafka: Mirror of Apache Kafka](https://github.com/apache/kafka)



# 整体把握



一个 Worker 中有一个线程池。

一个 Worker 中运行若干个 WorkerSinkTask。是通过线程池执行的。

停止任务的时候，是把 WorkerSinkTask 的 `stopping` 字段设置为 `true`，WorkerSinkTask 中判断 `stopping` 为 false 之后，跳出循环，Runnable 就执行结束了。

```java
// connect/runtime/src/main/java/org/apache/kafka/connect/runtime/WorkerSinkTask.java
// 启动任务就是在这里启动的
// 启动任务之后，也是在当前线程中执行一次又一次地从 Kafka 取数据然后进行处理的操作
// 在 iteration() 方法中会对从 Kafka 取到的数据进行处理，然后调用 SinkTask 的 put 方法
@Override
public void execute() {
    initializeAndStart();
    // Make sure any uncommitted data has been committed and the task has
    // a chance to clean up its state
    try (UncheckedCloseable suppressible = this::closePartitions) {
        while (!isStopping())
            iteration();
    }
}
```



Kafka Connector 中，开发者编写的都是 SinkTask，Kafka Connect 框架中使用一个 `WorkerSinkTask` 把 SinkTask 包裹起来，`WorkerSinkTask` 中持有一个 Kafka Consumer。在 WorkerSinkTask 中执行 poll() 获取数据并交给 SinkTask 处理。



# Worker



```java
// connect/runtime/src/main/java/org/apache/kafka/connect/runtime/Worker.java
public Worker(
    String workerId,
    Time time,
    Plugins plugins,
    WorkerConfig config,
    OffsetBackingStore offsetBackingStore,
    ConnectorClientConfigOverridePolicy connectorClientConfigOverridePolicy) {
    // Peng: 看这个 Executors.newCachedThreadPool()
    this(workerId, time, plugins, config, offsetBackingStore, Executors.newCachedThreadPool(), connectorClientConfigOverridePolicy);
}
```



`Executors.newCachedThreadPool()`，Worker 使用 `Executors.newCachedThreadPool()` 作为线程池来运行 SinkTask。

关于 `Executors.newCachedThreadPool()`：

> 它是一个可以无限扩大的线程池；
>
> 它比较适合处理执行时间比较小的任务；
>
> corePoolSize为0，maximumPoolSize为无限大，意味着线程数量可以无限大；
>
> keepAliveTime为60S，意味着线程空闲时间超过60S就会被杀死；
>
> 采用SynchronousQueue装等待的任务，这个阻塞队列没有存储空间，这意味着只要有请求到来，就必须要找到一条工作线程处理他，如果当前没有空闲的线程，那么就会再创建一条新的线程。
>
> 
>
> 作者：大闲人柴毛毛
> 链接：https://www.zhihu.com/question/23212914/answer/245992718
> 来源：知乎
> 著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。



# SinkTask

## 消费数据



```java
// connect/runtime/src/main/java/org/apache/kafka/connect/runtime/WorkerSinkTask.java
private void deliverMessages() {
    // Finally, deliver this batch to the sink
    try {
        // Since we reuse the messageBatch buffer, ensure we give the task its own copy
        log.trace("{} Delivering batch of {} messages to task", this, messageBatch.size());
        long start = time.milliseconds();
        
        // Peng: 这里就是向 SinkTask 发送数据的部分。
        task.put(new ArrayList<>(messageBatch));
        // if errors raised from the operator were swallowed by the task implementation, an
        // exception needs to be thrown to kill the task indicating the tolerance was exceeded
        if (retryWithToleranceOperator.failed() && !retryWithToleranceOperator.withinToleranceLimits()) {
            throw new ConnectException("Tolerance exceeded in error handler",
                                       retryWithToleranceOperator.error());
        }
        recordBatch(messageBatch.size());
        sinkTaskMetricsGroup.recordPut(time.milliseconds() - start);
        currentOffsets.putAll(origOffsets);
        messageBatch.clear();
        // If we had paused all consumer topic partitions to try to redeliver data, then we should resume any that
        // the task had not explicitly paused
        if (pausedForRedelivery) {
            if (!shouldPause())
                resumeAll();
            pausedForRedelivery = false;
        }
    } catch (RetriableException e) {
        log.error("{} RetriableException from SinkTask:", this, e);
        // If we're retrying a previous batch, make sure we've paused all topic partitions so we don't get new data,
        // but will still be able to poll in order to handle user-requested timeouts, keep group membership, etc.
        pausedForRedelivery = true;
        pauseAll();
        // Let this exit normally, the batch will be reprocessed on the next loop.
    } catch (Throwable t) {
        log.error("{} Task threw an uncaught and unrecoverable exception. Task is being killed and will not "
                  + "recover until manually restarted. Error: {}", this, t.getMessage(), t);
        throw new ConnectException("Exiting WorkerSinkTask due to unrecoverable exception.", t);
    }
}
```





# 参考资料

1. [java newCachedThreadPool 线程池使用在什么情况下? - 知乎](https://www.zhihu.com/question/23212914)


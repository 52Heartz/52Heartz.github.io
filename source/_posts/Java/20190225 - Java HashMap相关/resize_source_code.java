// 进入这个方法的前提代表size已经大于threshold了。

final Node<K,V>[] resize() {
    Node<K,V>[] oldTab = table;
    int oldCap = (oldTab == null) ? 0 : oldTab.length;
    int oldThr = threshold;
    int newCap, newThr = 0;
    if (oldCap > 0) { //oldCap大于0，说明table长度不是0，不是第一次resize()
        if (oldCap >= MAXIMUM_CAPACITY) { //oldCap存的是table长度，大于等于最大capacity，不再扩容
            threshold = Integer.MAX_VALUE;// 把threshold设置为整形的最大值，这样之后就不会再进入resize()方法了
            return oldTab;
        }
        else if ((newCap = oldCap << 1) < MAXIMUM_CAPACITY && //扩容之后仍小于最大capacity限制
                    oldCap >= DEFAULT_INITIAL_CAPACITY)
            newThr = oldThr << 1; // double threshold
    }
    else if (oldThr > 0) // initial capacity was placed in threshold 这里只针对显式初始化了initial capacity的情形，此时
                            // oldCap等于零，说明oldTab为null。oldThr存的是初始化的threshold，也就是initial capacity
        newCap = oldThr; // 这里就相当于把newCap赋值为initial capacity了
    else {               // zero initial threshold signifies using defaults，这里只针对显示初始化了threshold，但是赋值为0，同样使用默认情形
        newCap = DEFAULT_INITIAL_CAPACITY;
        newThr = (int)(DEFAULT_LOAD_FACTOR * DEFAULT_INITIAL_CAPACITY);
    }
    if (newThr == 0) { //前几次resize()和最后一次resize()
        float ft = (float)newCap * loadFactor;
        newThr = (newCap < MAXIMUM_CAPACITY && ft < (float)MAXIMUM_CAPACITY ?
                    (int)ft : Integer.MAX_VALUE);
    }
    threshold = newThr;
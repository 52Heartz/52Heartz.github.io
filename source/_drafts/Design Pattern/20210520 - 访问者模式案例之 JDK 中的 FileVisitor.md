---
title: 访问者模式案例之 JDK 中的 FileVisitor
mathjax: true
date: 2021-05-20 16:42:02
updated:
categories:
tags:
urlname: visitor-pattern-example-jdk-file-visitor
---



<!-- more -->

我们先来看一下 FileVisitor 类的注释：

> A visitor of files. An implementation of this interface is provided to the Files.walkFileTree methods to visit each file in a file tree.
> Usage Examples: Suppose we want to delete a file tree. In that case, each directory should be deleted after the entries in the directory are deleted.
>
> ```java
> Path start = ...;
> Files.walkFileTree(start, new SimpleFileVisitor<Path>() {
>     @Override
>     public FileVisitResult visitFile(Path file, BasicFileAttributes attrs) throws IOException {
>         Files.delete(file);
>         return FileVisitResult.CONTINUE;
>     }
>     
>     @Override
>     public FileVisitResult postVisitDirectory(Path dir, IOException e) throws IOException {
>         if (e == null) {
>             Files.delete(dir);
>             return FileVisitResult.CONTINUE;
>         } else {
>             // directory iteration failed
>             throw e;
>         }
>     }
> });
> ```
>
> Furthermore, suppose we want to copy a file tree to a target location. In that case, symbolic links should be followed and the target directory should be created before the entries in the directory are copied.
>
> ```java
> final Path source = ...;
> final Path target = ...;
> 
> Files.walkFileTree(source, EnumSet.of(FileVisitOption.FOLLOW_LINKS), Integer.MAX_VALUE,
>                    new SimpleFileVisitor<Path>() {
>                        @Override
>                        public FileVisitResult preVisitDirectory(Path dir, BasicFileAttributes attrs)
>                            throws IOException
>                        {
>                            Path targetdir = target.resolve(source.relativize(dir));
>                            try {
>                                Files.copy(dir, targetdir);
>                            } catch (FileAlreadyExistsException e) {
>                                if (!Files.isDirectory(targetdir))
>                                    throw e;
>                            }
>                            return CONTINUE;
>                        }
> 
>                        @Override
>                        public FileVisitResult visitFile(Path file, BasicFileAttributes attrs)
>                            throws IOException
>                        {
>                            Files.copy(file, target.resolve(source.relativize(file)));
>                            return CONTINUE;
>                        }
>                    });
> ```



通过定义的 Visitor，如果你想通过不同的方式遍历目录，只需要定义自己的 FileVisitor 实现类即可。

```java
public static Path walkFileTree(Path start,
                                Set<FileVisitOption> options,
                                int maxDepth,
                                FileVisitor<? super Path> visitor)
    throws IOException
{
    /**
         * Create a FileTreeWalker to walk the file tree, invoking the visitor
         * for each event.
         */
    try (FileTreeWalker walker = new FileTreeWalker(options, maxDepth)) {
        FileTreeWalker.Event ev = walker.walk(start);
        do {
            FileVisitResult result;
            switch (ev.type()) {
                case ENTRY :
                    IOException ioe = ev.ioeException();
                    if (ioe == null) {
                        assert ev.attributes() != null;
                        result = visitor.visitFile(ev.file(), ev.attributes());
                    } else {
                        result = visitor.visitFileFailed(ev.file(), ioe);
                    }
                    break;

                case START_DIRECTORY :
                    result = visitor.preVisitDirectory(ev.file(), ev.attributes());

                    // if SKIP_SIBLINGS and SKIP_SUBTREE is returned then
                    // there shouldn't be any more events for the current
                    // directory.
                    if (result == FileVisitResult.SKIP_SUBTREE ||
                        result == FileVisitResult.SKIP_SIBLINGS)
                        walker.pop();
                    break;

                case END_DIRECTORY :
                    result = visitor.postVisitDirectory(ev.file(), ev.ioeException());

                    // SKIP_SIBLINGS is a no-op for postVisitDirectory
                    if (result == FileVisitResult.SKIP_SIBLINGS)
                        result = FileVisitResult.CONTINUE;
                    break;

                default :
                    throw new AssertionError("Should not get here");
            }

            if (Objects.requireNonNull(result) != FileVisitResult.CONTINUE) {
                if (result == FileVisitResult.TERMINATE) {
                    break;
                } else if (result == FileVisitResult.SKIP_SIBLINGS) {
                    walker.skipRemainingSiblings();
                }
            }
            ev = walker.next();
        } while (ev != null);
    }

    return start;
}
```











# 参考资料




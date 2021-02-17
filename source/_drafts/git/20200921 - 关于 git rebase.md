---
title: 关于 git rebase
mathjax: true
date: 2020-09-21 11:24:09
updated:
categories:
tags:
urlname: about-git-rebase
---



<!-- more -->



rebase 之后，在没有冲突的情况下，commit 的 id 会变化，但是 Author 和 Date 已经 change set 都不变。



## 关于 --skip

[git的突出解决--git rebase之abort、continue、skip - 有爱jj - 博客园](https://www.cnblogs.com/chenjunjie12321/p/6876220.html)

[Git rebase skip误操作后，找回提交的commit(误删未push本地分支同理)](https://juejin.im/post/6844903891788627976)



# 其他

1. [化解冲突：git merge 与 git rebase 中的 ours 和 theirs | Ming's Blog](https://bitmingw.com/2017/02/16/git-merge-rebase-ours-and-theirs/)



## rebase 后 push 失败

```
$ git push self feature/pipeline-task
To ssh://code.fineres.com:7999/~peng/fine-tube.git
 ! [rejected]        feature/pipeline-task -> feature/pipeline-task (non-fast-forward)
error: failed to push some refs to 'ssh://code.fineres.com:7999/~peng/fine-tube.git'
hint: Updates were rejected because the tip of your current branch is behind
hint: its remote counterpart. Integrate the remote changes (e.g.
hint: 'git pull ...') before pushing again.
hint: See the 'Note about fast-forwards' in 'git push --help' for details.
```

> The `-f` **is** actually required because of the rebase. Whenever you do a rebase you would need to do a force push because the remote branch cannot be fast-forwarded to your commit. You'd **always** want to make sure that you do a pull before pushing, but if you don't like to force push to master or dev for that matter, you can create a new branch to push to and then merge or make a PR.
>
> [git - Updates were rejected because the tip of your current branch is behind its remote counterpart - Stack Overflow](https://stackoverflow.com/questions/39399804/updates-were-rejected-because-the-tip-of-your-current-branch-is-behind-its-remot)

貌似 rebase 之后必须 -f 上传才可以。

```
git push -u -f self
```











# 参考资料

1. [Git - Rebasing](https://git-scm.com/book/en/v2/Git-Branching-Rebasing)
---
title: 关于 SQL Server MERGE
mathjax: true
date: 2021-07-12 20:01:39
updated:
categories:
tags:
urlname: about-sql-merge
---



<!-- more -->



# 示例

## 完全基于 SQL 语句做插入更新

[MERGE (Transact-SQL) - SQL Server | Microsoft Docs](https://docs.microsoft.com/en-us/sql/t-sql/statements/merge-transact-sql?view=sql-server-ver15#c-using-merge-to-do-update-and-insert-operations-on-a-target-table-by-using-a-derived-source-table)

```sql
-- Create a temporary table variable to hold the output actions.
DECLARE @SummaryOfChanges TABLE(Change VARCHAR(20));

MERGE INTO Sales.SalesReason AS tgt
USING (VALUES ('Recommendation','Other'), ('Review', 'Marketing'),
              ('Internet', 'Promotion'))
       as src (NewName, NewReasonType)
ON tgt.Name = src.NewName
WHEN MATCHED THEN
UPDATE SET ReasonType = src.NewReasonType
WHEN NOT MATCHED BY TARGET THEN
INSERT (Name, ReasonType) VALUES (NewName, NewReasonType)
OUTPUT $action INTO @SummaryOfChanges;

-- Query the results of the table variable.
SELECT Change, COUNT(*) AS CountPerChange
FROM @SummaryOfChanges
GROUP BY Change;
```





# 参考资料

1. [MERGE (Transact-SQL) - SQL Server | Microsoft Docs](https://docs.microsoft.com/en-us/sql/t-sql/statements/merge-transact-sql?view=sql-server-ver15)
2. [The MERGE Statement in SQL Server 2008 - Simple Talk](https://www.red-gate.com/simple-talk/sql/learn-sql-server/the-merge-statement-in-sql-server-2008/)
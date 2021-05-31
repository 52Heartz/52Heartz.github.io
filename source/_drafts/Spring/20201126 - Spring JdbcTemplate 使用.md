---
title: Spring JdbcTemplate 使用
mathjax: true
date: 2020-11-26 23:46:36
updated:
categories:
tags:
urlname: about-spring-jdbctemplate
---



<!-- more -->

Javadoc：[JdbcTemplate (Spring Framework 5.3.1 API)](https://docs.spring.io/spring-framework/docs/current/javadoc-api/org/springframework/jdbc/core/JdbcTemplate.html)

[13. Data access with JDBC](https://docs.spring.io/spring-framework/docs/4.0.x/spring-framework-reference/html/jdbc.html)













# RowCallbackHandler







# 资源关闭问题

**ResultSet 的 关闭**：

查看 JDBCtemplate 的源码可以看到，JDBCTemplate 中处理了 resultSet 的关闭问题；

比如 `query(final String sql, final ResultSetExtractor<T> rse)` 中：

```java
try {
    rs = stmt.executeQuery(sql);
    var3 = rse.extractData(rs);
} finally {
    JdbcUtils.closeResultSet(rs);
}
```

**Connection 的获取和关闭**：

```java
public <T> T execute(StatementCallback<T> action) throws DataAccessException {
    Assert.notNull(action, "Callback object must not be null");
    Connection con = DataSourceUtils.getConnection(this.obtainDataSource());
    Statement stmt = null;

    Object var11;
    try {
        stmt = con.createStatement();
        this.applyStatementSettings(stmt);
        T result = action.doInStatement(stmt);
        this.handleWarnings(stmt);
        var11 = result;
    } catch (SQLException var9) {
        String sql = getSql(action);
        JdbcUtils.closeStatement(stmt);
        stmt = null;
        DataSourceUtils.releaseConnection(con, this.getDataSource());
        con = null;
        throw this.translateException("StatementCallback", sql, var9);
    } finally {
        JdbcUtils.closeStatement(stmt);
        DataSourceUtils.releaseConnection(con, this.getDataSource());
    }

    return var11;
}
```

JDBCTemplate 中实际调用的更底层的方法中处理了 Connetion 的获取和资源的释放。





# 参考资料




package com.xiaoyou.dao;

import com.alsaw.util.JdbcContext;
import com.xiaoyou.data.PageInfo;
import com.xiaoyou.util.DbBase;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class BaseDao
{
  private String db = null;
  private Connection conn = JdbcContext.currentContext().getConnection();

  public BaseDao(String db)
  {
    this.db = db; }

  public BaseDao() {
    this.db = this.db;
  }

  public List getList(String sql)
    throws Exception
  {
    List list = DbBase.executeQuery(sql, getConn());

    return list; }

  private Connection getConn() {
    if (this.db != null)
      this.conn = JdbcContext.currentContext(this.db).getConnection();

    return this.conn; }

  public List getListC(String sql) throws Exception {
    //List list = DbBase.executeQueryC(sql, getConn());

    return null; }

  public List getSList(String sql) throws Exception {
    List list = DbBase.executeQueryList(sql, getConn());

    return list;
  }

  public List getListByPage(String modelName, String fields, PageInfo pageinfo)
    throws Exception
  {
    List list = DbBase.queryByPage(modelName, fields, pageinfo, getConn());

    return list;
  }

  public List getListByPageC(String modelName, String fields, PageInfo pageinfo)
    throws Exception
  {
    List list = DbBase.queryByPageAndCompile(modelName, fields, pageinfo, getConn());

    return list;
  }

  public void delete(String sql)
    throws Exception
  {
    DbBase.executeUpdate(sql, getConn());
  }

  public void deleteBatch(ArrayList alSql)
    throws Exception
  {
    DbBase.executeBatch(alSql, getConn());
  }

  public Map queryone(String sql)
    throws Exception
  {
    Map map = DbBase.queryOne(sql, getConn());

    return map;
  }

  public Map queryoneC(String sql)
    throws Exception
  {
    Map map = (Map)DbBase.executeQueryCompile(sql, getConn()).get(0);

    return map;
  }

  public List querymoreC(String sql)
    throws Exception
  {
    return DbBase.executeQueryCompile(sql, getConn());
  }

  public void update(String sql)
    throws Exception
  {
    DbBase.executeUpdate(sql, getConn());
  }

  public void update(String sql, Object[] params)
    throws Exception
  {
    DbBase.executeUpdate(sql, params, getConn());
  }

  public void updateBatch(ArrayList alSql)
    throws Exception
  {
    DbBase.executeBatch(alSql, getConn());
  }

  public String getDb() {
    return this.db; }

  public void setDb(String db) {
    this.db = db;
  }
}
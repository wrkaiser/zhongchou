package com.xiaoyou.tag;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.TagSupport;

import com.xiaoyou.dao.BaseDao;

public class OptionTag extends TagSupport
{
  private static final long serialVersionUID = 1L;
  private String entity = "";

  private String sql = "";

  private String property = "default";

  private String selectValue = null;

  private String itemValue = "fid";

  private String itemLabel = "fname";

  private String searchKey = null;
  
  private String onlyoption = "false";

  private String searchValue = null;
  
  private String paramStr = "";
  
  private String db = null;
  
  private String selectText ="";
  
  
  
  
  public String getSelectText() {
	return selectText;
}

public void setSelectText(String selectText) {
	this.selectText = selectText;
}

public String getParamStr() {
	return paramStr;
}

public void setParamStr(String paramStr) {
	this.paramStr = paramStr;
}

public String getOnlyoption() {
	return onlyoption;
}

public void setOnlyoption(String onlyoption) {
	this.onlyoption = onlyoption;
}

public String getDb() {
	return db;
}

public void setDb(String db) {
	this.db = db;
}

public String getSql()
  {
    return this.sql;
  }

  public void setSql(String sql) {
    this.sql = sql;
  }

  public String getSearchKey() {
    return this.searchKey;
  }

  public void setSearchKey(String searchKey) {
    this.searchKey = searchKey;
  }

  public String getSearchValue() {
    return this.searchValue;
  }

  public void setSearchValue(String searchValue) {
    this.searchValue = searchValue;
  }

  public String getEntity() {
    return this.entity;
  }

  public void setEntity(String entity) {
    this.entity = entity;
  }

  public String getItemValue() {
    return this.itemValue;
  }

  public void setItemValue(String itemValue) {
    this.itemValue = itemValue;
  }

  public String getItemLabel() {
    return this.itemLabel;
  }

  public void setItemLabel(String itemLabel) {
    this.itemLabel = itemLabel;
  }

  public String getSelectValue() {
    return this.selectValue;
  }

  public void setSelectValue(String selectValue) {
    this.selectValue = selectValue;
  }

  public String getProperty() {
    return this.property;
  }

  public void setProperty(String property) {
    this.property = property;
  }

  public int doStartTag()
    throws JspException
  {
    try
    {
      BaseDao dao = new BaseDao();
      List<Map> items = null;
      try {
        if ((this.sql != null) && (!this.sql.isEmpty()))
          items = dao.getList(this.sql);
        else
          items = dao.getList("select * from " + this.entity);
      }
      catch (Exception e) {
        e.printStackTrace();
      }

      StringBuffer opStr = new StringBuffer();
      if("false".equals(onlyoption)){
    	  opStr.append("<select name=\"" + this.property + "\">");
      }
     
      opStr.append("<option value=\"\">默认</option>\r\n");
     
      
      if (items != null) {
    	  
    	  String value = "";
    	  Object label = null;
         for (Map item : items) {
           label = item.get(this.itemLabel);
           value = item.get(this.itemValue)+"";
          if(value==null|| "#".equals(value)){
        	   value = value+"";
          }else{
        	   value = value+paramStr;
          }
           
          if (items.size()==1 || (!value.isEmpty()) && (value.equals(this.selectValue)) || (label != null) && (label.equals(this.selectText)))
          {
              opStr.append("<option value=\"" + value + "\" selected>" + label + "</option>\r\n");
          }else{
            opStr.append("<option value=\"" + value + "\">" + label + "</option>\r\n");
          }

        }

      }

      if("false".equals(onlyoption)){
       opStr.append("</select>&nbsp;&nbsp;&nbsp;\r\n");
      }

      this.pageContext.getOut().write(opStr.toString());
    }
    catch (IOException ex)
    {
      throw new JspException(ex);
    }
    finally {
      this.entity = null;
      this.property = null;
      this.selectValue = null;
      this.itemValue = null;
      this.itemLabel = null;
    }

    return 0;
  }
}
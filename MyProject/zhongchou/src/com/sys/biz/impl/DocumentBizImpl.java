package com.sys.biz.impl;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import com.xiaoyou.dao.BaseDao;
import com.xiaoyou.data.PageInfo;
import com.sys.form.DocumentForm;

public class DocumentBizImpl extends BaseBizImpl
{
	
  public List getList(String cid,String pid, PageInfo pageinfo,String tabname)
    throws Exception
  {
	
	 if(cid!=null&&!cid.isEmpty()){
		  pageinfo.setQueryStr(" type.type=" + pid + " and t.cid='"+cid+"' order by type.id,t.pos,t.ctime desc");
	 }else{
		  pageinfo.setQueryStr(" type.type=" + pid + "  order by type.id,t.pos,t.ctime desc");
	 }
  
    
    BaseDao basedao = new BaseDao();
    return basedao.getListByPage("t_document"+tabname+" t left join wei_common_type type on type.id=t.cid", "t.*,FROM_UNIXTIME(t.ctime, '%Y-%m-%d') ctime,type.label cname", pageinfo);
  }
  
  public void saveorupdate(DocumentForm dform,String tabname)
    throws Exception
  {
    BaseDao basedao = new BaseDao();
    if (dform.getId() == 0)
    {
      this.sql = "insert into "+"t_document"+tabname+"(title,url,content,ctime,cid,img,pos) values(?,?,?,UNIX_TIMESTAMP(),?,?,?)";
      Object[] params = { dform.getTitle(), dform.getUrl(), dform.getContent(), dform.getCid(), dform.getImg(), Integer.valueOf(dform.getPos())};
      basedao.update(this.sql, params);
    }
    else
    {
      this.sql = "update "+"t_document"+tabname+" set title=?,url=?,content=?,ctime=UNIX_TIMESTAMP(),cid=?,img=?,pos=? where id=?";
      Object[] params = { dform.getTitle(), dform.getUrl(), dform.getContent(), dform.getCid(), dform.getImg(), Integer.valueOf(dform.getPos()),Integer.valueOf(dform.getId())};
      basedao.update(this.sql, params);
    }
  }
  
  public void delete(String id,String tabname)
    throws Exception
  {
	  super.delete("t_document"+tabname, id);
  }
  
  public Map detail(String id,String tabname)
    throws Exception
  {
    return super.detail("t_document"+tabname, id);
  }
  
  public String getTimeStemp(String time)  throws Exception{
	  SimpleDateFormat simpleDateFormat =new SimpleDateFormat("yyyy-MM-dd");
	     Date date=simpleDateFormat .parse(time);
	     int timeStemp = (int) date.getTime();
	     return String.valueOf(timeStemp);

}
}

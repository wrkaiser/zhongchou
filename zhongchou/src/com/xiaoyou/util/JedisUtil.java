package com.xiaoyou.util;

import java.util.Map;

import com.xiaoyou.dao.BaseDao;


import redis.clients.jedis.Jedis;
import redis.clients.jedis.JedisPool;
import redis.clients.jedis.JedisPoolConfig;

/**
 * 
 * @author Administrator
 *
 */
public class JedisUtil {
	 public static JedisPool pool;
	 static {
	        JedisPoolConfig config = new JedisPoolConfig();
	        config.setMaxActive(100);
	        config.setMaxIdle(20);
	        config.setMaxWait(1000);
	        config.setTestOnBorrow(true);
	        pool = new JedisPool(config, "localhost",6379);
	 }
	 public static String getkeyid(String tablename)throws Exception{
	       Jedis jedis = pool.getResource();
		   String keyid=jedis.lpop(tablename);
		   if(keyid!=null){
			   pool.returnResource(jedis);
			   return keyid;
		   }else{
			   BaseDao keydao=new BaseDao();
			   String sql="select * from  increment_config where TABLE_NAME='"+tablename+"'";
			   Map<String, String> keymap=keydao.queryone(sql);
			   int startid=Integer.parseInt(keymap.get("start_value"));
			   int offset=Integer.parseInt(keymap.get("offset_value"));
			   for(int id=startid+1;id<startid+offset;id++){
				   jedis.rpush(tablename, String.valueOf(id));
			   }
			   startid=startid+offset;
			   sql="update increment_config set start_value="+startid+" where id="+keymap.get("id")+"";
			   keydao.update(sql);
			   pool.returnResource(jedis);
			   //jedis.llen(key)
			   return keymap.get("start_value");
		   }
	   }
	    public static void push(String keyname,String value,Jedis jedis)throws Exception{
	    	jedis.rpush(keyname, value);
	    }
	    public static String gettag(String tagname)throws Exception{
	    	Jedis jedis = pool.getResource();
	    	String tag=jedis.get(tagname);
	    	pool.returnResource(jedis);
    		return tag;
	    }
	    public static void set(String key,String value,int expire)throws Exception{
	    	Jedis jedis = pool.getResource();
	    	jedis.setex(key, expire, value);
	    	pool.returnResource(jedis);
	    }
	    public static void set(String key,String value)throws Exception{
	    	Jedis jedis = pool.getResource();
	    	jedis.set(key,value);
	    	pool.returnResource(jedis);
	    }
//	    public static int noteid=0;
//	    public static int getNoteid()throws Exception{
//			 if(noteid==0){
//				 BaseDao keydao=new BaseDao();
//				 Map<String, String> lelekeymap=keydao.queryone("select max(noteid) leleid from  xy_mem_note");
//				 if(lelekeymap!=null&&!"".equals(lelekeymap.get("noteid"))){
//					 noteid=Integer.parseInt(lelekeymap.get("noteid"));
//				 }
//			 }
//			 noteid=noteid+1;
//			 return noteid;
//		 }
	    
}

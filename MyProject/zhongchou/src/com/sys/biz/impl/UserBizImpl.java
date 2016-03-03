package com.sys.biz.impl;

import java.util.HashMap;
import java.util.Map;


import com.xiaoyou.dao.BaseDao;
import com.xiaoyou.exception.SysException;
import com.xiaoyou.util.EncodeAndDecode;
import com.xiaoyou.util.JedisUtil;
import com.sys.biz.UserBiz;
import com.sys.form.MUserForm;

public class UserBizImpl implements UserBiz {
	private String sql="";
	public Map userRegist(MUserForm userform) throws Exception {
		BaseDao dao=new BaseDao();
		String uid=JedisUtil.getkeyid("wei_user");
		sql="insert into wei_user(userid,username,headimg,password,email,qq,telno,regtime,logtime,logip) values(?,?,?,?,?,?,?,unix_timestamp(),unix_timestamp(),?)";
		EncodeAndDecode code=new EncodeAndDecode();
		String headimg="http://img1.huixuer.com/default.jpg";
		Object[] params={uid,userform.getUsername(),headimg,code.encrypt(userform.getPassword()),userform.getEmail(),userform.getQq(),userform.getTelno(),userform.getLastIp()};
		dao.update(sql, params);
		Map map=new HashMap();
		map.put("userid", uid);
		map.put("username", userform.getUsername());
		map.put("headimg", headimg);
		return map;
	}

	public int isExistUser(MUserForm userform) throws Exception {
		BaseDao dao=new BaseDao();
		String username=userform.getUsername();
		sql="select userid from wei_user where username='"+username+"'";
		Map map=dao.queryone(sql);
		if(map!=null&&map.size()>0){
			return 2;
		}
		return 0;
	}

	public Map getPass(String userid) throws Exception {
		BaseDao dao=new BaseDao();
		sql="select  password from wei_user where userid="+userid;
		return dao.queryone(sql);
	}

	public Map autoLogin(String userid) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	public int findPass(String email) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}

	public void saveHead(String userid, String bigimg)
			throws Exception {
		sql="update wei_user set headimg='"+bigimg+"' where userid="+userid;
		BaseDao dao=new BaseDao();
		dao.update(sql);
	}

	public Map detail(String userid) throws Exception {
		sql="select userid,username,headimg,email,telno,role,qq from wei_user where userid="+userid;
		BaseDao dao=new BaseDao();
		return dao.queryone(sql);
	}
	public Map login(MUserForm userform) throws Exception {
		sql="select userid,username,headimg,password,role from wei_user where username='"+userform.getUsername()+"'";
		BaseDao dao=new BaseDao();
		Map user=dao.queryone(sql);
		if(user!=null&&user.size()>0){
			EncodeAndDecode code=new EncodeAndDecode();
			System.out.println(code.encrypt(userform.getPassword()));
			if(code.encrypt(userform.getPassword()).equals(user.get("password"))){
				return user;
			}else{
				throw new SysException("2");
			}
		}else{
			throw new SysException("1");
		}
	}

	public void updateInfo(MUserForm userform) throws Exception {
		sql="update wei_user set email='"+userform.getEmail()+"',telno='"+userform.getTelno()+"',qq='"+userform.getQq()+"' where userid="+userform.getUserid();
		BaseDao dao=new BaseDao();
		dao.update(sql);
	}

	public void updateemail(String email, String userid) throws Exception {
		BaseDao dao=new BaseDao();
		sql="select * from wei_user where email='"+email+"' limit 1";
		Map user=dao.queryone(sql);
		if(user!=null&&user.size()>0){
			throw new SysException("该邮箱已被注册使用");
		}
		sql="update wei_user set email='"+email+"' where userid="+userid;
		dao.update(sql);
	}

	public void updatetelno(String telno, String userid) throws Exception {
		BaseDao dao=new BaseDao();
		sql="select * from wei_user where telno='"+telno+"' limit 1";
		Map user=dao.queryone(sql);
		if(user!=null&&user.size()>0){
			throw new SysException("该手机号已被注册使用");
		}
		sql="update wei_user set telno='"+telno+"' where userid="+userid;
		dao.update(sql);
	}

	public void updatePass(MUserForm userform) throws Exception {
		EncodeAndDecode code=new EncodeAndDecode();
		sql="update wei_user set password='"+code.encrypt(userform.getPassword())+"' where userid="+userform.getUserid();
		BaseDao dao=new BaseDao();
		dao.update(sql);
	}


	
	
}

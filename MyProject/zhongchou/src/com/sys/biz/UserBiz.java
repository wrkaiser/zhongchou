package com.sys.biz;

import java.util.Map;

import com.sys.form.MUserForm;



public interface UserBiz {
	/**
	 * 添加修改用户
	 * @param contentform
	 * @throws Exception
	 */
	public Map userRegist(MUserForm userform)throws Exception;
	/**
	 * 检测用户返回0为不存在1为手机已被注册2为邮箱已被注册3为非法账号
	 * @param username
	 * @throws Exception
	 */
	public int isExistUser(MUserForm userform)throws Exception;
	/**
	 * 用户登录
	 * @param contentform
	 * @throws Exception
	 */
	public Map autoLogin(String userid)throws Exception;
	/**
	 * 找回密码
	 * @param String email
	 * @throws Exception
	 */
	public int findPass(String email)throws Exception;
	/**
	 * 保存头像
	 * @param userid
	 * @param bigimg
	 * @param smallimg
	 * @throws Exception
	 */
	public void saveHead(String userid,String bigimg)throws Exception;
	
	/**
	 * 用户详细
	 * @param userid
	 * @return
	 * @throws Exception
	 */
	public Map detail(String userid)throws Exception;
	/**
	 * 会员登录
	 * @param userid
	 * @return
	 * @throws Exception
	 */
	public Map login(MUserForm userform)throws Exception;
	/**
	 * 更新用户基本信息
	 * @param userform
	 * @throws Exception
	 */
	public void updateInfo(MUserForm userform)throws Exception;
	/**
	 * 更新用户手机绑定
	 * @param userform
	 * @throws Exception
	 */
	public void updatetelno(String telno,String userid)throws Exception;
	/**
	 * 更新用户邮箱绑定
	 * @param userform
	 * @throws Exception
	 */
	public void updateemail(String updateemail,String userid)throws Exception;
	/**
	 * 更新密码
	 * @param userform
	 * @throws Exception
	 */
	public void updatePass(MUserForm userform)throws Exception;
	/**
	 * 获取密码
	 * @param userid
	 * @return
	 * @throws Exception
	 */
	public Map getPass(String userid)throws Exception;
	
}

package com.sys.action;

import java.awt.Color;
import java.awt.Font;
import java.io.File;
import java.io.FileOutputStream;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;
import java.util.UUID;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.actions.DispatchAction;

import com.xiaoyou.exception.SysException;
import com.xiaoyou.util.CookieUtil;
import com.xiaoyou.util.EncodeAndDecode;
import com.xiaoyou.util.IpUtil;
import com.xiaoyou.util.JsonUtils;
import com.xiaoyou.util.MsgThread;
import com.xiaoyou.util.PictureWebServ;
import com.xiaoyou.util.StringUtil;
import com.xiaoyou.util.StringUtils;
import com.xiaoyou.util.SysConstant;
import com.sys.biz.SysMenuBiz;
import com.sys.biz.UserBiz;
import com.sys.biz.impl.SysMenuBizImpl;
import com.sys.biz.impl.UserBizImpl;
import com.sys.form.MUserForm;

import sun.misc.*;

public class UserAction extends BaseAction{
	
	
	/**
	 * 更新用户信息
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	public ActionForward updateinfo(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map user=(Map)request.getSession().getAttribute("User");
		if(user==null){
			return mapping.findForward("login");
		}
		MUserForm userform=(MUserForm)form;
		userform.setUserid(user.get("userid").toString());
		UserBiz userbiz=new UserBizImpl();
		try {
			userbiz.updateInfo(userform);
			request.getSession().setAttribute("User", user);
			response.getWriter().print("更新成功");
		} catch (Exception e) {
			log.error(StringUtil.msgfmt(e));
			response.getWriter().print("更新失败："+e.getMessage());
		}
		return null;
	}
	/**
	 * 更改密码
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	public ActionForward updatepass(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map user=(Map)request.getSession().getAttribute("User");
		if(user==null){
			return mapping.findForward("login");
		}
		MUserForm userform=(MUserForm)form;
		String ypassword=request.getParameter("ypassword");
		if(!userform.getPassword().equals(userform.getChkpassword())){
			response.getWriter().print("两次密码输入不一致");//两次密码输入不一致
			return null;
		}
		try {
			UserBiz userbiz=new UserBizImpl();
			Map upass=userbiz.getPass(user.get("userid").toString());//获取密码信息
			EncodeAndDecode Encode=new EncodeAndDecode();
			if(!Encode.encrypt(ypassword).equals(upass.get("password"))){
				response.getWriter().print("原密码输入有误");//原密码输入有误
				return null;
			}
			userform.setUserid(user.get("userid").toString());
			userbiz.updatePass(userform);
			response.getWriter().print("修改成功");//修改成功
		} catch (Exception e) {
			log.error(StringUtil.msgfmt(e));
			response.getWriter().print("相改失败");//相应失败
		}
		return null;
	}
	/**
	 * 会员基本信息
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	public ActionForward baseinfo(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map user=(Map)request.getSession().getAttribute("User");
		if(user==null){
			return mapping.findForward("login");
		}
		UserBiz userbiz=new UserBizImpl();
		request.setAttribute("User", userbiz.detail(user.get("userid").toString()));
		return mapping.findForward("baseinfo");
	}
	/**
	 * 会员基本信息
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	public ActionForward headinfo(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map user=(Map)request.getSession().getAttribute("User");
		if(user==null){
			return mapping.findForward("login");
		}
		return mapping.findForward("headinfo");
	}
	/**
	 * 会员登录
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	public ActionForward login(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		MUserForm userform=(MUserForm)form;
		UserBiz userbiz=new UserBizImpl();
		String reurl=request.getParameter("reurl");
		String remem=request.getParameter("remem");
		try {
			Map use=userbiz.login(userform);
			if(remem!=null&&"1".equals(remem)){
				use.put("remem", remem);
			}
			EncodeAndDecode Encode=new EncodeAndDecode();
			request.getSession().setAttribute("User", use);
			String L= (String) request.getSession().getAttribute("BLanguage");
			if (L==null||"".equals(L)) {
				request.getSession().setAttribute("BLanguage", "chs");
			}
			if(reurl!=null&&!"".equals(reurl)){
				response.sendRedirect(reurl);
				return null;
			}else{
				//初始化菜单
				SysMenuBiz mbiz = new SysMenuBizImpl();
				request.setAttribute("menus", mbiz.loopRightMenu(use.get("role").toString()));
				return mapping.findForward("success");
			}
		} catch (SysException e) {
			request.setAttribute("reurl",reurl);
			if(e.getMessage().equals("1"))
			   request.setAttribute("nameerror","用户不存在");
			else
				request.setAttribute("passerror","密码错误");
			return mapping.findForward("login");
		}
	}
	public ActionForward changepass(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map user=(Map)request.getSession().getAttribute("User");
		if(user==null){
			return mapping.findForward("login");
		}
		return mapping.findForward("changepass");
	}
	/**
	 * 注销登录
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	public ActionForward logout(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		    request.getSession().setAttribute("User", null);
		    request.getSession().invalidate();
			String ref=request.getParameter("ref");
			if(ref!=null){
				response.sendRedirect(ref);
			}else{
				response.sendRedirect(request.getContextPath()+"/back/log.shtml");
			}
			return null;
	} 
	
	
	/**
	 * 激活手机认证
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	public ActionForward verifitelno(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
			Map user=(Map)request.getSession().getAttribute("User");
			if(user==null){
				response.getWriter().print("-1");
				return null;
			}
			String code=request.getParameter("code");
			String telno=request.getParameter("telno");
			if(code!=null&&!"".equals(code)){
				try {
					Cookie[] cookies=request.getCookies();
					Cookie msgcodecookie=CookieUtil.getCookie(cookies, "_msgcode_");
					if(msgcodecookie!=null){
						EncodeAndDecode Encode=new EncodeAndDecode();
						String ccode=Encode.decrypt(msgcodecookie.getValue());
						String[] ccodes=ccode.split("#");
						if(ccodes[0].equals(telno)&&ccodes[1].equals(code)){
							UserBiz userbiz=new UserBizImpl();
							userbiz.updatetelno(telno, user.get("userid").toString());
							response.getWriter().print("99");//校验成功
							Cookie usercookie=new Cookie("_msgcode_",null);
							usercookie.setPath("/");
							//usercookie.setDomain("iidaxue.com");
							usercookie.setMaxAge(0);//保存20分钟
							response.addCookie(usercookie);//保存验证码
							return null;
						}
					}
				} catch (Exception e) {
					log.error(StringUtil.msgfmt(e));
					response.getWriter().print("-99");
					return null;
				}
				response.getWriter().print("-1");//校验失败，验证码有误
			}else{
				response.getWriter().print("-2");//请输入验证码
			}
			return null;
	}
	/**
	 * 头像上传
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	public ActionForward uploadhead(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map user=(Map)request.getSession().getAttribute("User");
		if(user==null){
			return null;
		}
		String pic=request.getParameter("pic");
		String pic1=request.getParameter("pic1");
		String pic2=request.getParameter("pic2");
		String pic3=request.getParameter("pic3");
		System.out.print(pic);
		String picweburl=SysConstant.PICWEB;
		String path =PictureWebServ.getPicturePath(picweburl);
		String date = new SimpleDateFormat("yyyyMM")
		.format(new Date());
		path = path+ "/headimg/"+date+"/" ;//头像存放地址
		File filedir = new File(path);
		if (!filedir.exists())
			filedir.mkdirs();
		String filename = UUID.randomUUID().toString();
		if(!pic.equals("")&&pic!=null){
			//原图
			File file = new File(path+"src.png");
			FileOutputStream fout = null;
			fout = new FileOutputStream(file);
			fout.write(new BASE64Decoder().decodeBuffer(pic));
			fout.close();
		}

		//图1
		File file1 = new File(path+filename+".png");
		FileOutputStream fout1 = null;
		fout1 = new FileOutputStream(file1);
		fout1.write(new BASE64Decoder().decodeBuffer(pic1));
		fout1.close();

		//图2
		File file2 = new File(path+filename+".png"+"48");
		FileOutputStream fout2 = null;
		fout2 = new FileOutputStream(file2);
		fout2.write(new BASE64Decoder().decodeBuffer(pic2));
		fout2.close();

		//图3
		File file3 = new File(path+filename+".png"+"20");
		FileOutputStream fout3 = null;
		fout3 = new FileOutputStream(file3);
		fout3.write(new BASE64Decoder().decodeBuffer(pic3));
		fout3.close();
		UserBiz userbiz=new UserBizImpl();
		userbiz.saveHead(user.get("userid").toString(), "http://"+picweburl+"/headimg/"+date+"/"+filename+".png");
		user.put("headimg", "http://"+picweburl+"/headimg/"+date+"/"+filename+".png");
		EncodeAndDecode Encode=new EncodeAndDecode();
		Cookie usercookie=new Cookie("_uinf_",Encode.encrypt(JsonUtils.mapToJson(user)));
		usercookie.setPath("/");
		//usercookie.setDomain("iidaxue.com");
		usercookie.setMaxAge(60*20);//保存20分钟
		response.addCookie(usercookie);//保存用户信息
		response.getWriter().println("{\"status\":1}");
		return null;
	}

	public ActionForward setBLanguage(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		String type=request.getParameter("id");
		try {
			if (type!=null) {
				if ("0".equals(type)) {
					request.getSession().setAttribute("BLanguage", "chs");
				}else {
					request.getSession().setAttribute("BLanguage", "eng");
				}
			}
			else
				request.getSession().setAttribute("BLanguage", "chs");
			response.getWriter().print("99");
		} catch (Exception e) {
			// TODO: handle exception
			response.getWriter().print("-99");
		}
		return null;
	}
	
	public ActionForward setLanguage(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		String type=request.getParameter("id");
		try {
			if (type!=null) {
				if ("0".equals(type)) {
					request.getSession().setAttribute("Language", "chs");
				}else {
					request.getSession().setAttribute("Language", "eng");
				}
			}
			else
				request.getSession().setAttribute("Language", "chs");
			response.getWriter().print("99");
		} catch (Exception e) {
			// TODO: handle exception
			response.getWriter().print("-99");
		}
		return null;
	}
}

package com.sys.action;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.log4j.Logger;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.actions.DispatchAction;
import org.apache.struts.upload.FormFile;

import com.sys.form.UploadForm;
import com.xiaoyou.util.GFtpClient;
import com.xiaoyou.util.ImageHepler;
import com.xiaoyou.util.JsonUtil;
import com.xiaoyou.util.TransforEventListener;


public class UploadAction extends DispatchAction{
	
	private Logger loger = Logger.getLogger(UploadAction.class);
	
	
	public ActionForward checkStatus(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		try{
		Map probar = (Map)request.getSession().getAttribute("fackyou");
		loger.error("checkStatus:"+probar);
		    response.setContentType("application/json");  
		    response.setCharacterEncoding("UTF-8");  
		    response.setHeader("Cache-Control", "no-cache");  
		if(probar!=null){
			String percent = probar.get("percent")+"";
			if("100".equals(percent)){
				request.getSession().removeAttribute("fackyou");
			}
			response.getWriter().println(JsonUtil.mapToJson(probar));
		}else{
			HashMap map = new HashMap();
			map.put("size", "0");
			map.put("send", "0");
			map.put("percent", "0");
			map.put("success", "true");
			
			response.getWriter().println(JsonUtil.mapToJson(map));
		}
		
		}catch(Exception e){
		
			loger.error(e.getMessage());
		}finally{
			response.getWriter().close();  
		}
	
		return null;
	}
	
	/**
	 * 视频上传
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	public ActionForward fileupload(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		String picweburl = request.getContextPath() + "/pimg";
	    String savePath = request.getRealPath("/pimg");
	    String subpath = new SimpleDateFormat("yyyyMM").format(new Date());
	    File f1 = new File(savePath + "/" + subpath);
	    System.out.println(savePath);
	    if (!(f1.exists()))
	      f1.mkdirs();

	    DiskFileItemFactory fac = new DiskFileItemFactory();
	    ServletFileUpload upload = new ServletFileUpload(fac);
	    upload.setHeaderEncoding("utf-8");
	    List fileList = null;
	    try {
	      fileList = upload.parseRequest(request);
	    } catch (FileUploadException ex) {
	      return null;
	    }
	    Iterator it = fileList.iterator();
	    String name = "";
	    String extName = "";
	    while (it.hasNext()) {
	      FileItem item = (FileItem)it.next();
	      if (!(item.isFormField())) {
	        name = item.getName();
	        long size = item.getSize();
	        String type = item.getContentType();
	        System.out.println(size + " " + type);
	        if (name != null) { if (name.trim().equals("")) {
	            continue;
	          }

	          if (name.lastIndexOf(".") >= 0)
	            extName = name.substring(name.lastIndexOf("."));

	          File file = null;
	            name = UUID.randomUUID().toString();
	            file = new File(savePath + "/" + subpath + "/" + name + extName);
	          try {
	            item.write(file);
	            response.getWriter().print("{\"status\":true,\"name\":\""+item.getName()+"\",\"fileUrl\":\"" + picweburl + "/" + subpath + "/" + name + extName + "\"}");
	          } catch (Exception e) {
	            e.printStackTrace();
	            response.getWriter().print("{\"status\":false,\"error\":\"" +e.getMessage()+ "\"}");
	          }
	        }
	      }
	    }
	    return null;
	}
	
}

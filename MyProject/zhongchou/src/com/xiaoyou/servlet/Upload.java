package com.xiaoyou.servlet;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.log4j.Logger;

import com.xiaoyou.dao.BaseDao;
import com.xiaoyou.util.ImageHepler;
import com.xiaoyou.util.PictureWebServ;
import com.xiaoyou.util.StringUtil;

public class Upload extends HttpServlet
{
  public void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException
  {
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
      return;
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
            ImageHepler.saveResizeImage(savePath + "/" + subpath + "/" + name + extName, savePath + "/" + subpath + "/" + name + extName,1000, true);
            response.getWriter().print("{\"status\":true,\"img\":\"" + picweburl + "/" + subpath + "/" + name + extName + "\"}");
          } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().print("{\"status\":false,\"error\":\"" +e.getMessage()+ "\"}");
          }
        }
      }
    }
  }
}
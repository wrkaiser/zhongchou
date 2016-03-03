package com.xiaoyou.servlet;
import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.util.Random;
import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
public class ImageServlet extends HttpServlet {
       public void doGet(HttpServletRequest request, HttpServletResponse response)
                     throws ServletException, IOException {
              this.doPost(request, response);
       }
       // 生成数字和字母的验证码
       public void doPost(HttpServletRequest request, HttpServletResponse response)
                     throws ServletException, IOException {
    	    response.setContentType("image/jpeg");
	   		response.setHeader("Pragma", "no-cache");
	   		response.setHeader("Cache-Control", "no-cache");
	   		response.setDateHeader("Expires", 0);

            BufferedImage img = new BufferedImage(111, 45,
                            BufferedImage.TYPE_INT_RGB);
              // 得到该图片的绘图对象
              Graphics g = img.getGraphics();
              Random r = new Random();
              Color c = new Color(168,219,248);
              g.setColor(c);
              // 填充整个图片的颜色
              g.fillRect(0, 0, 111, 45);
              // 向图片中输出数字和字母
              StringBuffer sb = new StringBuffer();
              char[] ch = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789".toCharArray();
              int index, len = ch.length;
              for (int i = 0; i < 4; i ++) {
                     index = r.nextInt(len);
                     g.setColor(new Color(r.nextInt(88), r.nextInt(188), r.nextInt(255)));
                     g.setFont(new Font("Arial", Font.BOLD | Font.ITALIC, 22));// 输出的字体和大小                  
                     g.drawString("" + ch[index], (i * 29) + 3, 30);//写什么数字，在图片的什么位置画
                     sb.append(ch[index]);
              }
              request.getSession().setAttribute("checkcode", sb.toString());
              ImageIO.write(img, "gif", response.getOutputStream());
       }     

}
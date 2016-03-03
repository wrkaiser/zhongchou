package com.xiaoyou.util;
import java.awt.Dimension;
import java.awt.Rectangle;
import java.text.SimpleDateFormat;
import java.util.Date;

import magick.CompositeOperator;
import magick.CompressionType;
import magick.DrawInfo;
import magick.ImageInfo;
import magick.MagickException;
import magick.MagickImage;
import magick.PixelPacket;
import magick.PreviewType;

public class JmagickHelps {
	      /**
	       * 压缩图片
	      * @param filePath 源文件路径
	       * @param toPath   缩略图路径
	       */
	      public static void createThumbnail(String filePath, String toPath,int width) throws MagickException{
	          ImageInfo info = null;
	          MagickImage image = null;
	          Dimension imageDim = null;
	          MagickImage scaled = null;
	          try{
	             info = new ImageInfo(filePath);
	              image = new MagickImage(info);
	              imageDim = image.getDimension();
	              int wideth = imageDim.width;
	              int height = imageDim.height;
	              double ratio = 1.0;   
				  if( wideth>width){    
				      ratio =(double)  width / wideth;   
				  }
				  int newWidth =(int)(wideth*ratio);   
				  int newHeight =(int)(height*ratio); 
	              scaled = image.scaleImage(newWidth, newHeight);//小图片文件的大小.
	              scaled.setFileName(toPath);
	              scaled.writeImage(info);
	          }finally{
	              if(scaled != null){
	                  scaled.destroyImages();
	              }
	          } 
	      }
	      /**
	       * 水印(图片logo)
	       * @param filePath  源文件路径
	       * @param toImg     修改图路径
	       * @param logoPath  logo图路径
	       * @throws MagickException
	       */
	      public static void initLogoImg(String filePath, String toImg,int pwidth, String logoPath) throws MagickException {
	          ImageInfo info = new ImageInfo();
	          MagickImage fImage = null;
	          MagickImage sImage = null;
	          MagickImage fLogo = null;
	          MagickImage sLogo = null;
	          Dimension imageDim = null;
	          Dimension logoDim = null;
	          try {
	              fImage = new MagickImage(new ImageInfo(filePath));
	              imageDim = fImage.getDimension();
	              int width = imageDim.width;
	              int height = imageDim.height;
	              if(pwidth<=0){
	            	  pwidth=660;
	              }
	              if (width > pwidth) {
	                  height = pwidth * height / width;
	                  width = pwidth;
	              }
	              sImage = fImage.scaleImage(width, height);
	             
	              fLogo = new MagickImage(new ImageInfo(logoPath));
	              logoDim = fLogo.getDimension();
	              int lw = logoDim.width;
	              int lh = logoDim.height ;
	              sLogo = fLogo.scaleImage(lw, lh);
	
	             sImage.compositeImage(CompositeOperator.AtopCompositeOp, sLogo,  width-lw-5 , height-lh-5);
	             sImage.setFileName(toImg);
	             sImage.writeImage(info);
	         } finally {
	             if(sImage != null){
	                 sImage.destroyImages();
	             }
	         }
	     }
	    
	     /**
	      * 水印(文字)
	        &nbsp;* @param filePath 源文件路径
	      * @param toImg    修改图路径
	      * @param text     名字(文字内容自己随意)
	      * @throws MagickException
	      */
	     public static void initTextToImg(String filePath, String toImg,  String text) throws MagickException{
	             ImageInfo info = new ImageInfo(filePath);
	             if (filePath.toUpperCase().endsWith("JPG") || filePath.toUpperCase().endsWith("JPEG")) {
	                 info.setCompression(CompressionType.JPEGCompression); //压缩类别为JPEG格式
	                 info.setPreviewType(PreviewType.JPEGPreview); //预览格式为JPEG格式
	                 info.setQuality(95);
	             }
	             MagickImage aImage = new MagickImage(info);
	             Dimension imageDim = aImage.getDimension();
	             int wideth = imageDim.width;
	             int height = imageDim.height;
	             if (wideth > 660) {
	                 height = 660 * height / wideth;
	                 wideth = 660;
	             }
	             int a = 0;
	             int b = 0;
	             String[] as = text.split("");
	             for (String string : as) {
	                 if(string.matches("[\u4E00-\u9FA5]")){
	                     a++;
	                 }
	                 if(string.matches("[a-zA-Z0-9]")){
	                     b++;
	                 }
	             }
	             int tl = a*12 + b*6 + 300;
	             MagickImage scaled = aImage.scaleImage(wideth, height);
	             if(wideth > tl && height > 5){
	                 DrawInfo aInfo = new DrawInfo(info);
	                 aInfo.setFill(PixelPacket.queryColorDatabase("white"));
	                 aInfo.setUnderColor(new PixelPacket(0,0,0,100));
	                 aInfo.setPointsize(12);
	                 //解决中文乱码问题,自己可以去随意定义个自己喜欢字体，我在这用的微软雅黑
	                 String fontPath = "C:/WINDOWS/Fonts/MSYH.TTF";
	 //                String fontPath = "/usr/maindata/MSYH.TTF";
	                 aInfo.setFont(fontPath);
	                 aInfo.setTextAntialias(true);
	                 aInfo.setOpacity(0);
	                 aInfo.setText("　" + text + "于　" + new SimpleDateFormat("yyyy-MM-dd").format(new Date()) + "　上传于XXXX网，版权归作者所有！");
	                 aInfo.setGeometry("+" + (wideth-tl) + "+" + (height-5));
	                 scaled.annotateImage(aInfo);
	             }
	             scaled.setFileName(toImg);
	             scaled.writeImage(info);
	             scaled.destroyImages();
	     }
	    
	    
	     /**
	      * 切图
	      * @param imgPath 源图路径
	      * @param toPath  修改图路径
	      * @param w      
	      * @param h      
	      * @param x      
	      * @param y
	      * @throws MagickException
	      */
	     public static void cutImg(String imgPath, String toPath, int w, int h, int x, int y) throws MagickException {
	         ImageInfo infoS = null;
	         MagickImage image = null;
	         MagickImage cropped = null;
	         Rectangle rect = null;
	         try {
	             infoS = new ImageInfo(imgPath);
	             image = new MagickImage(infoS);
	             rect = new Rectangle(x, y, w, h);
	             cropped = image.cropImage(rect);
	             cropped.setFileName(toPath);
	             cropped.writeImage(infoS);
	            
	         } finally {
	             if (cropped != null) {
	                 cropped.destroyImages();
	             }
	         }
	     }
	     /**
	       * 压缩图片
	      * @param filePath 源文件路径
	       * @param toPath   缩略图路径
	       */
	      public static void cutimg(String filePath, String toPath,int width,int height) throws MagickException{
	    	  ImageInfo info = null;
	    	    MagickImage image = null;
	    	    Dimension imageDim = null;
	    	    MagickImage scaled = null;
	    	    try {
	    	      info = new ImageInfo(filePath);
	    	      image = new MagickImage(info);
	    	      imageDim = image.getDimension();
	    	      int wideth = imageDim.width;
	    	      int sheight = imageDim.height;

	    	      double ratio = 1D;
	    	      if (wideth > width) {
	    	        ratio = (double)  width / wideth;
	    	        int newWidth = (int)(wideth * ratio);
	    	        int newHeight = (int)(sheight * ratio);
	    	        wideth = newWidth;
	    	        sheight = newHeight;
	    	        scaled = image.scaleImage(newWidth, newHeight);
	    	        scaled.setFileName(toPath);
	    	        scaled.writeImage(info);
	    	        image = scaled;
	    	      }

	    	      int x = 0; int y = 0;
	    	      if (wideth > width)
	    	        x = (wideth - width) / 2;

	    	      if (sheight > height)
	    	        y = (sheight - height) / 2;

	    	      Rectangle rect = new Rectangle(x, y, width, height);
	    	      scaled = image.cropImage(rect);
	    	      scaled.setFileName(toPath);
	    	      scaled.writeImage(info);
	    	    } finally {
	    	      if (scaled != null)
	    	        scaled.destroyImages();
	    	    }
	      }
	      /**
	     * @param args
	     */
	    public static void main(String[] args) { 
	          try {
	        	  System.out.println("JmagickHelps.main()"+((double)  200/493));
	          	JmagickHelps.createThumbnail("C:/Users/Administrator/Desktop/f6fb8976-a0f8-49fd-ae51-e291b66ce850.jpg", "g:/12.jpg",230);
	          	JmagickHelps.cutimg("C:/Users/Administrator/Desktop/f6fb8976-a0f8-49fd-ae51-e291b66ce850.jpg", "G:/13.jpg",200,200);
	          	//JmagickHelps.initLogoImg("G:/4.jpg", "G:/6.jpg",200,"G:/le_logo.png");
	  		} catch (Exception e) {
	  			e.printStackTrace();
	  		}
	              
	           
	      } 
	     
	 }
	 
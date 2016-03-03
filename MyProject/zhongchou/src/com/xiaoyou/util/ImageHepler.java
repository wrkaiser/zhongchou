package com.xiaoyou.util;

/**
 * @author jack hou
 * @date 2011-05-10
 * @version 1.0
 */
import java.awt.AlphaComposite;
import java.awt.Color;
import java.awt.Graphics;
import java.awt.Graphics2D;
import java.awt.Image;
import java.awt.Rectangle;
import java.awt.RenderingHints;
import java.awt.geom.AffineTransform;
import java.awt.image.BufferedImage;
import java.awt.image.ColorModel;
import java.awt.image.WritableRaster;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import javax.imageio.ImageIO;

import org.apache.log4j.Logger;

import com.sun.image.codec.jpeg.JPEGCodec;
import com.sun.image.codec.jpeg.JPEGImageEncoder;

/**
 * 图片工具类，完成图片的截取
 * 
 * @author inc062977
 * 
 */
public class ImageHepler {
	public static  Logger log=Logger.getLogger(ImageHepler.class);
	/**
	 * 实现图像的等比缩放
	 * 
	 * @param source
	 * @param targetW
	 * @param targetH
	 * @return
	 */
	private static BufferedImage resize(BufferedImage source, int targetW,
			int targetH) {
		// targetW，targetH分别表示目标长和宽
		int type = source.getType();
		BufferedImage target = null;
		double sx = (double) targetW / source.getWidth();
		double sy = (double) targetH / source.getHeight();
		// 这里想实现在targetW，targetH范围内实现等比缩放。如果不需要等比缩放
		// 则将下面的if else语句注释即可
		if (sx < sy) {
			sx = sy;
			targetW = (int) (sx * source.getWidth());
		} else {
			sy = sx;
			targetH = (int) (sy * source.getHeight());
		}
		if (type == BufferedImage.TYPE_CUSTOM) { // handmade
			ColorModel cm = source.getColorModel();
			WritableRaster raster = cm.createCompatibleWritableRaster(targetW,
					targetH);
			boolean alphaPremultiplied = cm.isAlphaPremultiplied();
			target = new BufferedImage(cm, raster, alphaPremultiplied, null);
		} else
			target = new BufferedImage(targetW, targetH, type);
		Graphics2D g = target.createGraphics();
		// smoother than exlax:
		g.setRenderingHint(RenderingHints.KEY_INTERPOLATION,
				RenderingHints.VALUE_INTERPOLATION_BICUBIC);
		g.drawRenderedImage(source, AffineTransform.getScaleInstance(sx, sy));
		g.dispose();
		return target;
	}
	/**
	 * 实现图像的等比缩放
	 * 
	 * @param source
	 * @param targetW
	 * @param targetH
	 * @return
	 */
	private static BufferedImage resizebywidth(BufferedImage source, int targetW) {
		// targetW，targetH分别表示目标长和宽
		int type = source.getType();
		BufferedImage target = null;
		double sx = (double) targetW / source.getWidth();
		// 这里想实现在targetW，targetH范围内实现等比缩放。如果不需要等比缩放
		// 则将下面的if else语句注释即可
		targetW = (int) (sx * source.getWidth());
		int height = (int) (sx * source.getHeight());
		if (type == BufferedImage.TYPE_CUSTOM) { // handmade
			ColorModel cm = source.getColorModel();
			WritableRaster raster = cm.createCompatibleWritableRaster(targetW,
					height);
			boolean alphaPremultiplied = cm.isAlphaPremultiplied();
			target = new BufferedImage(cm, raster, alphaPremultiplied, null);
		} else
			target = new BufferedImage(targetW, height, type);
		Graphics2D g = target.createGraphics();
		// smoother than exlax:
		g.setRenderingHint(RenderingHints.KEY_INTERPOLATION,
				RenderingHints.VALUE_INTERPOLATION_BICUBIC);
		g.drawRenderedImage(source, AffineTransform.getScaleInstance(sx, sx));
		g.dispose();
		return target;
	}
	public static void saveResizeImage(String inFilePath, String outFilePath,
			int width, boolean proportion) throws Exception {
		int newHeight=0;
		try {
			//JmagickHelps.createThumbnail(inFilePath,outFilePath,width);
		} catch (Exception e) {
			log.error(StringUtil.msgfmt(e));
			try{   
			    File srcfile = new File(inFilePath);   
			    if(!srcfile.exists()){   
			     System.out.println("文件不存在");   
			    }   
			    BufferedImage image = ImageIO.read(srcfile);   
		    	//获得缩放的比例   C:\nginx\imgserver\img1\201207\28d568ca-09b7-42ca-b716-751b4f07512c.jpg
			    double ratio = 1.0;   
			    //判断如果高、宽都不大于设定值，则不处理   
			    if( image.getWidth()>width){    
			      ratio =(double)  width / image.getWidth();   
			     }else{
			     }
			    //计算新的图面宽度和高度   
			    int newWidth =(int)(image.getWidth()*ratio);   
			     newHeight =(int)(image.getHeight()*ratio);   
			    BufferedImage bfImage= new BufferedImage(newWidth,newHeight,BufferedImage.TYPE_INT_RGB);   
			    bfImage.getGraphics().drawImage(image.getScaledInstance(newWidth, newHeight,Image.SCALE_SMOOTH),0,0,null);   
			       
			    FileOutputStream os = new FileOutputStream(outFilePath);   
			    JPEGImageEncoder encoder = JPEGCodec.createJPEGEncoder(os);   
			    encoder.encode(bfImage);   
			    os.close();    
			   } catch(Exception ex) {   
			    log.error(ex);   
			   }   
		}
		}
	
	public static int saveResizeImageAndWater(String inFilePath, String outFilePath,
			int width, String pressImg, float alpha) throws Exception {
		int newHeight=0;
		try {
			JmagickHelps.initLogoImg(inFilePath, outFilePath, width, pressImg);
		} catch (Exception e) {
		 try{   
			 File srcfile = new File(inFilePath);   
			    if(!srcfile.exists()){   
			     System.out.println("文件不存在");   
			     return newHeight;   
			    }   
		    	BufferedImage image = ImageIO.read(srcfile);   
		    	//获得缩放的比例   C:\nginx\imgserver\img1\201207\28d568ca-09b7-42ca-b716-751b4f07512c.jpg
			    double ratio = 1.0;   
			    //判断如果高、宽都不大于设定值，则不处理   
			    if( image.getWidth()>width){    
			      ratio =(double)  width / image.getWidth();   
			    }else{
			    	 return 0;
			     }
			    //计算新的图面宽度和高度   
			    int newWidth =(int)(image.getWidth()*ratio);   
			     newHeight =(int)(image.getHeight()*ratio);   
			    BufferedImage bfImage= new BufferedImage(newWidth,newHeight,BufferedImage.TYPE_INT_RGB);   
			   // bfImage.getGraphics().drawImage(image.getScaledInstance(newWidth, newHeight,Image.SCALE_SMOOTH),0,0,null);   
	   } catch(Exception ex) {   
	    log.error(ex);   
	   } 
	}
	   return newHeight;
		}
	/**
	 * 实现图像的等比缩放和缩放后的截取
	 * 
	 * @param inFilePath
	 *            要截取文件的路径
	 * @param outFilePath
	 *            截取后输出的路径
	 * @param width
	 *            要截取宽度
	 * @param hight
	 *            要截取的高度
	 * @param proportion
	 */
	public static void saveImageAsJpg(String inFilePath, String outFilePath,
			int width, int hight, boolean proportion) throws Exception {
		try {
			JmagickHelps.cutimg(inFilePath, outFilePath, width, hight);
		} catch (Exception e) {
			log.error(e);   
			// TODO: handle exception
			File file = new File(inFilePath);
			InputStream in = new FileInputStream(file);
			File saveFile = new File(outFilePath);

			BufferedImage srcImage = ImageIO.read(in);
			if (width > 0 || hight > 0) {
				// 原图的大小
				int sw = srcImage.getWidth();
				int sh = srcImage.getHeight();
				// 如果原图像的大小小于要缩放的图像大小，直接将要缩放的图像复制过去
				if (sw > width && sh > hight) {
					srcImage = resize(srcImage, width, hight);
				} else {
					String fileName = saveFile.getName();
					String formatName = fileName.substring(fileName
							.lastIndexOf('.') + 1);
					ImageIO.write(srcImage, formatName, saveFile);
					return;
				}
			}
			// 缩放后的图像的宽和高
			int w = srcImage.getWidth();
			int h = srcImage.getHeight();
			// 如果缩放后的图像和要求的图像宽度一样，就对缩放的图像的高度进行截取
			if (w == width) {
				// 计算X轴坐标
				int x = 0;
				int y = h / 2 - hight / 2;
				saveSubImage(srcImage, new Rectangle(x, y, width, hight), saveFile);
			}
			// 否则如果是缩放后的图像的高度和要求的图像高度一样，就对缩放后的图像的宽度进行截取
			else if (h == hight) {
				// 计算X轴坐标
				int x = w / 2 - width / 2;
				int y = 0;
				saveSubImage(srcImage, new Rectangle(x, y, width, hight), saveFile);
			}
			in.close();
		}
		
	}
	/**
	 * 实现图像的截取
	 * 
	 * @param inFilePath
	 *            要截取文件的路径
	 * @param outFilePath
	 *            截取后输出的路径
	 * @param width
	 *            要截取宽度
	 * @param hight
	 *            要截取的高度
	 * @param proportion
	 */
	public static void saveImage(String inFilePath, String outFilePath,
			int width, int hight, boolean proportion) throws Exception {
		File file = new File(inFilePath);
		InputStream in = new FileInputStream(file);
		File saveFile = new File(outFilePath);

		BufferedImage srcImage = ImageIO.read(in);
		// 图像的宽和高
		int w = srcImage.getWidth();
		int h = srcImage.getHeight();
			// 计算坐标
		int x = w / 2 - width / 2;
		int y = h / 2 - hight / 2;
		saveSubImage(srcImage, new Rectangle(x, y, width, hight), saveFile);
		in.close();
	}
	/**
	 * 实现图像的截取
	 * 
	 * @param inFilePath
	 *            要截取文件的路径
	 * @param outFilePath
	 *            截取后输出的路径
	 * @param width
	 *            要截取宽度
	 * @param hight
	 *            要截取的高度
	 * @param proportion
	 */
	public static void cutImage(String inFilePath, String outFilePath,
			int width, int hight,int x,int y) throws Exception {
		File file = new File(inFilePath);
		InputStream in = new FileInputStream(file);
		File saveFile = new File(outFilePath);

		BufferedImage srcImage = ImageIO.read(in);
			// 计算坐标
		saveSubImage(srcImage, new Rectangle(x, y, width, hight), saveFile);
		//saveResizeImage(outFilePath, outFilePath, 65, false);
		in.close();
	}
	/**
	 * 实现缩放后的截图
	 * 
	 * @param image
	 *            缩放后的图像
	 * @param subImageBounds
	 *            要截取的子图的范围
	 * @param subImageFile
	 *            要保存的文件
	 * @throws IOException
	 */
	public static void saveSubImage(BufferedImage image,
			Rectangle subImageBounds, File subImageFile) throws IOException {
		if (subImageBounds.x < 0 || subImageBounds.y < 0
				|| subImageBounds.width - subImageBounds.x > image.getWidth()
				|| subImageBounds.height - subImageBounds.y > image.getHeight()) {
			System.out.println("Bad   subimage   bounds");
			return;
		}
		BufferedImage subImage = image.getSubimage(subImageBounds.x,
				subImageBounds.y, subImageBounds.width, subImageBounds.height);
		String fileName = subImageFile.getName();
		String formatName = fileName.substring(fileName.lastIndexOf('.') + 1);
		ImageIO.write(subImage, formatName, subImageFile);
	}

	public static void reduceImg(String imgsrc, String imgdist, int widthdist,
			int heightdist) {
		try {
			File srcfile = new File(imgsrc);
			if (!srcfile.exists()) {
				return;
			}
			Image src = javax.imageio.ImageIO.read(srcfile);

			BufferedImage tag = new BufferedImage((int) widthdist,
					(int) heightdist, BufferedImage.TYPE_INT_RGB);

			tag.getGraphics().drawImage(
					src.getScaledInstance(widthdist, heightdist,
							Image.SCALE_SMOOTH), 0, 0, null);
			// / tag.getGraphics().drawImage(src.getScaledInstance(widthdist,
			// heightdist, Image.SCALE_AREA_AVERAGING), 0, 0, null);

			FileOutputStream out = new FileOutputStream(imgdist);
			JPEGImageEncoder encoder = JPEGCodec.createJPEGEncoder(out);
			encoder.encode(tag);
			out.close();

		} catch (IOException ex) {
			ex.printStackTrace();
		}
	}
	/**
	  * 图片水印
	  * @param pressImg 水印图片
	  * @param targetImg 目标图片
	  * @param x 修正值 默认在中间
	  * @param y 修正值 默认在中间
	  * @param alpha 透明度
	  */
	 public final static void pressImage(String pressImg, String targetImg, int x, int y, float alpha) {
	  try {
	   File img = new File(targetImg);
	   Image src = ImageIO.read(img);
	   int wideth = src.getWidth(null);
	   int height = src.getHeight(null);
	   BufferedImage image = new BufferedImage(wideth, height, BufferedImage.TYPE_INT_RGB);
	   Graphics2D g = image.createGraphics();
	   g.drawImage(src, 0, 0, wideth, height, null);
	   //水印文件
	   Image src_biao = ImageIO.read(new File(pressImg));
	   int wideth_biao = src_biao.getWidth(null);
	   int height_biao = src_biao.getHeight(null);
	   g.setComposite(AlphaComposite.getInstance(AlphaComposite.SRC_ATOP, alpha));
	   g.drawImage(src_biao, (wideth - wideth_biao) / 2, (height - height_biao) / 2, wideth_biao, height_biao, null);
	   //水印文件结束
	   g.dispose();
	   ImageIO.write((BufferedImage) image, "jpg", img);
	  } catch (Exception e) {
	   e.printStackTrace();
	  }
	 }
	public static void main(String[] args) {
		try {
			saveResizeImageAndWater("F:/1.jpg", "f:/2.jpg", 1000, "f:/2.png",70f);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}

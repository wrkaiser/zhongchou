package com.sys.form;
import org.apache.struts.action.ActionForm;

public class DocumentForm extends ActionForm{
	private int id;
	private String title;//文档标题',
	private String title_eng;
	private String content;//文档内容',//
	private String cid;//所属分类',
	private String img;//体标
	private String url; //url
	
	private String abst;
	
	private String tag;
	
	private String doc;
	
	private String swf;
	
	private String video;
	
	private String file;
	
	private int isrec;
	
	private String zhize;
	
	private String jingli;
	
	private String chengguo;
	
	private String ctime;
	
	
	public String getTag() {
		return tag;
	}
	public void setTag(String tag) {
		this.tag = tag;
	}
	public String getAbst() {
		return abst;
	}
	public void setAbst(String abst) {
		this.abst = abst;
	}
	private int pid;
	
	
	public int getPid() {
		return pid;
	}
	public void setPid(int pid) {
		this.pid = pid;
	}
	private String tname;
	
	
	public String getTname() {
		return tname;
	}
	public void setTname(String tname) {
		this.tname = tname;
	}
	private int pos;
	
	public int getPos() {
		return pos;
	}
	public void setPos(int pos) {
		this.pos = pos;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getCid() {
		return cid;
	}
	public void setCid(String cid) {
		this.cid = cid;
	}
	public String getImg() {
		return img;
	}
	public void setImg(String img) {
		this.img = img;
	}
	public String getDoc() {
		return doc;
	}
	public void setDoc(String doc) {
		this.doc = doc;
	}
	public String getSwf() {
		return swf;
	}
	public void setSwf(String swf) {
		this.swf = swf;
	}
	public String getVideo() {
		return video;
	}
	public void setVideo(String video) {
		this.video = video;
	}
	public String getFile() {
		return file;
	}
	public void setFile(String file) {
		this.file = file;
	}
	public int getIsrec() {
		return isrec;
	}
	public void setIsrec(int isrec) {
		this.isrec = isrec;
	}
	public String getZhize() {
		return zhize;
	}
	public void setZhize(String zhize) {
		this.zhize = zhize;
	}
	public String getJingli() {
		return jingli;
	}
	public void setJingli(String jingli) {
		this.jingli = jingli;
	}
	public String getChengguo() {
		return chengguo;
	}
	public void setChengguo(String chengguo) {
		this.chengguo = chengguo;
	}
	public String getCtime() {
		return ctime;
	}
	public void setCtime(String ctime) {
		this.ctime = ctime;
	}
	public String getTitle_eng() {
		return title_eng;
	}
	public void setTitle_eng(String title_eng) {
		this.title_eng = title_eng;
	}
}

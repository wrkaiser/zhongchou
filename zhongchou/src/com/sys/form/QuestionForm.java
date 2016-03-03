package com.sys.form;
import org.apache.struts.action.ActionForm;

public class QuestionForm extends ActionForm{
	private int id;
	private String type;//0判断1选择2填空',
	private String question;//` varchar(1000) default NULL COMMENT '问题',
	private String answer;//` tinyint(1) default NULL COMMENT '答案',
	private String item1;//` varchar(1000) default NULL,
	private String item2;//` varchar(1000) default NULL,
	private String item3;//` varchar(1000) default NULL,
	private String item4;//` varchar(1000) default NULL,
	private String expain;//` varchar(1000) default NULL COMMENT '解释',
	private String cid;//所属题库
	private String qno;//题号
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getQuestion() {
		return question;
	}
	public void setQuestion(String question) {
		this.question = question;
	}
	public String getAnswer() {
		return answer;
	}
	public void setAnswer(String answer) {
		this.answer = answer;
	}
	public String getItem1() {
		return item1;
	}
	public void setItem1(String item1) {
		this.item1 = item1;
	}
	public String getItem2() {
		return item2;
	}
	public void setItem2(String item2) {
		this.item2 = item2;
	}
	public String getItem3() {
		return item3;
	}
	public void setItem3(String item3) {
		this.item3 = item3;
	}
	public String getItem4() {
		return item4;
	}
	public void setItem4(String item4) {
		this.item4 = item4;
	}
	public String getExpain() {
		return expain;
	}
	public void setExpain(String expain) {
		this.expain = expain;
	}
	public String getCid() {
		return cid;
	}
	public void setCid(String cid) {
		this.cid = cid;
	}
	public String getQno() {
		return qno;
	}
	public void setQno(String qno) {
		this.qno = qno;
	}
	
}

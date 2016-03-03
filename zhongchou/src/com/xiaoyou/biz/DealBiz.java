package com.xiaoyou.biz;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.xiaoyou.dao.BaseDao;
import com.xiaoyou.data.PageInfo;

public class DealBiz {
	/*
	 * 获取众筹中项目列表
	 */
	public List getZhongChouList(String catid, String status, PageInfo pageinfo)
			throws Exception {
		String sql = "";
		BaseDao dao = new BaseDao();
		List<Map> list = new ArrayList<Map>();
		if (status == null || "".equals(status)) {
			if (catid != null && !"".equals(catid)) {

				pageinfo.setQueryStr("( zh_pros.ischecked=2 or zh_pros.ischecked =3) and zh_pros.proid=zh_pro_cat.proid and  zh_pro_cat.catid=wei_common_type.id and wei_common_type.id="
						+ catid +" order by zh_pros.tsort desc");
				list = dao.getListByPage("zh_pros,zh_pro_cat,wei_common_type",
						"zh_pros.* ", pageinfo);
			}else {

				pageinfo.setQueryStr(" ischecked=2 or ischecked =3");
				list = dao.getListByPage("zh_pros", "* ", pageinfo);

			}
		}
		else if (status != null && status.equals("zxsx")) {
			if (catid != null && !"".equals(catid)) {

				pageinfo.setQueryStr("( zh_pros.ischecked=2 or zh_pros.ischecked =3) and zh_pros.proid=zh_pro_cat.proid and  zh_pro_cat.catid=wei_common_type.id and wei_common_type.id="
						+ catid + " order by  zh_pros.tsort desc ,zh_pros.addtime desc");
				list = dao.getListByPage("zh_pros,zh_pro_cat,wei_common_type",
						"zh_pros.* ", pageinfo);

			}else{

				pageinfo.setQueryStr(" ischecked=2 or ischecked =3 order by zh_pros.tsort desc ,zh_pros.addtime desc ");
				list = dao.getListByPage("zh_pros", "* ", pageinfo);

			}

		}

		else if (status != null && status.equals("zgje")) {

			if (catid != null && !"".equals(catid)) {

				pageinfo.setQueryStr("( zh_pros.ischecked=2 or zh_pros.ischecked =3) and zh_pros.proid=zh_pro_cat.proid and  zh_pro_cat.catid=wei_common_type.id and wei_common_type.id="
						+ catid + " order by zh_pros.tsort desc ,  zh_pros.financialneeds desc");
				list = dao.getListByPage("zh_pros,zh_pro_cat,wei_common_type",
						"zh_pros.* ", pageinfo);

			}else {

				pageinfo.setQueryStr(" ischecked=2 or ischecked =3 order by tsort desc ,financialneeds  desc");
				list = dao.getListByPage("zh_pros", "* ", pageinfo);

			}

		}
		else if (status != null && status.equals("zdzcrs")) {

			if (catid != null && !"".equals(catid)) {

				pageinfo.setQueryStr("( zh_pros.ischecked=2 or zh_pros.ischecked =3) and zh_pros.proid=zh_pro_cat.proid and  zh_pro_cat.catid=wei_common_type.id and wei_common_type.id="
						+ catid
						+ " order by zh_pros.tsort desc ,(select count(*) from zh_pro_orders where  zh_pro_orders.proid=zh_pros.proid) desc");
				list = dao.getListByPage("zh_pros,zh_pro_cat,wei_common_type",
						"zh_pros.* ", pageinfo);
			}else{

				pageinfo.setQueryStr(" ischecked=2 or ischecked =3 order by zh_pros.tsort desc ,(select count(*) from zh_pro_orders where  zh_pro_orders.proid=zh_pros.proid) desc ");
				list = dao.getListByPage("zh_pros", "* ", pageinfo);

			}

		}
		else {

			if (catid != null && !"".equals(catid)) {

				pageinfo.setQueryStr("( zh_pros.ischecked=2 or zh_pros.ischecked =3) and zh_pros.proid=zh_pro_cat.proid and  zh_pro_cat.catid=wei_common_type.id and wei_common_type.id="
						+ catid
						+ " order by zh_pros.tsort desc , (select count(money) from zh_pro_orders where  zh_pro_orders.proid=zh_pros.proid) desc");
				list = dao.getListByPage("zh_pros,zh_pro_cat,wei_common_type",
						"zh_pros.* ", pageinfo);

			}else {

				pageinfo.setQueryStr(" ischecked=2 or ischecked =3 order by zh_pros.tsort desc ,(select count(money) from zh_pro_orders where  zh_pro_orders.proid=zh_pros.proid) desc ");
				list = dao.getListByPage("zh_pros", "* ", pageinfo);

			}
		}
		for (Map ma : list) {
			String proid = (String) ma.get("proid");
			String financialneeds = (String) ma.get("financialneeds");
			sql = "select sum(money) as money from  zh_pro_orders where proid="
					+ proid;
			Map aa = dao.queryone(sql);
			int m;
			double z;
			String money;
			if (aa.get("money") == null) {
				m = 0;
				z = 0;
			} else {
				money = aa.get("money").toString();
				z = Double.parseDouble(money);
				m = (int) z;
			}
			// int n = Integer.parseInt(financialneeds);
			double n = Double.parseDouble(financialneeds);
			double q = (z * 100) / n;
			int bili = (int) Math.ceil(q);
			// m = new StringBuilder(m).reverse().toString(); // 先将字符串颠倒顺序
			// String str = "";
			// for (int i = 0; i < m.length(); i++) {
			// if (i * 3 + 3 > m.length()) {
			// str += m.substring(i * 3, m.length());
			// break;
			// }
			// str += str.substring(i * 3, i * 3 + 3) + ",";
			// }
			// if (str.endsWith(",")) {
			// str = str.substring(0, str.length() - 1);
			// }
			// 最后再将顺序反转过来
			// m = new StringBuilder(str).reverse().toString();
			ma.put("money", m);
			ma.put("bili", bili);
		}
		return list;
	}

	/*
	 * 获取所有项目列表
	 */
	public List getAllProsList(String catid, String status, PageInfo pageinfo)
			throws Exception {
		String sql = "";
		BaseDao dao = new BaseDao();
		List<Map> list = new ArrayList<Map>();
		if (status == null || "".equals(status)) {
			if (catid != null && !"".equals(catid)) {

				pageinfo.setQueryStr("( zh_pros.ischecked=2 or zh_pros.ischecked =3 or zh_pros.ischecked =4) and zh_pros.proid=zh_pro_cat.proid and  zh_pro_cat.catid=wei_common_type.id and wei_common_type.id="
						+ catid+" order by  zh_pros.tsort desc ");
				list = dao.getListByPage("zh_pros,zh_pro_cat,wei_common_type",
						"zh_pros.* ", pageinfo);

			}else {

				pageinfo.setQueryStr(" ischecked=2 or ischecked =3 or zh_pros.ischecked =4 order by tsort desc");
				list = dao.getListByPage("zh_pros", "* ", pageinfo);

			}
		}
		else if (status != null && status.equals("zxsx")) {
			if (catid != null && !"".equals(catid)) {

				pageinfo.setQueryStr("( zh_pros.ischecked=2 or zh_pros.ischecked =3 or zh_pros.ischecked =4) and zh_pros.proid=zh_pro_cat.proid and  zh_pro_cat.catid=wei_common_type.id and wei_common_type.id="
						+ catid + " order by  zh_pros.tsort desc, zh_pros.addtime desc");
				list = dao.getListByPage("zh_pros,zh_pro_cat,wei_common_type",
						"zh_pros.* ", pageinfo);

			}else {

				pageinfo.setQueryStr(" ischecked=2 or ischecked =3  or zh_pros.ischecked =4 order by  zh_pros.tsort desc,zh_pros.addtime desc");
				list = dao.getListByPage("zh_pros", "* ", pageinfo);

			}

		}

		else if (status != null && status.equals("zgje")) {

			if (catid != null && !"".equals(catid)) {

				pageinfo.setQueryStr("( zh_pros.ischecked=2 or zh_pros.ischecked =3 or zh_pros.ischecked =4) and zh_pros.proid=zh_pro_cat.proid and  zh_pro_cat.catid=wei_common_type.id and wei_common_type.id="
						+ catid + " order by  zh_pros.tsort desc ,zh_pros.financialneeds desc");
				list = dao.getListByPage("zh_pros,zh_pro_cat,wei_common_type",
						"zh_pros.* ", pageinfo);

			}else {

				pageinfo.setQueryStr(" ischecked=2 or ischecked =3  or zh_pros.ischecked =4 order by zh_pros.tsort desc ,zh_pros.financialneeds  desc");
				list = dao.getListByPage("zh_pros", "* ", pageinfo);

			}

		}
		else if (status != null && status.equals("zdzcrs")) {

			if (catid != null && !"".equals(catid)) {

				pageinfo.setQueryStr("( zh_pros.ischecked=2 or zh_pros.ischecked =3 or zh_pros.ischecked =4) and zh_pros.proid=zh_pro_cat.proid and  zh_pro_cat.catid=wei_common_type.id and wei_common_type.id="
						+ catid
						+ " order by zh_pros.tsort desc ,(select count(*) from zh_pro_orders where  zh_pro_orders.proid=zh_pros.proid) desc");
				list = dao.getListByPage("zh_pros,zh_pro_cat,wei_common_type",
						"zh_pros.* ", pageinfo);
			}else{

				pageinfo.setQueryStr(" ischecked=2 or ischecked =3 or zh_pros.ischecked =4  order by zh_pros.tsort desc ,(select count(*) from zh_pro_orders where  zh_pro_orders.proid=zh_pros.proid) desc ");
				list = dao.getListByPage("zh_pros", "* ", pageinfo);

			}

		}
		else {

			if (catid != null && !"".equals(catid)) {

				pageinfo.setQueryStr("( zh_pros.ischecked=2 or zh_pros.ischecked =3 or zh_pros.ischecked =4) and zh_pros.proid=zh_pro_cat.proid and  zh_pro_cat.catid=wei_common_type.id and wei_common_type.id="
						+ catid
						+ " order by zh_pros.tsort desc ,(select count(money) from zh_pro_orders where  zh_pro_orders.proid=zh_pros.proid) desc");
				list = dao.getListByPage("zh_pros,zh_pro_cat,wei_common_type",
						"zh_pros.* ", pageinfo);

			}else {

				pageinfo.setQueryStr(" ischecked=2 or ischecked =3  or zh_pros.ischecked =4 order by zh_pros.tsort desc ,(select count(money) from zh_pro_orders where  zh_pro_orders.proid=zh_pros.proid) desc ");
				list = dao.getListByPage("zh_pros", "* ", pageinfo);

			}
		}
		for (Map ma : list) {
			String proid = (String) ma.get("proid");
			String financialneeds = (String) ma.get("financialneeds");
			sql = "select sum(money) as money from  zh_pro_orders where proid="
					+ proid;
			Map aa = dao.queryone(sql);
			int m;
			double z;
			String money;
			if (aa.get("money") == null) {
				m = 0;
				z = 0;
			} else {
				money = aa.get("money").toString();
				z = Double.parseDouble(money);
				m = (int) z;
			}
			// int n = Integer.parseInt(financialneeds);
			double n = Double.parseDouble(financialneeds);
			double q = (z * 100) / n;
			int bili = (int) Math.ceil(q);
			// m = new StringBuilder(m).reverse().toString(); // 先将字符串颠倒顺序
			// String str = "";
			// for (int i = 0; i < m.length(); i++) {
			// if (i * 3 + 3 > m.length()) {
			// str += m.substring(i * 3, m.length());
			// break;
			// }
			// str += str.substring(i * 3, i * 3 + 3) + ",";
			// }
			// if (str.endsWith(",")) {
			// str = str.substring(0, str.length() - 1);
			// }
			// // 最后再将顺序反转过来
			// m = new StringBuilder(str).reverse().toString();
			ma.put("money", m);
			ma.put("bili", bili);
		}
		return list;
	}

	/*
	 * 获取结束项目（成功项目）列表
	 */
	public List getSuccessedList(String catid, String status, PageInfo pageinfo)
			throws Exception {
		String sql = "";
		BaseDao dao = new BaseDao();
		List<Map> list = new ArrayList<Map>();
		if (status == null || "".equals(status)) {
			if (catid != null && !"".equals(catid)) {

				pageinfo.setQueryStr("(zh_pros.ischecked =4) and zh_pros.proid=zh_pro_cat.proid and  zh_pro_cat.catid=wei_common_type.id and wei_common_type.id="
						+ catid+" order by zh_pros.tsort desc ");
				list = dao.getListByPage("zh_pros,zh_pro_cat,wei_common_type",
						"zh_pros.* ", pageinfo);

			}else {

				pageinfo.setQueryStr(" zh_pros.ischecked =4 order by zh_pros.tsort desc");
				list = dao.getListByPage("zh_pros", "* ", pageinfo);

			}
		}
		else if (status != null && status.equals("zxsx")) {
			if (catid != null && !"".equals(catid)) {

				pageinfo.setQueryStr("(zh_pros.ischecked =4) and zh_pros.proid=zh_pro_cat.proid and  zh_pro_cat.catid=wei_common_type.id and wei_common_type.id="
						+ catid + " order by zh_pros.tsort desc, zh_pros.addtime desc");
				list = dao.getListByPage("zh_pros,zh_pro_cat,wei_common_type",
						"zh_pros.* ", pageinfo);

			}else {

				pageinfo.setQueryStr(" zh_pros.ischecked =4 order by zh_pros.tsort desc, zh_pros.addtime desc");
				list = dao.getListByPage("zh_pros", "* ", pageinfo);

			}

		}

		else if (status != null && status.equals("zgje")) {

			if (catid != null && !"".equals(catid)) {

				pageinfo.setQueryStr("(zh_pros.ischecked =4) and zh_pros.proid=zh_pro_cat.proid and  zh_pro_cat.catid=wei_common_type.id and wei_common_type.id="
						+ catid + " order by zh_pros.tsort desc, zh_pros.financialneeds desc");
				list = dao.getListByPage("zh_pros,zh_pro_cat,wei_common_type",
						"zh_pros.* ", pageinfo);

			}else {

				pageinfo.setQueryStr(" zh_pros.ischecked =4 order by  zh_pros.tsort desc, zh_pros.financialneeds  desc");
				list = dao.getListByPage("zh_pros", "* ", pageinfo);

			}

		}
		else if (status != null && status.equals("zdzcrs")) {

			if (catid != null && !"".equals(catid)) {

				pageinfo.setQueryStr("(zh_pros.ischecked =4) and zh_pros.proid=zh_pro_cat.proid and  zh_pro_cat.catid=wei_common_type.id and wei_common_type.id="
						+ catid
						+ " order by zh_pros.tsort desc,(select count(*) from zh_pro_orders where  zh_pro_orders.proid=zh_pros.proid) desc");
				list = dao.getListByPage("zh_pros,zh_pro_cat,wei_common_type",
						"zh_pros.* ", pageinfo);
			}else  {

				pageinfo.setQueryStr(" zh_pros.ischecked =4  order by zh_pros.tsort desc,(select count(*) from zh_pro_orders where  zh_pro_orders.proid=zh_pros.proid) desc ");
				list = dao.getListByPage("zh_pros", "* ", pageinfo);

			}

		}
		else  {

			if (catid != null && !"".equals(catid)) {

				pageinfo.setQueryStr("(zh_pros.ischecked =4) and zh_pros.proid=zh_pro_cat.proid and  zh_pro_cat.catid=wei_common_type.id and wei_common_type.id="
						+ catid
						+ " order by zh_pros.tsort desc,(select count(money) from zh_pro_orders where  zh_pro_orders.proid=zh_pros.proid) desc");
				list = dao.getListByPage("zh_pros,zh_pro_cat,wei_common_type",
						"zh_pros.* ", pageinfo);

			}else {

				pageinfo.setQueryStr(" zh_pros.ischecked =4 order by zh_pros.tsort desc,(select count(money) from zh_pro_orders where  zh_pro_orders.proid=zh_pros.proid) desc ");
				list = dao.getListByPage("zh_pros", "* ", pageinfo);

			}
		}
		for (Map ma : list) {
			String proid = (String) ma.get("proid");
			String financialneeds = (String) ma.get("financialneeds");
			sql = "select sum(money) as money from  zh_pro_orders where proid="
					+ proid;
			Map aa = dao.queryone(sql);
			int m;
			double z;
			String money;
			if (aa.get("money") == null) {
				m = 0;
				z = 0;
			} else {
				money = aa.get("money").toString();
				z = Double.parseDouble(money);
				m = (int) z;
			}
			// int n = Integer.parseInt(financialneeds);
			double n = Double.parseDouble(financialneeds);
			double q = (z * 100) / n;
			int bili = (int) Math.ceil(q);
			// m = new StringBuilder(m).reverse().toString(); // 先将字符串颠倒顺序
			// String str = "";
			// for (int i = 0; i < m.length(); i++) {
			// if (i * 3 + 3 > m.length()) {
			// str += m.substring(i * 3, m.length());
			// break;
			// }
			// str += str.substring(i * 3, i * 3 + 3) + ",";
			// }
			// if (str.endsWith(",")) {
			// str = str.substring(0, str.length() - 1);
			// }
			// // 最后再将顺序反转过来
			// m = new StringBuilder(str).reverse().toString();
			ma.put("money", m);
			ma.put("bili", bili);
		}
		return list;
	}

	/*
	 * 获取审核中（即将开始）项目的列表
	 */
	public List getWillStartList(String catid, String status, PageInfo pageinfo)
			throws Exception {
		String sql = "";
		BaseDao dao = new BaseDao();
		List<Map> list = new ArrayList<Map>();
		if (status == null || "".equals(status)) {
			if (catid != null && !"".equals(catid)) {

				pageinfo.setQueryStr("(zh_pros.ischecked =1) and zh_pros.proid=zh_pro_cat.proid and  zh_pro_cat.catid=wei_common_type.id and wei_common_type.id="
						+ catid + "");
				list = dao.getListByPage("zh_pros,zh_pro_cat,wei_common_type",
						"zh_pros.* ", pageinfo);

			}else{

				pageinfo.setQueryStr(" zh_pros.ischecked =1");
				list = dao.getListByPage("zh_pros", "* ", pageinfo);

			}
		}
		else if (status != null && status.equals("zxsx")) {
			if (catid != null && !"".equals(catid)) {

				pageinfo.setQueryStr("(zh_pros.ischecked =1) and zh_pros.proid=zh_pro_cat.proid and  zh_pro_cat.catid=wei_common_type.id and wei_common_type.id="
						+ catid + " order by zh_pros.addtime");
				list = dao.getListByPage("zh_pros,zh_pro_cat,wei_common_type",
						"zh_pros.* ", pageinfo);

			}else {

				pageinfo.setQueryStr(" zh_pros.ischecked =1 order by zh_pros.addtime");
				list = dao.getListByPage("zh_pros", "* ", pageinfo);

			}

		}

		else if (status != null && status.equals("zgje")) {

			if (catid != null && !"".equals(catid)) {

				pageinfo.setQueryStr("(zh_pros.ischecked =1) and zh_pros.proid=zh_pro_cat.proid and  zh_pro_cat.catid=wei_common_type.id and wei_common_type.id="
						+ catid + " order by zh_pros.financialneeds desc");
				list = dao.getListByPage("zh_pros,zh_pro_cat,wei_common_type",
						"zh_pros.* ", pageinfo);

			}else {

				pageinfo.setQueryStr(" zh_pros.ischecked =1 order by zh_pros.financialneeds  desc");
				list = dao.getListByPage("zh_pros", "* ", pageinfo);

			}

		}
		else if (status != null && status.equals("zdzcrs")) {

			if (catid != null && !"".equals(catid)) {

				pageinfo.setQueryStr("(zh_pros.ischecked =1) and zh_pros.proid=zh_pro_cat.proid and  zh_pro_cat.catid=wei_common_type.id and wei_common_type.id="
						+ catid
						+ " order by (select count(*) from zh_pro_orders where  zh_pro_orders.proid=zh_pros.proid) desc");
				list = dao.getListByPage("zh_pros,zh_pro_cat,wei_common_type",
						"zh_pros.* ", pageinfo);
			}else{

				pageinfo.setQueryStr(" zh_pros.ischecked =1  order by (select count(*) from zh_pro_orders where  zh_pro_orders.proid=zh_pros.proid) desc ");
				list = dao.getListByPage("zh_pros", "* ", pageinfo);

			}

		}
		else {

			if (catid != null && !"".equals(catid)) {

				pageinfo.setQueryStr("(zh_pros.ischecked =1) and zh_pros.proid=zh_pro_cat.proid and  zh_pro_cat.catid=wei_common_type.id and wei_common_type.id="
						+ catid
						+ " order by (select count(money) from zh_pro_orders where  zh_pro_orders.proid=zh_pros.proid) desc");
				list = dao.getListByPage("zh_pros,zh_pro_cat,wei_common_type",
						"zh_pros.* ", pageinfo);

			}else{

				pageinfo.setQueryStr(" zh_pros.ischecked =1 order by (select count(money) from zh_pro_orders where  zh_pro_orders.proid=zh_pros.proid) desc ");
				list = dao.getListByPage("zh_pros", "* ", pageinfo);

			}
		}
		for (Map ma : list) {
			String proid = (String) ma.get("proid");
			String financialneeds = (String) ma.get("financialneeds");
			sql = "select sum(money) as money from  zh_pro_orders where proid="
					+ proid;
			Map aa = dao.queryone(sql);
			int m;
			double z;
			String money;
			if (aa.get("money") == null) {
				m = 0;
				z = 0;
			} else {
				money = aa.get("money").toString();
				z = Double.parseDouble(money);
				m = (int) z;
			}
			// int n = Integer.parseInt(financialneeds);
			double n = Double.parseDouble(financialneeds);
			double q = (z * 100) / n;
			int bili = (int) Math.ceil(q);
    
			ma.put("money", m);
			ma.put("bili", bili);
		}
		return list;
	}

	/*
	 * 获取项目分类名字
	 */
	public List getTypeName() throws Exception {
		String sql = "";
		BaseDao dao = new BaseDao();
		sql = "select * from wei_common_type where type=18";
		List<Map> cate = dao.getList(sql);
		return cate;
	}

	/*
	 * 获取所有项目数量
	 */
	public String getAll() throws Exception {
		String sql = "";
		BaseDao dao = new BaseDao();
		sql = "select count(*) as cou from zh_pros where ischecked=1 or ischecked=2 or ischecked =3 or ischecked =4";
		Map a = dao.queryone(sql);
		String count = a.get("cou").toString();

		return count;
	}

	/*
	 * 获取众筹中项目数量
	 */
	public String getZhongChouing() throws Exception {
		String sql = "";
		BaseDao dao = new BaseDao();
		sql = "select count(*) as cou from zh_pros where ischecked=1 or ischecked=2 or ischecked =3";
		Map a = dao.queryone(sql);
		String count = a.get("cou").toString();

		return count;
	}

	/*
	 * 获取结束（成功）项目的数量
	 */
	public String getSuccessed() throws Exception {
		String sql = "";
		BaseDao dao = new BaseDao();
		sql = "select count(*) as cou from zh_pros where  ischecked =4";
		Map a = dao.queryone(sql);
		String count = a.get("cou").toString();
		return count;
	}

	/*
	 * 获取即将开始的项目的数量
	 */
	public String getWillStart() throws Exception {
		String sql = "";
		BaseDao dao = new BaseDao();
		sql = "select count(*) as cou from zh_pros where  ischecked =1";
		Map a = dao.queryone(sql);
		String count = a.get("cou").toString();

		return count;
	}
/*
 * 用户已登录的项目详细页
 * 
 */
	public Map getProDetail(String proid, String userid) throws Exception {
		String sql = "";
		BaseDao dao = new BaseDao();
		sql = "select * , FROM_UNIXTIME(addtime, '%Y-%m-%d') addtime from zh_pros where proid="
				+ proid;
		Map map = dao.queryone(sql);
		String userid1 = map.get("userid").toString();
		sql = "select username,headimg from zh_users  where userid=" + userid1;
		String username = dao.queryone(sql).get("username").toString();
		String headimg = dao.queryone(sql).get("headimg").toString();
		map.put("username", username);
		map.put("headimg", headimg);
		sql = "select sum(money) money ,count(*) count from zh_pro_orders where proid="
				+ proid;
		String money = dao.queryone(sql).get("money").toString();
		String count = dao.queryone(sql).get("count").toString();
		map.put("money", money);
		map.put("count", count);
		sql = "select wei_common_type.name  from zh_pros ,zh_pro_cat,wei_common_type where zh_pros.proid=zh_pro_cat.proid and zh_pro_cat.catid=wei_common_type.id and zh_pros.proid="
				+ proid;
		List<Map> list=dao.querymoreC(sql);
		String typename="";
		for(Map ma: list){
			String tname=ma.get("name").toString();
			typename=typename+tname+"  &nbsp;";
		}
		
		map.put("typename", typename);
		/*sql = "select count(*) collects from zh_pros, zh_pro_collects where zh_pros.proid=zh_pro_collects.proid and zh_pro_collects.proid="
				+ proid;
		String collects = dao.queryone(sql).get("collects").toString();
		map.put("collects", collects);*/
		sql = "select count(*) cou from zh_pro_collects where proid=" + proid
				+ " and userid=" + userid;
		String iscollect = dao.queryone(sql).get("cou").toString();
		int c = Integer.parseInt(iscollect);
		if (c == 1) {
			map.put("iscollect", 1);
		} else {
			map.put("iscollect", 0);
		}
		double z;
		double x = Double.parseDouble(map.get("financialneeds").toString());
		double y = Double.parseDouble(map.get("money").toString());
		z = (y * 100) / x;
		int bili = (int) Math.ceil(z);
		map.put("bili", bili);
		return map;
	}
/*
 *   未登录的项目详细页
 * 
 */
	public Map getProDetail(String proid) throws Exception {
		String sql = "";
		BaseDao dao = new BaseDao();
		sql = "select * , FROM_UNIXTIME(addtime, '%Y-%m-%d') addtime from zh_pros where proid="
				+ proid;
		Map map = dao.queryone(sql);
		String userid = map.get("userid").toString();
		sql = "select username,headimg from zh_users  where userid=" + userid;
		String username = dao.queryone(sql).get("username").toString();
		String headimg = dao.queryone(sql).get("headimg").toString();
		map.put("username", username);
		map.put("headimg", headimg);
		sql = "select sum(money) money ,count(*) count from zh_pro_orders where proid="
				+ proid;
		String money = dao.queryone(sql).get("money").toString();
		String count = dao.queryone(sql).get("count").toString();
		map.put("money", money);
		map.put("count", count);
		sql = "select wei_common_type.name  from zh_pros ,zh_pro_cat,wei_common_type where zh_pros.proid=zh_pro_cat.proid and zh_pro_cat.catid=wei_common_type.id and zh_pros.proid="
				+ proid;
		List<Map> list=dao.querymoreC(sql);
		String typename="";
		for(Map ma: list){
			String tname=ma.get("name").toString();
			typename=typename+tname+"  &nbsp;";
		}
		map.put("typename", typename);
		/*sql = "select count(*) collects from zh_pros, zh_pro_collects where zh_pros.proid=zh_pro_collects.proid and zh_pro_collects.proid="
				+ proid;
		String collects = dao.queryone(sql).get("collects").toString();
		map.put("collects", collects);*/

		double z;
		double x = Double.parseDouble(map.get("financialneeds").toString());
		double y = Double.parseDouble(map.get("money").toString());
		z = (y * 100) / x;
		int bili = (int) Math.ceil(z);
		map.put("bili", bili);
		return map;
	}
/*
 * 投资人(预定人)列表
 * 
 */
	public List getOrderDetail(String proid) throws Exception {

		String sql = "";
		BaseDao dao = new BaseDao();
		sql = "select * ,FROM_UNIXTIME(addtime, '%Y-%m-%d') addtime  from zh_pro_orders where proid="
				+ proid + " order by money desc";
		List<Map> list = dao.getList(sql);
		for (Map ma : list) {
			String userid = ma.get("userid").toString();
			sql = "select username ,headimg  from zh_users where userid="
					+ userid;
			String username = dao.queryone(sql).get("username").toString();
			String headimg = dao.queryone(sql).get("headimg").toString();
			ma.put("username", username);
			ma.put("headimg", headimg);
		}
		return list;
	}
/*
 * 获取项目的描述图片
 */
	public List getProPicture(String proid) throws Exception {
		String sql = "";
		BaseDao dao = new BaseDao();
		sql = "select * from zh_pros where proid=" + proid;
		String project_album = dao.queryone(sql).get("project_album")
				.toString();
		//System.out.println(project_album);
		String[] picture = project_album.split(",");
		List<String> list1 = new ArrayList();
		for (int i = 0; i < picture.length; i++) {
			list1.add(picture[i]);
		}

		return list1;
	}
/*
 * 点击关注更新数据库操作
 * 
 */
	public void getProCollects(String proid, String userid) throws Exception {
		String sql = "";
		BaseDao dao = new BaseDao();
		sql = "select count(*) count from zh_pro_collects where proid=" + proid
				+ " and userid=" + userid;
		String count = dao.queryone(sql).get("count").toString();
		int c = Integer.parseInt(count);
		if (c == 0) {
			sql = "insert into zh_pro_collects (userid,addtime,proid) values("
					+ userid + ",unix_timestamp() ," + proid + ")";
			dao.update(sql);
			sql="update zh_pros set loves=loves+1 where proid="+proid;
			dao.update(sql);
		}
		if (c == 1) {
			sql = "delete  from zh_pro_collects where proid=" + proid
					+ " and userid =" + userid;
			dao.delete(sql);
			sql="update zh_pros set loves=loves-1 where proid="+proid;
			dao.update(sql);
		}

	}
	/*
	 * 获取团队成员信息
	 * 
	 */
	public  List getTeamMember(String proid) throws Exception {
		 String sql="";
		 BaseDao dao=new BaseDao();
		 sql="select * from zh_pro_teams where proid="+proid;
		 List<Map> list=dao.getList(sql);
		 return list;
	}
	/*
	 * 对某个项目添加评论或提问
	 * 
	 */
	public void insertComm(String proid,String userid,String content) throws Exception{
		BaseDao dao=new BaseDao();
		String sql="";
		sql="insert into  zh_comms (proid,userid,addtime ,commcontent) values("+proid+","+userid+", unix_timestamp() ,'"+content+"')";   
		dao.update(sql);
		sql="update zh_pros set comms=comms+1 where proid="+proid; 
		dao.update(sql);
				
	    
	}
	/*
	 * 回复提问，只能该项目发起者才能对该项目的提问进行回答
	 * 
	 * 
	 */
	public void insertComm(String proid,String userid,String content,String id) throws Exception{
		BaseDao dao=new BaseDao();
		String sql="insert into  zh_comms (proid,userid,addtime ,commcontent,toid) values("+proid+","+userid+", unix_timestamp() ,'"+content+"',"+id+")";   
		dao.update(sql);
	}
	/*
	 * 获取提问回复列表
	 * 
	 */
	public List getCommList(String proid, PageInfo pageinfo) throws Exception{
		String sql="";
		BaseDao dao=new BaseDao();
		pageinfo.setQueryStr("proid="+proid+" and toid is null order by addtime desc");
		List<Map>  list = dao.getListByPage("zh_comms",
				"*,from_unixtime(addtime,'%y-%m-%d') addtime1 ", pageinfo);	
		for (Map ma:list){
			String id=ma.get("id").toString();
			String userid=ma.get("userid").toString();
			sql="select * from zh_users where userid="+userid;
		    Map m=dao.queryone(sql);
			String username=m.get("username").toString();
			String headimg=m.get("headimg").toString();
			ma.put("username", username);
			ma.put("headimg", headimg);
			sql="select * ,from_unixtime(addtime,'%y-%m-%d') addtime from zh_comms where toid="+id;
			Map map=dao.queryone(sql);
			if(map!=null){
			String tocomm=map.get("commcontent").toString();
			String answertime=map.get("addtime").toString();
			ma.put("answertime", answertime);
			ma.put("tocomm", tocomm);	
			}else{
				ma.put("answertime", "");
				ma.put("tocomm", "");	
			}
		}
		return list;
	}
	/*
	 * 获取发起人的id
	 * 
	 */
	public String getProUserid(String proid) throws Exception{
		 BaseDao dao=new BaseDao();
		 String sql="select userid from zh_pros where proid="+proid;
		String prouserid=dao.queryone(sql).get("userid").toString();
		 return prouserid;
	}
	/*
	 *判断是否预约
	 * 
	 * 
	 */
	public Boolean login(String userid,String proid) throws Exception{
		 BaseDao dao=new BaseDao();
		 String sql="select count(*) count from zh_pro_orders where userid="+userid+" and proid="+proid;
		 Map map=dao.queryone(sql);
		 String count=map.get("count").toString();
		 int c=Integer.parseInt(count);
		 if(c==1)
		 {
			 return true;
		 }else{
			 return false;
		 }

	}
	/*
	 * 添加预约或者变更雨夜
	 * 
	 * 
	 */
	public void addOrder(String proid,String userid ,String money,String comm) throws Exception{
		String sql="";
		BaseDao dao=new BaseDao();
		sql="select count(*) count from zh_pro_orders  where  proid="+proid+" and userid="+userid;
		String count=dao.queryone(sql).get("count").toString();
		int cou=Integer.parseInt(count);
		if(cou==0){
		 sql="insert into zh_pro_orders (userid,proid,addtime,money,comm) values("+userid+","+proid+", unix_timestamp() ,"+
		            money+",'"+comm+"')";
		}else{
		 sql="update  zh_pro_orders set money="+money+" ,comm='"+comm+"' where proid="+proid+" and userid="+userid;
		}
		dao.update(sql);
		
		
		  
	}
	/*
	 *  取消预约
	 * 
	 */
	public void cancelOrder(String proid,String userid) throws Exception{
		  
		BaseDao dao=new BaseDao();
		String sql="delete from  zh_pro_orders where proid="+proid+" and userid="+userid;
		dao.delete(sql);
		  
	}
	/*
	 * 获取项目融资需求金额
	 * 
	 */
	public String  getFinancialneeds(String proid) throws Exception{
		  
		BaseDao dao=new BaseDao();
		String sql="select financialneeds from zh_pros where proid="+proid;
		String financialneeds=dao.queryone(sql).get("financialneeds").toString();
		return financialneeds;
		  
	}
	/*
	 * 获取项目预约最低投资金额
	 * 
	 */
	public String  getMininvestment(String proid) throws Exception{
		  
		BaseDao dao=new BaseDao();
		String sql="select mininvestment from zh_pros where proid="+proid;
		String mininvestment=dao.queryone(sql).get("mininvestment").toString();
		return mininvestment;
		  
	}
	public List getHotsDeals()throws Exception{
		String sql="select zh_pros.proid,zh_pros.proname,zh_pros.proimg,zh_pros.loves,zh_pros.comms,zh_pros.financialneeds,t.cmoney,ceil(t.cmoney/zh_pros.financialneeds*100) cpercent from zh_pros left join (select sum(money) cmoney,proid from zh_pro_orders group by proid) t on t.proid=zh_pros.proid where  zh_pros.ischecked=2 or zh_pros.ischecked=3 order by zh_pros.tsort desc,zh_pros.addtime desc limit 20";
		BaseDao dao=new BaseDao();
		return dao.getList(sql);
	}
	public List getNewDeals()throws Exception{
		String sql="select zh_pros.proid,zh_pros.proname,zh_pros.proimg,zh_pros.loves,zh_pros.comms,zh_pros.financialneeds,t.cmoney,ceil(t.cmoney/zh_pros.financialneeds*100) cpercent from zh_pros left join (select sum(money) cmoney,proid from zh_pro_orders group by proid) t on t.proid=zh_pros.proid where  zh_pros.ischecked=2 or zh_pros.ischecked=3 order by zh_pros.addtime desc limit 20";
		BaseDao dao=new BaseDao();
		return dao.getList(sql);
	}
	/*
	 * 查询项目（按照项目名字模糊查询）
	 * 
	 */
	public List searchPros(String name,PageInfo pageinfo)throws Exception{
	    String sql="";
		BaseDao dao=new BaseDao();
		pageinfo.setQueryStr("proname like'%"+name+"%'");
		List<Map> list = dao.getListByPage("zh_pros",
				"*", pageinfo);
		for (Map ma : list) {
			String proid = (String) ma.get("proid");
			String financialneeds = (String) ma.get("financialneeds");
			sql = "select sum(money) as money from  zh_pro_orders where proid="
					+ proid;
			Map aa = dao.queryone(sql);
			int m;
			double z;
			String money;
			if (aa.get("money") == null) {
				m = 0;
				z = 0;
			} else {
				money = aa.get("money").toString();
				z = Double.parseDouble(money);
				m = (int) z;
			}
			
			double n = Double.parseDouble(financialneeds);
			double q = (z * 100) / n;
			int bili = (int) Math.ceil(q);
			
			ma.put("money", m);
			ma.put("bili", bili);
		}
		return list;
	}
   public  Map getDoc(String id) throws Exception {
	   BaseDao dao=new BaseDao();
	   String sql="select * from t_document where id="+id;
	   Map map=dao.queryone(sql);
	   return map;
	   
   }
	
}
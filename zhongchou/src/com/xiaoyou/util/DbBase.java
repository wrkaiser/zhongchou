package com.xiaoyou.util;

/**
 * @author jack hou
 * @date 2011-05-10
 * @version 1.0
 */

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.Statement;
import java.sql.Types;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;

import com.xiaoyou.data.PageInfo;


public class DbBase {
	//public static String DATASOURCE = "java:comp/env/TX_ORA";
	private static Logger log = Logger.getLogger(DbBase.class);

	private static void writeLog(String sql) {
		log.info(sql);
	}

	public static void executeBatch(ArrayList alSql,Connection conn) throws Exception {

		Statement st = null;
		try {
			/*
			 * InitialContext ic = new InitialContext(); DataSource ds =
			 * (DataSource) ic.lookup(DATASOURCE); conn = ds.getConnection();
			 */
			st = conn.createStatement();

			for (int i = 0; i < alSql.size(); i++) {
				String sqlstr = (String) alSql.get(i);
				writeLog(sqlstr);
				st.addBatch(sqlstr);
			}
			st.executeBatch();
		} catch (Exception e) {
			throw e;
		} finally {
			if (st != null) {
				try {
					st.close();
				} catch (Exception e) {
					throw e;
				}
			}
		}

	}


	public static int executeUpdate(String sql,Connection conn ) throws Exception {

		writeLog(sql);
		Statement st = null;
		int iResult = -1;

		try {
			st = conn.createStatement();
			iResult = st.executeUpdate(sql);
		} catch (Exception e) {
			throw e;
		} finally {
			if (st != null) {
				try {
					st.close();
				} catch (Exception e) {
					throw e;
				}
			}
		}
		return iResult;

	}
	
	public static int executeUpdate(String sql,Object[] params,Connection conn ) throws Exception {

		writeLog(sql);
		PreparedStatement ps = null;
		int iResult = -1;

		try {
			ps = conn.prepareStatement(sql);
			for(int i=0;i<params.length;i++){
				if(params[i]!=null)
					ps.setObject(i+1,params[i]);
				else
					ps.setNull(i+1, Types.INTEGER);
			}
			iResult = ps.executeUpdate();
		} catch (Exception e) {
			throw e;
		} finally {
			if (ps!= null) {
				try {
					ps.close();
				} catch (Exception e) {
					throw e;
				}
			}
		}
		return iResult;

	}

	public static final Map queryOne(String sql,Connection conn) throws Exception {
		writeLog(sql);
		Statement st = null;
		try {
			st = conn.createStatement();
			ResultSet rs = st.executeQuery(sql);
			ResultSetMetaData rsmd = rs.getMetaData();
			int count = rsmd.getColumnCount();
			if (rs.next()) {
				HashMap hdRow = new HashMap();
				for (int i = 1; i <= count; i++) {
					String fieldValue = "";
					int iType = rsmd.getColumnType(i);

					if (iType == 2 || iType == 3) {

						if (rsmd.getScale(i) == 0)
							fieldValue = rs.getString(i);
						else
							fieldValue = String.valueOf(rs.getDouble(i));

					} else if (iType == 8) {

						fieldValue = String.valueOf(rs.getDouble(i));
					} else if (iType == 6 || iType == 7) {

						fieldValue = String.valueOf(rs.getFloat(i));
					} else
						fieldValue = rs.getString(i);

					if (fieldValue == null)
						fieldValue = "";
					else {
						fieldValue = fieldValue.trim();
					}
					// fieldValue=StringUtil.dereplace0D0A(fieldValue);
					hdRow.put(rsmd.getColumnLabel(i).toLowerCase(), fieldValue);
				}
				return hdRow;
			}
			 rs.close();
		} catch (Exception e) {
			throw e;
		} finally {
			if (st != null) {
				try {
					st.close();
				} catch (Exception e) {
					throw e;
				}
			}
		}
		return null;
	}

	public static final List executeQuery(String sql,Connection conn ) throws Exception {
		writeLog(sql);
		Statement st = null;
		ArrayList alResult = new ArrayList();
		try {

			st = conn.createStatement();
			ResultSet rs = st.executeQuery(sql);
			ResultSetMetaData rsmd = rs.getMetaData();
			int count = rsmd.getColumnCount();
			// int rowNo = 0;

			while (rs.next()) {

				HashMap hdRow = new HashMap();

				for (int i = 1; i <= count; i++) {
					String fieldValue = "";
					int iType = rsmd.getColumnType(i);

					if (iType == 2 || iType == 3) {

						if (rsmd.getScale(i) == 0)
							fieldValue = rs.getString(i);
						else
							fieldValue = String.valueOf(rs.getDouble(i));

					} else if (iType == 8) {

						fieldValue = String.valueOf(rs.getDouble(i));
					} else if (iType == 6 || iType == 7) {

						fieldValue = String.valueOf(rs.getFloat(i));
					} else
						fieldValue = rs.getString(i);

					if (fieldValue == null)
						fieldValue = "";
					else {
						fieldValue = fieldValue.trim();
					}
					// fieldValue=StringUtil.dereplace0D0A(fieldValue);

					hdRow.put(rsmd.getColumnLabel(i).toLowerCase(), fieldValue);
				}

				// rowNo++;
				alResult.add(hdRow);
			}
			 rs.close();
		} catch (Exception e) {
			throw e;
		} finally {
			if (st != null) {
				try {
					st.close();
				} catch (Exception e) {
					throw e;
				}
			}
		}

		return alResult;

	}
	public static final List executeQueryC(String sql,Connection conn ) throws Exception {
		writeLog(sql);
		Statement st = null;
		ArrayList alResult = new ArrayList();
		try {

			st = conn.createStatement();
			ResultSet rs = st.executeQuery(sql);
			ResultSetMetaData rsmd = rs.getMetaData();
			int count = rsmd.getColumnCount();
			// int rowNo = 0;

			while (rs.next()) {

				HashMap hdRow = new HashMap();

				for (int i = 1; i <= count; i++) {
					String fieldValue = "";
					int iType = rsmd.getColumnType(i);

					if (iType == 2 || iType == 3) {

						if (rsmd.getScale(i) == 0)
							fieldValue = rs.getString(i);
						else
							fieldValue = String.valueOf(rs.getDouble(i));

					} else if (iType == 8) {

						fieldValue = String.valueOf(rs.getDouble(i));
					} else if (iType == 6 || iType == 7) {

						fieldValue = String.valueOf(rs.getFloat(i));
					} else
						fieldValue = rs.getString(i);

					if (fieldValue == null)
						fieldValue = "";
					else {
						fieldValue = fieldValue.trim();
					}
					// fieldValue=StringUtil.dereplace0D0A(fieldValue);

					hdRow.put(rsmd.getColumnLabel(i).toLowerCase(), fieldValue);
				}
				 Map contentinfo=JsonUtils.jsonToMap((String)hdRow.get("statecontent"));
            	 hdRow.put("statecontent", contentinfo);
				// rowNo++;
				alResult.add(hdRow);
			}
			 rs.close();
		} catch (Exception e) {
			throw e;
		} finally {
			if (st != null) {
				try {
					st.close();
				} catch (Exception e) {
					throw e;
				}
			}
		}

		return alResult;

	}
	public static final List queryByPage(String modelName, String fields,
			PageInfo pageInfo,Connection conn ) throws Exception {

		Statement st = null;
		ArrayList alResult = new ArrayList();

		try {
			String querystr = pageInfo.getQueryStr();
			String wheresql = "";

			if (querystr != null && !querystr.equals("")
					&& !querystr.startsWith(" order by"))
				wheresql += " where " + querystr;

			st = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
					ResultSet.CONCUR_READ_ONLY);

			int i_orderby = wheresql.indexOf("order by");

			String countsql = "select count(*) count from ";

			if (fields.indexOf("distinct") == -1) {
				countsql += modelName;
				if (i_orderby == -1)
					countsql += wheresql;
				else
					countsql += wheresql.substring(0, i_orderby);

			} else {
				countsql += "(select " + fields + " from " + modelName;

				if (i_orderby == -1)
					countsql += wheresql + ") t_tab";
				else
					countsql += wheresql.substring(0, i_orderby) + ") t_tab";

			}
			writeLog("select " + fields + " from " + modelName + wheresql);
			ResultSet rs = st.executeQuery(countsql);

			if (rs.next())
				pageInfo.setTotalRows(rs.getInt("count"));
			else
				pageInfo.setTotalRows(0);

			rs.close();

			if (querystr != null && querystr.startsWith(" order by")) {
				wheresql += querystr;
			}

			if (pageInfo.getTotalRows() != 0) {

				int limitidex=wheresql.indexOf("limit");
				if(limitidex>=0){
					wheresql=wheresql.substring(0, limitidex);
				}
				rs = st.executeQuery("select " + fields + " from " + modelName
						+ wheresql +" limit "+(pageInfo.getPageStartRow()-1)+","+pageInfo.getPageSize());

//				if (pageInfo.getCurrentPage() != 1)
//					rs.absolute(pageInfo.getPageStartRow() - 1);

				ResultSetMetaData rsmd = rs.getMetaData();
				int count = rsmd.getColumnCount();

				for (int j = 0; j < pageInfo.getPageSize() && rs.next(); j++) {

					HashMap hdRow = new HashMap();

					for (int i = 1; i <= count; i++) {

						String fieldValue = "";
						int iType = rsmd.getColumnType(i);

						if (iType == 2 || iType == 3) {

							if (rsmd.getScale(i) == 0)
								fieldValue = rs.getString(i);
							else
								fieldValue = String.valueOf(rs.getDouble(i));

						} else if (iType == 8) {

							fieldValue = String.valueOf(rs.getDouble(i));
						} else if (iType == 6 || iType == 7) {

							fieldValue = String.valueOf(rs.getFloat(i));
						} else
							fieldValue = rs.getString(i);

						if (fieldValue == null)
							fieldValue = "";
						else {
							fieldValue = fieldValue.trim();
						}
						// fieldValue=StringUtil.dereplace0D0A(fieldValue);

						hdRow.put(rsmd.getColumnLabel(i).toLowerCase(),
								fieldValue);
					}

					alResult.add(hdRow);
				}
			}
		} catch (Exception e) {
			throw e;
		} finally {
			if (st != null) {
				try {
					st.close();
				} catch (Exception e) {
					throw e;
				}
			}
		}
		return alResult;

	}
	

	public static final List executeQueryCompile(String sql,Connection conn ) throws Exception {
		writeLog(sql);
		Statement st = null;
		ArrayList alResult = new ArrayList();
		try {

			st = conn.createStatement();
			ResultSet rs = st.executeQuery(sql);
			ResultSetMetaData rsmd = rs.getMetaData();
			int count = rsmd.getColumnCount();
			// int rowNo = 0;

			while (rs.next()) {

				HashMap hdRow = new HashMap();

				for (int i = 1; i <= count; i++) {
					String fieldValue = "";
					int iType = rsmd.getColumnType(i);

					if (iType == 2 || iType == 3) {

						if (rsmd.getScale(i) == 0)
							fieldValue = rs.getString(i);
						else
							fieldValue = String.valueOf(rs.getDouble(i));

					} else if (iType == 8) {

						fieldValue = String.valueOf(rs.getDouble(i));
					} else if (iType == 6 || iType == 7) {

						fieldValue = String.valueOf(rs.getFloat(i));
					} else
						fieldValue = rs.getString(i);

					if (fieldValue == null)
						fieldValue = "";
					else {
						fieldValue = fieldValue.trim();
					}
					// fieldValue=StringUtil.dereplace0D0A(fieldValue);

					hdRow.put(rsmd.getColumnLabel(i).toLowerCase(), fieldValue);
				}

				 Map contentinfo=JsonUtils.jsonToMap((String)hdRow.get("statecontent"));
            	 hdRow.put("statecontent", contentinfo);
				alResult.add(hdRow);
			}
			 rs.close();
		} catch (Exception e) {
			throw e;
		} finally {
			if (st != null) {
				try {
					st.close();
				} catch (Exception e) {
					throw e;
				}
			}
		}

		return alResult;

	}
	public static final List queryByPageAndCompile(String modelName, String fields,
			PageInfo pageInfo,Connection conn ) throws Exception {

		Statement st = null;
		ArrayList alResult = new ArrayList();

		try {
			String querystr = pageInfo.getQueryStr();
			String wheresql = "";

			if (querystr != null && !querystr.equals("")
					&& !querystr.startsWith(" order by"))
				wheresql += " where " + querystr;

			st = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
					ResultSet.CONCUR_READ_ONLY);

			int i_orderby = wheresql.indexOf("order by");

			String countsql = "select count(*) count from ";

			if (fields.indexOf("distinct") == -1) {
				countsql += modelName;
				if (i_orderby == -1)
					countsql += wheresql;
				else
					countsql += wheresql.substring(0, i_orderby);

			} else {
				countsql += "(select " + fields + " from " + modelName;

				if (i_orderby == -1)
					countsql += wheresql + ") t_tab";
				else
					countsql += wheresql.substring(0, i_orderby) + ") t_tab";

			}
			writeLog("select " + fields + " from " + modelName + wheresql);
			ResultSet rs = st.executeQuery(countsql);

			if (rs.next())
				pageInfo.setTotalRows(rs.getInt("count"));
			else
				pageInfo.setTotalRows(0);

			rs.close();

			if (querystr != null && querystr.startsWith(" order by")) {
				wheresql += querystr;
			}

			if (pageInfo.getTotalRows() != 0) {

				int limitidex=wheresql.indexOf("limit");
				if(limitidex>=0){
					wheresql=wheresql.substring(0, limitidex);
				}
				rs = st.executeQuery("select " + fields + " from " + modelName
						+ wheresql +" limit "+(pageInfo.getPageStartRow()-1)+","+pageInfo.getPageSize());
//				if (pageInfo.getCurrentPage() != 1)
//					rs.absolute(pageInfo.getPageStartRow() - 1);

				ResultSetMetaData rsmd = rs.getMetaData();
				int count = rsmd.getColumnCount();

				for (int j = 0; j < pageInfo.getPageSize() && rs.next(); j++) {

					HashMap hdRow = new HashMap();

					for (int i = 1; i <= count; i++) {

						String fieldValue = "";
						int iType = rsmd.getColumnType(i);

						if (iType == 2 || iType == 3) {

							if (rsmd.getScale(i) == 0)
								fieldValue = rs.getString(i);
							else
								fieldValue = String.valueOf(rs.getDouble(i));

						} else if (iType == 8) {

							fieldValue = String.valueOf(rs.getDouble(i));
						} else if (iType == 6 || iType == 7) {

							fieldValue = String.valueOf(rs.getFloat(i));
						} else
							fieldValue = rs.getString(i);

						if (fieldValue == null)
							fieldValue = "";
						else {
							fieldValue = fieldValue.trim();
						}
						// fieldValue=StringUtil.dereplace0D0A(fieldValue);

						hdRow.put(rsmd.getColumnLabel(i).toLowerCase(),
								fieldValue);
					}
	            	 List pcontent=JsonUtils.jsonToList((String)hdRow.get("pcontent"));
	            	 hdRow.put("pcontent", pcontent);
					alResult.add(hdRow);
				}
			}
		} catch (Exception e) {
			throw e;
		} finally {
			if (st != null) {
				try {
					st.close();
				} catch (Exception e) {
					throw e;
				}
			}
		}
		return alResult;

	}
	
	public static final List complexQueryByPage(String modelName, String sql,
			PageInfo pageInfo,Connection conn ) throws Exception {

		Statement st = null;
		ArrayList alResult = new ArrayList();
		try {

			st = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
					ResultSet.CONCUR_READ_ONLY);

			ResultSet rs = st.executeQuery("select count(*) count from "
					+ modelName + " where " + pageInfo.getQueryStr());

			if (rs.next())
				pageInfo.setTotalRows(rs.getInt("count"));
			else
				pageInfo.setTotalRows(0);

			rs.close();

			if (pageInfo.getTotalRows() != 0) {
				writeLog(sql + " where " + pageInfo.getQueryStr());

				rs = st.executeQuery(sql + " where " + pageInfo.getQueryStr());

				if (pageInfo.getCurrentPage() != 1)
					rs.absolute(pageInfo.getPageStartRow() - 1);

				ResultSetMetaData rsmd = rs.getMetaData();
				int count = rsmd.getColumnCount();

				for (int j = 0; j < pageInfo.getPageSize() && rs.next(); j++) {

					HashMap hdRow = new HashMap();

					for (int i = 1; i <= count; i++) {
						String fieldValue = "";
						int iType = rsmd.getColumnType(i);

						if (iType == 2 || iType == 3) {

							if (rsmd.getScale(i) == 0)
								fieldValue = rs.getString(i);
							else
								fieldValue = String.valueOf(rs.getDouble(i));

						} else if (iType == 8) {

							fieldValue = String.valueOf(rs.getDouble(i));
						} else if (iType == 6 || iType == 7) {

							fieldValue = String.valueOf(rs.getFloat(i));
						} else
							fieldValue = rs.getString(i);

						if (fieldValue == null)
							fieldValue = "";
						else {
							fieldValue = fieldValue.trim();
						}
						// fieldValue=StringUtil.dereplace0D0A(fieldValue);

						hdRow.put(rsmd.getColumnLabel(i).toLowerCase(),
								fieldValue);
					}

					alResult.add(hdRow);
				}
			}
			rs.close();
		} catch (Exception e) {
			throw e;
		} finally {
			if (st != null) {
				try {
					st.close();
				} catch (Exception e) {
					throw e;
				}
			}
		}
		return alResult;

	}

	public static final List executeQueryList(String sql,Connection conn ) throws Exception {

		writeLog(sql);
		Statement st = null;
		ArrayList alResult = new ArrayList();
		try {

			st = conn.createStatement();
			ResultSet rs = st.executeQuery(sql);
			ResultSetMetaData rsmd = rs.getMetaData();
			int count = rsmd.getColumnCount();

			while (rs.next()) {

				ArrayList rowList = new ArrayList();

				for (int i = 1; i <= count; i++) {

					String fieldValue = rs.getString(i);

					if (fieldValue == null)
						fieldValue = "";
					else
						fieldValue = fieldValue.trim();

					rowList.add(fieldValue);
				}

				alResult.add(rowList);
			}
			rs.close();
		} catch (Exception e) {
			throw e;
		} finally {
			if (st != null) {
				try {
					st.close();
				} catch (Exception e) {
					throw e;
				}
			}
		}
		return alResult;
	}
}

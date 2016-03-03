package com.xiaoyou.util;
/**
 * @author jack hou
 * @date 2011-09-10
 * @version 1.0
 */
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.StringTokenizer;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;

import org.apache.log4j.Logger;

import com.xiaoyou.data.PageInfo;

public class JsonUtil {
	private static Logger log = Logger.getLogger(JsonUtil.class);
	 /**
     * json转化为List<Map>
     * @param productCodes  sjon格式({a:1,b:2},{c:3,d:4})
     * @return List<Map>
     */

    public static List<Map<String,String>> jsonToList(String json) {
        List<Map<String,String>> listMap = new ArrayList<Map<String,String>>();
        String JSON = json.substring(1, json.length() - 1);
        JSON = JSON.replaceAll("},", "}^");
        StringTokenizer strTokenizer = new StringTokenizer(JSON, "^");

        while (strTokenizer.hasMoreTokens()) {
            String token = strTokenizer.nextToken();
            Map paraMap = JsonUtil.getMap4Json(token);
            listMap.add(paraMap);
        }

       return listMap;
    }
    public static Map getMap4Json(String jsonString) {
        JSONObject jsonObject = JSONObject.fromObject(jsonString);
        Iterator keyIter = jsonObject.keys();
        String key;
        Object value;
        Map valueMap = new HashMap();
        while (keyIter.hasNext()) {
            key = (String) keyIter.next();
            value = String.valueOf(jsonObject.get(key));
            valueMap.put(key, value);
        }
        return valueMap;
    }


	 public static JSONObject generate(List list) {
	        Map<String, Object> map = new HashMap<String, Object>();
	        map.put("totalProperty", list.size());
	        map.put("root", list);
	        if(list==null)
	        	map.put("success", false);
	        else
	        	map.put("success", true);
	        return JSONObject.fromObject(map);
	    }
	 public static JSONObject generateList(List list,String pagestart) {
	        Map<String, Object> map = new HashMap<String, Object>();
	        map.put("pagestart", pagestart);
	        map.put("root", list);
	        if(list==null)
	        	map.put("success", false);
	        else
	        	map.put("success", true);
	        return JSONObject.fromObject(map);
	    }
	    public static JSONObject generate(List list,JsonConfig jsonconfig) {
	         Map<String, Object> map = new HashMap<String, Object>();
	        map.put("totalProperty", list.size());
	        map.put("root", list);
	        return JSONObject.fromObject(map,jsonconfig);
	    }
	 
	    public static JSONObject generate(List list,PageInfo info) {
	        Map<String, Object> map = new HashMap<String, Object>();
	        if(list==null)
	        	map.put("success", false);
	        else
	        	map.put("success", true);
	        map.put("totalProperty", list.size());
	        map.put("totalpage", info.getTotalPages());
	        map.put("root", list);
	        return JSONObject.fromObject(map);
	    }
	 
	    public static JSONObject javabean2json(Object object) {
	        Map<String, Object> map = new HashMap<String, Object>();
	        if(object==null)
	        	map.put("success", false);
	        else
	        	map.put("success", true);
	        map.put("data", object);
	        return JSONObject.fromObject(map);
	    }

	    public static JSONObject objectcollect2json(List list, String total) {
	        Map<String, Object> map = new HashMap<String, Object>();
	        map.put("totalProperty", total);
	        map.put("root", list);
	        return JSONObject.fromObject(map);
	    }
	    public static JSONObject mapToJson(Map map){
	    	if(map==null)
	        	map.put("success", false);
	        else
	        	map.put("success", true);
	    	return JSONObject.fromObject(map);
	    }


	// 将JSON转换成Map,其中valueClz为Map中value的Class,keyArray为Map的key
	public static Map json2Map( String json) {
		Map classMap = null;
		try{
		JSONObject jsonObject = JSONObject.fromObject(json);
		Iterator it=jsonObject.keys();
		 classMap = new HashMap();
		while(it.hasNext()){
			String key=(String)it.next();
			classMap.put(key, jsonObject.get(key));
		}
		}catch(Exception e){
			log.error(e.getMessage());
		}
		return classMap;
		
	}

	public static List<Map<String, String>> jsonToList(JSONArray ja)
			throws Exception {
//		for (int i = 0; i < ja.length(); i++) {
//			Iterator<?> items = ja.getJSONObject(i).keys();
//			while (items.hasNext()) {
//				String keyName = items.next().toString();
//				System.out.println(keyName + ": "
//						+ ja.getJSONObject(i).getString(keyName));
//				if ("items".equals(keyName))
//					return jsonToList(ja.getJSONObject(i).getString(keyName));
//			}
//		}
		System.out.print((((Map<String,String>)ja.get(0))).get("slimg"));
		return null;
	}
	
	
	 public static JSONObject generatePageList(List list,String pagestart,String totalpages) {
	        Map<String, Object> map = new HashMap<String, Object>();
	        map.put("pagestart", pagestart);
	        map.put("totalpages", totalpages);
	        map.put("root", list);
	        if(list==null)
	        	map.put("success", false);
	        else
	        	map.put("success", true);
	        return JSONObject.fromObject(map);
	    }
}


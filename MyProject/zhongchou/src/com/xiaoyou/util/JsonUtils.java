package com.xiaoyou.util;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.StringTokenizer;
import java.util.TreeMap;

import net.sf.json.JSONObject;

import com.alibaba.fastjson.JSON;

public class JsonUtils {
	public static String mapToJson(Map map){
		String jsonStr="";
		if(map!=null&&!map.isEmpty()){
			map.put("success", true);
		}else{
			map.put("success", false);
		}
		jsonStr=JSON.toJSONString(map);
		return jsonStr;
	};
	public static Map jsonToMap(String json){
		Map jsonmap=(Map)JSON.parse(json);
		return jsonmap;
	}
	
	public static Iterator jsonToIterator(String json){
		 JSONObject jsonObject = JSONObject.fromObject(json);
		 return jsonObject.keys();
	}
	public static String listToJson(List list){
		String jsonStr="";
		Map map=new HashMap();
		map.put("root", list);
	    if(list!=null&&list.size()>0){
	    	map.put("success", true);
	    }else{
			map.put("success", false);
		}
		jsonStr=JSON.toJSONString(map);
		return jsonStr;
	}
	public static String listToJson(List list,int totalpage){
		String jsonStr="";
		Map map=new HashMap();
		map.put("totalpage", totalpage);
	    map.put("root", list);
	    if(list!=null&&list.size()>0){
	    	map.put("success", true);
	    }else{
			map.put("success", false);
		}
		jsonStr=JSON.toJSONString(map);
		return jsonStr;
	}
	public static String javabean2json(Object object) {
        Map<String, Object> map = new HashMap<String, Object>();
        if(object==null)
        	map.put("success", false);
        else
        	map.put("success", true);
        map.put("data", object);
        return JSON.toJSONString(map);
    }
	public static String bean2json(Object object) {
        return JSON.toJSONString(object);
    }
	
	

    public static List<Map<String,String>> jsonToList(String json) {
        List<Map<String,String>> listMap = new ArrayList<Map<String,String>>();
        String JSON = json.substring(1, json.length() - 1);
        JSON = JSON.replaceAll("},", "}^");
        StringTokenizer strTokenizer = new StringTokenizer(JSON, "^");

        while (strTokenizer.hasMoreTokens()) {
            String token = strTokenizer.nextToken();
            Map paraMap = JsonUtils.getMap4Json(token);
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
   
}

package iit.lims.util;

import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.Set;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

public class ConverterUtils {
	/**
	 * Vo -> HashMap 변환
	 * 
	 * @param bean
	 * @param map
	 * @param prefixOverrides
	 * @param keyUpperCase
	 * @param camelCase
	 */
	public static void convertVoToHashMap(Object bean, HashMap<String, Object> map, String prefixOverrides,
			boolean keyUpperCase, boolean camelCase) {

		Class<?> cls = bean.getClass();

		for (Field field : cls.getDeclaredFields()) {
			field.setAccessible(true);

			Object value = null;
			String key;

			try {
				value = field.get(bean);
			} catch (IllegalArgumentException e) {
				System.out.println(
						"Exception position : CollectionsUtil - putValues(Object bean, Map<String, Object> map, String prefix)");
			} catch (IllegalAccessException e) {
				System.out.println(
						"Exception position : CollectionsUtil - putValues(Object bean, Map<String, Object> map, String prefix)");
			}

			// 선행문자 제거
			if (prefixOverrides == null) {
				key = field.getName();
			} else {
				key = field.getName().replaceFirst(prefixOverrides, "");
			}

			// key 대문자로 변경
			if (keyUpperCase) {
				key = key.toUpperCase();
			}

			// key camelCase로 변경
			if (camelCase) {
				StringBuffer buffer = new StringBuffer();
				
				for (String token : key.split("_")) {
					System.out.println(token);

				}
				
				
				for (String token : key.toLowerCase().split("_")) {
					buffer.append(StringUtils.capitalize(token));
				}
				key = StringUtils.uncapitalize(buffer.toString());
			}

			if (isValue(value)) {
				map.put(key, value);
			} else if (value instanceof BigDecimal) {
				map.put(key, value);
			} else {
				convertVoToHashMap(value, map, key, keyUpperCase, camelCase);
			}
		}
	}

	private static final Set<Class<?>> valueClasses = (Collections
			.unmodifiableSet(new HashSet<Class<? extends Object>>(Arrays.asList(Object.class, String.class, Boolean.class, Character.class,
					Byte.class, Short.class, Integer.class, Long.class, Float.class, Double.class))));

	private static boolean isValue(Object value) {
		return value == null || valueClasses.contains(value.getClass());
	}

	/**
	 * HashMap -> Vo 변환
	 * 
	 * @param map
	 * @param obj
	 * @return
	 */
	public static Object convertHashMapToVo(HashMap<String, Object> map, Object obj) {
		String keyAttribute = null;
		String setMethodString = "set";
		String methodString = null;
		Iterator<String> itr = map.keySet().iterator();

		while (itr.hasNext()) {
			keyAttribute = (String) itr.next();
			methodString = setMethodString + keyAttribute.substring(0, 1).toUpperCase() + keyAttribute.substring(1);
			Method[] methods = obj.getClass().getDeclaredMethods();
			for (int i = 0; i < methods.length; i++) {
				if (methodString.equals(methods[i].getName())) {
					try {
						methods[i].invoke(obj, map.get(keyAttribute));
					} catch (Exception e) {
						e.printStackTrace();
					}
				}
			}
		}
		return obj;
	}

	/**
	 * Json String -> HashMap 변환
	 * 
	 * @param jsonParam
	 * @return
	 * @throws ParseException
	 * @throws Exception
	 */
	public static HashMap<String, Object> jsonToJsonParam(String jsonParam) throws ParseException, Exception {

		HashMap<String, Object> param = new HashMap<String, Object>();

		if (null == jsonParam || jsonParam.isEmpty()) { // jsonParam 이 null 인 경우
														// 리턴
			return param;
		}

		JSONParser parser = new JSONParser();
		JSONObject json = (JSONObject) parser.parse(jsonParam);

		Iterator<?> iterator;
		for (iterator = json.keySet().iterator(); iterator.hasNext();) {
			String key = (String) iterator.next();
			Object value = json.get(key);
			if ((value != null) && ((!(value instanceof String)) || (!StringUtils.isEmpty((CharSequence) value)))) {

				if (value instanceof HashMap) {
					HashMap<String, Object> paramSub = new HashMap<String, Object>();
					Iterator<?> iteratorSub;
					JSONObject jsonSub = (JSONObject) parser.parse(value.toString());
					for (iteratorSub = jsonSub.keySet().iterator(); iteratorSub.hasNext();) {
						String subKey = (String) iteratorSub.next();
						Object subValue = jsonSub.get(subKey);
						if ((subValue != null) && ((!(subValue instanceof String))
								|| (!StringUtils.isEmpty((CharSequence) subValue)))) {
							paramSub.put(subKey, subValue);
						}
					}
					param.put(key, paramSub);
				} else {
					if (value instanceof JSONArray) {
						JSONArray jsonArray = new JSONArray();
						for (int k = 0; k < ((JSONArray) value).size(); k++) {
							JSONObject tmpJsonObj = new JSONObject();
							tmpJsonObj = (JSONObject) ((JSONArray) value).get(k);
							jsonArray.add(tmpJsonObj);
						}
						param.put(key, jsonArray);
					} else {
						param.put(key, value);
					}
				}
			} else {
				param.put(key, "");
			}
		}
		return param;
	}
	
	/**
	 * MultipartHttpServletRequest 를 map으로 변경하여 리턴함
	 * @param request
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public static HashMap<String, Object> MultipartToHashMap(MultipartHttpServletRequest request) {
		
		JSONObject json = new JSONObject();
		ArrayList<HashMap<String, Object>> arrayList = new ArrayList<HashMap<String, Object>>();
		
		try{
			
			JSONObject subMap = new JSONObject();
			JSONArray fileArrayList = new JSONArray();
			
			String jsonParam = request.getParameter("params");
			String fileName = "";
			
			JSONParser parser = new JSONParser();
			
			if(parser.parse(jsonParam).getClass().toString().equals("class org.json.simple.JSONArray")){
				arrayList = (ArrayList<HashMap<String, Object>>) parser.parse(jsonParam);
				json.put("arrayList", arrayList);
			}
			else{
				json = (JSONObject)parser.parse(jsonParam);				
			}
			
			Iterator<String> iter = request.getFileNames();
			
			while(iter.hasNext()){
				fileName = iter.next();
				MultipartFile mutipartFile = request.getFiles(fileName).get(0);
				
				subMap.put(fileName, mutipartFile);
				fileArrayList.add(subMap);
				subMap = new JSONObject();
			}
			
			json.put("fileLst", fileArrayList);
			
		}catch(Exception e){
			e.printStackTrace();
		}		
		
		return json;
		
	}
	
	public static ArrayList<HashMap<String,String>> jsonToArrayList(String json) {
		ArrayList<HashMap<String, String>> arrayList = new ArrayList<HashMap<String,String>>();
		json = json.replace("[", "").replace("]", "");
		json = json.substring(1, json.length() - 1);
        String[] split = json.split("[}][,][{]");
        for (String string : split) {
            String[] obj = string.split(",");
            HashMap<String, String> map = new HashMap<String, String>();
            for (int i=0; i<obj.length; i++) {
            	String[] obj2 = obj[i].split(":");
            	map.put(obj2[0].replace("\"",""), obj2[1].replace("\"",""));
            }
            arrayList.add(map);
        }
        
        return arrayList;
	}
}

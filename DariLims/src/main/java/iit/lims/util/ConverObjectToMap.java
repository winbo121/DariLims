package iit.lims.util;

import java.lang.reflect.Field;
import java.util.HashMap;
import java.util.Map;

public class ConverObjectToMap {
	public static Map<String, Object> conver(Object obj) {
		try {
			//Field[] fields = obj.getClass().getFields(); //private field는 나오지 않음.
			Field[] fields = obj.getClass().getDeclaredFields();
			Map<String, Object> resultMap = new HashMap<String, Object>();
			for (int i = 0; i <= fields.length - 1; i++) {
				fields[i].setAccessible(true);
				//System.out.println("zzzzzzzzzzzzzzzzzz"+fields[i].get(obj)); 
				if (fields[i].get(obj) != null) {
					resultMap.put(fields[i].getName(), fields[i].get(obj));
				}
			}
			return resultMap;
		} catch (IllegalArgumentException e) {
			e.printStackTrace();
		} catch (IllegalAccessException e) {
			e.printStackTrace();
		}
		return null;
	}
}

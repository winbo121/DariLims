package iit.lims.util;

import java.io.BufferedReader;
import java.io.IOException;
import java.sql.Clob;
import java.sql.SQLException;
import java.util.HashMap;

import org.springframework.jdbc.support.JdbcUtils;

public class CamelListMap extends HashMap<Object, Object>{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	
	 @Override
     public Object put(Object key, Object value) {
		 String camelKey = JdbcUtils.convertUnderscoreNameToPropertyName(key.toString());
		 
		 Object result = null;
		 
		 if(value.getClass().toString().equals("class oracle.sql.CLOB")){
			 StringBuffer strOut = new StringBuffer();
			 String str = "";
			 Clob clob = (Clob) value;
			 
			try {
				BufferedReader br = new BufferedReader(clob.getCharacterStream());
				while((str = br.readLine()) != null){
					strOut.append(str + "\n");
				}
			} catch (SQLException e) {
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			result = strOut;
		 }
		 else{
			result = value;
		 }
		 
		 return super.put(camelKey.trim(), result);
 
     }

}

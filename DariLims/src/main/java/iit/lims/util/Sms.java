package iit.lims.util;


import iit.lims.util.sms.service.SmsService;
import iit.lims.util.sms.vo.SmsVO;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.URL;
import java.net.URLConnection;

import javax.annotation.Resource;



public class Sms {

	/* real */
	private final static String SERVER_URL = "http://cpsms.skysms.co.kr/cpsms/cp_mms_send.php";
	
	/* test 
	private final static String SERVER_URL = "http://cpsms.skysms.co.kr/cpsms/cp_mms_send_test.php";
	*/
	private final static String CPUSERID = "cheillab";
	private final static String PASSWD = "cheillab";
	
    /**
	 * 문자천국
	 * 담당자:02-3430-5074(조진현씨)
	 * id : cheillab
	 * 비번 : cheillab
	 * http://www.skysms.co.kr/cpsms/
     */
	
	@Resource
	private SmsService service;
	
	public SmsVO SmsSend(SmsVO tagetVO) throws Exception {

        URL url = null;
        URLConnection urlConnection = null;        
        SmsVO vo = new SmsVO();
        
        try {
            String message = "안녕하세요. 제일분석센타입니다."+tagetVO.getReq_nm()+"님,"+tagetVO.getReq_org_nm()+","+tagetVO.getSample_reg_nm() + " / 분석료:"+tagetVO.getFee_tot()+"원 ";
           
            message = message + tagetVO.getCustom_msg();
            
            //잔류농약여부
//            if(tagetVO.getSms_type().equals("B")){
//                if(process.equals("A")){
//                	message = "안녕하세요. 제일분석센타입니다."+tagetVO.getReq_nm()+"님,"+tagetVO.getReq_org_nm()+","+tagetVO.getSample_reg_nm()+" 잔류농약분석이 접수되었습니다. "+
//                			"입금확인후 성적서 발행 가능하오니 이점 부탁드립니다. 입금계좌 농협 301-0139-0836-11 분석료:"+tagetVO.getFee_tot()+"원";
//                }else{
//                	message = "안녕하세요. 제일분석센타입니다."+tagetVO.getReq_nm()+"님,"+tagetVO.getReq_org_nm()+","+tagetVO.getSample_reg_nm()+" 잔류농약분석이 완료되었습니다. "+
//                			"입금확인후 성적서 발행 가능하오니 이점 부탁드립니다. 입금계좌 농협 301-0139-0836-11 분석료:"+tagetVO.getFee_tot()+"원";
//                }
//            }else{
//                if(process.equals("A")){
//	            	message = "안녕하세요. 제일분석센타입니다. "+tagetVO.getReq_org_nm()+"님,"+tagetVO.getSample_reg_nm()+" 분석이 접수되었습니다. "+
//	                		"입금확인후 성적서 발행 가능하오니 이점 부탁드립니다. 입금계좌 농협 211021-55-001548 분석료:"+tagetVO.getFee_tot()+"원";
//                }else{
//	            	message = "안녕하세요. 제일분석센타입니다. "+tagetVO.getReq_org_nm()+"님,"+tagetVO.getSample_reg_nm()+" 분석이 완료되었습니다. "+
//	            			"입금확인후 성적서 발행 가능하오니 이점 부탁드립니다. 입금계좌 농협 211021-55-001548  분석료:"+tagetVO.getFee_tot()+"원  ";
//                }
//            }

            url = new URL(SERVER_URL);
            urlConnection = url.openConnection();
            urlConnection.setDoOutput(true);
            

            printByOutputStream(urlConnection.getOutputStream(), 
            		"cpuserid=" + CPUSERID + 
            		"&passwd=" + PASSWD + 
            		"&destination=" + tagetVO.getSms_target() + "|" +
            		"&body=(수신)" + message +
            		"&callback=02-862-8666&reserve_date=&return_url=");
            
            tagetVO.setSms_result(printByInputStream(urlConnection.getInputStream()));          
        	tagetVO.setMessage(message);

        } catch(Exception e) {
            e.printStackTrace();
        }
        return tagetVO;
    }   

    // 웹 서버로 부터 받은 웹 페이지 결과를 콘솔에 출력하는 메소드
    public static String printByInputStream(InputStream is) {
		BufferedReader rd = null;
        String result = "";
        try {
			rd = new BufferedReader(new InputStreamReader(is, "EUC-KR"));
			String line;
			while ((line = rd.readLine()) != null) {
				result += line;
			}
        } catch(IOException e) {
            e.printStackTrace();
            result = "Error";
        }
        return result;
    }

    // 웹 서버로 파라미터명과 값의 쌍을 전송하는 메소드
    public static void printByOutputStream(OutputStream os, String msg) {
        try {
            byte[] msgBuf = msg.getBytes("EUC-KR");
            os.write(msgBuf, 0, msgBuf.length);
            os.flush();
        } catch(IOException e) {
            e.printStackTrace();
        }
    }

}

package iit.lims.util.tax.service.impl;

import java.util.ArrayList;
import java.util.HashMap;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.popbill.api.IssueResponse;
import com.popbill.api.TaxinvoiceService;
import com.popbill.api.taxinvoice.Taxinvoice;
import com.popbill.api.taxinvoice.TaxinvoiceDetail;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import iit.lims.accept.dao.CommissionCheckDAO;
import iit.lims.accept.vo.CommissionTaxInvoiceVO;
import iit.lims.util.tax.service.CommissionTaxinvoiceService;

@Service
public class CommissionTaxinvoiceServiceImpl extends EgovAbstractServiceImpl implements CommissionTaxinvoiceService {

	@Autowired
    private TaxinvoiceService taxinvoiceService;

	@Resource(name = "commissionCheckDAO")
	private CommissionCheckDAO commissionCheckDAO;
	
    public HashMap<String,Object> registIssue(CommissionTaxInvoiceVO vo) {
    	
    	//개발
    	String invoicerCorpNum = "1234567890";
    	//상업
    	//String invoicerCorpNum = "3148603405";
        
    	HashMap<String,Object> hmResult = new HashMap<String, Object>();
    	
    	IssueResponse response = null;
    	
        // 세금계산서 정보 객체
        Taxinvoice taxinvoice = new Taxinvoice();

        // 작성일자, 날짜형식(yyyyMMdd)
        taxinvoice.setWriteDate(vo.getWriteDate().replace("-", ""));

        // 과금방향, [정과금, 역과금] 중 선택기재, "역과금"은 역발행세금계산서 발행에만 가능
        taxinvoice.setChargeDirection("정과금");

        // 발행유형, [정발행, 역발행, 위수탁] 중 기재
        taxinvoice.setIssueType("정발행");

        // [영수, 청구] 중 기재
        taxinvoice.setPurposeType(vo.getPurposeType());

        // 발행시점, [직접발행, 승인시자동발행] 중 기재
        taxinvoice.setIssueTiming("직접발행");

        // 과세형태, [과세, 영세, 면세] 중 기재
        taxinvoice.setTaxType("과세");


        /*********************************************************************
         *				수정세금계산서 정보 (수정세금계산서 작성시 기재)
         * - 수정세금계산서 관련 정보는 연동매뉴얼 또는 개발가이드 링크 참조
         & - [참고] 수정세금계산서 작성방법 안내 [http://blog.linkhub.co.kr/650]
         *********************************************************************/

        /*TaxinvoiceInfo taxinvoiceInfo = null;*/
        String taxInvoiceSeq = commissionCheckDAO.selectTaxInvoiceSeq();;
        
        /*try{
        	taxinvoiceInfo = taxinvoiceService.getInfo(invoicerCorpNum, MgtKeyType.SELL, taxInvoiceSeq);
        }
    	catch (PopbillException e1) {
			e1.printStackTrace();
    	}*/

        //수정발행여부(1:최초발행,2:수정발행)
        String taxInvoiceFlag = "";
        if(vo.getPageType().equals("I")){
    		//최초발행
    		taxInvoiceFlag = "1";
    		
    	}else{
    		//수정발행
    		taxInvoiceFlag = "2";
    	}
        
        taxinvoice.setInvoicerMgtKey(taxInvoiceSeq);
		vo.setInvoicerMgtKey(taxInvoiceSeq);
    	
    	/*taxinvoiceInfo = taxinvoiceService.getInfo(invoicerCorpNum, MgtKeyType.SELL, vo.getTestReqNo());
    	
    	if (taxinvoiceInfo != null) {
    		
    		//수정발행
    		taxInvoiceFlag = "2";
    		
    		DateTimeFormatter dtf = DateTimeFormatter.ofPattern("MMddHHmmss");  
    		LocalDateTime now = LocalDateTime.now();  
    		
    		// 공급자 문서관리번호, 1~24자리 (숫자, 영문, '-', '_') 조합으로 사업자 별로 중복되지 않도록 구성
            String modifyKey = vo.getTestReqNo() + "_" + dtf.format(now);
            taxinvoice.setInvoicerMgtKey(modifyKey);
            vo.setInvoicerMgtKey(modifyKey);
            
    		// 수정사유코드, 수정사유에 따라 1~6 중 선택기재.
            taxinvoice.setModifyCode((short)1);
            // 원본세금계산서 ItemKey, 문서확인 (GetInfo API)의 응답결과 항목 중 ItemKey 확인
            taxinvoice.setOriginalTaxinvoiceKey(taxinvoiceInfo.getItemKey());
            vo.setOriginalTaxinvoiceKey(taxinvoiceInfo.getItemKey());
    	}
    	else {
    		//최초발행
    		taxInvoiceFlag = "1";
    		taxinvoice.setInvoicerMgtKey(vo.getTestReqNo());
    		vo.setInvoicerMgtKey(vo.getTestReqNo());
    	}*/
        
        /*********************************************************************
         *								공급자 정보
         *********************************************************************/

        // 공급자 사업자번호
        taxinvoice.setInvoicerCorpNum(invoicerCorpNum);

        // 공급자 종사업장 식별번호, 필요시 기재. 형식은 숫자 4자리.
        taxinvoice.setInvoicerTaxRegID("");

        // 공급자 상호
        taxinvoice.setInvoicerCorpName("대덕분석기술연구소");

        // 공급자 문서관리번호, 1~24자리 (숫자, 영문, '-', '_') 조합으로 사업자 별로 중복되지 않도록 구성
        //taxinvoice.setInvoicerMgtKey(vo.getTestReqNo());

        // 공급자 대표자성명
        taxinvoice.setInvoicerCEOName("최예림");

        // 공급자 주소
        taxinvoice.setInvoicerAddr("대전광역시 유성구 대학로 291, KAIST 에너지환경연구센터 N28동 1102호(구성동)");

        // 공급자 종목
        taxinvoice.setInvoicerBizClass("분석기기 분석 용역 및 기술 용역");

        // 공급자 업태
        taxinvoice.setInvoicerBizType("제조 서비스");

        // 공급자 담당자 성명
        taxinvoice.setInvoicerContactName("정지연");

        // 공급자 담당자 메일주소
        taxinvoice.setInvoicerEmail("analysis@dari.re.kr");

        // 공급자 담당자 연락처
        taxinvoice.setInvoicerTEL("042-867-6019");

        // 공급자 담당자 휴대폰번호
        taxinvoice.setInvoicerHP("");

        // 발행 안내문자메시지 전송여부
        // - 전송시 포인트 차감되며, 전송실패시 환불처리
        taxinvoice.setInvoicerSMSSendYN(false);


        /*********************************************************************
         *							공급받는자 정보
         *********************************************************************/

        // 공급받는자 구분, [사업자, 개인, 외국인] 중 기재
        taxinvoice.setInvoiceeType("사업자");

        // 공급받는자 사업자번호, '-' 제외 10자리
        taxinvoice.setInvoiceeCorpNum(vo.getInvoiceeCorpNum().replace("-", ""));

        // 공급받는자 상호
        taxinvoice.setInvoiceeCorpName(vo.getInvoiceeCorpName());

        // [역발행시 필수] 공급받는자 문서관리번호, 1~24자리까지 사업자번호별 중복없는 고유번호 할당
        //taxinvoice.setInvoiceeMgtKey(vo.getTestReqNo());

        // 공급받는자 대표자 성명
        taxinvoice.setInvoiceeCEOName(vo.getInvoiceeCeoName());

        // 공급받는자 주소
        taxinvoice.setInvoiceeAddr(vo.getInvoiceeAddr());

        // 공급받는자 종목
        taxinvoice.setInvoiceeBizClass(vo.getInvoiceeBizClass());

        // 공급받는자 업태
        taxinvoice.setInvoiceeBizType(vo.getInvoiceeBizType());

        // 공급받는자 담당자명
        taxinvoice.setInvoiceeContactName1(vo.getPay_nm());

        // 공급받는자 담당자 메일주소
        taxinvoice.setInvoiceeEmail1(vo.getPay_email());

        // 공급받는자 담당자 연락처
        taxinvoice.setInvoiceeTEL1(vo.getPay_tel());

        // 공급받는자 담당자 휴대폰번호
        taxinvoice.setInvoiceeHP1(vo.getInvoiceeHP1());

        // 역발행시 안내문자메시지 전송여부
        // - 전송시 포인트 차감되며, 전송실패시 환불처리
        taxinvoice.setInvoiceeSMSSendYN(vo.getInvoiceeSMSSendYN());


        /*********************************************************************
         *							세금계산서 기재정보
         *********************************************************************/

        // [필수] 공급가액 합계
        taxinvoice.setSupplyCostTotal(vo.getSupplyCostTotal());

        // [필수] 세액 합계
        taxinvoice.setTaxTotal(vo.getTaxTotal());

        // [필수] 합계금액, 공급가액 + 세액
        taxinvoice.setTotalAmount(vo.getTotalAmount());

        // 기재 상 일련번호
        taxinvoice.setSerialNum(vo.getSerialNum());

        // 기재 상 현금
        taxinvoice.setCash(vo.getCash());

        // 기재 상 수표
        taxinvoice.setChkBill(vo.getChkBill());

        // 기재 상 어음
        taxinvoice.setNote(vo.getNote());

        // 기재 상 외상미수금
        taxinvoice.setCredit(vo.getCredit());

        // 기재 상 비고
        taxinvoice.setRemark1(vo.getRemark());
        //taxinvoice.setRemark2(vo.getRemark2());
        //taxinvoice.setRemark3(vo.getRemark3());
        taxinvoice.setKwon(vo.getKwon());
        taxinvoice.setHo(vo.getHo());

        // 사업자등록증 이미지 첨부여부
        taxinvoice.setBusinessLicenseYN(vo.getBusinessLicenseYN());

        // 통장사본 이미지 첨부여부
        taxinvoice.setBankBookYN(vo.getBankBookYN());

        /*********************************************************************
         *							상세항목(품목) 정보
         *********************************************************************/

        taxinvoice.setDetailList(new ArrayList());

        // 상세항목 객체
        TaxinvoiceDetail detail = new TaxinvoiceDetail();
        detail.setSerialNum((short) 1); // 일련번호, 1부터 순차기재
        detail.setPurchaseDT(vo.getPrdPurchaseDt().replace("-","")); // 거래일자
        detail.setItemName(vo.getTestReqNo());
        detail.setSpec("");
        detail.setQty("1"); // 수량
        detail.setUnitCost(""); // 단가
        detail.setSupplyCost(vo.getPrdSupplyCost()); // 공급가액
        detail.setTax(vo.getPrdTax()); // 세액
        detail.setRemark(vo.getPrdItem());

        taxinvoice.getDetailList().add(detail);

//        detail = new TaxinvoiceDetail();
//
//        detail.setSerialNum((short) 2); // 일련번호, 1부터 순차기재
//        detail.setPurchaseDT("20190827"); // 거래일자
//        detail.setItemName("품목명2");
//        detail.setSpec("규격");
//        detail.setQty("1"); // 수량
//        detail.setUnitCost("50000"); // 단가
//        detail.setSupplyCost("50000"); // 공급가액
//        detail.setTax("5000"); // 세액
//        detail.setRemark("품목비고2");
//
//        taxinvoice.getDetailList().add(detail);


        /*********************************************************************
         *							추가담당자 정보
         *********************************************************************/

        //taxinvoice.setAddContactList(new ArrayList());

        //TaxinvoiceAddContact addContact = new TaxinvoiceAddContact();

        //addContact.setSerialNum(1);
        //addContact.setContactName("");
        //addContact.setEmail("");

        //taxinvoice.getAddContactList().add(addContact);


        // 거래명세서 동시작성여부
        Boolean WriteSpecification = false;

        // 거래명세서 관리번호
        String DealInvoiceKey = null;

        // 즉시발행 메모
        String Memo = "";

        // 지연발행 강제여부
        // 발행마감일이 지난 세금계산서를 발행하는 경우, 가산세가 부과될 수 있습니다.
        // 가산세가 부과되더라도 발행을 해야하는 경우에는 forceIssue의 값을
        // true로 선언하여 발행(Issue API)를 호출하시면 됩니다.
        Boolean ForceIssue = false;

        try {

            response = taxinvoiceService.registIssue(invoicerCorpNum, taxinvoice, WriteSpecification, Memo, ForceIssue, DealInvoiceKey);
            
            hmResult.put("resultCode", response.getCode());
            hmResult.put("confirmNum",response.getNtsConfirmNum());
            hmResult.put("message",response.getMessage());
            
            
        } catch (Exception e) {
        	e.printStackTrace();
        	
        	hmResult.put("resultCode", "0");
            hmResult.put("confirmNum","");
            hmResult.put("message",e.getMessage());
        }
        
        //세금계산서발행결과 저장
    	HashMap<String, Object> param = new HashMap<String, Object>();
    	param.put("writeDate",vo.getWriteDate());
    	param.put("testReqNo",vo.getTestReqNo());
    	param.put("purposeType",vo.getPurposeType());
    	param.put("invoicerMgtKey",vo.getInvoicerMgtKey());
    	param.put("originalInvoiceKey",vo.getOriginalTaxinvoiceKey());
    	param.put("invoiceeAddr",vo.getInvoiceeAddr());
    	param.put("invoiceeBizClass",vo.getInvoiceeBizClass());
    	param.put("invoiceeBizType",vo.getInvoiceeBizType());
    	param.put("invoiceeCeoName",vo.getInvoiceeCeoName());
    	param.put("invoiceeContactName",vo.getInvoiceeContactName());
    	param.put("invoiceeCorpName",vo.getInvoiceeCorpName());
    	param.put("invoiceeCorpNum",vo.getInvoiceeCorpNum());
    	param.put("invoiceeEmail",vo.getInvoiceeEmail());
    	param.put("invoiceeHp",vo.getInvoiceeHP1());
    	param.put("invoiceeTel",vo.getInvoiceeTel());
    	param.put("prdItemName",vo.getPrdItem());
    	param.put("prdPurchaseDt",vo.getPrdPurchaseDt());
    	param.put("prdRemark",vo.getPrdRemark());
    	param.put("prdSupplyCost",vo.getPrdSupplyCost());
    	param.put("prdTax",vo.getPrdTax());
    	//param.put("supplyCostTotal",vo.getSupplyCostTotal());
    	param.put("supplyCostTotal",vo.getPrdSupplyCost());
    	//param.put("taxTotal",vo.getTaxTotal());
    	param.put("taxTotal",vo.getPrdTax());
    	param.put("totalAmount",vo.getTotalAmount());
    	param.put("remark",vo.getRemark());
    	param.put("taxInvoiceResultCode", hmResult.get("resultCode"));
    	param.put("taxInvoiceResultMsg", hmResult.get("message"));
    	param.put("taxInvoiceNum", hmResult.get("confirmNum"));
    	param.put("taxInvoiceFlag",taxInvoiceFlag);
    	param.put("taxInvoiceSeq", taxInvoiceSeq);
    	
    	if (hmResult.get("resultCode").toString().equals("1")) {
        	//수수료입금테이블 세금계산서 발행 여부 업데이트
            HashMap<String, Object> param2 = new HashMap<String, Object>();
            param2.put("testReqSeq", vo.getTestReqSeq());
            param2.put("taxInvoiceNum", hmResult.get("confirmNum"));
            param2.put("taxInvoiceAmt", vo.getTotalAmount());
            param2.put("taxInvoiceFlag", "Y");
            
            commissionCheckDAO.updateCommissionDeposit(param2);	
        }

    	commissionCheckDAO.saveCommissionTaxInvoiceResult(param);
    	
        return hmResult;
    }
}
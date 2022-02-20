package iit.lims.accept.vo;

import iit.lims.master.vo.ReqOrgVO;

public class CommissionTaxInvoiceVO extends ReqOrgVO {

	/*********************************************************************
     *							발행 정보
     *********************************************************************/
	
	
	private String testReqSeq;
	
	//접수번호 리스트
	private String testReqNo;
	
	//작성일자
	private String writeDate;
	
	// 과금방향, [정과금, 역과금] 중 선택기재, "역과금"은 역발행세금계산서 발행에만 가능
	private String chargeDirection;

    // 발행유형, [정발행, 역발행, 위수탁] 중 기재
	private String issueType;

    // [영수, 청구] 중 기재
	private String purposeType;

    // 발행시점, [직접발행, 승인시자동발행] 중 기재
	private String issueTiming;

    // 과세형태, [과세, 영세, 면세] 중 기재
	private String taxType;
	
	// 공급자 사업자번호
	private String invoicerCorpNum;
	
	// 공급자 종사업장 식별번호, 필요시 기재. 형식은 숫자 4자리.
	private String invoicerTaxRegID;
	
	// 공급자 상호
	private String invoicerCorpName;
	
	// 공급자 문서관리번호, 1~24자리 (숫자, 영문, '-', '_') 조합으로 사업자 별로 중복되지 않도록 구성
	private String invoicerMgtKey;
	
	// 공급자 대표자성명
	private String invoicerCEOName;
	
	// 공급자 주소
	private String invoicerAddr;
	
	// 공급자 종목
	private String invoicerBizClass;

	// 공급자 업태
    private String invoicerBizType;

    // 공급자 담당자 성명
    private String invoicerContactName;

    // 공급자 담당자 메일주소
    private String invoicerEmail;

    // 공급자 담당자 연락처
    private String invoicerTEL;

    // 공급자 담당자 휴대폰번호
    private String invoicerHP;

    // 발행 안내문자메시지 전송여부
    // - 전송시 포인트 차감되며, 전송실패시 환불처리
    private Boolean invoicerSMSSendYN;

    // 발행번호
    private String taxInvoiceSeq;

    /*********************************************************************
     *							공급받는자 정보
     *********************************************************************/

    // 공급받는자 구분, [사업자, 개인, 외국인] 중 기재
    private String invoiceeType;

    // 공급받는자 사업자번호, '-' 제외 10자리
    private String invoiceeCorpNum;

    // 공급받는자 상호
    private String invoiceeCorpName;

    // [역발행시 필수] 공급받는자 문서관리번호, 1~24자리까지 사업자번호별 중복없는 고유번호 할당
    private String invoiceeMgtKey;

    // 공급받는자 대표자 성명
    private String invoiceeCeoName;

    // 공급받는자 주소
    private String invoiceeAddr;

    // 공급받는자 종목
    private String invoiceeBizClass;

    // 공급받는자 업태
    private String invoiceeBizType;

    // 공급받는자 담당자명
    private String invoiceeContactName;

    // 공급받는자 담당자 메일주소
    private String invoiceeEmail;

    // 공급받는자 담당자 연락처
    private String invoiceeTel;

    // 공급받는자 담당자 휴대폰번호
    private String invoiceeHP1;

    // 역발행시 안내문자메시지 전송여부
    // - 전송시 포인트 차감되며, 전송실패시 환불처리
    private Boolean invoiceeSMSSendYN;


    /*********************************************************************
     *							세금계산서 기재정보
     *********************************************************************/

    // [필수] 공급가액 합계
    private String supplyCostTotal;

    // [필수] 세액 합계
    private String taxTotal;

    // [필수] 합계금액, 공급가액 + 세액
    private String totalAmount;

    // 기재 상 일련번호
    private String serialNum;

    // 기재 상 현금
    private String cash;

    // 기재 상 수표
    private String chkBill;

    // 기재 상 어음
    private String note;

    // 기재 상 외상미수금
    private String credit;

    // 기재 상 비고
    private String remark;
    private short kwon;
    private short ho;

    // 사업자등록증 이미지 첨부여부
    private Boolean businessLicenseYN;

    // 통장사본 이미지 첨부여부
    private Boolean bankBookYN;


    /*********************************************************************
     *				수정세금계산서 정보 (수정세금계산서 작성시 기재)
     * - 수정세금계산서 관련 정보는 연동매뉴얼 또는 개발가이드 링크 참조
     & - [참고] 수정세금계산서 작성방법 안내 [http://blog.linkhub.co.kr/650]
     *********************************************************************/

    // 수정사유코드, 수정사유에 따라 1~6 중 선택기재.
    private short modifyCode;

    // 원본세금계산서 ItemKey, 문서확인 (GetInfo API)의 응답결과 항목 중 ItemKey 확인
    private String originalTaxinvoiceKey;
    
	
    
    /*********************************************************************
     *							상세항목(품목) 정보
     *********************************************************************/
    
    private String prdPurchaseDt;
    
    private String prdItem;
    
    private String prdSupplyCost;
    
    private String prdTax;
    
    private String prdRemark;
    
    
	
	
    private String invoiceDate;
    
    private String invoiceSDate;
    
    private String invoiceEDate;
    
    
	public String getWriteDate() {
		return writeDate;
	}

	public void setWriteDate(String writeDate) {
		this.writeDate = writeDate;
	}

	public String getInvoicerCorpNum() {
		return invoicerCorpNum;
	}

	public void setInvoicerCorpNum(String invoicerCorpNum) {
		this.invoicerCorpNum = invoicerCorpNum;
	}

	public String getInvoicerCorpName() {
		return invoicerCorpName;
	}

	public void setInvoicerCorpName(String invoicerCorpName) {
		this.invoicerCorpName = invoicerCorpName;
	}

	public String getInvoicerMgtKey() {
		return invoicerMgtKey;
	}

	public void setInvoicerMgtKey(String invoicerMgtKey) {
		this.invoicerMgtKey = invoicerMgtKey;
	}

	public String getInvoicerCEOName() {
		return invoicerCEOName;
	}

	public void setInvoicerCEOName(String invoicerCEOName) {
		this.invoicerCEOName = invoicerCEOName;
	}

	public String getInvoicerAddr() {
		return invoicerAddr;
	}

	public void setInvoicerAddr(String invoicerAddr) {
		this.invoicerAddr = invoicerAddr;
	}

	public String getInvoicerBizClass() {
		return invoicerBizClass;
	}

	public void setInvoicerBizClass(String invoicerBizClass) {
		this.invoicerBizClass = invoicerBizClass;
	}

	public String getInvoicerTaxRegID() {
		return invoicerTaxRegID;
	}

	public void setInvoicerTaxRegID(String invoicerTaxRegID) {
		this.invoicerTaxRegID = invoicerTaxRegID;
	}

	public String getInvoicerBizType() {
		return invoicerBizType;
	}

	public void setInvoicerBizType(String invoicerBizType) {
		this.invoicerBizType = invoicerBizType;
	}

	public String getInvoicerContactName() {
		return invoicerContactName;
	}

	public void setInvoicerContactName(String invoicerContactName) {
		this.invoicerContactName = invoicerContactName;
	}

	public String getInvoicerEmail() {
		return invoicerEmail;
	}

	public void setInvoicerEmail(String invoicerEmail) {
		this.invoicerEmail = invoicerEmail;
	}

	public String getInvoicerTEL() {
		return invoicerTEL;
	}

	public void setInvoicerTEL(String invoicerTEL) {
		this.invoicerTEL = invoicerTEL;
	}

	public String getInvoicerHP() {
		return invoicerHP;
	}

	public void setInvoicerHP(String invoicerHP) {
		this.invoicerHP = invoicerHP;
	}

	public Boolean getInvoicerSMSSendYN() {
		return invoicerSMSSendYN;
	}

	public void setInvoicerSMSSendYN(Boolean invoicerSMSSendYN) {
		this.invoicerSMSSendYN = invoicerSMSSendYN;
	}
	
	public String getTaxInvoiceSeq() {
		return taxInvoiceSeq;
	}

	public void setTaxInvoiceSeq(String taxInvoiceSeq) {
		this.taxInvoiceSeq = taxInvoiceSeq;
	}

	public String getInvoiceeType() {
		return invoiceeType;
	}

	public void setInvoiceeType(String invoiceeType) {
		this.invoiceeType = invoiceeType;
	}

	public String getInvoiceeCorpNum() {
		return invoiceeCorpNum;
	}

	public void setInvoiceeCorpNum(String invoiceeCorpNum) {
		this.invoiceeCorpNum = invoiceeCorpNum;
	}

	public String getInvoiceeCorpName() {
		return invoiceeCorpName;
	}

	public void setInvoiceeCorpName(String invoiceeCorpName) {
		this.invoiceeCorpName = invoiceeCorpName;
	}

	public String getInvoiceeMgtKey() {
		return invoiceeMgtKey;
	}

	public void setInvoiceeMgtKey(String invoiceeMgtKey) {
		this.invoiceeMgtKey = invoiceeMgtKey;
	}

	public String getInvoiceeCeoName() {
		return invoiceeCeoName;
	}

	public void setInvoiceeCeoName(String invoiceeCeoName) {
		this.invoiceeCeoName = invoiceeCeoName;
	}

	public String getInvoiceeAddr() {
		return invoiceeAddr;
	}

	public void setInvoiceeAddr(String invoiceeAddr) {
		this.invoiceeAddr = invoiceeAddr;
	}

	public String getInvoiceeBizClass() {
		return invoiceeBizClass;
	}

	public void setInvoiceeBizClass(String invoiceeBizClass) {
		this.invoiceeBizClass = invoiceeBizClass;
	}

	public String getInvoiceeBizType() {
		return invoiceeBizType;
	}

	public void setInvoiceeBizType(String invoiceeBizType) {
		this.invoiceeBizType = invoiceeBizType;
	}

	public String getInvoiceeHP1() {
		return invoiceeHP1;
	}

	public void setInvoiceeHP1(String invoiceeHP1) {
		this.invoiceeHP1 = invoiceeHP1;
	}

	public Boolean getInvoiceeSMSSendYN() {
		return invoiceeSMSSendYN;
	}

	public void setInvoiceeSMSSendYN(Boolean invoiceeSMSSendYN) {
		this.invoiceeSMSSendYN = invoiceeSMSSendYN;
	}

	public String getSupplyCostTotal() {
		return supplyCostTotal;
	}

	public void setSupplyCostTotal(String supplyCostTotal) {
		this.supplyCostTotal = supplyCostTotal;
	}

	public String getTaxTotal() {
		return taxTotal;
	}

	public void setTaxTotal(String taxTotal) {
		this.taxTotal = taxTotal;
	}

	public String getTotalAmount() {
		return totalAmount;
	}

	public void setTotalAmount(String totalAmount) {
		this.totalAmount = totalAmount;
	}

	public String getSerialNum() {
		return serialNum;
	}

	public void setSerialNum(String serialNum) {
		this.serialNum = serialNum;
	}

	public String getCash() {
		return cash;
	}

	public void setCash(String cash) {
		this.cash = cash;
	}

	public String getChkBill() {
		return chkBill;
	}

	public void setChkBill(String chkBill) {
		this.chkBill = chkBill;
	}

	public String getNote() {
		return note;
	}

	public void setNote(String note) {
		this.note = note;
	}

	public String getCredit() {
		return credit;
	}

	public void setCredit(String credit) {
		this.credit = credit;
	}

	public short getKwon() {
		return kwon;
	}

	public void setKwon(short kwon) {
		this.kwon = kwon;
	}

	public short getHo() {
		return ho;
	}

	public void setHo(short ho) {
		this.ho = ho;
	}

	public Boolean getBusinessLicenseYN() {
		return businessLicenseYN;
	}

	public void setBusinessLicenseYN(Boolean businessLicenseYN) {
		this.businessLicenseYN = businessLicenseYN;
	}

	public Boolean getBankBookYN() {
		return bankBookYN;
	}

	public void setBankBookYN(Boolean bankBookYN) {
		this.bankBookYN = bankBookYN;
	}

	public short getModifyCode() {
		return modifyCode;
	}

	public void setModifyCode(short modifyCode) {
		this.modifyCode = modifyCode;
	}

	public String getOriginalTaxinvoiceKey() {
		return originalTaxinvoiceKey;
	}

	public void setOriginalTaxinvoiceKey(String originalTaxinvoiceKey) {
		this.originalTaxinvoiceKey = originalTaxinvoiceKey;
	}

	public String getChargeDirection() {
		return chargeDirection;
	}

	public void setChargeDirection(String chargeDirection) {
		this.chargeDirection = chargeDirection;
	}

	public String getIssueType() {
		return issueType;
	}

	public void setIssueType(String issueType) {
		this.issueType = issueType;
	}

	public String getPurposeType() {
		return purposeType;
	}

	public void setPurposeType(String purposeType) {
		this.purposeType = purposeType;
	}

	public String getIssueTiming() {
		return issueTiming;
	}

	public void setIssueTiming(String issueTiming) {
		this.issueTiming = issueTiming;
	}

	public String getTaxType() {
		return taxType;
	}

	public void setTaxType(String taxType) {
		this.taxType = taxType;
	}

	public String getTestReqNo() {
		return testReqNo;
	}

	public void setTestReqNo(String testReqNo) {
		this.testReqNo = testReqNo;
	}

	public String getPrdPurchaseDt() {
		return prdPurchaseDt;
	}

	public void setPrdPurchaseDt(String prdPurchaseDt) {
		this.prdPurchaseDt = prdPurchaseDt;
	}

	public String getPrdItem() {
		return prdItem;
	}

	public void setPrdItem(String prdItem) {
		this.prdItem = prdItem;
	}

	public String getPrdSupplyCost() {
		return prdSupplyCost;
	}

	public void setPrdSupplyCost(String prdSupplyCost) {
		this.prdSupplyCost = prdSupplyCost;
	}

	public String getPrdTax() {
		return prdTax;
	}

	public void setPrdTax(String prdTax) {
		this.prdTax = prdTax;
	}

	public String getPrdRemark() {
		return prdRemark;
	}

	public void setPrdRemark(String prdRemark) {
		this.prdRemark = prdRemark;
	}

	public String getInvoiceeContactName() {
		return invoiceeContactName;
	}

	public void setInvoiceeContactName(String invoiceeContactName) {
		this.invoiceeContactName = invoiceeContactName;
	}

	public String getInvoiceeEmail() {
		return invoiceeEmail;
	}

	public void setInvoiceeEmail(String invoiceeEmail) {
		this.invoiceeEmail = invoiceeEmail;
	}

	public String getInvoiceeTel() {
		return invoiceeTel;
	}

	public void setInvoiceeTel(String invoiceeTel) {
		this.invoiceeTel = invoiceeTel;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public String getInvoiceDate() {
		return invoiceDate;
	}

	public void setInvoiceDate(String invoiceDate) {
		this.invoiceDate = invoiceDate;
	}

	public String getInvoiceSDate() {
		return invoiceSDate;
	}

	public void setInvoiceSDate(String invoiceSDate) {
		this.invoiceSDate = invoiceSDate;
	}

	public String getInvoiceEDate() {
		return invoiceEDate;
	}

	public void setInvoiceEDate(String invoiceEDate) {
		this.invoiceEDate = invoiceEDate;
	}

	public String getTestReqSeq() {
		return testReqSeq;
	}

	public void setTestReqSeq(String testReqSeq) {
		this.testReqSeq = testReqSeq;
	}
	
}
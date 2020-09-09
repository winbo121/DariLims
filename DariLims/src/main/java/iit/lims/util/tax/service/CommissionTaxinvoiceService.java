package iit.lims.util.tax.service;
import java.util.HashMap;
import com.popbill.api.IssueResponse;

import iit.lims.accept.vo.CommissionTaxInvoiceVO;

public interface CommissionTaxinvoiceService{
	
	public HashMap<String,Object> registIssue(CommissionTaxInvoiceVO vo) throws Exception;
}
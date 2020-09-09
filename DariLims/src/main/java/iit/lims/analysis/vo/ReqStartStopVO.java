package iit.lims.analysis.vo;

import iit.lims.analysis.vo.ResultApprovalVO;

public class ReqStartStopVO extends ResultApprovalVO {
	private String stop_reason;

	public String getStop_reason() {
		return stop_reason;
	}

	public void setStop_reason(String stop_reason) {
		this.stop_reason = stop_reason;
	}
}
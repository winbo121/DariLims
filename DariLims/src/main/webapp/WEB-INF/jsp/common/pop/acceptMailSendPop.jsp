
<%
	/***************************************************************************************
	 * 시스템명 	: DARI 실험실정보관리시스템
	 * 업무명 		: 접수증메일전송
	 * 파일명 		: acceptMailSendPop.jsp
	 * 작성자 		: 송성수
	 * 작성일 		: 2019.12.26
	 * 설  명		: 접수증 메일전송 팝업화면
	 *---------------------------------------------------------------------------------------
	 * 변경일		 변경자		변경내역 
	 *---------------------------------------------------------------------------------------
	 * 2019.12.26   송성수		최초 프로그램 작성         
	 * 
	 *---------------------------------------------------------------------------------------
	 ****************************************************************************************/
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<jsp:useBean id="currentDate" class="java.util.Date" />
<fmt:formatDate var="now" value="${currentDate}" pattern="YYYY-MM-dd" />

<!DOCTYPE html>
<html id="popHtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<link rel="stylesheet" media="screen" type="text/css" href="<c:url value='/css/jquery-ui.css'/>" />
<link rel="stylesheet" media="screen" type="text/css" href="<c:url value='/css/jqgrid/ui.jqgrid.css'/>" />
<link rel="stylesheet" media="screen" type="text/css" href="<c:url value='/css/tree/ui.fancytree.css'/>" />
<link rel="stylesheet" media="screen" type="text/css" href="<c:url value='/css/common/common.css'/>" />
<link rel="stylesheet" media="screen" type="text/css" href="<c:url value='/css/common/main.css'/>" />
<link rel="stylesheet" media="screen" type="text/css" href="<c:url value='/css/common/sub.css'/>" />
<link rel="stylesheet" media="screen" type="text/css" href="<c:url value='/css/common/crownix-viewer.min.css'/>" />
<script type="text/javascript" src="<c:url value='/script/lims.pop.js'/>"></script>
<script type="text/javascript" src="<c:url value='/script/jquery-1.11.0.min.js?time=${now}'/>"></script>
<script type="text/javascript" src="<c:url value='/script/jquery-ui.min.js?time=${now}'/>"></script>
<script type="text/javascript" src="<c:url value='/script/jquery.blockUI.js?time=${now}'/>"></script>
<script type="text/javascript" src="<c:url value='/script/jquery.form.js?time=${now}'/>"></script>
<script type="text/javascript" src="<c:url value='/script/jquery.message.js?time=${now}'/>"></script>
<script type="text/javascript" src="<c:url value='/script/jqgrid/grid.locale-kr.js?time=${now}'/>"></script>
<script type="text/javascript" src="<c:url value='/script/jqgrid/jquery.jqGrid.min.js?time=${now}'/>"></script>
<script type="text/javascript" src="<c:url value='/script/tree/jquery.fancytree-all.min.js?time=${now}'/>"></script>
<script type="text/javascript" src="<c:url value='/script/lims.com.js?time=${now}'/>"></script>
<script type="text/javascript" src="<c:url value='/script/lims.com.grid.js?time=${now}'/>"></script>
<script type="text/javascript" src="<c:url value='/script/crownix-invoker.min.js?time=${now}'/>"></script>
<script type="text/javascript" src="<c:url value='/script/crownix-viewer.min.js?time=${now}'/>"></script>

<title>LIMS</title>
<script type="text/javascript">
	var popupName = window.name; // 팝업창 이름 가져오기
	var test_req_no;
	$(function() {
		test_req_seq = popupName;
		
		//메일그룹콤보세팅
		ajaxComboForm("mailToSelect", "", "CHOICE", null, 'mailForm'); // 부서
		ajaxComboForm("mailToSelectCc", "", "CHOICE", null, 'mailForm'); // 부서
		
		//의뢰번호로 정보 가져오기
		var param = "test_req_seq=" + test_req_seq;
		var reqInfo = fnAjaxAction("selectAcceptDetailInfo.lims",param);

		//신청자명
		$('#reqNm').val(reqInfo.req_nm);
		//이메일주소
		$('#mailTo').val(reqInfo.req_org_email);
		//접수번호
		$('#testReqNo').val(reqInfo.test_req_no);
		//시료수
		$('#totSampleCnt').val(reqInfo.tot_sample_count);
		//지급제도
		if (reqInfo.express_flag == "N")
			$("#expressFlagN").attr('checked', 'checked');
		else if (reqInfo.express_flag == "Y")
			$("#expressFlagY").attr('checked', 'checked');
		else if (reqInfo.express_flag == "X")
			$("#expressFlagX").attr('checked', 'checked');
		
		//분석상태
		$('#state').val(reqInfo.state);
		//시료접수일
		$('#actDate').val(reqInfo.act_date);
		//분석완료예정일
		$('#deadlineDate').val(reqInfo.deadline_date);
		//분석완료일
		$('#deptApprDate').val(reqInfo.dept_appr_date);
		//분석료
		$('#feeTot').val(reqInfo.fee_tot);
		//샘플링 넘버
		$('#samplingNo').val(reqInfo.sampling_no);
		//견적서
		if (reqInfo.est_check == "N"){
			$("#estCheckN").attr('checked', 'checked');
		}else if (reqInfo.est_check == "Y"){
			$("#estCheckY").attr('checked', 'checked');
		}
		$('#est_no').val(reqInfo.est_no);
		$('#est_check').val(reqInfo.est_check);
		
		//성적서 제목(보여주기용)		
		var mailTitle = '';
		var sampling_no = reqInfo.sampling_no;
		var test_req_no = reqInfo.test_req_no;
		if (sampling_no == '' || sampling_no == null ) {
			mailTitle = "접수증 송부의 건 [" + test_req_no + "]";
		} else {
			//mailTitle = "성적서 송부의 건 [" + test_req_no + "] ["+sampling_no+"]";
			mailTitle = "접수증 송부의 건 [" + test_req_no + "]";
		}
		$('#mailTitle').val(mailTitle);
		
	});
	
	//메일전송
	function btn_Mail_Send_onclick() {
		if(confirm("메일을 전송하시겠습니까?")){
			if (!confirm("접수증을 전송하시겠습니까?")) {
				return false;
			}
			
			//이메일 주소 오류 확인 
			var mailTo = $("#mailTo").val();
	  		var mailToChk1 = mailTo.match(/</);
	  		var mailToChk2 = mailTo.match(/>/);
	  		if (mailTo == '' || mailTo == null ){
	  			alert("이메일을 입력해 주시기 바랍니다.")
				return false;
	 		} else if (mailToChk1 == "<"){
	 			if (mailToChk2 != ">"){
	 				alert("이메일을 바르게 입력해 주시기 바랍니다.")
	 				return false;
	 			}
	 		}
			
			var arrReportFile = new Array();
			var arrParam = new Array();
			
			//견적서 여부
			if($('#est_no').val() == ""){
				arrReportFile[0] = "ReceiptPaper_V01.mrd";
				arrParam[0] = test_req_seq;
			}
			else {
				if($('#est_check').val() == "Y"){
					
					arrReportFile[0] = "ReceiptPaper_V01.mrd";
					arrReportFile[1] = "EstimatePaper_V01.mrd";
					arrParam[0] = test_req_seq;
					arrParam[1] = $('#est_no').val();
				}
				else {
					arrReportFile[0] = "ReceiptPaper_V01.mrd";
					arrParam[0] = test_req_seq;
				}
			}
			getReportFile3(arrReportFile, arrParam, $('#testReqNo').val(), $('#samplingNo').val(),$('#est_check').val(), $('#mailTitleAdd').val());
		}

	}

	
</script>
</head>
<body id="popBody" onunload="opener.fnBasicEndLoading();">
<div class="popUp">
	<div class="pop_area pop_intro">
		<h2>접수증 메일 전송</h2>
		<div>
			<form id="mailForm" name="mailForm" onsubmit="return false;">
				<input name="est_no" id="est_no" type="hidden"/>
				<input name="est_check" id="est_check" type="hidden"/>
				<div class="sub_purple_01" style="margin-top: 0px;">
					<table width="100%" border="0" class="select_table">
						<tr>
							<td width="20%" class="table_title">
								<span style="font-size: 11px; margin-left: 15px; color: #b27ce0;">■</span>
								메일전송
							</td>
							<td class="table_button" style="text-align: right; padding-right: 30px;">
 								<span class="button white mlargeb auth_select" id="btn_Mail_Send" onclick="btn_Mail_Send_onclick();"> 
 									<button type="button">전송</button>
 								</span>
								<span class="button white mlargep" id="btn_Cancel" onclick="window.close();">
									<button type="button">닫기</button>
								</span>
							</td>
						</tr>
					</table>
					<table class="list_table">
					<tr>
						<td width="20%" class="table_title" colspan="2">
							<span style="font-size: 11px; margin-left: 15px; color: #b27ce0;">■</span>메일관리
						</td>
					</tr>
					<tr>
						<th>받는사람</th>
						<td>
							<input name="mailTo" id="mailTo" type="email" class="w300px" />
						</td>
					</tr>
					<tr>
						<th>참조메일</th>
						<td>
							<span class="button white mlargeb auth_select" id="btn_Add_Mail_Org_Cc" onclick='fnpop_reqOrgChoicePop("mailForm", "750", "550", "참조메일")'/>
								<button type="button">업체정보</button>
							</span> 
							 <span class="button white mlargeb auth_select" id="btn_Add_Mail_Group_Cc" onclick='fnpop_mailGroupChoicePop("mailForm", "750", "550", "참조메일");'>
								<button type="button">메일그룹</button>
							</span>  
							</br>
								<textarea rows="10" name="mailToCc" id="mailToCc" class="w70p"></textarea>
							<br/>
							<input name="mailCc" id="mailCc" type="hidden"/>
							<div id="mailCcDiv"></div>
						</td>
					</tr>
					<tr>
						<th>숨은참조메일</th>
						<td>
							<span class="button white mlargeb auth_select" id="btn_Add_Mail_Group_Bcc" onclick='fnpop_reqOrgChoicePop("mailForm", "750", "550", "숨은참조메일")'/>
								<button type="button">업체정보</button>
							</span> 
							<span class="button white mlargeb auth_select" id="btn_Add_Mail_Group_Bcc" onclick='fnpop_mailGroupChoicePop("mailForm", "750", "550", "숨은참조메일");'>
								<button type="button">메일그룹</button>
							</span>  
							</br>
							<textarea rows="3" name="mailToBcc" id="mailToBcc" class="w70p"></textarea>		

							<input name="mailBcc" id="mailBcc" type="hidden"/>
							<div id="mailBccDiv"></div>
						</td>
					</tr>
					<tr>
						<th>메일제목</th>
						<td>
							<input name="mailTitle" id="mailTitle" type="text" class="w300px" disabled="disabled"/></br>
							<input name="mailTitleAdd" id="mailTitleAdd" type="text" class="w500px" placeholder="메일 제목을 입력해주세요" onfocus="this.placeholder=''"/></br>
						</td>
					</tr>
					</table>
					
					<table class="list_table">
					<tr>
						<td width="20%" class="table_title" colspan="2">
							<span style="font-size: 11px; margin-left: 15px; color: #b27ce0;">■</span>분석업무내용
						</td>
					</tr>
					<tr>
						<th>신청자명</th>
						<td>
							<input name="reqNm" id="reqNm" type="text" class="w300px" readonly="readonly" disabled="disabled"/>
						</td>
					</tr>
					<tr>
						<th>접수번호</th>
						<td>
							<input name="testReqNo" id="testReqNo" type="text" class="w300px" disabled="disabled"/>
						</td>
					</tr>
					<tr>
						<th>Sampling NO</th>
						<td>
							<input name="samplingNo" id="samplingNo" type="text" class="w300px" disabled="disabled"/>
						</td>
					</tr>
					<tr>
						<th>시료수</th>
						<td>
							<input name="totSampleCnt" id="totSampleCnt" type="text" class="w100px" disabled="disabled"/>
						</td>
					</tr>
					<tr>
						<th>지급제도</th>
						<td>
							<input name="expressFlag" id="expressFlagN" type="radio" value="N"  disabled="disabled"/>
							<label for="expressFlagN">일반</label>	
							<input name="expressFlag" id="expressFlagY" type="radio" value="Y" disabled="disabled"/>
							<label for="expressFlagY">지급</label>
							<input name="expressFlag" id="expressFlagX" type="radio" value="X" disabled="disabled"/>
							<label for="expressFlagX">입회</label>	
						</td>
					</tr>
					
					<tr>
						<th>분석상태</th>
						<td>
							<input name="state" id="state" type="text" class="w300px" disabled="disabled"/>
						</td>
					</tr>
					<tr>
						<th>시료접수일</th>
						<td>
							<input name="actDate" id="actDate" type="text" class="w300px" disabled="disabled"/>
						</td>
					</tr>
					<tr>
						<th>분석완료예정일</th>
						<td>
							<input name="deadlineDate" id="deadlineDate" type="text" class="w300px" disabled="disabled"/>
						</td>
					</tr>
					<tr>
						<th>분석료</th>
						<td>
							<input name="feeTot" id="feeTot" type="text" class="w300px" disabled="disabled"/>
						</td>
					</tr>
					<tr>
						<th>견적서 전송여부</th>
						<td>
							<input name="est_check" id="estCheckN" type="radio" value="N" disabled="disabled"/>
							<label for="accept_method_n">전송안함</label>	
							<input name="est_check" id="estCheckY" type="radio" value="Y" disabled="disabled"/>
							<label for="est_check_y">전송함</label>
						</td>
					</tr>

					</table>
				</div>
			</form>
		</div>
	</div>
</div>

<div id="crownix-viewer" style="width:0px; height:0px; display:none;"></div>

</body>
</html>

<%
	/***************************************************************************************
	 * 시스템명 	: DARI 실험실정보관리시스템
	 * 업무명 		: 성적서메일전송
	 * 파일명 		: reportMailSendPop.jsp
	 * 작성자 		: 한지연
	 * 작성일 		: 2020.03.03
	 * 설  명		: 성적서 메일전송 팝업화면
	 *---------------------------------------------------------------------------------------
	 * 변경일		 변경자		변경내역 
	 *---------------------------------------------------------------------------------------
	 * 2020.03.03   한지연		최초 프로그램 작성         
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
	var log_no;
	$(function() {
		log_no = popupName;
		
		//메일그룹콤보세팅
		ajaxComboForm("mailToSelect", "", "CHOICE", null, 'mailForm'); // 부서
		ajaxComboForm("mailToSelectCc", "", "CHOICE", null, 'mailForm'); // 부서
		
		//의뢰번호로 정보 가져오기
		var param = "log_no=" + log_no;
		var reqInfo = fnAjaxAction("selectReportMailList.lims",param);

		//신청자명
		$('#reqNm').val(reqInfo[0].req_nm);
		//이메일주소
		$('#mailTo').val(reqInfo[0].req_org_email); 
		//성적서발행번호
		$('#reportPublishNo').val(reqInfo[0].report_publish_no);
		
		//성적서 제목(보여주기용)		
		var mailTitle = '';
		var sampling_no = reqInfo[0].sampling_no;
		var test_req_no = reqInfo[0].test_req_no;
		if (sampling_no == '' || sampling_no == null ) {
			mailTitle = "성적서 송부의 건 [" + test_req_no + "]";
		} else {
			//mailTitle = "성적서 송부의 건 [" + test_req_no + "] ["+sampling_no+"]";
			mailTitle = "성적서 송부의 건 [" + test_req_no + "]";
		}
		$('#mailTitle').val(mailTitle);
	});
	function  goto1(num) {
		
		if(num==1){
			var fileValue = $("#file1").val().split("\\");
			
			var fileName = fileValue[fileValue.length-1];

			$('#filename1').html(fileName);
			
		}
		else if(num==2){
			var fileValue = $("#file2").val().split("\\");
			
			var fileName = fileValue[fileValue.length-1];
		
			$('#filename2').html(fileName);
		}
		else{
			var fileValue = $("#file3").val().split("\\");
			
			var fileName = fileValue[fileValue.length-1];
			
			$('#filename3').html(fileName);
		}
			
	}
	
	//메일전송
	function btn_Mail_Send_onclick() {
	
		if(confirm("메일을 전송하시겠습니까?")){ 

		var report_doc_seq = popupName;
		

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
 		
		var param = "log_no=" + log_no;
		var reqInfo = fnAjaxAction("selectReportMailList.lims",param);
		
		var formNm = reqInfo[0].form_name;
		var formVersion = reqInfo[0].doc_revision_seq;
		var reportFileNm = formNm + "_V" + formVersion + ".mrd";
		var form_seq = reqInfo[0].form_seq;
		var form_name = reqInfo[0].form_name;
		
		var test_req_seq = reqInfo[0].test_req_seq; 
		var test_sample_seq = reqInfo[0].test_sample_seq;
		var test_req_no = reqInfo[0].test_req_no;
		var report_doc_seq = reqInfo[0].report_doc_seq;
		var pick_no = reqInfo[0].pick_no;
		var report_publish_no = reqInfo[0].report_publish_no;
		var sampling_no = reqInfo[0].sampling_no;
		//var req_etc = reqInfo[0].req_etc;
		
		var formData = new FormData($("#mailForm")[0]);
				
		console.log("폼데이타 " + formData);
		console.log(formData);
		
		//바이오고형연료성적서구분
		if(form_seq == "19-025" || form_seq == "19-026"|| form_seq == "19-028"|| form_seq == "19-029"){
			getReportFile(reportFileNm, "/rp ["+report_publish_no+"] ["+pick_no+"] [REPORT_PUBLISH_LOG] [REPORT_SAMPLE_PL] [REPORT_SAMPLE_ITEM_PL] [REPORT_PUBLISH_NO] " ,  test_req_no, sampling_no, formData);
		//목재제품규격품질검사구분
		}else if(form_seq == "19-002" || form_seq == "19-003" || form_seq == "19-004" || form_seq == "19-005" ){
			getReportFile(reportFileNm, "/rp ["+report_publish_no+"] ["+test_sample_seq+"] [REPORT_PUBLISH_LOG] [REPORT_SAMPLE_PL] [REPORT_SAMPLE_ITEM_PL] [REPORT_PUBLISH_NO]" ,  test_req_no, sampling_no, formData);
			
		}else{
			var reportChk = form_name.match(/multiplex/);
			var reportChkSingle = form_name.match(/single/); 
			var arr_sample = new Array();
			
			var std_flag = "N";
			if ( form_seq == "19-011" || form_seq == "19-012" || form_seq == "19-019" || form_seq == "19-020" || form_seq == "20-005"){
				std_flag = "Y";
			}
			if(reportChk == "multiplex"){

				//공인 - 일반 Mix
				if (form_seq == "20-005"||form_seq == "20-006"){
					if (test_sample_seq.length > 19){
					alert("공인/일반 성적서의 시료는 2개까지 가능합니다.")
						return false;
					} else {
						var arrReportFile = new Array();
						
						arrReportFile[0] = "TestResultKOLAS-multiplexEN_V01.mrd";
						arrReportFile[1] = "TestResult-multiplexEN_V01.mrd";
						
						if(test_sample_seq.length > 1){
							var arr_sample = test_sample_seq.split(',');
							var separation = new Array();

							for (i = 1; i <test_sample_seq.length+1; i++ ){
								var add = i;
								separation[i-1]=add;
							}
							getReportFile2(arrReportFile, report_publish_no, arr_sample, "REPORT_PUBLISH_LOG", "REPORT_SAMPLE_PL", "REPORT_SAMPLE_ITEM_PL", std_flag, "REPORT_PUBLISH_NO", separation,  test_req_no, "mix", formData);
						
						}
					}
				} else {
					//분리발행
					if(test_sample_seq.length > 9){
						var arr_sample = test_sample_seq.split(',');
						var separation = new Array();
						for (i = 1; i <((test_sample_seq.length+1)/10)+1; i++ ){
							var add = i;
							separation[i-1]=add;
						}
						getReportFile2(reportFileNm, report_publish_no, arr_sample, "REPORT_PUBLISH_LOG", "REPORT_SAMPLE_PL", "REPORT_SAMPLE_ITEM_PL", std_flag, "REPORT_PUBLISH_NO" , separation ,  test_req_no, "sep", formData);
					} else {
						var separation = null;
						getReportFile(reportFileNm, "/rp ["+report_publish_no+"]["+test_sample_seq+"][REPORT_PUBLISH_LOG] [REPORT_SAMPLE_PL] [REPORT_SAMPLE_ITEM_PL]["+std_flag+"][REPORT_PUBLISH_NO]["+separation+"]" ,  test_req_no, sampling_no, formData);
					}
				}
			}
			//단일항목
			if( reportChkSingle == "single"){
				var arr_sample = test_sample_seq.split(',');
				getReportFile(reportFileNm, "/rp ["+report_publish_no+"]["+test_sample_seq+"][REPORT_PUBLISH_LOG] [REPORT_SAMPLE_PL] [REPORT_SAMPLE_ITEM_PL]["+std_flag+"][REPORT_PUBLISH_NO]" , test_req_no, sampling_no, formData);
			}
		}
	}
	}
	
	
	
</script>
</head>
<body id="popBody" onunload="opener.fnBasicEndLoading();">
<div class="popUp">
	<div class="pop_area pop_intro">
		<h2>성적서 메일 전송</h2>
		<div>
			<form id="mailForm" name="mailForm" onsubmit="return false;" enctype="multipart/form-data">
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
							<input name="mailTo" id="mailTo" type="text" class="w300px" />
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
					<tr>
						<th>메일내용</th>
						<td>
							<textarea id="mailContents" name="mailContents" rows=30 cols=92></textarea>
						</td>
					</tr>
					<tr>
						<th>첨부파일1</th>
						<td>
							파일이름 : <em id='filename1'></em> <br>
							<input type="file" name="mailAttach" size="50" onchange="goto1(1);" id='file1' >
						</td>
					</tr>
					<tr>
						<th>첨부파일2</th>
						<td>
							파일이름 : <em id='filename2'></em> <br>
							<input type="file" name="mailAttach" size="50" onchange="goto1(2);" id='file2' >
						</td>
					</tr>
					<tr>
						<th>첨부파일3</th>
						<td>
							파일이름 : <em id='filename3'></em> <br>
							<input type="file" name="mailAttach" size="50" onchange="goto1(3);" id='file3' >
						</td>
					</tr>
					</table>
					
					<table class="list_table">
					<tr>
						<td width="20%" class="table_title" colspan="2">
							<span style="font-size: 11px; margin-left: 15px; color: #b27ce0;">■</span>시험접수내용
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
							<input name="reportPublishNo" id="reportPublishNo" type="text" class="w300px" disabled="disabled"/>
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
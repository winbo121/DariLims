
<%
	/***************************************************************************************
	 * 시스템명 	: 통합장비관제시스템
	 * 업무명 		: 의뢰처 조회(팝업)
	 * 파일명 		: reqOrgChoicePop.jsp
	 * 작성자 		: 진영민
	 * 작성일 		: 2015.01.22
	 * 설  명		: 
	 *---------------------------------------------------------------------------------------
	 * 변경일		 변경자		변경내역 
	 *---------------------------------------------------------------------------------------
	 * 2015.09.09    최은향		최초 프로그램 작성         
	 * 
	 *---------------------------------------------------------------------------------------
	 ****************************************************************************************/
%>
<%@ page language="java" contentType="text/html; charsfet=UTF-8" pageEncoding="UTF-8"%>
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
<script type="text/javascript" src="<c:url value='/script/lims.pop.js?time=${now}'/>"></script>

<title>LIMS</title>

<script type="text/javascript">
	var obj;
	var popupName = window.name; // 팝업창 이름 가져오기
	var fnGridInit = false;
	
	$(function() {
		obj = window.dialogArguments;
		grid('../accept/selectReqOrgList.lims', 'orgForm', 'orgGrid');
		gridSub('../commonCode/selectCommonCodeDept.lims', 'formSub', 'gridSub');
		
		
		$(window).bind('resize', function() {
			$("#orgGrid").setGridWidth($('#view_grid_main').width(), false);
		}).trigger('resize');
		
		$(window).bind('resize', function() {
			$("#gridSub").setGridWidth($('#view_grid_sub2').width(), false);
		}).trigger('resize');
		
		$('#tabs').tabs({
			create : function(event, ui) {
				// 기본
				$('#tabs').tabs("enable", 0);
				$('#tabs').tabs("enable", 1);
				$('#tabs').tabs("enable", 2);
				$("#orgGrid").setGridWidth($('#view_grid_main').width(), false);
				$("#gridSub").setGridWidth($('#view_grid_sub2').width(), false);
			},
			activate : function(event, ui) {
				$("#orgGrid").setGridWidth($('#view_grid_main').width(), false);
				$("#gridSub").setGridWidth($('#view_grid_sub2').width(), false);
			}
			
		});

		ajaxComboForm("org_type", "C24", "ALL", null, 'orgForm');
		ajaxComboForm("org_type", "C24", "ALL", null, 'detailForm');
		fn_Enter_Search('orgForm', 'orgGrid');
	});


	// 의뢰처 그리드
	function grid(url, form, grid) {
		$('#' + grid).jqGrid({
			datatype : function(json) {
				fnGridInit ? fn_GridData(url, form, grid) : fnGridInit = true;
			},
			height : '290',
			autowidth : true,
			gridview : true,
			shrinkToFit : false,
			rowNum : -1,
			rownumbers : true,
			pager : "#"+grid+"Pager",
			viewrecords : true,
			scroll : true,
			rowList:[50,100,200],
			prmNames : {
				id : 'KEY',
				page : 'pageNum',
				rows : 'pageSize',
				sort : 'sortTarget',
				order : 'sortValue'
			},
				jsonReader : {        
				root : 'rows',        
				page : 'pageNum',        
				rowNum : 'pageSize',        
				records : 'total',        
				total : 'totalPage',        
				id : 'row_num',     
				repeatitems : true        
			},
			colModel : [ {
				index : 'req_org_no',
				label : '의뢰처번호',
				name : 'req_org_no',
				key : true,
				hidden : true
			}, {
				label : '의뢰처코드',
				name : 'org_type_cd',
				hidden : true	
			}, {
				label : '의뢰처구분',
				name : 'org_type',
				width : '90',
				align : 'center'
			}, {
				label : '의뢰처',
				name : 'org_nm'
			}, {
				label : '담당자',
				//name : 'charger'
				name : 'req_nm',
				width : '80',
				align : 'center'
			}, {
				label : '담당자 전화번호',
				name : 'charger_tel'
				//name : 'req_tel'
			}, {
				label : 'EMAIL',
				name : 'email'
			}, {
				label : '결제담당자',
				name : 'pay_nm',
				width : '80'			
			} , {
				label : '결제담당자 전화번호',
				name : 'pay_tel',
				width : '120'			
			} , {
				label : '결제담당자 이메일',
				name : 'pay_email',
				width : '120'			
			} ,{
				label : '사업자번호',
				name : 'biz_no',
				width : '90' 
			}, {
				label : '업태',
				name : 'bsnsc',
				width : '80'
			}, {
				label : '종목',
				name : 'item',
				width : '80'
			}, {
				label : '법인번호',
				name : 'cor_no',
				width : '80'
			}, {
				label : '비고',
				name : 'org_desc'
			}, {
				label : '대표자',
				name : 'pre_man'
			}, {
				label : '할인률',
				hidden : true,
				name : 'discount_rate'
			}, {
				label : '할인여부',
				hidden : true,
				name : 'discount_flag'
			}, {
				label : '의뢰자전화번호',
				name : 'pre_tel_num'
			}, {
				label : '팩스',
				name : 'pre_fax_num'
			}, {
				label : '우편번호',
				name : 'zip_code'
			}, {
				label : '주소',
				name : 'addr1',
				width : '200'
			}, {
				label : '상세주소',
				name : 'addr2',
				width : '200'			
			}],
			gridComplete : function() {
			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
			},
			onSelectRow : function(rowId, status, e) {
			},
			ondblClickRow : function(rowId, iRow, iCol, e) {
				btn_Choice_Onclick(grid);
			}
		});
	}

	// 부서 그리드
	function gridSub(url, form, grid) {
		$('#' + grid).jqGrid({
			datatype : function(json) {
				fnGridData(url, form, grid);
			},
			height : '288',
			autowidth : true,
			loadonce : true,
			mtype : "POST",
			gridview : true,
			shrinkToFit : false,
			rowNum : -1,
			rownumbers : true,
			colModel : [ {
				index : 'req_org_no',
				label : 'code',
				name : 'code',
				key : true,
				hidden : true
			}, {
				index : 'req_org_nm',
				label : '부서',
				name : 'code_Name'
			} ],
			gridComplete : function() {
			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
			},
			onSelectRow : function(rowId, status, e) {
			},
			ondblClickRow : function(rowId, iRow, iCol, e) {
				btn_Choice_Onclick(grid);
			}
		});
	}

	// 조회시 이벤트
	function btn_Select_onclick() {
		$('#orgGrid').setGridParam({page: 1});
		$('#orgGrid').trigger('reloadGrid');
	}
	
	// 저장 이벤트
	function fn_suc(json) {
		if (json == null) {
			$.showAlert("저장 실패하였습니다.");
		} else {
			//$('#detailForm').find('#inst_no').val(json);
			$.showAlert("", {
				type : 'insert'
			});
			btn_Select_onclick();
		}
	}
	
	// 저장 시 이벤트
	function btn_Save_onclick(grid) {
		// 필수값 체크
		if(formValidationCheck("detailForm")){
			return;
		}
				
		if ($('#detailForm').find('#biz_file').val() != '') {
			var json = fnAjaxFileAction('../master/insertReqOrg.lims', 'detailForm', fn_suc);
		} else {
			var param = $('#detailForm').serialize();
			var json = fnAjaxAction('../master/insertReqOrg.lims', param);
			if (json == null) {
				$.showAlert("저장 실패하였습니다.");
			} else {
				$('#orgGrid').trigger('reloadGrid');
				$.showAlert("", {
					type : 'insert'
				});
			}
		}
	}
		 
	// 해당 row 선택시 이벤트
	function btn_Choice_Onclick(grid) {
		
		var closeORnot="";
		
		var parent = opener.window.document;
		var rowId = $('#' + grid).getGridParam('selrow');
		var data;
		if (rowId != null) {
			var row = $('#' + grid).getRowData(rowId);
			
			if(grid != 'gridSub'){
				// 부모창에 던져주기
				// 의뢰업체
				if(popupName == '의뢰업체'){
					parent.reqDetailForm.req_org_no.value = row.req_org_no;
					parent.reqDetailForm.req_org_nm.value = row.org_nm;
					parent.reqDetailForm.req_nm.value = row.req_nm;
					parent.reqDetailForm.req_org_addr.value = row.addr1 + " " + row.addr2;
					parent.reqDetailForm.charger_tel.value = row.charger_tel;
					parent.reqDetailForm.email.value = row.email;
					// 할인율과 할인 여부가 있을때만..
					if(row.discount_rate != '' &&  row.discount_flag != ''){
						//parent.reqDetailForm.discount_rate.value = row.discount_rate; // 할인율
						opener.fnpop_reqOrgcallback(row.discount_flag);
					} else {
						//parent.reqDetailForm.discount_rate.value = ''; // 할인율
						opener.fnpop_reqOrgcallback('N');
					}
					
				} else if(popupName == '소유업체'){	// 소유업체
					parent.reqDetailForm.req_org_no2.value = row.req_org_no;
					parent.reqDetailForm.req_org_nm2.value = row.org_nm;
					parent.reqDetailForm.req_org_addr2.value = row.addr1 + " " + row.addr2;
					parent.reqDetailForm.charger_tel2.value = row.charger_tel;
				} else if(popupName == '계산서발행업체'){	// 계산서발행업체
					parent.reqDetailForm.req_org_no3.value = row.req_org_no;
					parent.reqDetailForm.req_org_nm3.value = row.org_nm;
					parent.reqDetailForm.req_org_addr3.value = row.addr1 + " " + row.addr2;
					parent.reqDetailForm.charger_tel3.value = row.charger_tel;
				} else if(popupName == '상담의뢰업체'){
					parent.counselTotalPopForm.req_org_no.value = row.req_org_no;
					parent.counselTotalPopForm.org_nm.value = row.org_nm;
					parent.counselTotalPopForm.org_type_cd.value = row.org_type_cd;
					parent.counselTotalPopForm.org_type.value = row.org_type;
					parent.counselTotalPopForm.zip_code.value = row.zip_code;
					parent.counselTotalPopForm.addr1.value = row.addr1 + " " + row.addr2;
					parent.counselTotalPopForm.pre_tel_num.value = row.prcharger_tele_tel_num;
					parent.counselTotalPopForm.req_nm.value = row.req_nm;
					parent.counselTotalPopForm.req_tel.value = row.req_tel;
				} else if(popupName == '장비대여접수'){
					parent.instRentPopForm.req_org_no.value = row.req_org_no;
					parent.instRentPopForm.org_nm.value = row.org_nm;
					parent.instRentPopForm.org_type_cd.value = row.org_type_cd;
					parent.instRentPopForm.org_type.value = row.org_type;
					parent.instRentPopForm.zip_code.value = row.zip_code;
					parent.instRentPopForm.addr1.value = row.addr1 + " " + row.addr2;
					parent.instRentPopForm.pre_tel_num.value = row.pre_tel_num;
					parent.instRentPopForm.req_nm.value = row.req_nm;
					parent.instRentPopForm.req_tel.value = row.req_tel;
				} else if(popupName == '조회의뢰'){
					parent.reqListForm.req_org_nm.value = row.org_nm;
					parent.reqListForm.req_nm.value = row.req_nm;
				} else if(popupName == '의뢰정보팝업'){
					parent.reqForm.req_org_no.value = row.req_org_no;
					parent.reqForm.req_org_nm.value = row.org_nm;
					parent.reqForm.req_nm.value = row.req_nm;
					parent.reqForm.zip_code.value = row.zip_code;
					parent.reqForm.addr1.value = row.addr1;
					parent.reqForm.addr2.value = row.addr2;
					parent.reqForm.req_tel.value = row.pre_tel_num;
				} else if(popupName == '결과입력'){
					parent.reqListForm.req_org_nm.value = row.org_nm;
					parent.reqListForm.req_nm.value = row.req_nm;
				} else if(popupName == '성적서발행'){
					parent.reportWriteForm.req_org_nm.value = row.org_nm;
				} else if(popupName == '성적서작성'){
					parent.reportReqForm.req_org_nm.value = row.org_nm;
				} else if(popupName == '견적업체'){
					parent.estimatePopFrom.est_org_no.value = row.req_org_no;
					parent.estimatePopFrom.est_org_nm.value = row.org_nm;
				} else if(popupName == '견적업체_TEMP'){
					parent.templateForm.est_org_no.value = row.req_org_no;
					parent.templateForm.est_org_nm.value = row.org_nm;
				} else if(popupName == '성적서_POPUP'){
					parent.reportWritePopForm.destination_nm.value = row.org_nm;
					parent.reportWritePopForm.req_org_addr.value = row.addr1;
				} else if(popupName == '참조메일'){
					for(var i=0; i<parent.mailForm.mailToCc.value.split(',').length; i++){
						if(parent.mailForm.mailToCc.value.split(',')[i].substring((parent.mailForm.mailToCc.value.split(',')[i].indexOf('<'))+1,parent.mailForm.mailToCc.value.split(',')[i].indexOf('>'))== row.email){
							closeORnot="1"
						}						
					}
				  if(closeORnot==""){
					if(parent.mailForm.mailToCc.value  == null || parent.mailForm.mailToCc.value == ''){
						parent.mailForm.mailToCc.value =  '"' + row.req_nm+ '" <' + row.email  + '>'; // 메일 팝업창 참조메일이 빈공간일때 
					} else {
						parent.mailForm.mailToCc.value = parent.mailForm.mailToCc.value +", "+ "\n" +'"' + row.req_nm + '" <' + row.email + '>';// 메일 팝업창 참조메일이 빈공간아닐때
					}
				   }
				} else if(popupName == '숨은참조메일'){
					for(var i=0; i<parent.mailForm.mailToBcc.value.split(',').length; i++){
						if(parent.mailForm.mailToBcc.value.split(',')[i].substring((parent.mailForm.mailToBcc.value.split(',')[i].indexOf('<'))+1,parent.mailForm.mailToBcc.value.split(',')[i].indexOf('>'))==row.email){
							closeORnot="1"
						}				
					}
				if(closeORnot==""){
					if(parent.mailForm.mailToBcc.value  == null || parent.mailForm.mailToBcc.value == ''){
						parent.mailForm.mailToBcc.value =  '"' + row.req_nm+ '" <' + row.email + '>'; // 메일 팝업창 참조메일이 빈공간일때 
					} else {
						parent.mailForm.mailToBcc.value = parent.mailForm.mailToBcc.value +", "+ "\n" +'"' + row.req_nm + '" <' + row.email + '>';// 메일 팝업창 참조메일이 빈공간아닐때
					}
				 }
				} else{	// 성적서발행업체
					parent.reqDetailForm.req_org_no4.value = row.req_org_no;
					parent.reqDetailForm.req_org_nm4.value = row.org_nm;
					parent.reqDetailForm.req_org_addr4.value = row.addr1 + " " + row.addr2;
					parent.reqDetailForm.charger_tel4.value = row.charger_tel;
				}
			}else{ // 부서 그리드에서 선택시
				if(popupName == '의뢰업체'){
					parent.reqDetailForm.req_org_no.value = row.code;
					parent.reqDetailForm.req_org_nm.value = row.code_Name;
					parent.reqDetailForm.req_nm.value = "";
					parent.reqDetailForm.req_org_addr.value = "";
					parent.reqDetailForm.req_org_tel.value = "";
				} else if(popupName == '소유업체'){	// 소유업체
					parent.reqDetailForm.req_org_no2.value = row.code;
					parent.reqDetailForm.req_org_nm2.value = row.code_Name;
					parent.reqDetailForm.req_org_addr2.value = "";
					parent.reqDetailForm.req_org_tel2.value = "";
				} else if(popupName == '계산서발행업체'){	// 계산서발행업체
					parent.reqDetailForm.req_org_no3.value = row.code;
					parent.reqDetailForm.req_org_nm3.value = row.code_Name;
					parent.reqDetailForm.req_org_addr3.value = "";
					//parent.reqDetailForm.req_org_tel3.value = "";
					parent.reqDetailForm.pre_tel_num.value = row.pre_tel_num;
					parent.reqDetailForm.req_nm.value = row.req_nm;
					parent.reqDetailForm.req_tel.value = row.req_tel;
					parent.reqDetailForm.req_email.value = row.req_email;
				} else if(popupName == '상담의뢰업체'){
					parent.counselTotalPopForm.reqorgan_nm.value = row.code;
					parent.counselTotalPopForm.reqorgan_cd.value = row.code_Name;
					parent.counselTotalPopForm.reqorgan_addr.value = "";
					parent.counselTotalPopForm.reqclient_home_num.value = "";
				} else if(popupName == '조회의뢰'){
					parent.reqListForm.req_org_nm.value = row.org_nm;
					parent.reqListForm.req_nm.value = row.req_nm;
				} else if(popupName == '의뢰정보팝업'){
					parent.reqForm.req_org_no.value = row.req_org_no;
					parent.reqForm.req_org_nm.value = row.org_nm;
					parent.reqForm.req_nm.value = "";
				} else if(popupName == '결과입력'){
					parent.reqListForm.req_org_nm.value = row.code_Name;
					parent.reqListForm.req_nm.value = "";
				} else if(popupName == '참조메일'){
					if(parent.mailForm.mailToCc.value  == null || parent.mailForm.mailToCc.value == ''){
						parent.mailForm.mailToCc.value =  '"' + row.req_nm + '" < ' + row.email + ' >'; // 메일 팝업창 참조메일이 빈공간일때 
					} else {
						parent.mailForm.mailToCc.value = parent.mailForm.mailToCc.value +", "+ "\n" +'"' + row.req_nm + '" <' + row.email + '>';// 메일 팝업창 참조메일이 빈공간아닐때
					}
				} else if(popupName == '숨은참조메일'){
					if(parent.mailForm.mailToBcc.value  == null || parent.mailForm.mailToBcc.value == ''){
						parent.mailForm.mailToBcc.value =  '"' + row.req_nm + '" < ' + row.email + ' >'; // 메일 팝업창 참조메일이 빈공간일때 
					} else {
						parent.mailForm.mailToBcc.value = parent.mailForm.mailToBcc.value +", "+ "\n" +'"' + row.req_nm + '" <' + row.email + '>';// 메일 팝업창 참조메일이 빈공간아닐때
					}
				} else{	// 성적서발행업체
					parent.reqDetailForm.req_org_no4.value = row.code;
					parent.reqDetailForm.req_org_nm4.value = row.code_Name;
					parent.reqDetailForm.req_org_addr4.value = "";
					parent.reqDetailForm.req_org_tel4.value = "";
				}
			}
			//opener.fnpop_callback();
			if(closeORnot==""){
				window.close();
			}
			if(closeORnot=="1"){
				$.showAlert('중복된 이메일 입니다.');
			}
			
		} else {
			$.showAlert('선택된 행이 없습니다.');
		}
	}
		 
		 
	// 주소
	function fn_zipcode(grid){
		fnpop_zipCodePop(grid, '800', '500');
		fnBasicStartLoading();
	}

</script>
</head>
<body id="popBody" onunload="opener.fnBasicEndLoading();">
<div class="popUp">
	<div class="pop_area pop_intro">
		<h2>의뢰처</h2>
		<div id="tabs">
			<ul>
				<li id="tab1"><a href="#tabDiv1">의뢰처 목록</a></li>
				<li id="tab2"><a href="#tabDiv2">의뢰처 추가</a></li>
<!-- 				<li id="tab3"><a href="#tabDiv3">부서</a></li> -->
			</ul>
			<div id="tabDiv1">
				<form id="orgForm" name="orgForm" onsubmit="return false;">
					<div class="sub_purple_01 w100p">
						<table width="100%" border="0" class="select_table">
							<tr>
								<td width="20%" class="table_title">
									<span>■</span>
									의뢰처 목록
								</td>
								<td class="table_button" style="text-align: right; padding-right: 30px;">
									<span class="button white mlargeb auth_select" id="btn_Select" onclick="btn_Select_onclick();">
										<button type="button">조회</button>
									</span>
									<span class="button white mlargeg auth_save" id="btn_Choice" onclick="btn_Choice_Onclick('orgGrid');">
										<button type="button">선택</button>
									</span>
									<span class="button white mlargep" id="btn_Cancel" onclick="window.close();">
										<button type="button">닫기</button>
									</span>
								</td>
							</tr>
						</table>
						<table width="100%" border="0" class="list_table">
							<tr>
								<th>의뢰처</th>
								<td>
									<input name="org_nm" type="text" class="inputhan w100px" />
								</td>
								<th>구분</th>
								<td>
									<select name="org_type" id="org_type" class="w100px"></select>
								</td>
								<th>담당자</th>
								<td>
									<input name="req_nm" type="text" class="inputhan w100px" />
								</td>
							</tr>
						</table>
					</div>
					<input type="hidden" id="sortName" name="sortName">
					<input type="hidden" id="sortType" name="sortType">
					<input type='hidden' id='pageNum' name='pageNum'/>
					<input type='hidden' id='pageSize' name='pageSize'/>
					<input type='hidden' id='sortTarget' name='sortTarget'/>
					<input type='hidden' id='sortValue' name='sortValue'/>
					<div id="view_grid_main">
						<table id="orgGrid"></table>
						<div id="orgGridPager"></div>
					</div>
				</form>
			</div>
			
			<div id="tabDiv2">
				<form id="detailForm" name="detailForm" onsubmit="return false;">
					<div class="sub_blue_01">
						<table width="100%" border="0" class="select_table">
							<tr>
								<td width="20%" class="table_title">
									<span>■</span>
									의뢰처 추가
								</td>
								<td class="table_button" style="text-align: right; padding-right: 30px;">
									<span class="button white mlargeg auth_save" id="btn_Insert" onclick="btn_Save_onclick();">
										<button type="button">저장</button>
									</span>
									<span class="button white mlargep" id="btn_Cancel" onclick="window.close();">
										<button type="button">닫기</button>
									</span>
								</td>
							</tr>
						</table>
					</div>
					<table able width="100%" border="0" class="list_table">
						<tr>
							<th style="min-width: 140px;" class="indispensable">기관/업체/의뢰인명</th>
							<td style="min-width: 195px;">
								<input name="org_nm" id="org_nm" type="text" class="inputhan inputCheck" />
							</td>
							<th style="min-width: 140px;" class="indispensable">구분</th>
							<td>
								<select id="org_type" name="org_type" class="inputCheck"></select>
							</td>
<!-- 						<th>업체명(영문)</th>
							<td><input name="org_nm_en" id="org_nm_en" type="text" class="inputhan"  maxlength="100"" />
							</td> -->
						</tr>
						<tr>
							<th>업태</th>
							<td>
								<input name="bsnsc" type="bsnsc" class="inputhan" maxlength="100"/>
							</td>
							<th>종목</th>
							<td>
								<input name="item" type="item" class="inputhan" maxlength="13"/>
							</td>
						</tr>
						<tr>
							<th>법인번호</th>
							<td>
								<input name="cor_no" type="cor_no" class="inputhan" maxlength="100"/>
							</td>
							<th>사업자등록번호</th>
							<td>
								<input name="biz_no1" id="biz_no1" type="text" style="width:20px;" maxlength="3" class="inputhan"/>
								-
								<input name="biz_no2" id="biz_no2" type="text" style="width:20px;" maxlength="2" class="inputhan"/>
								-
								<input name="biz_no3" id="biz_no3" type="text" style="width:40px;" maxlength="5" class="inputhan"/>
							</td>
							<%-- <th style="min-width:90px;">사업등록증</th>
							<td>							
							<!-- 파일형식 -->
								<input id="file_nm" name="file_nm" type="hidden" value="${detail.file_nm}" />
								<c:if test="${detail.file_nm == null ||  detail.file_nm == ''}">
									<label id="file_name">첨부파일이 없습니다.</label>
								</c:if>
								<!-- 첨부파일 있을때...
								<c:if test="${detail.file_nm != null && detail.file_nm != ''}">
									<label id="file_name"><a href="accept/bizFileDown.lims?req_org_no=${detail.req_org_no}">${detail.file_nm}</a></label>
									<img src="<c:url value='/images/common/icon_stop.png'/>" id="clear_add_file" style="cursor: pointer;" onClick='fn_LabelClear("file_name"), fn_TextClear("business_file"), fn_TextClear("file_nm")' />
								</c:if>
								 -->
								<input name="biz_file" id="biz_file" type="file"  class="inputCheck"/>
							</td> --%>
						</tr>
						<tr>
							<th>목재생산업 종류</th>
							<td>
								<input name="wooden_type" type="text" value="${detail.wooden_type}"/>
							</td>			
							<th>목재생산업 등록번호</th>
							<td>
								<input name="biz_wooden" type="text" value="${detail.biz_wooden}"/>
							</td>
						</tr>
						<tr>
							<th>담당자 성명</th>
							<td>
								<input name="charger" type="text" class="inputhan" value="${detail.charger }" />
							</td>
							<th>대표자명</th>
							<td>
								<input name="pre_man" type="text" class="inputhan" maxlength="100"  value="${detail.pre_man }" />					
							</td>
			
						</tr>
						<tr>
							<th>담당자 전화번호</th>
							<td>
								<input name="charger_tel" type="text" class="" value="${detail.charger_tel }" />
							</td>
							<th>의뢰자 전화번호</th>
							<td>
								<input name="pre_tel_num" type="text" class="" value="${detail.pre_tel_num }" />
							</td>
						<tr>
							<th>담당자 이메일</th>
							<td>
								<input name="email" type="text" class=""  />
							</td>
							<th>팩스번호</th>
							<td>
								<input name="pre_fax_num" type="text" class="" />
							</td>
						</tr>
						<tr>
							<th>결제담당자명</th>
							<td>
								<input name="pay_nm" type="text" class=""  />
			 				</td>
							<th>결제담당자 전화번호</th>
							<td>
								<input name="pay_tel" type="text" class=""  />
			 				</td>
						</tr>
						<tr>
							<th>결제담당자 이메일</th>
							<td>
								<input name="pay_email" type="email" class=""  />
			 				</td>
						<th>업체영문명</th>
							<td> 
								<input name="eng_nm" type="text" class="" value="${detail.eng_nm}" />
							</td>
						</tr>
						<tr>
							<th>본사 주소</th>
							<td colspan="3">
								<input name="zip_code" id="zip_code" type="text" style="width: 80px;"  />
								<img style="vertical-align: text-bottom;" src="../images/common/icon_search.png" class="auth_select" id="btn_Req_Org" onclick="fn_zipcode('detailForm');">
								<input style="width: 200px;" name="addr1" id="addr1" type="text" class="inputhan"  />
								<input style="width: 350px;" name="addr2" id="addr2" type="text" class="inputhan"  />
							</td>										
						</tr>
					</table>
				</form>
				 <form id="pacForm" name="pacForm" onsubmit="return false;">
					<table class="list_table" style="border-top:solid 0px #82bbce;">
						<tr>
							<th>설명</th>
							<td colspan="3">
								<textarea rows="11" style="width: 100%" name="org_desc"></textarea>
							</td>
						</tr>
					</table>
				</form>
			</div>
			<!-- 
			<div id="tabDiv3">
				<form id="formSub" name="formSub" onsubmit="return false;">
					<div class="sub_purple_01 w100p">
						<table width="100%" border="0" class="select_table">
							<tr>
								<td width="20%" class="table_title">
									<span>■</span>
									부서 목록
								</td>
								<td class="table_button" style="text-align: right; padding-right: 30px;">
									<span class="button white mlargeg" id="btn_Save" onclick="btn_Choice_Onclick('gridSub');">
										<button type="button">선택</button>
									</span>
									<span class="button white mlargep" id="btn_Cancel" onclick="window.close();">
										<button type="button">닫기</button>
									</span>
								</td>
							</tr>
						</table>
					</div>
					<input type="hidden" id="sortName" name="sortName">
					<input type="hidden" id="sortType" name="sortType">
					<div id="view_grid_sub2">
						<table id="gridSub"></table>
					</div>
				</form>
			</div>
			 -->
		</div>
	</div>
</div>
</body>
</html>
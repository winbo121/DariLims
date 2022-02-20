
<%
	/***************************************************************************************
	 * 시스템명 	: 통합장비관제시스템
	 * 업무명 		: 견적관리
	 * 파일명 		: estimateL01.jsp
	 * 작성자 		: 윤상준
	 * 작성일 		: 2015.09.10
	 * 설  명		: 견적관리 조회 화면
	 *---------------------------------------------------------------------------------------
	 * 변경일		 변경자		변경내역 
	 *---------------------------------------------------------------------------------------
	 * 2015.09.10    윤상준		최초 프로그램 작성         
	 * 
	 *---------------------------------------------------------------------------------------
	 ****************************************************************************************/
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html >
<link rel="stylesheet" media="screen" type="text/css" href="<c:url value='/css/common/sub.css'/>" />

<style>
#InsertTemplateDiv {
	background-color: white;
	border: 2px;
	border-radius: 8px;
	border-style: solid;
	border-color: #b27ce0;
	width: 300px;
	position: absolute;
	padding-bottom: 15px;
	z-index:2000;
}
</style>

<script type="text/javascript">
	
	/* 달력 셋팅 */
	fnDatePickerImg('startDate');
	fnDatePickerImg('endDate');
	
	$('#InsertTemplateDiv').hide();
	
	var est_state;
	var est_gubun;
	var mtlr_mst_no;
	var fnGridInit = false;
	
	$(function() {
		/* 세부권한검사 */
		fn_auth_check();
		
		est_state = fnGridCommonCombo('C39', null);
		ajaxComboForm("est_gubun", "C57", "", "", 'estimateForm');
		ajaxComboForm("est_state", "C58", '', '', "estimateForm");
		ajaxComboForm("doc_seq", "C60002", "CHOICE", "", "estimateForm");
		ajaxComboForm("dept_cd", "", "${session.dept_cd}", "ALL", "estimateForm"); // 부서		
		//ajaxComboForm("org_cd", "", "", "CHOICE", "estimateForm"); // 견적업체
		
		//$("#dept_cd option").not(":selected").attr("disabled", "disabled");
		estimateGrid('accept/selectEstimateList.lims', 'estimateForm', 'estimateGrid');
				
		//엔터키 눌렀을 경우
		fn_Enter_Search('estimateForm', 'estimateGrid');
		
	 	//그리드 사이즈 
		$(window).bind('resize', function() { 
		    $("#estimateGrid").setGridWidth($('#view_grid_main').width(), true); 
		}).trigger('resize');
	});
	
	// 견적 리스트
	function estimateGrid(url, form, grid) {
		var lastRowId = 0;
		$('#' + grid).jqGrid({
			datatype : function(json) {
				fnGridInit ? fnGridData(url, form, grid) : fnGridInit = true;
				//fnGridData(url, form, grid);
			},
			height : '230',
			autowidth : true,
			loadonce : true,
			mtype : "POST",
			gridview : true,
			shrinkToFit : true,
			rowNum : -1,
			rownumbers : true,
			colModel : [ {
				label : '견적번호',
				name : 'est_no',
				align : 'center',
				width : '80',
				key : true
			}, {
				label : '진행상태',
				name : 'est_state_nm',
				align : 'center',
				width : '80'
			}, {
				label : '견적구분',
				name : 'est_gubun',
				align : 'center',
				hidden : true,
				width : '80'
			}, {
				label : '견적구분',
				name : 'est_gubun_nm',
				align : 'center',
				width : '80'
			}, {
				label : '견적업체',
				name : 'est_org_nm',
				align : 'center',
				width : '100'
			}, {
				label : '견적제목',
				name : 'est_title',
				width : '200',
				align : 'center'
			}, {				
				label : '견적일',
				name : 'est_date',
				align : 'center',
				width : '80'
			}, {				
				label : 'Reference',
				name : 'est_ref',
				align : 'center',
				width : '80'
			}, {
				label : '견적신청인',
				name : 'est_charger_nm',
				align : 'center',
				width : '80'
			}, {
				label : '견적작성자',
				name : 'creater_id',
				align : 'center',
				width : '80'
			}],
			emptyrecords: '데이터가 존재하지 않습니다.',
			gridComplete : function() {
				$("#detail").empty();
				lastRowId = 0;
 				/* fnSelectFirst(grid); */
			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
			},
			beforeSelectRow : function(rowId, e) {
 				if (rowId && rowId != lastRowId) {
					if(editCount()) {
						if(!confirm("수정중인 구매요청 목록은 사라집니다."))
							return 'stop';
					}
				} 
 				return true;			
			},
			onSelectRow : function(rowId, status, e) {
				
				if (rowId && rowId != lastRowId) {	
					lastRowId = rowId;
					
					var est_gubun = $('#estimateGrid').jqGrid('getCell', rowId, 'est_gubun');
					var param = 'est_no=' + rowId+ "&est_gubun="+est_gubun;
					
					fnViewPage('accept/estimateDetail.lims', 'detail', param);
				}

			}
		});
	}
	
	// 견적서출력
	function btn_Print_onclick(){
		
		var doc_seq = $("#doc_seq").val();
		var rowId = $("#estimateGrid").getGridParam('selrow');
		if(fnIsEmpty(rowId)){
			alert("선택된 견적이 없습니다.");
			return;
		}
		if(fnIsEmpty(doc_seq)){
			alert("출력하실 양식을 선택해주세요.");
			return;
		}
		var est_gubun = $('#estimateGrid').jqGrid('getCell', rowId, 'est_gubun');
		var url = "estimateView.lims?est_no=" + rowId+ "&est_gubun="+est_gubun+"&doc_seq="+doc_seq;
		$('#excelReportForm').attr({action:url, method:'post'}).submit();
		
	}
	   
	// 구매요청목록에 수정, 삭제, 업데이트 된 항목이 있는지 확인
	function editCount() {
		var grid = 'estimateDetailGrid';
		var check = false;
		var ids = $('#' + grid).jqGrid("getDataIDs");
		for(var i in ids) {
			var row = $('#estimateDetailGrid').getRowData(ids[i]);
			if(row.crud == 'n' || row.crud == 'd' || row.crud == 'u') 			
				check = true;
		}		
		return check;
	}
	
	// 조회버튼 클릭 이벤트
	function btn_Search_onclick() {	
		if(editCount()) {
			if(!confirm("수정중인 구매요청 목록은 사라집니다."))
				return 'stop';
		}
		$('#detail').empty();
		$('#estimateGrid').trigger('reloadGrid');
	}
	
	function fn_estimatePop(pageType){
		var selRow = "";
		if (pageType == "detail"){
			selRow = $("#estimateGrid").getGridParam('selrow');
			if(fnIsEmpty(selRow)){
				alert("선택된 견적이 없습니다.");
				return;
			}
		} 
		fnpop_estimatePop("deptTeamPop", pageType, selRow);
		fnBasicStartLoading();
	}
	
	
	function fnpop_estimatePop(popupName, pageType, selRow){		
		var url = "accept/estimatePop.lims?pageType="+pageType+"&est_no="+selRow;
		var option = "toolbar=no, location=no, menubar=no, scrollbars=no, status=no, resizable=yes";
		var iwidth = "600";
		var iheight = "400";
		var itop = ($(window).height() - iheight) / 2;
		var ileft = ($(window).width() - iwidth) / 2;
		option += ", width=" + iwidth + ", height=" + iheight + ", top=" + itop + ", left=" + ileft;		
		openPopup = window.open(encodeURI(url), popupName, option);		
	}
	
	function fnpop_callback(returnParam){
		$('#estimateGrid').trigger('reloadGrid');
		fnBasicEndLoading();
	}
	
	// 키보드 이벤트
	function input_Reset(){
		$("#creater_id").val("");
	}
	
	// 요청자 등록팝업
	function btn_Pop_UserChoice() {
		fnBasicStartLoading();		
		fnpop_UserInfoPop("estimateForm", "500", "500", 'estimate', '');
	}
	
	function fn_IdTextClear(textId, textId2) {
		if ($("#" + textId) != null || $("#" + textId2) != null) {
			$("#" + textId).val('');
			$("#" + textId2).val('');
		}
	}
	
	// 템플릿불러보기 POPUP
	function fn_estimateTemplate() {
		fnpop_estimateTemplatePop("estimateTemplate", "700", "800");
		fnBasicStartLoading();
	}
	
	// 템플릿 콜백
	function tem_callback() {
		btn_Search_onclick();
		fnBasicEndLoading();
	}
	
	// 템플릿 등록
	function btn_InsertTemplate_onclick(state) {		
		var selRow = $("#estimateGrid").getGridParam('selrow');
		if(selRow == null || selRow == ""){
			alert("선택된 견적이 없습니다.");
			return false;
		}
		if(state == '0'){
			$('#InsertTemplateDiv').css("top", ($(window).height() / 2.5) - ($('#InsertTemplateDiv').outerHeight() / 2));
			$('#InsertTemplateDiv').css("left", ($(window).width() / 2) - ($('#InsertTemplateDiv').outerWidth() / 2));
			$('#InsertTemplateDiv').show();
			fnBasicStartLoading();
		} else {
			var row = $('#estimateGrid').getRowData(selRow);
			var est_title = $('#InsertTemplateDiv').find('#est_title').val();
			if (est_title == "" || est_title == null){
				alert("템플릿명을 입력해 주세요.");
				return false;
			}
			
			if (confirm("템플릿으로 등록하시겠습니까?")) {
				var url = 'accept/estimateTemplateInsert.lims';
				var data = '&est_no='+row.est_no+'&est_title='+est_title;
				var json = fnAjaxAction(url, data);
				if (json == null) {
					$.showAlert('등록이 실패되었습니다.');
				} else {
					btn_Close_onclick();
					btn_Search_onclick();
					$.showAlert('템플릿 등록이 완료되었습니다.');
				}
			}
		}
	}
	
	// 템플릿으로 등록 div 닫기버튼 이벤트
	function btn_Close_onclick() {
		fn_TextClear('est_title');
		$('#InsertTemplateDiv').hide();
		fnBasicEndLoading();
	}
	//견적서
	function btn_print_onclick() {
		var rowId = $('#estimateGrid').getGridParam('selrow');
		var printGbn = "C60002";
		if (rowId != null) {
			$("#dialogPrint").dialog({
				width : 555,
				height : 130,
				resizable : false,
				title : '출력물 개정 정보',
				modal : true,
				open : function(event, ui) {
					$(".ui-dialogPrint-titlebar-close").hide();
					var data = "printGbn="+printGbn;
					fnViewPage('/revisionPop.lims', 'dialogPrint', data);

				},
				buttons : [
				{
					text : "미리보기",
					click : function() {
						// 필수 체크
						if(formValidationCheck("revisionPopForm")){			
							return;
						} else {
							var fileNm = $("#revisionPopForm").find("#doc_seq").val() + "_V" 
									   + $("#revisionPopForm").find("#doc_seq option:checked").text() + ".mrd";
							
						 	var req_no = $('#estimateGrid').getGridParam('selrow'); 
							
							html5Viewer(fileNm, "/rp ["+req_no+"] []" , false);
							
						}
					}
				
				},  
				{
					text : "출력",
					click : function() {
						var fileNm = $("#revisionPopForm").find("#doc_seq").val() + "_V" 
						   + $("#revisionPopForm").find("#doc_seq option:checked").text() + ".mrd";
						
					 	var req_no = $('#estimateGrid').getGridParam('selrow'); 
						
						html5Viewer(fileNm, "/rp ["+req_no+"] []" , false);
					}
				}, 
				{
					text : "취소",
					click : function() {
						$('#dialogPrint').dialog("destroy");
					}
				}]
			});
		} else {
			$.showAlert('선택된 행이 없습니다.');
		}
	}
	
	function btn_delete_onclick(grid){
		fnEditRelease(grid);
		var url = "accept/deleteEstimate.lims";	
		var data = 'est_no=' + $("#estimateGrid").getGridParam('selrow');
		
		
		
		if(confirm("선택하신 항목을 삭제하시겠습니까?")){
			//var data = fnGetGridCheckData(grid);
			var json = fnAjaxAction(url, data);	
			if (json == null) {
				alert('error');
			} else {
				alert('선택하신 항목이 삭제되었습니다.');
				$('#'+grid).trigger('reloadGrid');
			}
		}
			
		
	}
	
	function btn_copy_onclick(grid){
		fnEditRelease(grid);
		var url = "accept/copyEstimate.lims";	
		var data = 'est_no=' + $("#estimateGrid").getGridParam('selrow');
		
		if(confirm("선택하신 항목을 복사하시겠습니까?")){
			var json = fnAjaxAction(url, data);	
			if (json == null) {
				alert('error');
			} else {
				alert('선택하신 항목이 복사되었습니다.');
				$('#'+grid).trigger('reloadGrid');
			}
		}
	}
	
	
</script>
<div>	
	<form id="estimateForm" name="estimateForm" onsubmit="return false;">
		<div class="sub_purple_01">
			<table  class="select_table" >
				<tr>
					<td class="table_title">
						<span>■</span>
						견적목록
					</td>
					<td class="table_button">
						
						<!-- <select id="doc_seq" name="doc_seq" class="w200px"></select>
						<span class="button white mlargeg auth_select" id="btn_Print" onclick="btn_Print_onclick();">
							<button type="button">견적서출력</button>
						</span> -->
						<!--
						<span class="button white mlargeb auth_select" id="btn_Add_Template" onclick="btn_InsertTemplate_onclick(0);">
							<button type="button">템플릿추가</button>
						</span>
						<span class="button white mlargeb auth_select" id="btn_Select_Template" onclick="fn_estimateTemplate();">
							<button type="button">템플릿불러보기</button>
						</span>
						-->
						<span class="button white mlargeb auth_select" onclick="btn_print_onclick();">
							<button type="button">견적서</button>
						</span>
						<span class="button white mlargep auth_select" id="btn_Select" onclick="btn_Search_onclick();">
							<button type="button">조회</button>
						</span>
						<span class="button white mlargeg auth_save" id="btn_insert" onclick="fn_estimatePop('insert');">
							<button type="button">등록</button>
						</span>
						<span class="button white mlargep auth_select" id="btn_Select" onclick="btn_copy_onclick('estimateGrid')">
							<button type="button">복사</button>
						</span>
						<span class="button white mlargeg auth_save" id="btn_update" onclick="fn_estimatePop('detail');">
							<button type="button">수정</button>
						</span>
						<span class="button white mlarger auth_delete" id="btn_delete" onclick="btn_delete_onclick('estimateGrid');">
							<button type="button">삭제</button>
						</span> 

					</td>
				</tr>
			</table>
			<table class="list_table">
				<tr>
					<th>견적업체</th>
					<td>
						<input name="est_org_nm" type="text" />
					</td>
					<th>등록부서</th>
					<td>
						<select name="dept_cd" id="dept_cd" class="w150px"></select>
					</td>
					<th>견적작성자</th>
					<td>
						<input name="user_nm" id="user_nm" type="text" style="width: 100px;" onkeypress="input_Reset();"/>
						<input name="creater_id" id="creater_id" type="hidden" style="width: 100px;" />
						<img style="cursor: pointer; vertical-align: text-bottom;" src="images/common/icon_search.png" class="auth_select" onclick="btn_Pop_UserChoice();">
						<img src="<c:url value='/images/common/icon_stop.png'/>" id="idClear" style="cursor: pointer;vertical-align:text-bottom;" onClick='fn_IdTextClear("user_nm", "creater_id")' />
					</td>
					<th>견적일자</th>
					<td>
						<input name="startDate" id="startDate" type="text" class="w80px" readonly="readonly" />
						<img src="<c:url value='/images/common/calendar_del.png'/>" id="startDateStop" style="cursor: pointer;" onClick='fn_TextClear("startDate")' /> ~
						<input name="endDate" id="endDate" type="text" class="w80px" readonly="readonly" />
						<img src="<c:url value='/images/common/calendar_del.png'/>" id="endDateStop" style="cursor: pointer;" onClick='fn_TextClear("endDate")' />
					</td>
				</tr>
				<tr>
					<th>진행상태</th>
					<td>
						<select name="est_state" id="est_state" class="w150px"></select>
					</td>
					<th>견적구분</th>
					<td>
						<select name="est_gubun" id="est_gubun" class="w150px"></select>
					</td>
					<th>견적제목</th>
					<td colspan="3">
						<input name="est_title" type="text" />
					</td>	
				</tr>			
			</table>
		</div>	
<!-- 		<input type="hidden" id="est_org_no" name="est_org_no"> -->
		<input type="hidden" id="sortName" name="sortName">
		<input type="hidden" id="sortType" name="sortType">
		<div id="view_grid_main">
			<table id="estimateGrid"></table>
		</div>
	</form>
	<form id="excelReportForm" name="excelReportForm"></form>
</div>
<div id="detail"></div>

<form id="insertTemplateForm" name="insertTemplateForm" onsubmit="return false;">
	<div id='InsertTemplateDiv'>
		<div class="sub_purple_01" style="width: 90%">
			<table  class="select_table" >
				<tr>
					<td width="40%" class="table_title">
						<span>■</span>
						템플릿 등록
					</td>
					<td class="table_button" style="text-align: right;">
						<span class="button white mlargep auth_save" id="btn_Insert_Template" onclick="btn_InsertTemplate_onclick(1);">
							<button type="button">등록</button>
						</span>
						<span class="button white mlargep auth_select" id="btn_Template_Update_Close" onclick="btn_Close_onclick();">
							<button type="button">닫기</button>
						</span>
					</td>
				</tr>
			</table>
			<table  class="list_table">
				<tr>
					<th>템플릿명</th>
					<td width="30%">
						<input type="text" id="est_title" name="est_title"/>
					</td>
				</tr>
			</table>
		</div>
	</div>
</form>
<div id="dialog"></div>
<div id="dialogPrint" class="sub_blue_01 w100p" style="display: none; margin-top: 0px;"></div>

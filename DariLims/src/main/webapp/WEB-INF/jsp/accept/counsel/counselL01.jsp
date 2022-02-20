
<%
	/***************************************************************************************
	 * 시스템명 	: 통합장비관제시스템
	 * 업무명 		: 상담관리
	 * 파일명 		: counselL01.jsp
	 * 작성자 		: 허태원
	 * 작성일 		: 2015.10.16
	 * 설  명		: 상담관리 리스트 화면
	 *---------------------------------------------------------------------------------------
	 * 변경일		변경자		변경내역 
	 *---------------------------------------------------------------------------------------
	 * 2015.10.16    허태원		최초 프로그램 작성         
	 * 
	 *---------------------------------------------------------------------------------------
	 ****************************************************************************************/
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html >
<link rel="stylesheet" media="screen" type="text/css" href="<c:url value='/css/common/sub.css'/>" />
<script type="text/javascript">
	var fnGridInit = false;

	$(function() {
		/* 세부권한검사 */
		fn_auth_check();
		
		// 등록일자
		fnDatePickerImg('startDate');
		fnDatePickerImg('endDate');

		//개별상담리스트 등록 버튼
		$('#btn_New_Sub').hide();
		//개별상담리스트 선택 버튼
		$('#btn_Choice_Sub').hide();
		//개별상담리스트 삭제 버튼
		$('#btn_Delete_Sub').hide();
		//개별상담리스트 조회 버튼
		$('#btn_Select_Sub').hide();
		
		//상담구분 콤보박스
		ajaxComboForm("counsel_div", "C70", "", "", "counselPersonalForm");
		ajaxComboForm("dept_cd", "", "${session.dept_cd}", "ALL", "counselTotalForm"); // 부서
		//$("#dept_cd option").not(":selected").attr("disabled", "disabled");
		
		//통합상담리스트 목록
		mainGrid('accept/selectCounselTotalList.lims', 'counselTotalForm', 'counselTotalGrid');
		//$('#counselTotalGrid').clearGridData(); // 최초 조회시 데이터 안나옴
		
		//개별상담리스트 목록
		subGrid('accept/selectCounselPersonalList.lims', 'counselPersonalForm', 'counselPersonalGrid');	

		//엔터키 눌렀을 경우(그리드 조회)
		fn_Enter_Search('counselTotalForm', 'counselTotalGrid');

		//그리드 width조절하기
		$(window).bind('resize', function() {
			$("#counselTotalGrid").setGridWidth($('#view_grid_main').width(), true);
			$("#counselPersonalGrid").setGridWidth($('#view_grid_sub').width(), true);
		}).trigger('resize');		
	});

	var lastRowId;
	// 통합상담리스트 목록
	function mainGrid(url, form, grid) {
		$('#' + grid).jqGrid({
			datatype : function(json) {
				fnGridInit ? fnGridData(url, form, grid) : fnGridInit = true;
				//fnGridData(url, form, grid);
			},
			height : '250',
			autowidth : true,
			loadonce : true,
			mtype : "POST",
			gridview : true,
			shrinkToFit : true,
			rowNum : -1,
			rownumbers : true,
			//multiselect : true,
			colModel : [ {
				type : 'not',
				label : '<input type="checkbox" id="chk" onclick="fn_chk(\'' + grid + '\' , \'' + form + '\');" />',
				name : 'chk',
				width : '40',
				sortable : false,
				align : 'center',
				formatter : "checkbox",
				formatoptions : {
					disabled : false
				}
			}, {
				label : '통합상담번호',
				name : 'total_no',
				width : '100',
				align : 'center',				
				key : true
			}, {
				label : '최초상담일',
				name : 'counsel_date',
				width : '100',
				align : 'center'				
			}, {
				label : '업체명',
				name : 'org_nm',
				width : '200',
				align : 'center'				
			}, {
				label : '업체구분',
				name : 'org_type_cd',
				width : '80',		
				align : 'center'
			}, {
				label : '대표번호',
				name : 'pre_tel_num',
				width : '120',
				align : 'center'				
			}, /* {
				label : '담당자',
				name : 'req_nm',
				width : '150',
				align : 'center'
			}, */  {
				label : '신청인명',
				name : 'counsel_client_nm',
				width : '120',
				align : 'center'				
			},  {
				label : '신청인 전화번호',
				name : 'req_tel',
				width : '120',
				align : 'center'
			}],
			emptyrecords : '데이터가 존재하지 않습니다.',
			gridComplete : function() {
				//fnSelectFirst(counselTotalGrid);
			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
			},
			onSelectRow : function(rowId, status, e) {
				$('#counselPersonalForm').find('#total_no').val(rowId);
				if(rowId != null || rowId != ''){
					$('#counselPersonalGrid').trigger('reloadGrid');
					$('#btn_New_Sub').show();
					$('#btn_Choice_Sub').show();
					$('#btn_Delete_Sub').show();
					$('#btn_Select_Sub').show();
				}
			},
			ondblClickRow : function(rowId, iRow, iCol, e) {	
				fnpop_CounselTotal('update','통합상담');
			},
			onCellSelect : function(rowId, iCol, cellcontent, e) {
			}
		});
	}

	// 개별상담리스트 목록
	function subGrid(url, form, grid) {
		$('#' + grid).jqGrid({
			datatype : function(json) {
				fnGridData(url, form, grid);
			},			
			height : '250',
			autowidth : true,
			loadonce : true,
			mtype : "POST",
			gridview : true,
			shrinkToFit : true,
			rowNum : -1,
			rownumbers : true,
			colModel : [ {
				type : 'not',
				label : '<input type="checkbox" id="chk" onclick="fn_chk(\'' + grid + '\' , \'' + form + '\');" />',
				name : 'chk',
				width : '40',
				sortable : false,
				align : 'center',
				formatter : "checkbox",
				formatoptions : {
					disabled : false
				}
			}, {
				label : '개별상담번호',
				name : 'personal_no',
				width : '100',
				align : 'center',				
				key : true
			},  {
				label : '상담일',
				name : 'counsel_date',
				width : '150',
				align : 'center'				
			}, {
				label : '상담구분',
				name : 'counsel_div',
				width : '150',
				align : 'center'
			}, {
				label : '상태',
				name : 'counsel_progress_sts',
				width : '150',				
				align : 'center'
			}, {
				label : '작성자',
				name : 'creater_id',
				width : '150',				
				align : 'center'
			}, {
				label : '상담결과',
				name : 'counsel_result',
				width : '150',				
				align : 'center'
			}, ],
			emptyrecords : '데이터가 존재하지 않습니다.',
			gridComplete : function() {				
			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
			},
			onSelectRow : function(rowId, status, e) {
				$('#counselPersonalForm').find('#personal_no').val(rowId);
			},
			ondblClickRow : function(rowId, iRow, iCol, e) {	
				fnpop_CounselPersonal('update','개별상담');
			},
		});
	}
	
	//통합 상담 삭제
	function btn_deleteTotal_onclick(){
		var b = false;
		var data;
		var ids = $('#counselTotalGrid').jqGrid("getDataIDs");
		data = 'total_no=';
		if (ids.length > 0) {
			for ( var i in ids) {
				var row = $('#counselTotalGrid').getRowData(ids[i]);
				if (row.chk == 'Yes') {
					data += ids[i] + ',';		
					b = true;
				}
			}
		}
		if (b) {
			if (!confirm('상담업체를 삭제하면 개별상담까지 삭제됩니다.\n삭제하시겠습니까?')) {
				return false;
			}
			data = data.substr(0, data.length - 1);
			var json = fnAjaxAction('accept/deleteCounselTotal.lims', data);			
			if (json == null) {
				alert('삭제 실패하였습니다.');
			} else {
				btn_select_onclick();
				alert('삭제 완료되었습니다.');
			}
		} else {
			alert('선택된 행이 없습니다.');
		}
	}
	
	//개별 상담 삭제
	function btn_deletePersonal_onclick(){
		var b2 = false;
		var data = 'total_no=' + $('#counselTotalGrid').jqGrid('getGridParam', 'selrow');
		var data2 = 'personal_no=';
		var ids2 = $('#counselPersonalGrid').jqGrid("getDataIDs");  
		if (ids2.length > 0) {
			for ( var i in ids2) {
				var row = $('#counselPersonalGrid').getRowData(ids2[i]);
				if (row.chk == 'Yes') {
					data2 += ids2[i] + ',';		
					b2 = true;
				}
			}
		}
		
		if (b2) {
			if (!confirm('삭제하시겠습니까?')) {
				return false;
			}		
			data2 = data2.substr(0, data2.length - 1);
			
			var strData = data +"&"+ data2;
			
			var json = fnAjaxAction('accept/deleteCounselPersonal.lims', strData);			
			if (json == null) {
				alert('삭제 실패하였습니다.');
			} else {
				$('#counselPersonalGrid').trigger('reloadGrid');
				alert('삭제 완료되었습니다.');
			}
		} else {
			alert('선택된 행이 없습니다.');
		}
	}
	
	function fnpop_callback_total(){
		$('#counselTotalGrid').trigger('reloadGrid');
		fnBasicEndLoading();
	}
	
	function fnpop_callback_personal(){
		$('#counselPersonalGrid').trigger('reloadGrid');
		fnBasicEndLoading();
	}
	
	//상담업체리스트 조회
	function btn_select_onclick(){
		$('#counselTotalGrid').trigger('reloadGrid');
		$('#counselPersonalForm').find('#total_no').val('');
		$('#counselPersonalForm').find('#personal_no').val('');
		$('#counselPersonalGrid').clearGridData();
		//$('#counselPersonalGrid').trigger('reloadGrid');
		$('#btn_New_Sub').hide();
		$('#btn_Choice_Sub').hide();
		$('#btn_Delete_Sub').hide();
		$('#btn_Select_Sub').hide();		
		personalReset();
	}
	
	//상담리스트 조회
	function btn_selectPersonal_onclick(){
		var total_no = $('#counselPersonalForm').find('#total_no').val();
		if ( total_no == null || total_no == ''){
			alert("업체리스트를 선택해 주세요.");
			return false;
		}
		$('#counselPersonalGrid').trigger('reloadGrid');		
	}
	
	//상담업체리스트 행 선택
	function fnpop_CounselTotal(type, text){		
		fnpop_CounselTotalPop(type, text);
	}
	
	//상담리스트 행 선택
	function fnpop_CounselPersonal(type, text){
		fnpop_CounselPersonalPop(type, text);
	}
	
	//상담리스트 조회 조건 초기화
	function personalReset(){
		$('#counsel_div').find('option:first').attr('selected', 'selected');
		$("input:radio[name='counsel_progress_sts']:radio[value='']").prop('checked', true);
		$("#startDate").val('');
		$("#endDate").val('');
	}

	// 조회 키보드 이벤트
	function input_Reset(){
		$("#creater_id").val("");
	}
	
	// 요청자 등록팝업
	function btn_Pop_UserChoice() {
		fnBasicStartLoading();		
		fnpop_UserInfoPop("counselPersonalForm", "500", "500", 'counsel', '');
	}
	
	function fnpop_callback(){
		$('#counselPersonalGrid').trigger('reloadGrid');
		fnBasicEndLoading();		
	}
	
	function fn_IdTextClear(textId, textId2) {
		if ($("#" + textId) != null || $("#" + textId2) != null) {
			$("#" + textId).val('');
			$("#" + textId2).val('');
		}
	}
</script>
<form id="counselTotalForm" name="counselTotalForm" onsubmit="return false;">
	<div class="sub_purple_01">
		<table  class="select_table" >
			<tr>
				<td width="20%" class="table_title">
					<span>■</span>
					상담업체리스트 
				</td>
				<td class="table_button">
					<span class="button white mlargep auth_select" id="btn_Select" onclick="btn_select_onclick();">
						<button type="button">조회</button>
					</span>
					<span class="button white mlargeg auth_save" id="btn_New" onclick="fnpop_CounselTotal('insert','통합상담');">
						<button type="button">등록</button>
					</span>
					<span class="button white mlargeb auth_select" id="btn_Choice" onclick="fnpop_CounselTotal('update','통합상담');">
						<button type="button">선택</button>
					</span>		
					<span class="button white mlarger auth_save" id="btn_Delete" onclick="btn_deleteTotal_onclick('counselTotalGrid');">
						<button type="button">삭제</button>
					</span>									
				</td>
			</tr>
		</table>

		<!-- 조회 테이블 -->
		<table  class="list_table" >
			<tr>
				<th>상담등록부서</th>
				<td>
					<select name="dept_cd" id="dept_cd" style="width: 173px"></select>
				</td>
				<th>통합상담번호</th>
				<td>
					<input name="total_no" id="total_no" type="text" style="width: 190px;" />
				</td>				
				<th>업체명</th>
				<td>
					<input name="org_nm" id="org_nm" type="text" style="width: 150px;" />
				</td>
				<th>신청인명</th>
				<td>
					<input name="counsel_client_nm" id="counsel_client_nm" type="text" style="width: 150px;" />
				</td>				
			</tr>	
		</table>
	</div>
	<input type="hidden" id="sortName" name="sortName">
	<input type="hidden" id="sortType" name="sortType">
	<div id="view_grid_main">
		<table id="counselTotalGrid"></table>
	</div>
</form>

<form id="counselPersonalForm" name="counselPersonalForm" onsubmit="return false;">
	<div class="sub_purple_01">
		<table  class="select_table" >
			<tr>
				<td width="20%" class="table_title">
					<span>■</span>
					상담리스트
				</td>
				<td class="table_button">
					<span class="button white mlargep auth_select" id="btn_Select" onclick="btn_selectPersonal_onclick();">
						<button type="button">조회</button>
					</span>
					<span class="button white mlargeg auth_save" id="btn_New_Sub" onclick="fnpop_CounselPersonalPop('insert', '개별상담');">
						<button type="button">등록</button>
					</span>
					<span class="button white mlargeb auth_select" id="btn_Choice_Sub" onclick="fnpop_CounselPersonalPop('update', '개별상담');">
						<button type="button">선택</button>
					</span>
					<span class="button white mlarger auth_save" id="btn_Delete_Sub" onclick="btn_deletePersonal_onclick();">
						<button type="button">삭제</button>
					</span>					
				</td>
			</tr>
		</table>
		
		<!-- 조회 테이블 -->
		<table  class="list_table" >
			<tr>			
				<th>작성자</th>
				<td>
					<input name="user_nm" id="user_nm" type="text" style="width: 80px;" onkeypress="input_Reset();"/>
					<input name="creater_id" id="creater_id" type="hidden" style="width: 160px;" />
					<img style="cursor: pointer; vertical-align: text-bottom;" src="images/common/icon_search.png" class="auth_select" onclick="btn_Pop_UserChoice();">
					<img src="<c:url value='/images/common/icon_stop.png'/>" id="idClear" style="cursor: pointer;vertical-align:text-bottom;" onClick='fn_IdTextClear("user_nm", "creater_id")' />
				</td>
				<th>상담구분</th>
				<td>
					<select name="counsel_div" id="counsel_div" style="width: 120px"></select>
				</td>	
				<th>상담일자</th>
				<td>
					<input name="startDate" id="startDate" type="text" style="text-align: center; width: 60px;" readonly="readonly" />
					<img src="<c:url value='/images/common/calendar_del.png'/>" id="startDateStop" style="cursor: pointer;" onClick='fn_TextClear("startDate")' /> ~
					<input name="endDate" id="endDate" type="text" style="text-align: center; width: 60px;" readonly="readonly" />
					<img src="<c:url value='/images/common/calendar_del.png'/>" id="endDateStop" style="cursor: pointer;" onClick='fn_TextClear("endDate")' />
				</td>				
				<th>진행상태</th>
				<td>
					<label><input type='radio' id="counsel_progress_sts" name='counsel_progress_sts' value='' style="width: 20px" checked="checked" />전체</label> 
					<label><input type='radio' id="counsel_progress_sts" name='counsel_progress_sts' value='C63001' style="width: 20px" />상담진행중</label> 
					<label><input type='radio' id="counsel_progress_sts" name='counsel_progress_sts' value='C63002' style="width: 20px" />상담완료</label>
				</td>				
			</tr>			
		</table>
	</div>
	<input type="hidden" id="total_no" name="total_no">
	<input type="hidden" id="personal_no" name="personal_no">
	<input type="hidden" id="sortName" name="sortName">
	<input type="hidden" id="sortType" name="sortType">
	<div id="view_grid_sub">
		<table id="counselPersonalGrid"></table>
	</div>
</form>
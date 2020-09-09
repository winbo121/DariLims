
<%
	/***************************************************************************************
	 * 시스템명 	: 통합장비관제시스템
	 * 업무명 		: 사용자관리
	 * 파일명 		: userD01.jsp
	 * 작성자 		: 윤상준	
	 * 작성일 		: 2015.08.20
	 * 설  명		: 사용자관리 상세 조회 화면
	 *---------------------------------------------------------------------------------------
	 * 변경일		 변경자		변경내역 
	 *---------------------------------------------------------------------------------------
	 * 2015.08.20    윤상준		최초 프로그램 작성         
	 * 
	 *---------------------------------------------------------------------------------------
	 ****************************************************************************************/
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" media="screen" type="text/css" href="<c:url value='/css/common/sub.css'/>" />
<style></style>
<script type="text/javascript">
	$(function() {
		ajaxComboForm("pre_dept_cd", "", "${detail.pre_dept_cd }", null, 'deptDetailForm'); // 부서
		if(!fnIsEmpty($('#deptDetailForm').find('#pageType').val())){
			$("#dept_cd").attr("readonly", "readonly");
		}
		
		deptTeamGrid('system/selectDeptTeamList.lims', 'deptTeamForm', 'deptTeamGrid');
		//$('#deptTeamGrid').clearGridData(); // 최초 조회시 데이터 안나옴
		
		deptTeamUserGrid("system/selectDeptTeamUserList.lims", "deptTeamUserForm", "deptTeamUserGrid"); 
		
		$(window).bind('resize', function() {
			$("#deptTeamGrid").setGridWidth($('#view_grid_sub_l').width(), true);
		}).trigger('resize');
		$(window).bind('resize', function() {
			$("#deptTeamUserGrid").setGridWidth($('#view_grid_sub_r').width(), true);
		}).trigger('resize');
		
		$("#pre_dept_cd").change(function(){
		});
	});

	function btn_save_onclick() {
		
		if(formValidationCheck("deptDetailForm")){
			return;
		}
		
/* 		if(!fn_lengthCheck("dept_cd","7")){
			return;
		} */
		
		if (confirm("저장하시겠습니까?")) {
			var url ;
			if(fnIsEmpty($('#deptDetailForm').find('#pageType').val())){
				url = 'system/insertDeptInfo.lims';
			}else{
			 	url = 'system/updateDeptInfo.lims';
			}

			var json = fnAjaxAction(url, $('#deptDetailForm').serialize());
			if (json == null) {
				$.showAlert('저장 실패되었습니다.');
			} else {
				$('#deptLimsGrid').trigger('reloadGrid');
				$('#detail').empty();
				$.showAlert('저장이 완료되었습니다.');
			}
		}
		
		
	}
	
	function deptTeamGrid(url, form, grid) {
		$('#' + grid).jqGrid({
			datatype : function(json) {
				fnGridData(url, form, grid);
			},
			height : '100',
			loadonce : true,
			mtype : "POST",
			gridview : true,
			rowNum : -1,
			rownumbers : true,
			//shrinkToFit : true,
			//multiselect : true,
			sortname : 'dept_nm',
			sortorder : 'asc',
			colModel : [  {
				type : 'not',
				label : '부서명',
				name : 'dept_nm' // 'dept_nm' 일반보기
			}, {
				label : '팀코드',
				name : 'team_cd',
				width : '80',
				key : true
			}, {
				label : '팀명',
				name : 'team_nm',
				width : '100'
			}, {
				label : '비고',
				name : 'team_desc',
				width : '180'
			}, {
				label : '사용여부',
				width : '100',
				align : 'center',
				editable : true,
				edittype : 'select',
				editoptions : {
					value : 'Y:사용함;N:사용안함'
				},
				name : 'use_flag'
			} ],
			gridComplete : function() {
			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
			},
			onSelectRow : function(rowId, status, e) {	
				$('#deptTeamUserForm').find('#team_cd').val(rowId);
				$('#deptTeamUserGrid').trigger('reloadGrid');
			},
			ondblClickRow : function(rowId, iRow, iCol, e) {
				/* fnGridEdit(grid, rowId, rowId);
				var colArr = $('#' + grid).jqGrid('getGridParam', 'colModel');
				$('#' + rowId + '_' + colArr[iCol].name).focus();
				$('#' + grid).setCell(rowId, 'icon', gridU); */
			}
		});
	}
	
	function deptTeamUserGrid(url, form, grid) {
		$('#' + grid).jqGrid({
			datatype : function(json) {
				fnGridData(url, form, grid);
			},
			height : '100',
			loadonce : true,
			mtype : "POST",
			gridview : true,
			rowNum : -1,
			rownumbers : true,
			//shrinkToFit : true,
			autowidth : true,
			//multiselect : true,
			sortname : 'dept_nm',
			sortorder : 'asc',
			colModel : [  {
				type : 'not',
				label : '부서명',
				name : 'dept_nm' 
			}, {
				label : '사용자명',
				name : 'user_nm'				
			}, {
				label : '사용자아이디',
				name : 'user_id',
				key : true
			}],
			gridComplete : function() {
			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
			},
			onSelectRow : function(rowId, status, e) {	
				//fnViewPage('system/selectDeptLimsDetail.lims', 'detailDiv', 'pageType=detail&dept_cd=' + rowId);
			},
			ondblClickRow : function(rowId, iRow, iCol, e) {
				/* fnGridEdit(grid, rowId, rowId);
				var colArr = $('#' + grid).jqGrid('getGridParam', 'colModel');
				$('#' + rowId + '_' + colArr[iCol].name).focus();
				$('#' + grid).setCell(rowId, 'icon', gridU); */
			}
		});
	}
	
	function fn_deptTeamPop(pageType){
		var selDept = $("#deptLimsGrid").getGridParam('selrow');
		var selTeam = "";
		if(fnIsEmpty(selDept)){
			alert("선택된 부서가 없습니다.");
			return;
		}
		if(pageType == "detail"){
			selTeam = $("#deptTeamGrid").getGridParam('selrow');
			if(fnIsEmpty(selTeam)){
				alert("선택된 팀이 없습니다.");
				return;
			}
		}
		fnpop_deptTeamPop("deptTeamPop", pageType, selDept, selTeam);
		fnBasicStartLoading();
	}
	
	function fnpop_callback(returnParam){
		$('#deptTeamGrid').trigger('reloadGrid');
		fnBasicEndLoading();
	}
	
	
	
	function btn_Del_Sub1_onclick(){
		var selTeam = $("#deptTeamGrid").getGridParam('selrow');
		if(fnIsEmpty(selTeam)){
			alert("선택된 팀이 없습니다.");
			return;
		}
		if(confirm("선택한 팀을 삭제 하시겠습니까?\n해당팀의 사용자정보도 삭제됩니다.")) {
			$('#deptTeamForm').find('#team_cd').val(selTeam);
			var url = 'system/deleteDeptTeam.lims';

			var json = fnAjaxAction(url, $('#deptTeamForm').serialize());
			if (json == null) {
				$.showAlert('삭제 실패되었습니다.');
			} else {
				$('#deptTeamGrid').trigger('reloadGrid');
				$('#deptTeamUserGrid').trigger('reloadGrid');
				$.showAlert('삭제 완료되었습니다.');
			}
		}
	}

	//팀 사용자 추가 팝업
	function btn_Add_Sub_onclick(){		
		fnpop_UserInfoPop("", "500", "500", "deptTeamInfo", '');
		fnBasicStartLoading();		
	}
	
	//팀 사용자 삭제 처리
	function btn_Save_Sub_onclick(){
		var team_cd = $("#deptTeamGrid").getGridParam('selrow');
		var user_id = $("#deptTeamUserGrid").getGridParam('selrow');
		if(fnIsEmpty(user_id)){
			alert("선택된 사용자가 없습니다.");
			return;
		}
		if(confirm("삭제하시겠습니까?")) {				
			$('#deptTeamForm').find('#team_cd').val(team_cd);
			$('#deptTeamForm').find('#user_id').val(user_id);
			var url = 'system/deleteDeptTeamUser.lims';
			var json = fnAjaxAction(url, $('#deptTeamForm').serialize());
			if (json == null) {
				alert('삭제 실패되었습니다.');
			} else {				
				$('#deptTeamUserGrid').trigger('reloadGrid');
				alert('삭제 완료되었습니다.');				
			}
		}
		
	}
	
	function fnpop_callback_teamUser(){
		$('#deptTeamUserGrid').trigger('reloadGrid');
		fnBasicEndLoading();
	}
	
</script>

<div>
<form id="popParamForm" name="popParamForm" method="post">
<input type="hidden" id="popParam" name="popParam"/>
<input type="hidden" id="popUrl" name="popUrl"/>
</form >
<form id="deptDetailForm" name="deptDetailForm" onsubmit="false">
<input type="hidden" id="pageType" name="pageType" value="${pageType}"/>
<table class="select_table">
	<tr>
		<td class="table_title">
			<span style="font-size: 11px; margin-left: 15px; color: #27aeea;">■</span>
			부서 정보
		</td>
		<td class="table_button" >
			<span class="button white mlargeb auth_save" id="btn_Add" onclick="btn_save_onclick();">
				<button type="button">저장</button>
			</span>
		</td>
	</tr>
	
</table>
<table class="list_table" >
	<tr>
		<th class="indispensable" >부서명</th>
		<td>
			<input id="dept_nm" name="dept_nm" class="w200px inputCheck inputhan" type="text" value="${detail.dept_nm }" />
		</td>
		<th>부서코드/약어</th>
		<td>
			<input maxlength="7" class="w200px" type="text"  disabled="disabled"  value="${detail.dept_cd }" />
			<input id="dept_cd" name="dept_cd" maxlength="7" class="w200px" type="hidden"  value="${detail.dept_cd }" />
			<input id="dept_label_cd" name=dept_label_cd maxlength="1" class="w50px" type="text"  value="${detail.dept_label_cd }" />
		</td>
	</tr>
	<tr>
		<th class="indispensable">상위부서</th>
		<td>
			<select id="pre_dept_cd" name="pre_dept_cd" class="w200px inputCheck"></select>
			<%-- <input id="dept_nm" name="dept_nm" type="text" class="" value="${detail.dept_nm }" /> --%>
		</td>
		<th class="indispensable">사용여부</th>
		<!--radio 버튼-->
		<td>
			<input type="radio" name="use_flag" id="use_flag" class="w15 inputCheck" value="Y"  <c:if test="${detail.use_flag == 'Y'}">checked="checked"</c:if> />
			사용함
			<input type="radio" name="use_flag" id="use_flag" class="w15 inputCheck" value="N"  <c:if test="${detail.use_flag != 'Y'}">checked="checked"</c:if> />
			사용안함
		</td>
	</tr>
	<tr>
		<th >부서관리자</th>
		<td>
			<input id="charger_cd" name="charger_cd" class="w200px" type="text" value="${detail.charger_cd }" />
		</td>
		<th  >비고</th>
		<td>
			<input id="dept_desc" name="dept_desc" maxlength="7" class="w300px" type="text"  value="${detail.dept_desc }" />
		</td>
	</tr>
</table>
</form>
</div>


<div class="sub_blue_01 w45p">
	<table class="select_table">
		<tr>
			<td class="table_title">
				<span>■</span>
				팀 목록
			</td>
			<td class="table_button">
				<span class="button white mlargep auth_save" id="btn_Save_Sub1" onclick="fn_deptTeamPop('insert');">
					<button type="button">추가</button>
				</span>
				<span class="button white mlargep auth_save" id="btn_Save_Sub1" onclick="fn_deptTeamPop('detail');">
					<button type="button">수정</button>
				</span>
				<span class="button white mlarger auth_save" id="btn_Save_Sub1" onclick="btn_Del_Sub1_onclick();">
					<button type="button">삭제</button>
				</span>
			</td>
		</tr>
	</table>
	<form id="deptTeamForm" name="deptTeamForm" onsubmit="return false;">
		<input type="hidden" id="dept_cd" name="dept_cd" value="${detail.dept_cd }">
		<input type="hidden" id="sortName" name="sortName">
		<input type="hidden" id="sortType" name="sortType">
		<input type="hidden" id="team_cd" name="team_cd" />
		<input type="hidden" id="user_id" name="user_id" />
		<div id="view_grid_sub_l">
			<table id="deptTeamGrid"></table>
		</div>
	</form>
</div>
<div class="w10p">

</div>
<div class="sub_blue_01 w45p">
	<table class="select_table">
		<tr>
			<td class="table_title">
				<span>■</span>
				팀 사용자
			</td>
			<td class="table_button">
				<span class="button white mlargep auth_save" id="btn_Save_Sub2" onclick="btn_Add_Sub_onclick();">
					<button type="button">추가</button>
				</span>
				<span class="button white mlarger auth_save" id="btn_Save_Sub2" onclick="btn_Save_Sub_onclick();">
					<button type="button">삭제</button>
				</span>
			</td>
		</tr>
	</table>
	<form id="deptTeamUserForm" name="deptTeamUserForm" onsubmit="return false;">
		<input type="hidden" id="sortName" name="sortName">
		<input type="hidden" id="sortType" name="sortType">
		<input type="hidden" id="team_cd" name="team_cd" />
		<div id="view_grid_sub_r">
			<table id="deptTeamUserGrid"></table>
		</div>
	</form>
</div>

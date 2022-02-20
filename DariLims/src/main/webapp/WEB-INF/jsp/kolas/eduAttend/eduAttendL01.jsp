
<%
	/***************************************************************************************
	 * 시스템명 	: 통합장비관제시스템
	 * 업무명 		: 교육결과등록
	 * 파일명 		: eduAttendL01.jsp
	 * 작성자 		: 석은주
	 * 작성일 		: 2015.01.28
	 * 설  명		: 교육과정등록 리스트 조회 화면
	 *---------------------------------------------------------------------------------------
	 * 변경일		 변경자		변경내역 
	 *---------------------------------------------------------------------------------------
	 * 2015.01.28    석은주		최초 프로그램 작성         
	 * 
	 *---------------------------------------------------------------------------------------
	 ****************************************************************************************/
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html >
<link rel="stylesheet" media="screen" type="text/css" href="<c:url value='/css/common/sub.css'/>" />
<style>
</style>
<script type="text/javascript">
	$(function() {
		/* 세부권한검사 */
		fn_auth_check();
		
		fnDatePickerImg('startDate');
		fnDatePickerImg('endDate');
		
		grid('kolas/selectEduCurrList.lims', 'form', 'grid');
		$('#grid').clearGridData(); // 최초 조회시 데이터 안나옴
		
		ajaxComboForm("dept_cd", "", "ALL", null, 'form');		
		ajaxCombo("edu_kind", "C07", "ALL", "");
				
		//그리드 사이즈 
		$(window).bind('resize', function() { 
		    $("#grid").setGridWidth($('#view_grid_main').width(), true); 
		}).trigger('resize');
		
		// 엔터키
		fn_Enter_Search('form', 'grid');
	});

	// 교육과정 리스트
	function grid(url, form, grid) {
		var lastRowId = 0;
		$('#' + grid).jqGrid({
			datatype : function(json) {
				fnGridData(url, form, grid);
			},
			height : '230',
			autowidth : true,
			loadonce : true,
			mtype : "POST",
			gridview : true,
			shrinkToFit : false,
			rowNum : -1,			
			rownumbers : true,
			sortname : 'edu_result_no',
			sortorder : 'asc',
			colModel : [ {
				label : '교육결과번호',
				name : 'edu_result_no',
				key : true,
				hidden : true
			}, {
				label : '교육종류',
				name : 'edu_kind',
				width : '100'
			}, {
				label : '관리부서',
				name : 'mgr_dept'
			}, {
				label : '교육기관',
				name : 'edu_org'
			}, {
				label : '교육장소',
				name : 'edu_place'
			}, {
				label : '교육시작일',
				name : 'edu_sdate',
				align : 'center',
				width : '100'
			}, {
				label : '교육종료일',
				name : 'edu_edate',
				align : 'center',
				width : '100'
			}, {
				label : '사내외구분',
				name : 'edu_type',
				align : 'center',
				width : '70'
			}, {
				label : '교육내용',
				name : 'edu_content'
			}, {				
				label : '비고사항',
				name : 'edu_desc'
			} ],
			emptyrecords: '데이터가 존재하지 않습니다.',
			gridComplete : function() {
				editChange = false;
				lastRowId = 0;
				//fnSelectFirst(grid);
				$('#btn_Cancle').hide();
			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
			},
			beforeSelectRow : function(rowId, e) {				
 				if (rowId && rowId != lastRowId) {
 					if(editChange) {	 						
 						if (!confirm('수정중인 교육참석자 목록은 사라집니다. 이동하시겠습니까?')) 
 							return;						
 					} 					
				}
 				editChange = false;
	 			return true;
			},
			onSelectRow : function(rowId, status, e) {
				if (rowId && rowId != lastRowId) {
					lastRowId = rowId;
					var param = 'edu_result_no=' + rowId;
					fnViewPage('kolas/eduAttendList.lims', 'detail', param);
				}
			}
		});
	}
	
	// 조회
	function btn_Search_onclick() {	
		if(editChange) {	 						
			if (!confirm('수정중인 교육참석자 목록은 사라집니다. 이동하시겠습니까?')) 
				return;						
		} 
		editChange = false;
		$('#detail').empty();
		$('#grid').trigger('reloadGrid');		
	}
	
	// 사용자 추가 팝업
	function fnpop_UserInfo(){		
		fnBasicStartLoading();
		fnpop_UserInfoPop("form", "500", "500", "user", '');
	}
	
	// 콜백
	function fnpop_callback(){
		fnBasicEndLoading();
	}
	
</script>
<form id="form" name="form" onsubmit="return false;">
	<div class="sub_purple_01">
		<table  class="select_table" >
			<tr>
				<td width="20%" class="table_title">
					<span style="font-size: 11px; margin-left: 15px; color: #b27ce0;">■</span>
					교육과정목록
				</td>
				<td class="table_button" style="text-align: right; padding-right: 30px;">
					<span class="button white mlargep auth_select" id="btn_Select" onclick="btn_Search_onclick();">
						<button type="button">조회</button>
					</span>
				</td>
			</tr>
		</table>
		<table  class="list_table" >
			<tr>
				<th>교육종류</th>
				<td>
					<select name="edu_kind" id="edu_kind" class="w120px"></select>
				</td>
				<th>교육기관</th>
				<td>
					<input name="edu_org" type="text" class="inputhan" />
				</td>				
				<th>사내외구분</th>
				<td>
					<label><input type='radio' name='edu_type' value='' style="width:20px" checked="checked"/>전체</label>
				    <label><input type='radio' name='edu_type' value='사내' style="width:20px"/>사내</label>
					<label><input type='radio' name='edu_type' value='사외' style="width:20px"/>사외</label>
				</td>				
			</tr>
			<tr>
				<th>관리부서</th>
				<td>
					<select id="dept_cd" name="mgr_dept" class="w120px"></select>
				</td>
				<th>교육일</th>
				<td>
					<input name="startDate" id="startDate" type="text" class="inputhan w80px"/>
					<img src="<c:url value='/images/common/calendar_del.png'/>" id="startDateStop" style="cursor: pointer;" onClick='fn_TextClear("startDate")' />
					~
					<input name="endDate" id="endDate" type="text" class="inputhan w80px"/>	
					<img src="<c:url value='/images/common/calendar_del.png'/>" id="startDateStop" style="cursor: pointer;" onClick='fn_TextClear("endDate")' />				
				</td>
				<th>참석자</th>
				<td>
					<input name="user_nm" id="user_nm" type="text" class="w80px"/>
					<input name="user_id" id="user_id" type="hidden" class="w80px"/>
					<img style="cursor: pointer; vertical-align: text-bottom;" src="images/common/icon_search.png" class="auth_select" id="userInfo" onclick='fnpop_UserInfo();'/>
					<img src="images/common/icon_stop.png" id="infoDel" style="cursor: pointer; vertical-align: text-bottom;" onClick='fn_TextClear("user_id"), fn_TextClear("user_nm")' />
				</td>
			</tr>
		</table>		
	</div>
	
	<input type="hidden" id="sortName" name="sortName">
	<input type="hidden" id="sortType" name="sortType">
	<div id="view_grid_main">
		<table id="grid"></table>
	</div>
</form>

<form id="detail" name="detail" onsubmit="return false;"></form>

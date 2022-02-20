
<%
	/***************************************************************************************
	 * 시스템명 	: 통합장비관제시스템
	 * 업무명 		: 항목별 담당자
	 * 파일명 		: testItemUserL01.jsp
	 * 작성자 		: 진영민
	 * 작성일 		: 2015.01.22
	 * 설  명		: 
	 *---------------------------------------------------------------------------------------
	 * 변경일		 변경자		변경내역 
	 *---------------------------------------------------------------------------------------
	 * 2015.01.22    진영민		최초 프로그램 작성         
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
	var fnGridInit = false;
	$(function() {
		/* 세부권한검사 */
		fn_auth_check();
		ajaxComboForm("testitm_lclas_cd", "", "ALL", "", "testItemForm"); // 항목 대분류
		ajaxComboForm("testitm_mlsfc_cd", "", "ALL", "", "testItemForm"); // 항목 중분류

		grid('master/selectTestItemUserList.lims', 'testItemForm', 'testItemGrid');
		$('#testItemGrid').clearGridData(); // 최초 조회시 데이터 안나옴		
		
		ajaxComboForm("test_item_type", "C20", "ALL", "", "testItemForm");
		ajaxComboForm("dept_cd", "", "ALL", null, 'allItemUserForm');

		$(window).bind('resize', function() {
			$("#testItemGrid").setGridWidth($('#view_grid_main').width(), true);
		}).trigger('resize');
		
		fn_Enter_Search('testItemForm', 'testItemGrid');
	});


	function grid(url, form, grid) {
		$('#' + grid).jqGrid({
			datatype : function(json) {
				fnGridInit ? fn_GridData(url, form, grid) : fnGridInit = true;
			},
			height : '400',
			autowidth : true,
			gridview : true,
			shrinkToFit : false,
			rowNum : 5000,
			rownumbers : true,
			multiselect : true,
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
				label : 'test_item_cd',
				name : 'test_item_cd',
				key : true,
				hidden : true,
				search : false
			}, {
				label : '항목대분류',
				name : 'testitm_lclas_nm',
				width : '200'
			}, {
				label : '항목중분류',
				name : 'testitm_mlsfc_nm',
				width : '200'
			}, {
				label : '항목',
				name : 'test_item_nm',
				width : '250'
			}, {
				label : '항목영문명',
				name : 'test_item_eng_nm',
				width : '250'
			}, {
				label : 'tester_dept_cd',
				name : 'tester_dept_cd',
				hidden : true
			}, {
				label : '담당부서',
				name : 'tester_dept_nm',
				width : '150'
			}, {
				label : 'tester_user_id',
				name : 'tester_user_id',
				hidden : true
			}, {
				label : '담당자',
				name : 'tester_user_nm',
				width : '150'
			}, {
				label : '사용여부',
				name : 'use_flag',
				width : '80',
				align : 'center'
			}],
			gridComplete : function() {
			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
			},
			onSelectRow : function(rowId, status, e) {
			}
		});
	}

	function btn_Insert_onclick(){
		var rowIds = $('#testItemGrid').getGridParam('selarrrow');
		if(rowIds.length == 0){
			alert("항목을 선택해주세요.");
			return;
		}
		if (confirm('담당자를 등록하시겠습니까?')) {
			fnpop_UserInfoPop("testItemGrid", "500", "500", 'testItemUser', '');	
		}
	}
	
	function fnpop_callback_testItemUser(dept_cd, user_id){
		var rowIds = $('#testItemGrid').getGridParam('selarrrow');
		
		var data = "pageType=INSERT";
		data += "&tester_dept_cd="+dept_cd;
		data += "&tester_user_id="+user_id;
		data += "&arr_test_item="+rowIds;
		data += "&test_item_cnt="+rowIds.length;
		
		var json = fnAjaxAction('master/saveTestItemUser.lims', data);
		if (json == null) {
			alert('저장실패하였습니다.');
			return false;
		} else {
			alert('저장하였습니다.');
			btn_Select_onclick();
		}
	}
	
	function btn_Delete_onclick(){
		var rowIds = $('#testItemGrid').getGridParam('selarrrow');
		if(rowIds.length == 0){
			alert("항목을 선택해주세요.");
			return;
		}
		if (confirm('담당자를 삭제하시겠습니까?')) {
			var data = "pageType=DELETE";
			data += "&arr_test_item="+rowIds;
			data += "&test_item_cnt="+rowIds.length;
			
			var json = fnAjaxAction('master/saveTestItemUser.lims', data);
			if (json == null) {
				alert('삭제실패하였습니다.');
				return false;
			} else {
				alert('삭제하였습니다.');
				btn_Select_onclick();
			}
		}
	}
	
	// 조회 이벤트
	function btn_Select_onclick() {
		if($('#testItemForm').find('#tester_user_nm').val() == null || $('#testItemForm').find('#tester_user_nm').val() == ''){
			$('#testItemForm').find('#tester_user_id').val('');
		}
		$('#testItemGrid').setGridParam({page: 1});
		$('#testItemGrid').trigger('reloadGrid');
	}

 	function infoUser(){
		fnpop_UserInfoPop('testItemForm', "500", "500", 'itemUserFind', '');
	} 
	
	function fnpop_callback(){
		fnBasicEndLoading();
	}  
		
</script>

<div class="sub_purple_01 w100p">
	<form id="testItemForm" name="testItemForm" onsubmit="return false;">
		<table  class="select_table" >
			<tr>
				<td width="20%" class="table_title">
					<span>■</span>
					시험항목별 담당자
				</td>
				<td class="table_button" style="text-align: right; padding-right: 30px;">
					<span class="button white mlargep auth_select" id="btn_Insert" onclick="btn_Insert_onclick();">
						<button type="button">담당등록</button>
					</span>
					<span class="button white mlarger auth_select" id="btn_Delete" onclick="btn_Delete_onclick();">
						<button type="button">담당삭제</button>
					</span>
					<span class="button white mlargeg auth_select" id="btn_Select" onclick="btn_Select_onclick();">
						<button type="button">조회</button>
					</span>
				</td>
			</tr>
		</table>
		<table  class="list_table" >
			<tr>
				<th>항목유형</th>
				<td width="35%">
					<select name="testitm_lclas_cd" id="testitm_lclas_cd" class="w200px"></select>
					<select name="testitm_mlsfc_cd" id="testitm_mlsfc_cd" class="w200px"></select>
				</td>
				<th>사용여부</th>
				<td>
					<label><input type='radio' name='use_flag' value='' style="width: 20px"/>전체</label> 
					<label><input type='radio' name='use_flag' value='Y' style="width: 20px" checked="checked"/>사용</label>
					<label><input type='radio' name='use_flag' value='N' style="width: 20px" />미사용</label>
				</td>
			</tr>
			<tr>
				<th>항목명</th>
				<td>
					<input name="test_item_nm" type="text" class="inputhan w300px" />
				</td>
				<th>담당자</th>
				<td >
					<input id="tester_user_id" name="tester_user_id" type="hidden"/>
					<input id="tester_user_nm" name="tester_user_nm" type="text" class="inputhan w200px" />
					<img style="width: 16px;" src="images/common/icon_search.png" class="auth_select" onclick='infoUser();'>
				</td>
		</table>

		<input type="hidden" id="sortName" name="sortName">
		<input type="hidden" id="sortType" name="sortType">
		<input type='hidden' id='pageNum' name='pageNum'/>
		<input type='hidden' id='pageSize' name='pageSize'/>
		<input type='hidden' id='sortTarget' name='sortTarget'/>
		<input type='hidden' id='sortValue' name='sortValue'/>
		<div id="view_grid_main">
			<table id="testItemGrid"></table>
			<div id="testItemGridPager"></div>
		</div>
	</form>
</div>
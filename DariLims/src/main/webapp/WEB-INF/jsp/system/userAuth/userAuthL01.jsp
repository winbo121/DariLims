
<%
	/***************************************************************************************
	 * 시스템명 	: 통합장비관제시스템
	 * 업무명 		: 사용자권한관리
	 * 파일명 		: userAuthL01.jsp
	 * 작성자 		: 
	 * 작성일 		: 2015.01.01
	 * 설  명		: 사용자권한관리 화면
	 *---------------------------------------------------------------------------------------
	 * 변경일		변경자		변경내역 
	 *---------------------------------------------------------------------------------------
	 * 2015.08.13   최은향		최초 프로그램 작성         
	 * 
	 *---------------------------------------------------------------------------------------
	 ****************************************************************************************/
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html >
<link rel="stylesheet" media="screen" type="text/css" href="<c:url value='/css/common/sub.css'/>" />
<script type="text/javascript">
	$(function() {
		/* 세부권한검사 */
		fn_auth_check();
		
		ajaxComboForm("dept_cd", "", "ALL", null, 'mainForm'); // 부서
		ajaxComboForm("dept_cd", "", "ALL", null, 'subForm'); // 부서
		
// 		ajaxComboForm("office_cd", "", "ALL", null, 'mainForm'); // 사업소별
// 		ajaxComboForm("office_cd", "", "ALL", null, 'subForm'); // 사업소별
		
		authGroupGrid('system/selectAuthGroupList.lims', 'authGroupForm', 'authGroupGrid');
		$('#authGroupGrid').clearGridData(); // 최초 조회시 데이터 안나옴
		
		cmmnUserGrid('system/selectCmmnUserList.lims', 'mainForm', 'cmmnUserGrid');
		$('#cmmnUserGrid').clearGridData(); // 최초 조회시 데이터 안나옴
		
		authUserGrid('system/selectAuthUserList.lims', 'subForm', 'authUserGrid');
		$('#authUserGrid').clearGridData(); // 최초 조회시 데이터 안나옴

		// 엔터키 눌렀을 경우
		fn_Enter_Search('mainForm', 'cmmnUserGrid');		
		fn_Enter_Search('subForm', 'authUserGrid');

		$(window).bind('resize', function() {
			$("#authGroupGrid").setGridWidth($('#view_grid_main').width(), true);
		}).trigger('resize');
		$(window).bind('resize', function() {
			$("#cmmnUserGrid").setGridWidth($('#view_grid_main').width()*.450);
		}).trigger('resize');
		$(window).bind('resize', function() {
			$("#authUserGrid").setGridWidth($('#view_grid_main').width()*.450);
		}).trigger('resize');
		
		fn_show_type($('#mainForm').find("#req_dept_office").val());
		fn_show_type_sub($('#subForm').find("#req_dept_office_sub").val());
	});

	function authGroupGrid(url, form, grid) {
		var lastRowId;
		$('#' + grid).jqGrid({
			datatype : function(json) {
				fnGridData(url, form, grid);
			},
			height : '230',
			autowidth : true,
			loadonce : true,
			mtype : "POST",
			gridview : true,
			shrinkToFit : true,
			rowNum : -1,
			rownumbers : true,
			sortname : 'role_group_nm',
			sortorder : 'asc',
			colModel : [ {
				label : '권한그룹코드',
				name : 'role_no',
				key : true,
				editable : true
			}, {
				label : '권한그룹명',
				name : 'role_group_nm',
				editable : true
			}, {
				label : '권한설명',
				name : 'role_desc',
				width : 400,
				editable : true
			}, {
				label : '순서',
				name : 'disp_order',
				editable : true,
				editrules : {
					number : true
				}
			}, {
				label : '사용여부',
				name : 'use_flag',
				editable : true,
				edittype : "select",
				editoptions : {
					value : 'Y:사용;N:사용안함'
				}
			}, {
				label : '생성자',
				name : 'creater_id'
			}, {
				label : '생성일시',
				name : 'create_date'
			} ],
			gridComplete : function() {
				$('#btn_AddLine').show();
				$('#btn_Save').hide();
				$('#btn_Delete').hide();
				fnSelectFirst(grid);
			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
			},
			onSelectRow : function(rowId, status, e) {

				if (rowId && rowId != lastRowId) {
					$('#' + grid).jqGrid('restoreRow', lastRowId);
					lastRowId = rowId;
					$('#btn_AddLine').show();
					$('#btn_Save').hide();
					$('#btn_Delete').hide();

					var row = $('#' + grid).getRowData(rowId);
					$('#mainForm').find('#role_no').val(row.role_no);
					$('#subForm').find('#role_no').val(row.role_no);

					$('#cmmnUserGrid').trigger('reloadGrid');
					$('#authUserGrid').trigger('reloadGrid');
				}
			},
			ondblClickRow : function(rowId, iRow, iCol, e) {
				$('#' + grid).jqGrid('editRow', rowId);
				$('#btn_AddLine').hide();
				$('#btn_Save').show();
				$('#btn_Delete').show();
			}
		});
	}

	function cmmnUserGrid(url, form, grid) {
		$('#' + grid).jqGrid({
			datatype : function(json) {
				fnGridData(url, form, grid);
			},
			height : '230',
			loadonce : true,
			mtype : "POST",
			gridview : true,
			rowNum : -1,
			rownumbers : true,
			shrinkToFit : true,
			multiselect : true,
			sortname : 'dept_nm',
			sortorder : 'asc',
			autowidth : false,
			colModel : [ {
				label : '부서명',
				name : 'dept_nm',
				width : 360
			}, {
				label : '사용자명',
				name : 'user_nm',
				width : 200
			}, {
				label : '사용자ID',
				name : 'user_id',
				width : 200,
				key : true,
			} ],
			gridComplete : function() {
				if (grid == 'cmmnUserGrid') {
					fnCheckAction(grid);
				}
			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
			}
		});
	}

	function authUserGrid(url, form, grid) {
		$('#' + grid).jqGrid({
			datatype : function(json) {
				fnGridData(url, form, grid);
			},
			height : '230',
			loadonce : true,
			mtype : "POST",
			gridview : true,
			rowNum : -1,
			rownumbers : true,
			shrinkToFit : true,
			multiselect : true,
			sortname : 'dept_nm',
			sortorder : 'asc',
			autowidth : false,
			colModel : [ {
				label : '부서명',
				name : 'dept_nm',
				width :250
			}, {
				label : '사용자명',
				name : 'user_nm',
				width : 250
			}, {
				label : '사용자ID',
				name : 'user_id',
				key : true,
				width : 250
			} ],
			gridComplete : function() {
				if (grid == 'authUserGrid') {
					fnCheckAction(grid);
				}
			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
			}
		});
	}

	//조회버튼 클릭 이벤트 - 공통사용자 조회
	function fn_Search_userCmmn() {
		$('#cmmnUserGrid').trigger('reloadGrid');
	}

	//조회버튼 클릭 이벤트 - LIMS사용자 조회
	function fn_Search_userLims() {
		$('#authUserGrid').trigger('reloadGrid');
	}

	function btn_AddLine_onclick() {
		var grid = 'authGroupGrid';
		$('#' + grid).jqGrid('addRow', {
			rowID : 'insert',
			position : 'last'
		});
		$('#btn_AddLine').hide();
		$('#btn_Save').show();
		$('#btn_Delete').hide();
	}
	  
	//채원 : 삭제 이벤트
	function btn_Delete_onclick(){
		var rowId = $('#authGroupGrid').getGridParam('selrow');
		if (!confirm('정말 삭제하시겠습니까?')) {
			return false;
		}
		$('#authGroupGrid').jqGrid('saveRow', rowId, function(){
			alert("삭제되었습니다");
			fs_search();
		}, 'system/delAuthGroup.lims', null);
	}

	//메뉴그룹 저장버튼 클릭 이벤트
	function btn_Save_onclick() {
		var rowId = $('#authGroupGrid').getGridParam('selrow');
		var pageType = "";
		if (rowId == 'insert') {
			pageType = 'insert';
		} else {
			pageType = 'update';
		}
		$('#authGroupGrid').jqGrid('saveRow', rowId, successfunc, 'system/saveAuthGroup.lims', {
			pageType : pageType
		}, fs_search, null, null);
	}

	function fs_search(rowId) {
		$('#authGroupGrid').trigger('reloadGrid');
	}

	//메뉴권한 추가
	function fn_btn_Right_onclick() {
		var data = 'role_no=' + $('#mainForm').find('#role_no').val() + '&user_id=';
		var arr = $('#cmmnUserGrid').getGridParam('selarrrow');
		if (arr != '') {
			for ( var i in arr) {
				data += arr[i] + ",";
			}
		}
		var json = fnAjaxAction('system/insertAuthUser.lims', data);
		if (json == null) {
			alert('error');
		} else {
			$('#cmmnUserGrid').trigger('reloadGrid');
			$('#authUserGrid').trigger('reloadGrid');
			alert('추가 완료되었습니다.');
		}
	}

	//메뉴권한 삭제
	function fn_btn_Left_onclick() {
		var data = 'role_no=' + $('#subForm').find('#role_no').val() + '&user_id=';
		var arr = $('#authUserGrid').getGridParam('selarrrow');
		if (arr != '') {
			for ( var i in arr) {
				data += arr[i] + ",";
			}
		}
		var json = fnAjaxAction('system/deleteAuthUser.lims', data);
		if (json == null) {
			alert('error');
		} else {
			$('#cmmnUserGrid').trigger('reloadGrid');
			$('#authUserGrid').trigger('reloadGrid');
			alert('삭제 완료되었습니다.');
		}
	}
	

	// 부서 & 사업소 선택
	function fn_show_type(req_dept_office) {
		var th = 'typeThSearch';
		var form = 'mainForm';
		
		//alert(req_dept_office);
		
		if(req_dept_office == 'd'){
			//$('#' + th).text('요청부서명');
			$('#' + form).find("#dept_cd").show();
			$('#' + form).find("#office_cd").hide();
			$('#' + form).find("#office_cd").val('');
		}else{
			//$('#' + th).text('요청사업소명');
			$('#' + form).find("#dept_cd").hide();
			$('#' + form).find("#office_cd").show();
			$('#' + form).find("#dept_cd").val('');
		}
	}
	

	// 부서 & 사업소 선택
	function fn_show_type_sub(req_dept_office) {
		var th = 'typeThSearch';
		var form = 'subForm';
		
		//alert(req_dept_office);
		
		if(req_dept_office == 'd'){
			//$('#' + th).text('요청부서명');
			$('#' + form).find("#dept_cd").show();
			$('#' + form).find("#office_cd").hide();
			$('#' + form).find("#office_cd").val('');
		}else{
			//$('#' + th).text('요청사업소명');
			$('#' + form).find("#dept_cd").hide();
			$('#' + form).find("#office_cd").show();
			$('#' + form).find("#dept_cd").val('');
		}
	}
	
	// 조회버튼 클릭 이벤트
	function btn_Search_onclick() {
		$('#authGroupGrid').trigger('reloadGrid');
		btn_Search_Sub_onclick();
	}
	
	// 조회버튼 클릭 이벤트
	function btn_Search_Sub_onclick() {
		$('#cmmnUserGrid').trigger('reloadGrid');
		$('#authUserGrid').trigger('reloadGrid');
	}
</script>
<div class="sub_purple_01 w100p">
	<form id="authGroupForm" name="authGroupForm" onsubmit="return false;">
		<table  class="select_table" >
			<tr>
				<td class="table_title">
					<span>■</span>
					권한그룹
				</td>
				<td class="table_button">
					<span class="button white mlargep auth_select" id="btn_Select" onclick="btn_Search_onclick();">
						<button type="button">조회</button>
					</span>
					<span class="button white mlargep auth_save" id="btn_AddLine" onclick="btn_AddLine_onclick();">
						<button type="button">행추가</button>
					</span>
					<span class="button white mlargeg auth_save" id="btn_Save" onclick="btn_Save_onclick();">
						<button type="button">저장</button>
					</span>
					<span class="button white mlarger auth_save" id="btn_Delete" onclick="btn_Delete_onclick();">
						<button type="button">삭제</button>
					</span>
				</td>
			</tr>
		</table>
		<input type="hidden" id="sortName" name="sortName">
		<input type="hidden" id="sortType" name="sortType">
		<div id="view_grid_main">
			<table id="authGroupGrid"></table>
		</div>
	</form>
</div>


<div class="sub_blue_01 w45p">
	<form id="mainForm" name="mainForm" onsubmit="return false;">
		<table  class="select_table" >
			<tr>
				<td class="table_title">
					<span>■</span>
					전체사용자
				</td>
				<td class="table_button">
					<span class="button white mlargep auth_select" id="btn_Select" onclick="fn_Search_userCmmn();">
						<button type="button">조회</button>
					</span>
				</td>
			</tr>
		</table>
		<table  class="list_table" >
			<tr>
				<th id="typeThSearch">
					<input name="req_dept_office" id="req_dept_office" type="radio" value="d" checked="checked" onClick="fn_show_type($(this).val())"/>
					<label for="req_dept_office">부서명</label>
<!-- 					<input name="req_dept_office" id="req_dept_office2" type="radio" value="o" onClick="fn_show_type($(this).val())"/> -->
<!-- 					<label for="req_dept_office2">사업소명</label> -->
				</th>
				<td>
					<select name="dept_cd" id="dept_cd" class="w120px"></select>
<!-- 					<select name="office_cd" id="office_cd" class="w120px"></select> -->
				</td>
				<th>사용자명</th>
				<td>
					<input name="user_nm" type="text" class="inputhan" />
				</td>
				<th>사용자ID</th>
				<td>
					<input name="user_id" type="text" />
				</td>
			</tr>
		</table>
		<input type="hidden" id="role_no" name="role_no">
		<input type="hidden" id="sortName" name="sortName">
		<input type="hidden" id="sortType" name="sortType">
		<div id="view_grid_sub_l">
			<table id="cmmnUserGrid"></table>
		</div>
	</form>
</div>

<!-- 하단 좌우 이동 버튼 -->
<div class="w10p">
	<span>
		<button type="button" onclick="fn_btn_Right_onclick();" id="btn_Right" class="btnRight auth_save"></button>
	</span>
	<br>
	<br>
	<span>
		<button type="button" onclick="fn_btn_Left_onclick();" id="btn_Left" class="btnLeft auth_save"></button>
	</span>
</div>

<div class="sub_blue_01 w45p">
	<form id="subForm" name="subForm" onsubmit="return false;">
		<table  class="select_table" >
			<tr>
				<td class="table_title">
					<span>■</span>
					LIMS사용자
				</td>
				<td class="table_button">
					<span class="button white mlargep auth_select" id="btn_Select" onclick="fn_Search_userLims();">
						<button type="button">조회</button>
					</span>
				</td>
			</tr>
		</table>
		<table  class="list_table" >
			<tr>
				<th id="typeThSearch">
					<input name="req_dept_office" id="req_dept_office_sub" type="radio" value="d" checked="checked" onClick="fn_show_type_sub($(this).val())"/>
					<label for="req_dept_office_sub">부서명</label>
<!-- 					<input name="req_dept_office" id="req_dept_office_sub2" type="radio" value="o" onClick="fn_show_type_sub($(this).val())"/> -->
<!-- 					<label for="req_dept_office_sub2">사업소명</label> -->
				</th>
				<td>
					<select name="dept_cd" id="dept_cd" class="w120px"></select>
<!-- 					<select name="office_cd" id="office_cd" class="w120px"></select> -->
				</td>
				<th>사용자명</th>
				<td>
					<input name="user_nm" type="text" class="inputhan" />
				</td>
				<th>사용자ID</th>
				<td>
					<input name="user_id" type="text" />
				</td>
			</tr>
		</table>
		<input type="hidden" id="role_no" name="role_no">
		<input type="hidden" id="sortName" name="sortName">
		<input type="hidden" id="sortType" name="sortType">
		<div id="view_grid_sub_r">
			<table id="authUserGrid"></table>
		</div>
	</form>
</div>

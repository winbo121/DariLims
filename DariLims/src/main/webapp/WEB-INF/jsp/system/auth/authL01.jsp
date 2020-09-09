
<%
	/***************************************************************************************
	 * 시스템명 	: 통합장비관제시스템
	 * 업무명 		: 메뉴별 권한관리
	 * 파일명 		: authL01.jsp
	 * 작성자 		: 
	 * 작성일 		: 
	 * 설  명		: 
	 *---------------------------------------------------------------------------------------
	 * 변경일		 변경자		변경내역 
	 *---------------------------------------------------------------------------------------
	 *     
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
		
		authGroupGrid('system/selectAuthGroupList.lims', 'authGroupForm', 'authGroupGrid');
		$('#authGroupGrid').clearGridData(); // 최초 조회시 데이터 안나옴
		
		cmmnMenuGrid('system/selectCmmnMenuList.lims', 'cmmnMenuForm', 'cmmnMenuGrid');
		$('#cmmnMenuGrid').clearGridData(); // 최초 조회시 데이터 안나옴
		
		authMenuGrid('system/selectAuthMenuList.lims', 'authMenuForm', 'authMenuGrid');
		$('#authMenuGrid').clearGridData(); // 최초 조회시 데이터 안나옴

		$(window).bind('resize', function() {
			$("#authGroupGrid").setGridWidth($('#view_grid_main').width(), true);
		}).trigger('resize');
		$(window).bind('resize', function() {
			$("#cmmnMenuGrid").setGridWidth($('#view_grid_main').width()*.450);
		}).trigger('resize');
		$(window).bind('resize', function() {
			$("#authMenuGrid").setGridWidth($('#view_grid_main').width()*.450);
		}).trigger('resize');
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
				editable : true,
				editrules : {
					required : true
				}
			}, {
				label : '권한그룹명',
				name : 'role_group_nm',
				editable : true,
				editrules : {
					required : true
				}
			}, {
				label : '권한설명',
				name : 'role_desc',
				width : 400,
				editable : true,
				editrules : {
					required : true
				}
			}, {
				label : '순서',
				name : 'disp_order',
				editable : true,
				editrules : {
					required : true,
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
				$('#addBtn').show();
				$('#istBtn').hide();
				fnSelectFirst(grid);
			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
			},
			onSelectRow : function(rowId, status, e) {
				if (rowId && rowId != lastRowId) {
					$('#' + grid).jqGrid('restoreRow', lastRowId);
					lastRowId = rowId;
					$('#addBtn').show();
					$('#istBtn').hide();

					var row = $('#' + grid).getRowData(rowId);
					$('#cmmnMenuForm').find('#role_no').val(row.role_no);
					$('#authMenuForm').find('#role_no').val(row.role_no);

					$('#cmmnMenuGrid').trigger('reloadGrid');
					$('#authMenuGrid').trigger('reloadGrid');
				}
			},
			ondblClickRow : function(rowId, iRow, iCol, e) {
				$('#' + grid).jqGrid('editRow', rowId);
				$('#addBtn').hide();
				$('#istBtn').show();
			}
		});
	}

	function cmmnMenuGrid(url, form, grid) {
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
			sortname : 'pre_menu_nm',
			sortorder : 'asc',
			colModel : [{
				label : '상위메뉴명',
				name : 'pre_menu_nm'
			}, {
				label : '메뉴명',
				name : 'menu_nm'
			}, {
				label : '메뉴코드',
				name : 'menu_cd',
				key : true,
				hidden : true
			} ],
			gridComplete : function() {
				if (grid == 'cmmnMenuGrid') {
					fnCheckAction(grid);
				}
			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
			}
		});
	}

	function authMenuGrid(url, form, grid) {
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
			sortname : 'menu_nm',
			sortorder : 'asc',
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
			},{
				label : '권한그룹코드',
				name : 'role_no',
			},{
				label : '상위메뉴명',
				name : 'pre_menu_nm'
			}, {
				label : '메뉴명',
				name : 'menu_nm'
			}, {
				label : '조회',
				width : '40',
				sortable : false,
				align : 'center',
				editable : true,
				edittype : 'chckbox',
				editoptions :{value : "1:0"},
				formatter : "checkbox",
				formatoptions : {
					disabled : false
				},
				name : 'auth_select'
			}, {
				label : '저장',
				width : '40',
				sortable : false,
				align : 'center',
				editable : true,
				edittype : 'chckbox',
				editoptions :{value : "1:0"},
				formatter : "checkbox",
				formatoptions : {
					disabled : false
				},
				name : 'auth_save'
			}, {
				label : '메뉴코드',
				name : 'menu_cd',
				key : true,
				hidden : true
			} ],
			gridComplete : function() {
				if (grid == 'authMenuGrid') {
					fnCheckAction(grid);
				}
			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
			}
		});
	}

	function btn_AddLine_onclick() {
		var grid = 'authGroupGrid';
		$('#' + grid).jqGrid('addRow', {
			rowID : 'insert',
			position : 'last'
		});
		$('#addBtn').hide();
		$('#istBtn').show();
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
		if (!fn_saveGridValidation("cmmnMenuGrid")) {
			return;
		}

		var data = 'role_no=' + $('#cmmnMenuForm').find('#role_no').val() + '&menu_cd=';
		var arr = $('#cmmnMenuGrid').getGridParam('selarrrow');
		if (arr != '') {
			for ( var i in arr) {
				data += arr[i] + ",";
			}
		}
		var json = fnAjaxAction('system/insertAuthMenu.lims', data);
		if (json == null) {
			alert('error');
		} else {
			$('#cmmnMenuGrid').trigger('reloadGrid');
			$('#authMenuGrid').trigger('reloadGrid');
			$.showAlert("", {
				type : 'insert'
			});
		}
	}

	function fn_insert_Success(json) {

	}

	//메뉴권한 삭제
	function fn_btn_Left_onclick() {
		var grid = "authMenuGrid";
		var data = 'role_no=' + $('#authMenuForm').find('#role_no').val() + '&menu_cd=';
		var ids = $('#' + grid).jqGrid("getDataIDs");
		var cnt = 0;
		for ( var i in ids) {
			var row = $('#' + grid).getRowData(ids[i]);
			if (row.chk == 'Yes') {
				data += ids[i] + ",";
				cnt ++;
			}
		}
		if(cnt == 0){
			alert("선택된메뉴가 없습니다.");
			return;
		}else{
			if(confirm("선택된메뉴를 삭제 하시겠습니까?")){
				var json = fnAjaxAction('system/deleteAuthMenu.lims', data);
				if (json == null) {
					alert('error');
				} else {
					$('#cmmnMenuGrid').trigger('reloadGrid');
					$('#authMenuGrid').trigger('reloadGrid');
					$.showAlert("", {
						type : 'delete'
					});
				}
			}
		}
	}


	function fn_saveValidation() {
		if (!fnIsEmpty($('#role_no').val())) {
			$.showAlert("메뉴코드를 입력하십시오.");
			$('#role_no').focus();
			return false;
		}
		return true;
	}

	//그리드에서 데이터 확인(그리드에서 바로 처리 불가능할 경우)
	function fn_saveGridValidation(grid) {
		var rowArr = $('#' + grid).getGridParam('selarrrow');
		if (rowArr.length == 0) {
			$.showAlert('선택된 메뉴가 없습니다.');
			return;
		}
		return true;
	}
	
	
	function btn_Save_sub_onclick(){
		var grid = "authMenuGrid";
		//var rowId = $('#' + grid).getGridParam('selrow');
	/* 	$('#' + grid).setCell(rowId, "auth_save",1);
		alert($('#' + grid).getCell(rowId, "auth_save")); */
		
		var data = fnGetGridAllData(grid);
		var url = 'system/saveAuthMenu.lims';
		
		if (confirm("저장하시겠습니까?")) {
			var json = fnAjaxAction(url, data);
			if (json == null) {
				alert('저장 실패되었습니다.');
			} else {
				//$('#deptLimsGrid').trigger('reloadGrid');
				alert('저장이 완료되었습니다.');
				//$('#gridMain').trigger('reloadGrid');
			}
		}		
	}
	
	// 조회버튼 클릭 이벤트
	function btn_Search_onclick() {
		$('#authGroupGrid').trigger('reloadGrid');
		btn_Search_Sub_onclick();
	}  
	
	// 서브 조회버튼 클릭 이벤트
	function btn_Search_Sub_onclick() {
		$('#cmmnMenuGrid').trigger('reloadGrid');
		$('#authMenuGrid').trigger('reloadGrid');
	}  
	
</script>
<div class="sub_purple_01 w100p">
	<form id="authGroupForm" name="authGroupForm" onsubmit="return false;">
		<table class="select_table" >
			<tr>
				<td class="table_title">
					<span>■</span>
					권한그룹
				</td>
				<td class="table_button">
					<span class="button white mlargeb auth_select" id="btn_Select" onclick="btn_Search_onclick();">
						<button type="button">조회</button>
					</span>
					<span class="button white mlargep auth_save" id="addBtn" onclick="btn_AddLine_onclick();">
						<button class="auth_save" type="button">행추가</button>
					</span>
					<span class="button white mlargeb auth_save" id="istBtn" onclick="btn_Save_onclick();">
						<button type="button">저장</button>
					</span>
				</td>
			</tr>
		</table>
	</form>
	<input type="hidden" id="sortName" name="sortName">
	<input type="hidden" id="sortType" name="sortType">
	<div id="view_grid_main">
		<table id="authGroupGrid"></table>
	</div>
</div>


<div class="sub_blue_01 w45p">
	<form id="cmmnMenuForm" name="cmmnMenuForm" onsubmit="return false" style="width: 100%;">
		<table class="select_table" >
			<tr>
				<td class="table_title">
					<span>■</span>
					전체메뉴
				</td>
			</tr>
		</table>
		<input type="hidden" id="role_no" name="role_no">
		<input type="hidden" id="sortName" name="sortName">
		<input type="hidden" id="sortType" name="sortType">
		<div id="view_grid_sub_l">
			<table id="cmmnMenuGrid"></table>
		</div>
	</form>
</div>

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
	<table class="select_table" >
		<tr>
			<td class="table_title">
				<span>■</span>
				권한메뉴
			</td>
			<td class="table_button">
				<span class="button white mlargeb auth_save" id="btn_Save_sub" onclick="btn_Save_sub_onclick();">
					<button type="button">저장</button>
				</span>
			</td>
		</tr>
	</table>
	<form id="authMenuForm" name="authMenuForm" onsubmit="return false;" style="width: 100%;">
		<input type="hidden" id="role_no" name="role_no">
		<input type="hidden" id="sortName" name="sortName">
		<input type="hidden" id="sortType" name="sortType">
		<div id="view_grid_sub_r">
			<table id="authMenuGrid"></table>
		</div>
	</form>
</div>

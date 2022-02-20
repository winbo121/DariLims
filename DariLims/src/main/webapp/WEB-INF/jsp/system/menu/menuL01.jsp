
<%
	/***************************************************************************************
	 * 시스템명 	: 통합장비관제시스템
	 * 업무명 		: 메뉴관리
	 * 파일명 		: menuL01.jsp
	 * 작성자 		: 정우용
	 * 작성일 		: 2015.01.20
	 * 설  명		: 메뉴관리 리스트 조회 화면
	 *---------------------------------------------------------------------------------------
	 * 변경일		 변경자		변경내역 
	 *---------------------------------------------------------------------------------------
	 * 2015.01.20    정우용		최초 프로그램 작성         
	 * 
	 *---------------------------------------------------------------------------------------
	 ****************************************************************************************/
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" media="screen" type="text/css" href="<c:url value='/css/common/sub.css'/>" />
<style>
</style>

<script type="text/javascript">
	$(function() {
		/* 세부권한검사 */
		fn_auth_check();

		//url명명 규칙(p.21) 
		menuGroupGrid('system/selectMenuGroupList.lims', 'mainForm', 'menuGroupGrid');
		$('#menuGroupGrid').clearGridData(); // 최초 조회시 데이터 안나옴
		menuDetailGrid('system/selectMenuDetailList.lims', 'subForm', 'menuDetailGrid');
		$('#menuDetailGrid').clearGridData(); // 최초 조회시 데이터 안나옴
		
		fnEditRelease('menuGroupGrid');

		
		// 엔터키 눌렀을 경우
		fn_Enter_Search('mainForm', 'menuGroupGrid');
		fn_Enter_Search('subForm', 'menuDetailGrid');
	        
        $(window).bind('resize', function() {
			$("#menuGroupGrid").setGridWidth($('#sub_purple_01').width(), true);
		}).trigger('resize');    
		 
		$(window).bind('resize', function() {
			$("#menuDetailGrid").setGridWidth($('#sub_purple_01').width(), true);
		}).trigger('resize');
		
	});

	function menuGroupGrid(url, form, grid) {
		var lastRowId;
		$('#' + grid).jqGrid({
			datatype : function(json) {
				fnGridData(url, form, grid);
			},
			height : '230',
			autowidth : false,
			loadonce : true,
			mtype : "POST",
			gridview : true,
			rowNum : -1,
			rownumbers : true,
			sortname : 'disp_order',
			sortorder : 'asc',
			colModel : [ {
				label : '메뉴명',
				name : 'menu_nm',
				editable : true,
				width : '150',
				editrules : {
					required : true
				}
			}, {
				label : '메뉴코드',
				name : 'menu_cd',
				key : true,
				editable : true,
				width : '130',
				editrules : {
					required : true,
					number : true
				}
			}, {
				label : '정렬순서',
				name : 'disp_order',
				editable : true,
				width : '100',
				editrules : {
					number : true
				}
			}, {
				label : '사용여부',
				name : 'use_flag',
				editable : true,
				width : '100',
				edittype : "select",
				editoptions : {
					value : 'Y:사용;N:미사용'
				},
				editrules : {
					required : true
				}
			}, {
				label : '메뉴설명',
				name : 'menu_desc',
				width : '160',
				editable : true
			} ],
			gridComplete : function() {
				fnSelectFirst(grid);

				$('#btn_AddLine').show();
				$('#btn_Save').hide();
				$('#btn_Delete').hide();

			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
			},
			onSelectRow : function(rowId, status, e) {
				$("#subForm")[0].reset();

				if (rowId && rowId != lastRowId) {
					$('#' + grid).jqGrid('restoreRow', lastRowId);
					lastRowId = rowId;
					$('#btn_AddLine').show();
					$('#btn_Save').hide();
					$('#btn_Delete').hide();

					//fnEditRelease('menuDetailGrid');

					var row = $('#' + grid).getRowData(rowId);
					$('#subForm').find('#pre_menu_cd').val(row.menu_cd);
					$('#menuDetailGrid').trigger('reloadGrid');
				}
			},
			ondblClickRow : function(rowId, iRow, iCol, e) {
				fnEditRelease(grid);
				$('#' + grid).jqGrid('editRow', rowId);

				$('#btn_AddLine').hide();
				$('#btn_Save').show();
				$('#btn_Delete').show();
			}

		});
	}

	function menuDetailGrid(url, form, grid) {
		var lastRowId;
		$('#' + grid).jqGrid({
			datatype : function(json) {
				fnGridData(url, form, grid);
			},
			height : '230',
			autowidth : false,
			loadonce : true,
			mtype : "POST",
			gridview : true,
			rowNum : -1,
			rownumbers : true,
			sortname : 'disp_order',
			sortorder : 'asc',
			colModel : [ {
				label : '메뉴명',
				name : 'menu_nm',
				editable : true,
				width : '150',
				editrules : {
					required : true
				}
			}, {
				label : '메뉴코드',
				name : 'menu_cd',
				key : true,
				editable : true,
				width : '80',
				editrules : {
					required : true,
					number : true
				}
			}, {
				label : '메뉴경로',
				name : 'menu_url',
				editable : true,
				width : '200',
				editrules : {
					required : true
				}
			}, {
				label : '정렬순서',
				name : 'disp_order',
				editable : true,
				width : '100',
				editrules : {
					number : true
				}
			}, {
				label : '사용여부',
				name : 'use_flag',
				editable : true,
				edittype : "select",
				width : '100',
				editoptions : {
					value : 'Y:사용;N:미사용'
				},
				editrules : {
					required : true
				}
			}, {
				label : '메뉴설명',
				name : 'menu_desc',
				width : '160',
				editable : true
			} ],
			gridComplete : function() {
				//공통버튼명(p.24)
				$('#btn_AddLine_Sub1').show();
				$('#btn_Save_Sub1').hide();
				$('#btn_Delete_Sub1').hide();
			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
			},
			onSelectRow : function(rowId, status, e) {
				if (rowId && rowId != lastRowId) {
					$('#' + grid).jqGrid('restoreRow', lastRowId);
					lastRowId = rowId;
					$('#btn_AddLine_Sub1').show();
					$('#btn_Save_Sub1').hide();
					$('#btn_Delete_Sub1').hide();
				}
			},
			ondblClickRow : function(rowId, iRow, iCol, e) {
				fnEditRelease(grid);
				$('#' + grid).jqGrid('editRow', rowId);
				$('#btn_AddLine_Sub1').hide();
				$('#btn_Save_Sub1').show();
				$('#btn_Delete_Sub1').show();
			}
		});
	}

	//메뉴그룹 조회버튼 클릭 이벤트
	function btn_Search_onclick() {
		$('#menuGroupGrid').trigger('reloadGrid');
		btn_Search_Sub1_onclick();
	}

	//메뉴그룹 행추가버튼 클릭 이벤트
	function btn_AddLine_onclick() {
		var grid = 'menuGroupGrid';
		$('#' + grid).jqGrid('addRow', {
			rowID : 0,
			position : 'last'
		});
		$('#btn_AddLine').hide();
		$('#btn_Save').show();
		$('#btn_Delete').hide();
	}

	//메뉴그룹 저장버튼 클릭 이벤트
	function btn_Save_onclick() {
		var grid = 'menuGroupGrid';
		var rowId = $('#' + grid).getGridParam('selrow');
		var pageType = '';
		if (rowId == '0') {
			pageType = 'insert';
		} else {
			pageType = 'update';
		}
		$('#' + grid).jqGrid('saveRow', rowId, successfunc, 'system/saveMenuGroup.lims', {
			pageType : pageType
		}, fn_Success_insertGroup, null, null);
	}

	//메뉴그룹 삭제버튼 클릭 이벤트
	function btn_Delete_onclick() {
		if (!confirm("삭제하시겠습니까?")) {
			return false;
		}
		var grid = 'menuGroupGrid';
		var rowId = $('#' + grid).getGridParam('selrow');
		$('#' + grid).jqGrid('saveRow', rowId, successfunc, 'system/deleteMenu.lims', null, fn_Success_deleteGroup, null, null);
	}

	//메뉴그룹 저장 후 콜백 이벤트
	function fn_Success_insertGroup(json) {
		if (json == null) {
			$.showAlert("저장 실패하였습니다.");
		} else {
			$.showAlert("", {
				type : 'insert'
			});
			$('#menuGroupGrid').trigger('reloadGrid');
		}
	}

	//메뉴그룹 삭제 후 콜백 이벤트
	function fn_Success_deleteGroup(json) {
		if (json == null) {
			$.showAlert("삭제 실패하였습니다.");
		} else {
			$.showAlert("", {
				type : 'delete'
			});
			$('#menuGroupGrid').trigger('reloadGrid');
		}
	}

	//메뉴상세 조회버튼 클릭 이벤트
	function btn_Search_Sub1_onclick() {
		$('#menuDetailGrid').trigger('reloadGrid');
	}

	//메뉴상세 행추가버튼 클릭 이벤트
	function btn_AddLine_Sub1_onclick() {
		var preMenuCd = $('#subForm').find('#pre_menu_cd').val();
		if (preMenuCd != '') {
			var grid = 'menuDetailGrid';
			$('#' + grid).jqGrid('addRow', {
				rowID : 0,
				position : 'last'
			});
			$('#btn_AddLine_Sub1').hide();
			$('#btn_Save_Sub1').show();
			$('#btn_Delete_Sub1').hide();
		} else {
			alert("선택된 메뉴그룹이 없습니다.");
		}
	}

	//메뉴상세 저장버튼 클릭 이벤트
	function btn_Save_Sub1_onclick() {
		var grid = 'menuDetailGrid';
		var rowId = $('#' + grid).getGridParam('selrow');
		var pageType = '';
		var pre_menu_cd = $('#subForm').find('#pre_menu_cd').val();
		if (rowId == '0') {
			pageType = 'insert';
		} else {
			pageType = 'update';
		}
		$('#' + grid).jqGrid('saveRow', rowId, successfunc, 'system/saveMenuDetail.lims', {
			pageType : pageType,
			pre_menu_cd : pre_menu_cd
		}, fn_Success_inserDetail, null, null);
	}

	//메뉴상세 삭제버튼 클릭 이벤트
	function btn_Delete_Sub1_onclick() {
		$.showConfirm("삭제하시겠습니까?", {
			yesCallback : function() {
				var grid = 'menuDetailGrid';
				var rowId = $('#' + grid).getGridParam('selrow');
				$('#' + grid).jqGrid('saveRow', rowId, successfunc, 'system/deleteMenu.lims', null, fn_Success_deleteDetail, null, null);
			}
		});
	}

	//메뉴상세 저장 후 콜백 이벤트
	function fn_Success_inserDetail(json) {
		if (json == null) {
			$.showAlert("저장 실패하였습니다.");
		} else {
			$.showAlert("", {
				type : 'insert'
			});
			$('#menuDetailGrid').trigger('reloadGrid');
		}
	}

	//메뉴그룹 삭제 후 콜백 이벤트
	function fn_Success_deleteDetail(json) {
		if (json == null) {
			$.showAlert("삭제 실패하였습니다.");
		} else {
			$.showAlert("", {
				type : 'delete'
			});
			$('#menuDetailGrid').trigger('reloadGrid');
		}
	}
</script>
<div class="sub_purple_01 w49p">
	<form id="mainForm" name="mainForm" onsubmit="return false;">
		<table  class="select_table" >
			<tr>
				<td class="table_title">
					<span>■</span>
					메뉴그룹
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
		<table  class="list_table" >
			<tr>
				<th>메뉴명</th>
				<td>
					<input type="text" id="menu_nm" name="menu_nm" class="inputhan" />
				</td>
				<th>사용여부</th>
				<td>
					<label><input type='radio' name='use_flag' value='' checked="checked" />전체</label> <label><input type='radio' name='use_flag' value='Y' />사용</label> <label><input type='radio' name='use_flag' value='N' />미사용</label>
				</td>
			</tr>
		</table>
		<input type="hidden" id="sortName" name="sortName">
		<input type="hidden" id="sortType" name="sortType">
		<div id="view_grid_sub_l">
			<table id="menuGroupGrid"></table>
		</div>
	</form>
</div>

<div class="sub_purple_01 w49p">
	<form id="subForm" name="subForm" onsubmit="return false;">
		<table  class="select_table" >
			<tr>
				<td class="table_title">
					<span>■</span>
					메뉴상세
				</td>
				<td class="table_button">
					<span class="button white mlargep auth_select" id="btn_Select" onclick="btn_Search_Sub1_onclick();">
						<button type="button">조회</button>
					</span>
					<span class="button white mlargep auth_save" id="btn_AddLine_Sub1" onclick="btn_AddLine_Sub1_onclick();">
						<button type="button">행추가</button>
					</span>
					<span class="button white mlargeg auth_save" id="btn_Save_Sub1" onclick="btn_Save_Sub1_onclick();">
						<button type="button">저장</button>
					</span>
					<span class="button white mlarger auth_save" id="btn_Delete_Sub1" onclick="btn_Delete_Sub1_onclick();">
						<button type="button">삭제</button>
					</span>
				</td>
			</tr>
		</table>
		<table  class="list_table" >
			<tr>
				<th>메뉴명</th>
				<td>
					<input type="text" id="menu_nm" name="menu_nm" class="inputhan" />
				</td>
				<th>사용여부</th>
				<td>
					<label><input type='radio' name='use_flag' value='' checked="checked" />전체</label> <label><input type='radio' name='use_flag' value='Y' />사용</label> <label><input type='radio' name='use_flag' value='N' />미사용</label>
				</td>
			</tr>
		</table>
		<input type="hidden" id="pre_menu_cd" name="pre_menu_cd">
		<input type="hidden" id="sortName" name="sortName">
		<input type="hidden" id="sortType" name="sortType">
		<div id="view_grid_sub_r w49p">
			<table id="menuDetailGrid"></table>
		</div>
	</form>
</div>

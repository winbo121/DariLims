
<%
	/***************************************************************************************
	 * 시스템명 	: 대덕분석기술연구소
	 * 업무명 		: 메일그룹관리
	 * 파일명 		: mailGroupL01.jsp
	 * 작성자 		: 송성수
	 * 작성일 		: 2020.01.06
	 * 설  명		: 메일그룹관리
	 *---------------------------------------------------------------------------------------
	 * 변경일		 변경자		변경내역 
	 *---------------------------------------------------------------------------------------
	 * 2020.01.06   송성수		최초 프로그램 작성         
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
		mailGroupGrid('master/selectListMailGroup.lims', 'mainForm', 'mailGroupGrid');
		$('#mailGroupGrid').clearGridData(); // 최초 조회시 데이터 안나옴
		
		mailDetailGrid('master/selectListMailAddress.lims', 'subForm', 'mailDetailGrid');
		$('#mailDetailGrid').clearGridData(); // 최초 조회시 데이터 안나옴

		// 엔터키 눌렀을 경우
		fn_Enter_Search('mainForm', 'mailGroupGrid');

		fn_Enter_Search('subForm', 'mailDetailGrid');

		$(window).bind('resize', function() {
			$("#mailGroupGrid").setGridWidth($('#sub_purple_01').width(), true);
		}).trigger('resize');
		$(window).bind('resize', function() {
			$("#mailDetailGrid").setGridWidth($('#sub_purple_01').width(), true);
		}).trigger('resize');
	});

	function mailGroupGrid(url, form, grid) {
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
			shrinkToFit : true,
			colModel : [ {
				label : '메일그룹순번',
				name : 'mailGroupSn',
				key : true,
				editable : false,
				hidden : true
			}, {
				label : '메일그룹명',
				name : 'mailGroupNm',
				editable : true,
				width : '500',
				editrules : {
					required : true
				}
			}, {
				label : '사용여부',
				name : 'useYn',
				editable : true,
				edittype : "select",
				width : '190',
				editoptions : {
					value : 'Y:사용;N:미사용'
				},
				editrules : {
					required : true
				}
			}],
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

					//fnEditRelease('mailDetailGrid');

					var row = $('#' + grid).getRowData(rowId);
					$('#subForm').find('#mailGroupSn').val(row.mailGroupSn);
					$('#mailDetailGrid').trigger('reloadGrid');
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

	function mailDetailGrid(url, form, grid) {
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
			shrinkToFit : true,
			colModel : [ {
				label : '메일주소',
				name : 'mailAddress',
				width : '250',
				editable : true,
				
				editrules : {
					required : true
				}
			}, {
				label : '메일그룹순번',
				name : 'mailGroupSn',
				width : '100',
				editable : false
			}, {
				label : '메일그룹상세순번',
				name : 'mailGroupDetailSn',
				width : '120',
				key : true,
				editable : false
			}, {
				label : '이름',
				name : 'mailNm',
				width : '120',
				editable : true
			}, {
				label : '사용여부',
				name : 'useYn',
				width : '80',
				editable : true,
				edittype : "select",
				editoptions : {
					value : 'Y:사용;N:미사용'
				},
				editrules : {
					required : true
				}
			}],
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
					//$('#' + grid).jqGrid('restoreRow', lastRowId);
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
		$('#mailGroupGrid').trigger('reloadGrid');
		btn_Search_Sub1_onclick();
	}

	//메뉴그룹 행추가버튼 클릭 이벤트
	function btn_AddLine_onclick() {
		var grid = 'mailGroupGrid';
		$('#' + grid).jqGrid('addRow', {
			rowID : 0,
			position : 'last'
		});
		$('#btn_AddLine').hide();
		$('#btn_Save').show();
		$('#btn_Delete').hide();
	}

	//메일그룹 저장버튼 클릭 이벤트
	function btn_Save_onclick() {
		var grid = 'mailGroupGrid';
		var rowId = $('#' + grid).getGridParam('selrow');
		var pageType = '';
		if (rowId == '0') {
			pageType = 'insert';
		} else {
			pageType = 'update';
		}
		$('#' + grid).jqGrid('saveRow', rowId, successfunc, 'master/saveMailGroup.lims', {
			pageType : pageType
		}, fn_Success_insertGroup, null, null);
	}

	//메일그룹 삭제버튼 클릭 이벤트
	function btn_Delete_onclick() {
		if (!confirm("삭제하시겠습니까?")) {
			return false;
		}
		var grid = 'mailGroupGrid';
		var rowId = $('#' + grid).getGridParam('selrow');
		$('#' + grid).jqGrid('saveRow', rowId, successfunc, 'master/deleteMailGroup.lims', null, fn_Success_deleteGroup, null, null);
	}

	//메뉴그룹 저장 후 콜백 이벤트
	function fn_Success_insertGroup(json) {
		if (json == null) {
			$.showAlert("저장 실패하였습니다.");
		} else {
			$.showAlert("", {
				type : 'insert'
			});
			$('#mailGroupGrid').trigger('reloadGrid');
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
			$('#mailGroupGrid').trigger('reloadGrid');
		}
	}

	//메뉴상세 조회버튼 클릭 이벤트
	function btn_Search_Sub1_onclick() {
		$('#mailDetailGrid').trigger('reloadGrid');
	}

	//메일그룹 상세 행추가버튼 클릭 이벤트
	function btn_AddLine_Sub1_onclick() {
		var preMailCd = $('#subForm').find('#mailGroupSn').val();
		if (preMailCd != '') {
			var grid = 'mailDetailGrid';
			$('#' + grid).jqGrid('addRow', {
				rowID : 0,
				position : 'last'
			});
			$('#btn_AddLine_Sub1').hide();
			$('#btn_Save_Sub1').show();
			$('#btn_Delete_Sub1').hide();
		} else {
			alert("선택된 메일그룹이 없습니다.");
		}
	}

	//메뉴상세 저장버튼 클릭 이벤트
	function btn_Save_Sub1_onclick() {
		var grid = 'mailDetailGrid';
		var rowId = $('#' + grid).getGridParam('selrow');
		var pageType = '';
		var mailGroupSn = $('#subForm').find('#mailGroupSn').val();
		if (rowId == '0') {
			pageType = 'insert';
		} else {
			pageType = 'update';
		}
		$('#' + grid).jqGrid('saveRow', rowId, successfunc, 'master/saveMailAddress.lims', {
			pageType : pageType,
			mailGroupSn : mailGroupSn
		}, fn_Success_inserDetail, null, null);
	}

	//메뉴상세 삭제버튼 클릭 이벤트
	function btn_Delete_Sub1_onclick() {
		$.showConfirm("삭제하시겠습니까?", {
			yesCallback : function() {
				var grid = 'mailDetailGrid';
				var rowId = $('#' + grid).getGridParam('selrow');
				$('#' + grid).jqGrid('saveRow', rowId, successfunc, 'master/deleteMailAddress.lims', null, fn_Success_deleteDetail, null, null);
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
			$('#mailDetailGrid').trigger('reloadGrid');
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
			$('#mailDetailGrid').trigger('reloadGrid');
		}
	}
</script>
<div class="sub_purple_01 w49p">
	<form id="mainForm" name="mainForm" onsubmit="return false;">
		<table  class="select_table" >
			<tr>
				<td class="table_title">
					<span>■</span>
					메일그룹
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
				<th>메일그룹명</th>
				<td>
					<input type="text" id="mail_nm" name="mail_nm" class="inputhan" />
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
			<table id="mailGroupGrid"  style="width:49%;"></table>
		</div>
	</form>
</div>

<div class="sub_purple_01 w49p">
	<form id="subForm" name="subForm" onsubmit="return false;">
		<table  class="select_table" >
			<tr>
				<td class="table_title">
					<span>■</span>
					메일그룹상세
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
				<th>이메일</th>
				<td>
					<input type="text" id="mailAddress" name="mailAddress" class="inputhan" />
				</td>
				<th>사용여부</th>
				<td>
					<label><input type='radio' name='useYn' value='' checked="checked" />전체</label> <label><input type='radio' name='useYn' value='Y' />사용</label> <label><input type='radio' name='useYn' value='N' />미사용</label>
				</td>
			</tr>
		</table>
		<input type="hidden" id="mailGroupSn" name="mailGroupSn">
		<input type="hidden" id="sortName" name="sortName">
		<input type="hidden" id="sortType" name="sortType">
		<div id="view_grid_sub_r" >
			<table id="mailDetailGrid" style="width:49%;"></table>
		</div>
	</form>
</div>

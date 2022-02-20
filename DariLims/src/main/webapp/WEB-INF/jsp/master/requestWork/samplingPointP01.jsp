<%
	/***************************************************************************************
	 * 시스템명 	: 통합장비관제시스템
	 * 업무명 		: 채수장소관리
	 * 파일명 		: samplingPointP01.jsp
	 * 작성자 		: 최은향
	 * 작성일 		: 2015.02.02
	 * 설  명		: 채수장소관리 팝업 화면
	 *---------------------------------------------------------------------------------------
	 * 변경일		 변경자		변경내역 
	 *---------------------------------------------------------------------------------------
	 * 2015.02.02    최은향		최초 프로그램 작성         
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
	var obj;
	$(function() {
		obj = window.dialogArguments;
		grid('master/selectOfficeList.lims', 'form', 'grid');
		//ajaxComboForm("org_type", "C24", "ALL", null, 'form');

		$(window).bind('resize', function() {
			$("#grid").setGridWidth($('#view_grid_main').width(), false);
		}).trigger('resize');

		// 엔터키 눌렀을 경우(그리드 조회)
		fn_Enter_Search('form', 'grid');
	});
	function grid(url, form, grid) {
		$('#' + grid).jqGrid({
			datatype : function(json) {
				fnGridData(url, form, grid);
			},
			height : '272',
			autowidth : true,
			//width : '390',
			loadonce : true,
			mtype : "POST",
			gridview : true,
			shrinkToFit : false,
			rowNum : -1,
			rownumbers : true,
			colModel : [ {
				index : 'req_org_no',
				label : '의뢰처번호',
				name : 'req_org_no',
				key : true,
				hidden : true
			}, {
				index : 'req_org_nm',
				label : '의뢰처',
				width : '150', 
				name : 'org_nm'
			}, {
				label : '의뢰처구분',
				width : '150', 
				name : 'org_type'
			}, {
				label : '담당자',
				//name : 'charger'
				align : 'center',
				width : '60', 
				name : 'req_nm'
			}, {
				label : '담당자전화번호',
				//name : 'charger_tel'
				width : '100', 
				name : 'req_tel'
			}, {
				label : '대표번호',
				width : '100', 
				name : 'pre_tel_num'
			}, {
				label : '팩스',
				width : '100', 
				name : 'pre_fax_num'
			}, {
				label : '홈페이지',
				width : '200', 
				name : 'homepage'
			}, {
				label : '비고',
				width : '200', 
				name : 'org_desc'
			}, {
				label : '우편번호',
				width : '60', 
				align : 'center',
				name : 'zip_code'
			}, {
				label : '주소',
				name : 'addr1'
			}, {
				label : '상세주소',
				name : 'addr2'
			} ],
			gridComplete : function() {
			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
			},
			onSelectRow : function(rowId, status, e) {
			},
			ondblClickRow : function(rowId, iRow, iCol, e) {
				btn_Save_onclick(grid);
			}
		});
	}
	function gridSub(url, form, grid) {
		$('#' + grid).jqGrid({
			datatype : function(json) {
				fnGridData(url, form, grid);
			},
			height : 'auto',
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
				btn_Save_onclick(grid);
			}
		});
	}
	function btn_Select_onclick() {
		$('#grid').trigger('reloadGrid');
	}
	function btn_Save_onclick(grid) {
		var rowId = $('#' + grid).getGridParam('selrow');
		if (rowId != null) {
			var data = '';
			var row = $('#' + grid).getRowData(rowId);
			for ( var r in row) {
				var val = row[r];
				var cell = $('#' + grid).getColProp(r);
				if (cell.edittype == 'select') {
					$('#' + grid).jqGrid('editRow', rowId, true);
					val = $('#' + grid).find('#' + rowId + '_' + r).val();
					fnEditRelease(grid);
				}
				if (r != 'icon') {
					data += r + '●★●' + val + '■★■';
				}
			}
			data = data.substring(0, data.length - 3);
			window.returnValue = data;
			window.close();
		} else {
			$.showAlert('선택된 행이 없습니다.');
		}
	}
</script>

<div class="popUp">
	<div class="pop_area pop_intro">
	<h2>사업소</h2>
		<form id="form" name="form" onsubmit="return false;">
			<div class="sub_purple_01 w100p" style="margin-top: 0px;">
				<table  class="select_table" >
					<tr>
						<td width="20%" class="table_title">
							<span>■</span>
							사업소 목록
						</td>
						<td class="table_button">
							<span class="button white mlargep auth_save" id="btn_Select" onclick="btn_Select_onclick();">
								<button type="button">조회</button>
							</span>
							<span class="button white mlargeg auth_save" id="btn_Save" onclick="btn_Save_onclick('grid');">
								<button type="button">선택</button>
							</span>
							<span class="button white mlargeb" id="btn_Cancel" onclick="window.close();">
								<button type="button">취소</button>
							</span>
						</td>
					</tr>
				</table>
				<table  class="list_table" >
					<tr>
						<th>의뢰처</th>
						<td>
							<input name="org_nm" type="text" class="inputhan" />
						</td>
						<th>담당자</th>
						<td>
							<input name="req_nm" type="text" class="inputhan" />
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
	</div>
</div>
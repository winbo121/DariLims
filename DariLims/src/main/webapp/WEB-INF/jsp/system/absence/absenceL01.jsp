
<%
	/***************************************************************************************
	 * 시스템명 	: 통합장비관제시스템
	 * 업무명 		: 부재관리
	 * 파일명 		: absenceL01.jsp
	 * 작성자 		: 진영민
	 * 작성일 		: 2015.06.11
	 * 설  명		: 
	 *---------------------------------------------------------------------------------------
	 * 변경일		 변경자		변경내역 
	 *---------------------------------------------------------------------------------------
	 * 2015.06.11    진영민		최초 프로그램 작성         
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
		
		ajaxComboForm("dept_cd", "", "${session.dept_cd }", "ALLNAME", 'form');

		grid('system/selectAbsenceList.lims', 'form', 'grid');
		$('#grid').clearGridData(); // 최초 조회시 데이터 안나옴

		userGrid('system/selectAbsenceUserList.lims', 'userForm', 'userGrid');

		//그리드 width조절하기
		$(window).bind('resize', function() {
			$("#grid").setGridWidth($('#view_grid_main').width(), true);
		}).trigger('resize');
		fn_Enter_Search('form', 'grid');
		fn_Enter_Search('userForm', 'userGrid');
	});
	function grid(url, form, grid) {
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
			colModel : [ {
				label : '아이디',
				name : 'user_id',
				align : 'center',
				key : true,
				hidden : true
			}, {
				label : '부서',
				name : 'dept_nm',
				align : 'center'
			}, {
				label : '부재자',
				name : 'user_nm',
				align : 'center'
			}, {
				label : '부재기간',
				name : 'startDate',
				align : 'center'
			}, {
				label : '대리부서',
				name : 'substitute_dept_nm',
				align : 'center'
			}, {
				label : '대리자',
				name : 'substitute_nm',
				align : 'center'
			}, {
				label : '사유 및 내용',
				name : 'etc'
			} ],
			gridComplete : function() {
			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
			},
			onSelectRow : function(rowId, status, e) {
				fnViewPage('system/selectAbsenceDetail.lims', 'detailDiv', 'pageType=detail&user_id=' + rowId);
				$('#btn_Save_Sub1').show();
				$('#btn_Delete_Sub1').show();
			}
		});
	}
	function userGrid(url, form, grid) {
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
			colModel : [ {
				label : '아이디',
				name : 'user_id',
				align : 'center',
				key : true,
				hidden : true
			}, {
				label : '부서',
				name : 'dept_nm',
				align : 'center'
			}, {
				label : '성명',
				name : 'user_nm',
				align : 'center'
			}, {
				label : '직책',
				name : 'rank_nm'
			} ],
			gridComplete : function() {
			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
			},
			onSelectRow : function(rowId, status, e) {
			},
			ondblClickRow : function(rowId, iRow, iCol, e) {
				var row = $('#userGrid').getRowData(rowId);
				$('#detail').find('#substitute_dept_nm').text(row.dept_nm);
				$('#detail').find('#substitute_nm').text(row.user_nm);
				$('#detail').find('#substitute_id').val(row.user_id);
				$('#dialog').dialog("destroy");
			}
		});
	}
	function btn_Select_onclick() {
		$('#grid').trigger('reloadGrid');
		$('#btn_Save_Sub1').hide();
		$('#btn_Delete_Sub1').hide();
	}
	function btn_New_onclick() {
		fnViewPage('system/selectAbsenceDetail.lims', 'detailDiv', null);
		$('#btn_Save_Sub1').show();
		$('#btn_Delete_Sub1').hide();
		$('#grid').jqGrid('resetSelection');
	}
	function btn_Save_onclick() {
		if ($('#detail').find('#substitute_id').val() == '${session.user_id}') {
			alert('본인을 대리자로 지정할 수 없습니다.');
		} else if ($('#detail').find('#substitute_id').val() == '') {
			alert('대리자를 지정해 주세요.');
		} else if ($('#detail').find('#startDate').val() == '') {
			alert('시작일을 지정해 주세요.');
		} else if ($('#detail').find('#endDate').val() == '') {
			alert('종료일을 지정해 주세요.');
		} else {
			var url = 'system/saveAbsence.lims';
			var json = fnAjaxAction(url, $('#detail').serialize());
			if (json == null) {
				$.showAlert('저장 실패되었습니다.');
			} else {
				$('#grid').trigger('reloadGrid');
				$('#detail').empty();
				$.showAlert('저장이 완료되었습니다.');
			}
		}
	}
	function btn_Delete_onclick() {
		if (!confirm("삭제하시겠습니까?")) {
			return false;
		}
		if ($('#detail').find('#user_id').val() != '${session.user_id}') {
			$.showAlert('본인건만 삭제 가능합니다.');
		} else {
			var json = fnAjaxAction('system/deleteAbsence.lims', $('#detail').serialize());
			if (json == null) {
				$.showAlert('삭제 실패되었습니다.');
			} else {
				$('#grid').trigger('reloadGrid');
				$('#detail').empty();
				$('#userDiv').hide();
				$.showAlert('삭제 완료되었습니다.');
			}
		}
	}
	function btn_Choice_onclick(rowId) {
		$("#dialog").dialog({
			width : 700,
			height : 390,
			resizable : false,
			title : '사용자 목록',
			modal : true,
			open : function(event, ui) {
				$(window).bind('resize', function() {
					$("#userGrid").setGridWidth($('#view_grid_sub1').width(), true);
				}).trigger('resize');
			},
			buttons : [ {
				text : "선택",
				click : function() {
					var rowId = $('#userGrid').getGridParam('selrow');
					var row = $('#userGrid').getRowData(rowId);
					$('#detail').find('#substitute_dept_nm').text(row.dept_nm);
					$('#detail').find('#substitute_nm').text(row.user_nm);
					$('#detail').find('#substitute_id').val(row.user_id);
					$(this).dialog("destroy");
				}
			}, {
				text : "취소",
				click : function() {
					$(this).dialog("destroy");
				}
			} ]
		});
	}
</script>
<div class="sub_purple_01 w100p">
	<form id="form" name="form" onsubmit="return false;">
		<table  class="select_table" >
			<tr>
				<td width="20%" class="table_title">
					<span>■</span>
					부재설정리스트
				</td>
				<td class="table_button" style="text-align: right; padding-right: 30px;">
					<span class="button white mlargep auth_select" id="btn_Select" onclick="btn_Select_onclick();">
						<button type="button">조회</button>
					</span>
					<span class="button white mlargep auth_save" id="btn_New_Sub1" onclick="btn_New_onclick();">
						<button type="button">추가</button>
					</span>
				</td>
			</tr>
		</table>
		<table  class="list_table" >
			<tr>
				<th>부서</th>
				<td>
					<select name=dept_cd id="dept_cd" class="w100px"></select>
				</td>
				<th>부재자</th>
				<td>
					<input id="user_nm" name="user_nm" />
				</td>
				<th>대리자</th>
				<td>
					<input id="substitute_nm" name="substitute_nm" />
				</td>
			</tr>
		</table>
		<input type="hidden" id="sortName" name="sortName">
		<input type="hidden" id="sortType" name="sortType">
		<div id="view_grid_main">
			<table id="grid"></table>
		</div>
	</form>
</div>
<div class="sub_blue_01 w100p" id="detailDiv"></div>

<div id="dialog" style="display: none;">
	<div class="sub_blue_01 w100p">
		<form id="userForm" name="userForm" onsubmit="return false;">
			<input type="hidden" id="dept_cd" name="dept_cd" value="${session.dept_cd }">
			<input type="hidden" id="user_id" name="user_id" value="${session.user_id }">
			<input type="hidden" id="sortName" name="sortName">
			<input type="hidden" id="sortType" name="sortType">
			<div id="view_grid_sub1">
				<table id="userGrid"></table>
			</div>
		</form>
	</div>
</div>

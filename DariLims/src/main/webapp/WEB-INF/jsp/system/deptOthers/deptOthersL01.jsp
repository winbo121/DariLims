
<%
	/***************************************************************************************
	 * 시스템명 	: 통합장비관제시스템
	 * 업무명 		: 사업소관리
	 * 파일명 		: deptOthersL01.jsp
	 * 작성자 		: 최은향
	 * 작성일 		: 2015.08.01
	 * 설  명		: 사업소관리 리스트 조회 화면
	 *---------------------------------------------------------------------------------------
	 * 변경일		 변경자		변경내역 
	 *---------------------------------------------------------------------------------------
	 * 2015.08.01    최은향		최초 프로그램 작성         
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
	var quart;
	var qreport_type;
	$(function() {
		/* 세부권한검사 */
		fn_auth_check();
		
		$('#btn_User_New').hide();

		grid('system/selectDeptOthersList.lims', 'form', 'grid');
		$('#grid').clearGridData(); // 최초 조회시 데이터 안나옴

		userGrid('system/selectDeptOthersUserList.lims', 'formSub', 'gridSub');
		fn_Enter_Search('form', 'grid');

		$(window).bind('resize', function() {
			$("#grid").setGridWidth($('#view_grid_main').width(), true);
		}).trigger('resize');
		$(window).bind('resize', function() {
			$("#gridSub").setGridWidth($('#view_grid_sub1').width(), true);
		}).trigger('resize');
	});

	function grid(url, form, grid) {
		var lastRowId;
		$('#' + grid).jqGrid({
			datatype : function(json) {
				fnGridData(url, form, grid);
			},
			height : '500',
			autowidth : true,
			loadonce : true,
			mtype : "POST",
			gridview : true,
			shrinkToFit : false,
			rowNum : -1,
			rownumbers : true,
			colModel : [ {
				label : 'dept_cd',
				name : 'dept_cd',
				key : true,
				hidden : true
			}, {
				label : '사업소',
				name : 'dept_nm'
			}, {
				label : '사용',
				name : 'use_flag',
				edittype : "select",
				editoptions : {
					value : "Y:사용;N:사용안함"
				},
				formatter : 'select'
			} ],
			gridComplete : function() {
			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
			},
			onSelectRow : function(rowId, status, e) {
				if (rowId && rowId != lastRowId) {
					lastRowId = rowId;
					$('#btn_User_New').show();
					$('#formSub').find('#dept_cd').val(rowId);
					btn_Select_Sub_onclick();
				}
			},
			ondblClickRow : function(rowId, iRow, iCol, e) {
				fn_add_dept_others(1);
			}
		});
	}
	function userGrid(url, form, grid) {
		$('#' + grid).jqGrid({
			datatype : function(json) {
				if ($('#formSub').find('#dept_cd').val() != '') {
					fnGridData(url, form, grid);
				}
			},
			height : '500',
			autowidth : true,
			loadonce : true,
			mtype : "POST",
			gridview : true,
			shrinkToFit : false,
			rowNum : -1,
			rownumbers : true,
			colModel : [ {
				label : '성명',
				name : 'user_nm'
			}, {
				label : '아이디',
				name : 'user_id',
				key : true
			}, {
				label : '비밀번호',
				name : 'user_pw'
			}, {
				label : '전화번호',
				name : 'office_tel_num'
			}, {
				label : '휴대폰',
				name : 'mobile_phone'
			}, {
				label : '이메일',
				name : 'email_addr'
			}, {
				label : '사용',
				name : 'use_flag',
				edittype : "select",
				editoptions : {
					value : "Y:사용;N:사용안함"
				},
				formatter : 'select'
			} ],
			gridComplete : function() {
			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
			},
			onSelectRow : function(rowId, status, e) {
			},
			ondblClickRow : function(rowId, iRow, iCol, e) {
				fn_add_user(1);
			}

		});
	}
	
	// 사업소 그리드 새로고침
	function btn_Select_onclick() {
		$('#grid').trigger('reloadGrid');
	}
	
	// 사업소별 담당자 그리드 새로고침
	function btn_Select_Sub_onclick() {
		$('#gridSub').trigger('reloadGrid');
	}
	
	// 사업소 추가(0) & 수정(1)
	function fn_add_dept_others(type) {
		$("#dialog1").dialog({
			width : 300,
			height : 200,
			resizable : false,
			title : '사업소',
			modal : true,
			open : function(event, ui) {
				//$("#dialog").dialog().parents(".ui-dialog").find(".ui-dialog-titlebar").remove();
				$(".ui-dialog-titlebar-close").hide();
				if (type == 0) {
					$('#dialogform1').find('#dept_nm').val('');
					$('#dialogform1').find('#dept_cd').val('');
					$('#dialogform1').find('input[id=use_flag]').each(function(index, entry) {
						if ($(this).val() == 'Y') {
							$(this).prop("checked", true);
						} else {
							$(this).prop("checked", false);
						}
					});
				} else {
					var row = $('#grid').getRowData($('#grid').getGridParam('selrow'));
					$('#dialogform1').find('#dept_nm').val(row.dept_nm);
					$('#dialogform1').find('#dept_cd').val(row.dept_cd);

					$('#dialogform1').find('input[id=use_flag]').each(function(index, entry) {
						if ($(this).val() == row.use_flag) {
							$(this).prop("checked", true);
						} else {
							$(this).prop("checked", false);
						}
					});
				}
			},
			buttons : [ {
				text : "저장",
				click : function() {
					if ($('#dialogform1').find('#dept_nm').val() == '') {
						alert("사업소명을 입력해 주세요.");
					} else {
						var data = $('#dialogform1').serialize();
						var json = fnAjaxAction('system/saveDeptOthers.lims', data);
						if (json == null) {
							alert('error');
						} else {
							btn_Select_onclick();
							$('#dialog1').dialog("destroy");
						}
					}
				}
			}, {
				text : "취소",
				click : function() {
					$('#dialog1').dialog("destroy");
				}
			} ]
		});
	}
	
	// 사업소 사용자 추가(1) 및 수정(0)
	function fn_add_user(type) {
		$("#dialog2").dialog({
			width : 500,
			height : 350,
			resizable : false,
			title : '사용자',
			modal : true,
			open : function(event, ui) {
				//$("#dialog").dialog().parents(".ui-dialog").find(".ui-dialog-titlebar").remove();
				$(".ui-dialog-titlebar-close").hide();
				if (type == 0) {
					var row = $('#grid').getRowData($('#grid').getGridParam('selrow'));
					$('#dialogform2').find('#dept_cd').val(row.dept_cd);
					$('#dialogform2').find('#user_nm').val('');
					$('#dialogform2').find('#user_pw').val('');
					$('#dialogform2').find('#user_id').val('');
					$('#dialogform2').find('#user_id').prop("readonly", false);
					$('#dialogform2').find('input[id=use_flag]').each(function(index, entry) {
						if ($(this).val() == 'Y') {
							$(this).prop("checked", true);
						} else {
							$(this).prop("checked", false);
						}
					});
				} else {
					var row = $('#grid').getRowData($('#grid').getGridParam('selrow'));
					$('#dialogform2').find('#dept_cd').val(row.dept_cd);
					row = $('#gridSub').getRowData($('#gridSub').getGridParam('selrow'));
					$('#dialogform2').find('#user_nm').val(row.user_nm);
					$('#dialogform2').find('#user_pw').val(row.user_pw);
					$('#dialogform2').find('#user_id').val(row.user_id);
					$('#dialogform2').find('#user_id').prop("readonly", true);
					$('#dialogform2').find('input[id=use_flag]').each(function(index, entry) {
						if ($(this).val() == 'Y') {
							$(this).prop("checked", true);
						} else {
							$(this).prop("checked", false);
						}
					});
				}
			},
			buttons : [ {
				text : "저장",
				click : function() {
					if ($('#dialogform2').find('#user_id').val() == '') {
						alert("아이디를 입력해 주세요.");
					} else if ($('#dialogform2').find('#user_nm').val() == '') {
						alert("성명을 입력해 주세요");
					} else if ($('#dialogform2').find('#user_pw').val() == '') {
						alert("비밀번호를 입력해 주세요");
					} else {
						var data = $('#dialogform2').serialize();
						var json = fnAjaxAction('system/saveDeptOthersUser.lims', data);
						if (json == null) {
							alert('error');
						} else {
							btn_Select_Sub_onclick();
							$('#dialog2').dialog("destroy");
						}
					}
				}
			}, {
				text : "취소",
				click : function() {
					$('#dialog2').dialog("destroy");
				}
			} ]
		});
	}
</script>
<div class="sub_blue_01 w20p">
	<form id="form" name="form" onsubmit="return false;">
		<table  class="select_table" >
			<tr>
				<td width="20%" class="table_title">
					<span>■</span>
					사업소 목록
				</td>
				<td class="table_button" style="text-align: right; padding-right: 30px;">
					<span class="button white mlargep auth_save" id="btn_New" onclick="fn_add_dept_others(0);">
						<button type="button">사업소 추가</button>
					</span>
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
<div class="sub_blue_01 w10p"></div>
<div class="sub_blue_01 w70p">
	<form id="formSub" name="formSub" onsubmit="return false;">
		<table  class="select_table" >
			<tr>
				<td width="20%" class="table_title">
					<span>■</span>
					사업소 사용자 목록
				</td>
				<td class="table_button" style="text-align: right; padding-right: 30px;">
					<span class="button white mlargep auth_save" id="btn_User_New" onclick="fn_add_user(0);">
						<button type="button">사용자 추가</button>
					</span>
				</td>
			</tr>
		</table>
		<input type="hidden" id="sortName" name="sortName">
		<input type="hidden" id="sortType" name="sortType">
		<input type="hidden" id="dept_cd" name="dept_cd">
		<div id="view_grid_sub1">
			<table id="gridSub"></table>
		</div>
	</form>
</div>

<div id="dialog1" style="display: none;">
	<div class="sub_blue_01 w100p">
		<form id="dialogform1" name="dialogform1">
			<table  class="list_table"  style="border-top:solid 1px #82bbce;">
				<tr>
					<th>사업소명</th>
					<td>
						<input type="hidden" id="dept_cd" name="dept_cd">
						<input type="text" id="dept_nm" name="dept_nm">
					</td>
				</tr>
				<tr>
					<th>사용</th>
					<td>
						<input type="radio" id="use_flag" name="use_flag" value="Y" checked="checked">
						사용
						<input type="radio" id="use_flag" name="use_flag" value="N">
						사용안함
					</td>
				</tr>
			</table>
		</form>
	</div>
</div>

<div id="dialog2" style="display: none;">
	<form id="dialogform2" name="dialogform2">
		<div class="sub_blue_01 w100p">
			<form id="dialogform1" name="dialogform1">
				<table  class="list_table"  style="border-top:solid 1px #82bbce;">
					<tr>
						<th>성명</th>
						<td>
							<input type="hidden" id="dept_cd" name="dept_cd">
							<input type="text" id="user_nm" name="user_nm">
						</td>
						<th>사용</th>
						<td>
							<input type="radio" id="use_flag" name="use_flag" value="Y" checked="checked">
							사용
							<input type="radio" id="use_flag" name="use_flag" value="N">
							사용안함
						</td>
					</tr>
					<tr>
						<th>아이디</th>
						<td>
							<input type="text" id="user_id" name="user_id">
						</td>
						<th>비밀번호</th>
						<td>
							<input type="text" id="user_pw" name="user_pw">
						</td>
					</tr>
					<tr>
						<th>전화번호</th>
						<td>
							<input type="text" id="office_tel_num" name="office_tel_num">
						</td>
						<th>휴대폰</th>
						<td>
							<input type="text" id="mobile_phone" name="mobile_phone">
						</td>
					</tr>
					<tr>
						<th>이메일</th>
						<td colspan="3">
							<input type="text" id="email_addr" name="email_addr">
						</td>
					</tr>
				</table>
			</form>
		</div>
	</form>
</div>

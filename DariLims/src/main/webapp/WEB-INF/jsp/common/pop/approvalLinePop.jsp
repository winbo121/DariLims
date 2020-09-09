
<%
	/***************************************************************************************
	 * 시스템명 	: 통합장비관제시스템
	 * 업무명 		: 결재선 변경 (팝업)
	 * 파일명 		: resultCheckP01.jsp
	 * 작성자 		: 진영민
	 * 작성일 		: 2015.02.26
	 * 설  명		: 
	 *---------------------------------------------------------------------------------------
	 * 변경일		 변경자		변경내역 
	 *---------------------------------------------------------------------------------------
	 * 2015.02.26    진영민		최초 프로그램 작성         
	 * 
	 *---------------------------------------------------------------------------------------
	 ****************************************************************************************/
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html id="popHtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<link rel="stylesheet" media="screen" type="text/css" href="<c:url value='/css/jquery-ui.css'/>" />
<link rel="stylesheet" media="screen" type="text/css" href="<c:url value='/css/jqgrid/ui.jqgrid.css'/>" />
<link rel="stylesheet" media="screen" type="text/css" href="<c:url value='/css/tree/ui.fancytree.css'/>" />
<link rel="stylesheet" media="screen" type="text/css" href="<c:url value='/css/common/common.css'/>" />
<link rel="stylesheet" media="screen" type="text/css" href="<c:url value='/css/common/main.css'/>" />
<link rel="stylesheet" media="screen" type="text/css" href="<c:url value='/css/common/sub.css'/>" />
<script type="text/javascript" src="<c:url value='/script/jquery-1.11.0.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/script/jquery-ui.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/script/jquery.blockUI.js'/>"></script>
<script type="text/javascript" src="<c:url value='/script/jquery.form.js'/>"></script>
<script type="text/javascript" src="<c:url value='/script/jquery.message.js'/>"></script>
<script type="text/javascript" src="<c:url value='/script/jqgrid/grid.locale-kr.js'/>"></script>
<script type="text/javascript" src="<c:url value='/script/jqgrid/jquery.jqGrid.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/script/tree/jquery.fancytree-all.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/script/lims.com.js'/>"></script>
<script type="text/javascript" src="<c:url value='/script/lims.com.grid.js'/>"></script>

<title>LIMS</title>
<script type="text/javascript">
	var popupName = window.name; // 팝업창 이름 가져오기
	var arr = new Array;
	
	$(function() {
		arr = popupName.split("★●★");
		
		ajaxComboForm("dept_cd", "", "${session.dept_cd}", 'ALLNAME', 'cmmnUserForm');
		//if (arr[1] != 'dept') {
		//	$('#cmmnUserForm').find('#dept_cd option').not(":selected").attr("disabled", "disabled");
		//}
		apprLineGrid('selectApprLineList.lims', 'apprLineForm', 'apprLineGrid');
		cmmnUserGrid('selectCmmnUserList.lims', 'cmmnUserForm', 'cmmnUserGrid');
		apprLineUserGrid('selectApprLineUserList.lims', 'apprLineUserForm', 'apprLineUserGrid');

		fn_Enter_Search('cmmnUserForm', 'cmmnUserGrid');
		fn_Enter_Search('apprLineUserForm', 'apprLineUserGrid');
	});

	function cmmnUserGrid(url, form, grid) {
		$('#' + grid).jqGrid({
			datatype : function(json) {
				fnGridData(url, form, grid);
			},
			height : '440',
			autowidth : true,
			loadonce : true,
			mtype : "POST",
			gridview : true,
			rowNum : -1,
			rownumbers : true,
			shrinkToFit : false,
			multiselect : true,
			sortname : 'dept_nm',
			sortorder : 'asc',
			colModel : [ {
				label : '부서명',
				name : 'dept_nm'
			}, {
				label : '사용자명',
				name : 'user_nm',
				width : '100'
			}, {
				label : '사용자아이디',
				name : 'user_id',
				key : true,
			} ],
			gridComplete : function() {
			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
			}
		});
	}
	var lastRowId;
	var defaultAppr = null;
	function apprLineGrid(url, form, grid) {
		$('#' + grid).jqGrid({
			datatype : function(json) {
				fnGridData(url, form, grid);
			},
			height : '175',
			autowidth : true,
			loadonce : true,
			mtype : "POST",
			gridview : true,
			rowNum : -1,
			rownumbers : true,
			shrinkToFit : true,
			multiselect : false,
			colModel : [ {
				label : '결재선명',
				name : 'appr_line_nm',
				editable : true
			}, {
				label : '기본결재선',
				name : 'appr_default',
				editable : false,
				width : '50',
				align : 'center'
			}, {
				label : '비고',
				name : 'appr_line_rmk',
				editable : true
			}, {
				label : '결재마스터일련번호',
				name : 'appr_mst_seq',
				key : true,
				hidden : true
			} ],
			gridComplete : function() {
			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
			},
			beforeSelectRow : function(rowId, e) {
				if (rowId && rowId != lastRowId) {
					if (lastRowId == 0) {
						$('#' + grid).jqGrid('delRowData', lastRowId);
					}
				}
				return true;
			},
			onSelectRow : function(rowId, status, e) {
				if (rowId && rowId != lastRowId) {
					$('#' + grid).jqGrid('restoreRow', lastRowId);
					lastRowId = rowId;
					$('#btn_Move').show();
					var row = $('#' + grid).getRowData(rowId);
					$('#cmmnUserForm').find('#appr_mst_seq').val(row.appr_mst_seq);
					$('#apprLineUserForm').find('#appr_mst_seq').val(row.appr_mst_seq);

					$('#cmmnUserGrid').trigger('reloadGrid');
					$('#apprLineUserGrid').trigger('reloadGrid');
				}
			},
			ondblClickRow : function(rowId, iRow, iCol, e) {
				fnGridEdit(grid, rowId, null);
				var colArr = $('#' + grid).jqGrid('getGridParam', 'colModel');
				$('#' + rowId + '_' + colArr[iCol].name).focus();
			}
		});
	}

	function apprLineUserGrid(url, form, grid) {
		$('#' + grid).jqGrid({
			datatype : function(json) {
				fnGridData(url, form, grid);
			},
			height : '231',
			autowidth : true,
			loadonce : true,
			mtype : "POST",
			gridview : true,
			rowNum : -1,
			rownumbers : true,
			shrinkToFit : true,
			multiselect : true,
			colModel : [ {
				type : 'not',
				label : '부서명',
				name : 'dept_nm'
			}, {
				type : 'not',
				label : '사용자명',
				name : 'user_nm',
				width : '100'
			}, {
				label : '사용자아이디',
				name : 'user_id'
			} ],
			gridComplete : function() {
			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
			},
			ondblClickRow : function(rowId, iRow, iCol, e) {
				fnGridEdit(grid, rowId, null);
				var colArr = $('#' + grid).jqGrid('getGridParam', 'colModel');
				$('#' + rowId + '_' + colArr[iCol].name).focus();

				$('#' + grid).setCell(rowId, 'icon', gridU);
			}
		});
		$('#' + grid).sortableRows();
	}

	//조회버튼 클릭 이벤트 - 공통사용자 조회
	function fn_Search_userCmmn() {
		$('#cmmnUserGrid').trigger('reloadGrid');
	}

	function btn_Add_onclick() {
		var rowId = $('#apprLineGrid').getGridParam('selrow');
		$('#apprLineGrid').jqGrid('restoreRow', rowId);
		$('#apprLineGrid').jqGrid('addRow', {
			rowID : 0,
			position : 'last',
			initdata : {
				appr_mst_seq : 0
			}
		});
		$('#' + rowId + '_appr_line_nm').focus();
		$('#btn_Move').hide();
	}

	function fn_Success(json) {
		if (json == null) {
			alert('error');
		} else {
			$('#apprLineGrid').trigger('reloadGrid');
			$('#btn_Move').show();
			defaultAppr = null;
			alert('저장 완료되었습니다.');
		}
	}
	function btn_Save_onclick() {
		if (!confirm('결재선 저장하시겠습니까?')) {
			return false;
		}
		var rowId = $('#apprLineGrid').getGridParam('selrow');
		var row = $('#apprLineGrid').getRowData(rowId);
		if ($('#' + rowId + '_appr_line_nm').val() == '') {
			alert('결재선명을 입력해주세요.');
			return false;
		}
		var url;
		if (rowId == '0') {
			url = 'insertApprLine.lims';
		} else {
			url = 'updateApprLine.lims';
		}
		$('#apprLineGrid').jqGrid('saveRow', rowId, successfunc, url, null, fn_Success);
	}

	function btn_Delete_onclick() {
		var rowId = $('#apprLineGrid').getGridParam('selrow');
		if (rowId == null) {
			alert('선택된 행이 없습니다.');
			return false;
		} else {
			if (!confirm('선택된 결재선을 삭제하시겠습니까?')) {
				return false;
			}
			
			var row = $('#apprLineGrid').getRowData(rowId);
			if (row.appr_default == "Y") {
				alert('기본결재선은 삭제할 수 없습니다.');
				return false;
			}
			
			var json = fnAjaxAction('deleteApprLine.lims', 'appr_mst_seq=' + rowId);
			if (json == null) {
				alert('error');
			} else {
				alert('삭제가 완료되었습니다.');
				$('#apprLineGrid').trigger('reloadGrid');
			}
		}
	}

	function btn_Default_onclick() {
		var rowId = $('#apprLineGrid').getGridParam('selrow');
		if (rowId == null) {
			alert('선택된 행이 없습니다.');
			return false;
		} else {
			if (!confirm('기본결재선으로 지정하시겠습니까?')) {
				return false;
			}
			
			var row = $('#apprLineGrid').getRowData(rowId);
			if (row.appr_default == "Y") {
				alert('현재 기본결재선으로 지정되어 있습니다.');
				return false;
			}
			
			var json = fnAjaxAction('updateApprDefault.lims', 'appr_mst_seq=' + rowId);
			if (json == null) {
				alert('error');
			} else {
				alert('저장이 완료되었습니다.');
				$('#apprLineGrid').trigger('reloadGrid');
			}
		}
	}
	
	function btn_Move(m) {
		var left = 'cmmnUserGrid';
		var right = 'apprLineUserGrid';
		switch (m) {
		case 1:
			var leftRowArr = $('#' + left).getGridParam('selarrrow');
			if (leftRowArr.length > 0) {
				for ( var w in leftRowArr) {
					var leftRow = $('#' + left).getRowData(leftRowArr[w]);
					var id = fnNextRowId(right);
					$('#' + right).jqGrid('addRowData', id, leftRow, 'last');
					$('#' + left).jqGrid('delRowData', leftRowArr[w]);
				}
			} else {
				$.showAlert('선택된 행이 없습니다.');
			}
			break;
		case 3:
			var rightRowArr = $('#' + right).getGridParam('selarrrow');
			if (rightRowArr.length > 0) {
				for (var i = rightRowArr.length - 1; i >= 0; i--) {
					var rightRow = $('#' + right).getRowData(rightRowArr[i]);
					var id = fnNextRowId(left);
					$('#' + left).jqGrid('addRowData', id, rightRow, 'last');
					$('#' + right).jqGrid('delRowData', rightRowArr[i]);
				}
			} else {
				$.showAlert('선택된 행이 없습니다.');
			}
			break;
		}
	}

	function btn_Save_Sub1_onclick() {
		var rowArr = $('#apprLineUserGrid').jqGrid("getDataIDs");
		if (rowArr.length > 0) {
			var data = fnGetGridAllData('apprLineUserGrid') + '&appr_mst_seq=' + $('#apprLineUserForm').find('#appr_mst_seq').val();
			var json = fnAjaxAction('saveApprovalUser.lims', data);
			if (json == null) {
				alert('error');
			} else {
				alert('저장이 완료되었습니다.');
			}
		} else {
			alert('선택된 행이 없습니다.');
		}
	}

	// 선택 이벤트
	function btn_Choice_onclick() {
		var grid = 'apprLineGrid';
		fnEditRelease(grid);
		var rowId = $('#' + grid).getGridParam('selrow');
		if (rowId != null) {
			var row = $('#' + grid).getRowData(rowId);
			var json = fnAjaxAction('selectApprLineUserList.lims', 'appr_mst_seq=' + row.appr_mst_seq);
			if (json == null) {
				alert('error');
			} else if (json == '') {
				$.showAlert('결재라인에 결재자가 없습니다.');
			} else {
				var user = '';
				$(json).each(function(index, entry) {
					user += entry["user_nm"] + '▶';
				});
				user = '[' + user.substring(0, user.length - 1) + ']';
				var data = row.appr_line_nm + user + '■★■' + row.appr_mst_seq
				
				// 부모창에 던져주기
				$(opener.document).find("#reqListForm #appr_line_nm").text(row.appr_line_nm); // 이름
				$(opener.document).find("#reqListForm #appr_mst_seq").text(row.appr_mst_seq); // 코드
				$(opener.document).find("#reqListForm #appr_mst_seq").val(row.appr_mst_seq); // 코드
				$(opener.document).find("#reqListForm #appr_line_nm").val(row.appr_line_nm + user); // 이름
			
				//window.returnValue = data;
				opener.fnpop_callback();
				window.close();
			}
		} else {
			$.showAlert('선택된 행이 없습니다.');
		}
	}
</script>
</head>
<body id="popBody" onunload="opener.fnBasicEndLoading();">
<div class="popUp">
	<div class="pop_area pop_intro">
		<h2>결재선 변경</h2>
		<div>
			<div class="sub_purple_01 w45p" style="margin-bottom:30px">
				<form id="cmmnUserForm" name="cmmnUserForm" onsubmit="return false;">
					<table width="100%" border="0" class="select_table" >
						<tr>
							<td width="100%" class="table_title">
								<span style="font-size: 11px; margin-left: 15px; color: #b27ce0;">■</span>
								전체사용자
							</td>
							<td class="table_button" style="text-align: right; padding-right: 30px;">
								<span class="button white mlargep auth_select" id="btn_Select" onclick="fn_Search_userCmmn();">
									<button type="button">조회</button>
								</span>
	
							</td>
						</tr>
					</table>
					<table width="100%" border="0" class="list_table" >
						<tr>
							<th nowrap="nowrap">부서</th>
							<td>
								<select name="dept_cd" id="dept_cd" class="w120px"></select>
							</td>
							<th nowrap="nowrap">사용자명</th>
							<td>
								<input name="user_nm" type="text" class="inputhan" />
							</td>
						</tr>
					</table>
					<input type="hidden" id="appr_mst_seq" name="appr_mst_seq">
					<input type="hidden" id="sortName" name="sortName">
					<input type="hidden" id="sortType" name="sortType">
					<div>
						<table id="cmmnUserGrid"></table>
					</div>
				</form>
			</div>
	
			<div class="w10p" style="margin-top:370px;">
				<div id="btn_Move" style="display: none;">
					<span>
						<button type="button" id="btn_Right" onclick="btn_Move(1);" class="btnRight"></button>
					</span>
					<br>
					<br>
					<span>
						<button type="button" id="btn_Left" onclick="btn_Move(3);" class="btnLeft"></button>
					</span>
				</div>
			</div>
	
			<div class="sub_purple_01 w45p" style="margin-bottom:30px">
				<form id="apprLineForm" name="apprLineForm" onsubmit="return false;">
					<table width="100%" border="0" class="select_table" >
						<tr>
							<td width="30%" class="table_title">
								<span>■</span>
								결재선목록
							</td>
							<td class="table_button" style="text-align: right; padding-right: 30px;">
								<span class="button white mlargep auth_save" id="btn_Save" onclick="btn_Default_onclick();">
									<button type="button">기본결재선 지정</button>
								</span>
								<span class="button white mlargep auth_save" id="btn_Add" onclick="btn_Add_onclick();">
									<button type="button">추가</button>
								</span>
								<span class="button white mlargep auth_save" id="btn_Save" onclick="btn_Save_onclick();">
									<button type="button">저장</button>
								</span>
								<span class="button white mlargep auth_save" id="btn_Save" onclick="btn_Delete_onclick();">
									<button type="button">삭제</button>
								</span>
								<span class="button white mlargep auth_save" id="btn_Select" onclick="btn_Choice_onclick();">
									<button type="button">선택</button>
								</span>
							</td>
						</tr>
					</table>
					<input type="hidden" id="sortName" name="sortName">
					<input type="hidden" id="sortType" name="sortType">
					<div>
						<table id="apprLineGrid"></table>
					</div>
				</form>
				<form id="apprLineUserForm" name="apprLineUserForm" onsubmit="return false;">
					<table width="100%" border="0" class="select_table" >
						<tr>
							<td width="100%" class="table_title">
								<span style="font-size: 11px; margin-left: 10px; color: #b27ce0;">■</span>
								결재자목록
							</td>
							<td class="table_button" style="text-align: right; padding-right: 30px;">
								<span class="button white mlargep auth_save" id="btn_Save_Sub" onclick="btn_Save_Sub1_onclick();">
									<button type="button">저장</button>
								</span>
	
							</td>
						</tr>
					</table>
					<input type="hidden" id="appr_mst_seq" name="appr_mst_seq">
					<input type="hidden" id="sortName" name="sortName">
					<input type="hidden" id="sortType" name="sortType">
					<div>
						<table id="apprLineUserGrid"></table>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>
</body>
</html>
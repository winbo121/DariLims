
<%
	/***************************************************************************************
	 * 시스템명 	: 통합장비관제시스템
	 * 업무명 		: 항목추가
	 * 파일명 		: instChoicePop.jsp
	 * 작성자 		: 최은향
	 * 작성일 		: 2015.01.22
	 * 설  명		: 
	 *---------------------------------------------------------------------------------------
	 * 변경일		 변경자		변경내역 
	 *---------------------------------------------------------------------------------------
	 * 2015.09.10    최은향		최초 프로그램 작성         
	 * 2015.09.23    윤상준		변경   
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
	//var obj;
	var arr = new Array(); 
	//var arr;
	var dept
	var popupName = window.name; // 팝업창 이름 가져오기
	var test_sample_seq;
	var inst_no;
	var test_std_no;
	var est_no;
	var pageType;
	$(function() {		
		var stringList = new Array(); 
		stringList = popupName.split("◆★◆");

		est_no = stringList[0];
		inst_no = stringList[1];
		test_std_no = stringList[2];
		pageType = stringList[3];

		arr = inst_no.split(",");

 		grid('../instrument/machine.lims', 'allItemForm', 'instAllGrid');
		grid('../instrument/machine.lims', 'instForm', 'instGrid');

	});
	var sel = false;
	
	
	function grid(url, form, grid) {
		var height = '240';
		$('#' + grid).jqGrid({
			datatype : function(json) {
				if (grid == 'instAllGrid') {
					fnGridData(url, form, grid);
				}
			},
			height : height,
			autowidth : true,
			loadonce : true,
			mtype : "POST",
			gridview : true,
			shrinkToFit : false,
			rowNum : -1,
			rownumbers : true,
			multiselect : true,
			colModel : [ {
				label : '시험장비번호',
				name : 'inst_no',
				key : true,
				hidden : true
			}, {
				label : '장비관리번호',
				width : '80',
				align : 'center',
				name : 'inst_mng_no'
			}, {
				label : '장비명',
				width : '150',
				name : 'inst_kor_nm'
			}, {
				label : '장비영문명',
				width : '150',
				name : 'inst_eng_nm'
			}, {
				label : '관리부서',
				width : '100',
				name : 'dept_nm'
			}, {
				label : '관리부서코드',
				name : 'dept_cd',
				hidden : true
			}, {
				label : '관리자',
				align : 'center',
				width : '80',
				name : 'admin_user'
			}, {
				label : '사용수수료',
				width : '100',
				align : 'right',
				name : 'use_price',
				formatter : 'integer',
				formatoptions : {
					thousandsSeparator : ","
				}
			}, {
				label : '설치장소',
				width : '150',
				name : 'instl_plc'
			}, {
				label : '사용여부',
				width : '60',
				name : 'use_flag',
				align : 'center',
				formatter : function(value) {
					if (value == "Y") {
						return '사용함';
					} else {
						return '사용안함';
					}
				}
			} ],
			gridComplete : function() {
			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
			},
			onSelectAll : function(aRowids, status) {
			},
			onSelectRow : function(rowId, status, e) {
				var nowRow = $('#' + grid).getRowData(rowId);
				var inst_no = nowRow.inst_no;
				if (grid != 'instGrid') {
					var b = false;
					if ($.inArray(inst_no, arr) != -1) {
						$.showAlert('이미 존재하는 항목입니다.');
						$('#' + grid).jqGrid('setSelection', rowId, false);
					} else {
						var ids = $('#instGrid').jqGrid("getDataIDs");
						if (ids.length > 0) {
							for ( var r in ids) {
								var row = $('#instGrid').getRowData(ids[r]);
								if (inst_no == row.inst_no) {
									b = true;
								}
							}
						}
						ids = $('#' + grid).getGridParam('selarrrow');
						if (ids.length > 1) {
							for ( var r in ids) {
								if (ids[r] != rowId) {
									var row = $('#' + grid).getRowData(ids[r]);
									if (inst_no == row.inst_no) {
										b = true;
									}
								}
							}
						}
						if (b) {
							$.showAlert('이미 선택된 항목입니다.');
							$('#' + grid).jqGrid('setSelection', rowId, false);
						}
					}
				} else if (grid == 'instGrid') {
					if (!sel) {
						sel = true;
						var ids = $('#' + grid).jqGrid("getDataIDs");
						if (ids.length > 0) {
							for ( var r in ids) {
								var row = $('#' + grid).getRowData(ids[r]);
							}
							sel = false;
						}
					}
				}
			}
		});
		if (grid == 'instGrid') {
			$('#' + grid).sortableRows(null);
		}
		//$('#' + grid).jqGrid('setFrozenColumns');
	}


	// 항목 추가하기
	function btn_Save_Sub2_onclick() {
		var grid = 'instGrid';
		var ids = $('#' + grid).jqGrid("getDataIDs");
		var data;
		var json;
		
		if (ids.length > 0) {
			if(pageType == "EST"){ // 견적항목추가
				data = fnGetGridAllData(grid) + '&test_sample_seq=' + est_no+"&pageType="+pageType;
				json = fnAjaxAction('insertInstGrid.lims', data);
			
				if (json == null) {
					$.showAlert('추가 실패하였습니다.');
				} else {				
					$.showAlert('추가 완료하였습니다.');
					// 콜백함수
					opener.fnpop_callback();
					// 닫기
					window.close();
				}
			}
		} else {
			$.showAlert('선택된 행이 없습니다.');
		}
	}

	function fn_Success(json) {
		if (json == null) {
			$.showAlert('저장실패하였습니다.');
		} else {
			$.showAlert('저장이 완료되었습니다.');
			window.close();
		}
	}

	function btn_Select_onclick() {
		$('#grid').trigger('reloadGrid');
	}

	function btn_Move(m) {
		var left = 'instAllGrid';
		var right = 'instGrid';
		switch (m) {
		case 1:
				var leftRowArr = $('#' + left).getGridParam('selarrrow');
				var rightIds = $('#' + right).jqGrid("getDataIDs");
				if (leftRowArr.length > 0) {
					for ( var w in leftRowArr) {
						var b = 0;
						var leftRow = $('#' + left).getRowData(leftRowArr[w]);
						var inst_no = leftRow.inst_no;
						for ( var i in rightIds) {
							var rightRow = $('#' + right).getRowData(rightIds[i]);
							if (inst_no == rightRow.inst_no) {
								b = 2;
							}
						}
						if (b == 2) {
							$.showAlert('이미 선택된 항목이 존재합니다.');
						} else {
							var bool = true;
							var rightRowArr = $('#' + right).jqGrid("getDataIDs");
							for ( var z in rightRowArr) {
								var rightRow = $('#' + right).getRowData(rightRowArr[z]);
								if (inst_no == rightRow.inst_no) {
									bool = false;
								}
							}
							if (bool) {
								var id = fnNextRowId(right);
								$('#' + right).jqGrid('addRowData', id, leftRow, 'last');
							}
						}
					}
					for (var i = leftRowArr.length - 1; i >= 0; i--) {
						$('#' + left).jqGrid('setSelection', leftRowArr[i], false);
					}
				} else {
					$.showAlert('선택된 행이 없습니다.');
				}
			break;
		case 3:
			var rowArr = $('#' + right).getGridParam('selarrrow');
			if (rowArr.length > 0) {
				for (var i = rowArr.length - 1; i >= 0; i--) {
					$('#' + right).jqGrid('delRowData', rowArr[i]);
				}
			} else {
				$.showAlert('선택된 행이 없습니다.');
			}
			break;
		}
	}

	function btn_Select_Sub2_onclick() {
		$('#instAllGrid').trigger('reloadGrid');
	}

	function btn_Select_Sub3_onclick() {
		$('#groupGrid').trigger('reloadGrid');
	}
</script>
</head>
<body id="popBody" onunload="opener.fnBasicEndLoading();">
	<div class="popUp">
		<div class="pop_area pop_intro">
			<h2>장비추가</h2>
					<div class="sub_purple_01" >
						<form id="allItemForm" name="allItemForm" onsubmit="return false;">
							<table class="select_table">
								<tr>
									<td width="20%" class="table_title">
										<span>■</span>
										장비 목록
									</td>
									<td class="table_button">
										<span class="button white mlargeb auth_select" id="btn_Select" onclick="btn_Select_Sub2_onclick();">
											<button type="button">조회</button>
										</span>
									</td>
								</tr>
							</table>
							<table class="list_table">
								<tr>
									<th>장비관리번호</th>
									<td>
										<input name="inst_mng_no" type="text" class="inputhan" />
									</td>
									<th>사용여부</th>
									<td>
										<label><input type='radio' name='use_flag' value='' style="width: 20px" checked="checked" />전체</label> <label><input type='radio' name='use_flag' value='Y' style="width: 20px" />사용함</label> <label><input type='radio' name='use_flag' value='N' style="width: 20px" />사용안함</label>
									</td>
								</tr>
								<tr>
									<th>장비명/영문명</th>
									<td>
										<input name="inst_kor_nm" type="text" class="inputhan" />
									</td>
									<th>LAS기기여부</th>
									<td>
										<select name="kolas_yn" style="width: 115px">
											<option value="">전체</option>
											<option value="N">일반기기</option>
											<option value="Y">KOLAS기기</option>
										</select>
									</td>
								</tr>
							</table>
							<input type="hidden" id="test_std_no" name="test_std_no">
							<input type="hidden" id="sortName" name="sortName">
							<input type="hidden" id="sortType" name="sortType">
							<div id="view_grid_main">
								<table id="instAllGrid"></table>
							</div>
						</form>
					</div>
			<div class="sub_purple_01" style="text-align: center; clear: both;">
				<button type="button" id="btn_Right" onclick="btn_Move(1);" class="btnDown"></button>
				<button type="button" id="btn_Left" onclick="btn_Move(3);" class="btnUp"></button>
			</div>
			<div class="sub_purple_01" id="itemDiv">
				<form id="instForm" name="instForm" onsubmit="return false;">
					<table class="select_table">
						<tr>
							<td width="20%" class="table_title" nowrap="nowrap">
								<span>■</span>
								선택 장비
							</td>
							<td class="table_button">
								<span class="button white mlargeg auth_save" id="btn_Save_Sub2" onclick="btn_Save_Sub2_onclick();">
									<button type="button">추가</button>
								</span>
								<span class="button white mlargep" id="btn_Cancel" onclick="window.close();">
									<button type="button">닫기</button>
								</span>
							</td>
						</tr>
					</table>
					<input type="hidden" id="sortName" name="sortName">
					<input type="hidden" id="sortType" name="sortType">
					<div id="view_grid_sub">
						<table id="instGrid"></table>
					</div>
				</form>
			</div>
		</div>
	</div>
</body>
</html>
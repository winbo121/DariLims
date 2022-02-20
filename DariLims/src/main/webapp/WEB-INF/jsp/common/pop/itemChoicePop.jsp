
<%
	/***************************************************************************************
	 * 시스템명 	: 통합장비관제시스템
	 * 업무명 		: (접수) 항목추가
	 * 파일명 		: itemChoicePop.jsp
	 * 작성자 		: 최은향
	 * 작성일 		: 2016.01.13
	 * 설  명		: (탭1)기준항목: 기준 & 품목 & 부서 조건을 만족하는 INDV_SPEC에 등록된 항목 리스트
	 				  (탭2)전체 항목: 전체 항목 리스트
	 				  조회하여 선택하는 팝업
	 * 사용 페이지	: 접수등록
	 *---------------------------------------------------------------------------------------
	 * 변경일		 변경자		변경내역 
	 *---------------------------------------------------------------------------------------
	 * 2016.01.13    최은향		최초 프로그램 작성         
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
	var arr = new Array(); 
	var dept;
	var popupName = window.name; // 팝업창 이름 가져오기
	var test_sample_seq;
	var test_item_cd;
	var test_std_no;
	var est_no;
	var pageType;
	var std_no;
	var rev_no;
	var type; // 식약처 & 자사 구분
	var fnGridInit = false;
	var fnGridInitSub = false;
	var dept_cd;
	
	$(function() {
		var stringList = new Array(); 
		stringList = popupName.split("◆★◆");
		
		test_sample_seq = stringList[0];
		est_no = stringList[0];
		std_no = stringList[0];		
		test_item_cd = stringList[1];		
		test_std_no = stringList[2];		
		pageType = stringList[3];
		rev_no = stringList[4];
		type = stringList[5];
		dept_cd = stringList[6];
		

		ajaxComboForm("testitm_lclas_cd", "", "ALL", "", "allItemForm"); // 항목 대분류
		groupCombo("groupItemForm"); // 그룹

		// 시료번호
		if(test_sample_seq != null && test_sample_seq != ""){
			$("#groupItemForm").find("#test_sample_seq").val(test_sample_seq);
			$("#allItemForm").find("#test_sample_seq").val(test_sample_seq);
		}		
		// 접수 부서
		if(dept_cd != null && dept_cd != ""){
			$("#groupItemForm").find("#dept_cd").val(dept_cd);
			$("#allItemForm").find("#dept_cd").val(dept_cd);
		}

		
		arr = test_item_cd.split(",");


		// 전체 항목( 부모 창에서 시료 번호 + 시험기준 값 가져옴)
		grid('../master/selectTestItemAllList.lims', 'allItemForm', 'allItemGrid');
		
		// 그룹별 항목
		groupGrid('../master/selectTestItemInGroupList.lims', 'groupItemForm', 'groupItemGrid');
		
		// 선택된 항목
		grid('selectAcceptItemList.lims', 'itemForm', 'itemGrid');


		$('#itemDivTabs').tabs({
			create : function(event, ui) {
				//$('#itemDivTabs').tabs("enable", 2);
				
				$('#itemDiv').width($('#itemDiv').width() - 20);
				$(window).bind('resize', function() {
					$("#groupItemGrid").setGridWidth($('#view_grid_main').width(), false);
				}).trigger('resize');
				$(window).bind('resize', function() {
					$("#allItemGrid").setGridWidth($('#view_grid_sub').width(), false);
				}).trigger('resize');
				$(window).bind('resize', function() {
					$("#itemGrid").setGridWidth($('#view_grid_sub3').width(), false);
				}).trigger('resize');
			},
			activate : function(event, ui) {
				$(window).bind('resize', function() {
					$("#groupItemGrid").setGridWidth($('#view_grid_main').width(), false);
				}).trigger('resize');
				$(window).bind('resize', function() {
					$("#allItemGrid").setGridWidth($('#view_grid_sub').width(), false);
				}).trigger('resize');
				$(window).bind('resize', function() {
					$("#itemGrid").setGridWidth($('#view_grid_sub3').width(), false);
				}).trigger('resize');
			}
		});
		fn_Enter_Search('groupItemForm', 'groupItemGrid');
		fn_Enter_Search('allItemForm', 'allItemGrid');
	});

	function fnListLclasChange(obj){
		ajaxComboForm("testitm_mlsfc_cd", obj.value, "ALL", "", "allItemForm"); // 항목 중분류
	}

	function groupCombo(form) {
		var url = '../master/selectItemGroupList.lims';
		$.ajax({
			url : url,
			type : 'POST',
			async : false,
			dataType : 'json',
			data : "",
			timeout : 5000,
			error : function() {
				alert('Group 조회실패');
			},
			success : function(json) {
				var select = $("#" + form).find("#test_item_group_no");
				select.empty();
				select.append("<option value=''>선택</option>");
				$(json).each(function(index, entry) {
					select.append("<option value='" + entry["test_item_group_no"] + "'>" + entry["test_item_group_nm"] + "</option>");
				});
				select.trigger('change');// 강제로 이벤트 시키기
			}
		});
	}
	
	// 전체 항목
	var sel = false;
	function grid(url, form, grid) {
		$('#' + grid).jqGrid({
			datatype : function(json) {
				if (grid == 'allItemGrid') {
					fn_GridData(url, form, grid);
				}
			},
			colModel : [ {
				label : '항목대분류',
				name : 'testitm_lclas_nm',
				width : '150'
			}, {
				label : '항목중분류',
				name : 'testitm_mlsfc_nm',
				width : '150'
			}, {
				type : 'not',
				label : '항목명',
				name : 'test_item_nm',
				width : '220'
			}, {
				type : 'not',
				label : '항목영문명',
				name : 'test_item_eng_nm',
				width : '220'
			}, {
				label : 'test_item_cd',
				name : 'test_item_cd',
				key : true,
				hidden : true
			}, {
				label : '항목별시험방법',
				name : 'test_method_no',
				hidden : true
			}, {
				label : '항목별시험기기',
				name : 'inst_no',
				hidden : true
			}, {
				type : 'not',
				label : '부서',
				name : 'dept_nm',
				hidden : true,
				width : '100'
			}, {
				type : 'not',
				label : '시험자',
				name : 'user_nm',
				width : '70',
				hidden : true,
				align : 'center'
			}, {
				label : 'user_id',
				name : 'user_id',
				hidden : true
			}, {
				type : 'not',
				label : 'KOLAS',
				name : 'kolas_flag',
				align : 'center',
				width : '70',
				hidden : true
			}, {
				label : '수수료',
				name : 'fee',
				width : '70',
				align : 'right',
				hidden : true
			}, {
				label : '수수료그룹',
				name : 'fee_group_nm',
				hidden : true
			}, {
				label : 'fee_group_no',
				name : 'fee_group_no',
				hidden : true
			}, {
				type : 'not',
				label : '항목 그룹',
				name : 'test_item_group_nm',
				hidden : false,
				hidden : true
			}],
			height : '240',
			rowNum : -1,
			rownumbers : true,
			autowidth : false,
			gridview : false,
			shrinkToFit : false,
			multiselect : true,
			pager : "#"+grid+"Pager",
			viewrecords : true,
			scroll : true,
			rowList : [50,100,200],
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
			gridComplete : function() {
				gridLstPopComplete();
			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
			},
			onSelectAll : function(aRowids, status) {
			},
			onSelectRow : function(rowId, status, e) {
				var nowRow = $('#' + grid).getRowData(rowId);
				var test_item_cd = nowRow.test_item_cd;
				if (grid != 'itemGrid') {
					var b = false;
					if ($.inArray(test_item_cd, arr) != -1) {
						$.showAlert('이미 존재하는 항목입니다.');
						$('#' + grid).jqGrid('setSelection', rowId, false);
					} else {
						var ids = $('#itemGrid').jqGrid("getDataIDs");
						if (ids.length > 0) {
							for ( var r in ids) {
								var row = $('#itemGrid').getRowData(ids[r]);
								if (test_item_cd == row.test_item_cd) {
									b = true;
								}
							}
						}
						ids = $('#' + grid).getGridParam('selarrrow');
						if (ids.length > 1) {
							for ( var r in ids) {
								if (ids[r] != rowId) {
									var row = $('#' + grid).getRowData(ids[r]);
									if (test_item_cd == row.test_item_cd) {
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
				}
			}
		});
		if (grid == 'itemGrid') {
			$('#' + grid).sortableRows(null);
		}
	}

	function gridLstPopComplete(){	
		$(window).bind('resize', function() {
			$("#allItemGrid").setGridWidth($('#view_grid_sub').width(), false);
		}).trigger('resize');
	}
	
	// 그룹 항목
	function groupGrid(url, form, grid) {
		var group = false;
		$('#' + grid).jqGrid({
			datatype : function(json) {
				if ($('#' + form).find('#test_item_group_no').val() != '') {
					fnGridData(url, form, grid);
				}
			},
			height : '240',
			autowidth : true,
			loadonce : true,
			mtype : "POST",
			gridview : true,
			shrinkToFit : false,
			rowNum : 5000,
			rownumbers : true,
			multiselect : true,
			colModel : [ {
				label : '항목대분류',
				name : 'testitm_lclas_nm',
				width : '150'
			}, {
				label : '항목중분류',
				name : 'testitm_mlsfc_nm',
				width : '150'
			}, {
				type : 'not',
				label : '항목명',
				name : 'test_item_nm',
				width : '220'
			}, {
				type : 'not',
				label : '항목영문명',
				name : 'test_item_eng_nm',
				width : '220'
			}, {
				label : 'test_item_cd',
				name : 'test_item_cd',
				hidden : true
			}, {
				label : '항목별시험방법',
				name : 'test_method_no',
				hidden : true
			}, {
				label : '항목별시험기기',
				name : 'inst_no',
				hidden : true
			}, {
				type : 'not',
				label : '부서',
				name : 'dept_nm',
				hidden : true,
				width : '100'
			}, {
				type : 'not',
				label : '시험자',
				name : 'user_nm',
				width : '70',
				hidden : true,
				align : 'center'
			}, {
				label : 'user_id',
				name : 'user_id',
				hidden : true
			}, {
				type : 'not',
				label : 'KOLAS',
				name : 'kolas_flag',
				align : 'center',
				width : '70',
				hidden : true
			}, {
				label : '수수료',
				name : 'fee',
				width : '70',
				align : 'right',
				hidden : true
			}, {
				label : '수수료그룹',
				name : 'fee_group_nm',
				hidden : true
			}, {
				label : 'fee_group_no',
				name : 'fee_group_no',
				hidden : true
			} ],
			gridComplete : function() {
				groupGridLstPopComplete();
			},
			gridComplete : function() {
			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
			},
			onSelectAll : function(aRowids, status) {
			},
			onSelectRow : function(rowId, status, e) {
				var nowRow = $('#' + grid).getRowData(rowId);
				var test_item_cd = nowRow.test_item_cd;
				if (grid != 'itemGrid') {
					var b = false;
					if ($.inArray(test_item_cd, arr) != -1) {
						$.showAlert('이미 존재하는 항목입니다.');
						$('#' + grid).jqGrid('setSelection', rowId, false);
					} else {
						var ids = $('#itemGrid').jqGrid("getDataIDs");
						if (ids.length > 0) {
							for ( var r in ids) {
								var row = $('#itemGrid').getRowData(ids[r]);
								if (test_item_cd == row.test_item_cd) {
									b = true;
								}
							}
						}
						ids = $('#' + grid).getGridParam('selarrrow');
						if (ids.length > 1) {
							for ( var r in ids) {
								if (ids[r] != rowId) {
									var row = $('#' + grid).getRowData(ids[r]);
									if (test_item_cd == row.test_item_cd) {
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
				}
			}
		});
		if (grid == 'itemGrid') {
			$('#' + grid).sortableRows(null);
		}
	}

	function groupGridLstPopComplete(){	
		$(window).bind('resize', function() {
			$("#groupItemGrid").setGridWidth($('#view_grid_sub').width(), false);
		}).trigger('resize');
	}
	
	// 항목 추가하기 ( 추가 시 시험 일지에도 등록 )
	function btn_Save_Sub2_onclick() {
		var grid = 'itemGrid';
		var ids = $('#' + grid).jqGrid("getDataIDs");		
		var data;
		var json;
		if (ids.length > 0) {
			if(pageType == "EQUIP"){ // 장비대여항목추가
				data = fnGetGridAllData(grid) + '&test_sample_seq=' + test_sample_seq+"&pageType="+pageType;
				json = fnAjaxAction('insertItemGrid.lims', data);		
			} else if(pageType == "TESTSTD"){ // 검사기준관리항목추가
				data = fnGetGridAllData(grid) + '&test_std_no=' + std_no+ '&rev_no=' + rev_no+ "&pageType="+pageType;
				json = fnAjaxAction('insertItemGrid.lims', data); 	
			} else if(pageType == "FEE") { // 기본항목수수료 FEE
				data = fnGetGridAllData(grid) + "&test_std_no=" + std_no + "&pageType="+pageType+"&sel_dept_cd="+dept_cd; /*셀렉트한 부서 cd */
				json = fnAjaxAction('../accept/insertItemGrid.lims', data);	
			} else { 
				data = fnGetGridAllData(grid) + '&test_sample_seq=' + test_sample_seq + "&pageType="+pageType + "&type=" + type;
				json = fnAjaxAction('insertItemGrid.lims', data);
			}
			
				
			if (json == null) {
				$.showAlert('추가 실패하였습니다.');
			} else {
				$.showAlert('추가 완료하였습니다.');
				// 콜백함수
				opener.fnpop_callback();
				// 닫기
				window.close();
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

	function btn_Move(m) {
		var left;
		if ($('#itemDivTabs').tabs('option', 'active') == 1) {
			left = 'groupItemGrid';
		} else{
			left = 'allItemGrid';
		}

		var right = 'itemGrid';
		switch (m) {
		case 1:			
			var leftRowArr = $('#' + left).getGridParam('selarrrow');
			var rightIds = $('#' + right).jqGrid("getDataIDs");
			if (leftRowArr.length > 0) {
				for ( var w in leftRowArr) {
					var b = 0;
					var leftRow = $('#' + left).getRowData(leftRowArr[w]);
					var test_item_cd = leftRow.test_item_cd;
					for ( var i in rightIds) {
						var rightRow = $('#' + right).getRowData(rightIds[i]);
						if (test_item_cd == rightRow.test_item_cd) {
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
							if (test_item_cd == rightRow.test_item_cd) {
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
		$('#groupItemGrid').trigger('reloadGrid');
	}
	function btn_Select_Sub3_onclick() {
		$('#allItemGrid').setGridParam({page: 1});
		$('#allItemGrid').trigger('reloadGrid');
	}
</script>
</head>
<body id="popBody" onunload="opener.fnBasicEndLoading();">
	<div class="popUp">
		<div class="pop_area pop_intro">
			<h2>항목추가</h2>
			<div id="itemDivTabs">
				<ul>
					<li><a href="#tabDiv3">전체 항목</a></li>
					<li><a href="#tabDiv4">그룹 항목</a></li>
				</ul>
				<div id="tabDiv3">
					<div class="sub_purple_01" style="margin-top: 0px;">
						<form id="allItemForm" name="allItemForm" onsubmit="return false;">
							<table width="100%" border="0" class="select_table" >
								<tr>
									<td width="20%" class="table_title">
										<span>■</span>
										전체 항목 목록
									</td>
									<td class="table_button" style="text-align: right; padding-right: 30px;">
										<span class="button white mlargeb auth_select" id="btn_Select" onclick="btn_Select_Sub3_onclick();">
											<button type="button">조회</button>
										</span>
									</td>
								</tr>
							</table>
							<table  class="list_table" >
								<tr>
									<th>항목유형</th>
									<td>
										<select name="testitm_lclas_cd" id="testitm_lclas_cd" class="w200px" onchange="fnListLclasChange(this)"></select>
										<select name="testitm_mlsfc_cd" id="testitm_mlsfc_cd" class="w200px"></select>
									</td>
									<th>항목명</th>
									<td>
										<input name="test_item_nm" type="text" class="inputhan w200px" />
									</td>
								</tr>
								<tr>
									<th>사용여부</th>
									<td>
										<label><input type='radio' name='use_flag' value='' style="width: 20px"/>전체</label> 
										<label><input type='radio' name='use_flag' value='Y' style="width: 20px" checked="checked"/>사용</label>
										<label><input type='radio' name='use_flag' value='N' style="width: 20px" />미사용</label>
									</td>
									<th style='display:none;'>식약처기준 여부</th>
									<td style='display:none;'> 
										<label><input type='radio' name='kfda_yn' value='Y' style="width: 20px"/>예</label>
										<label><input type='radio' name='kfda_yn' value='N' style="width: 20px" checked="checked"/>아니오</label>
									</td>
								</tr>
							</table>
							<input type="hidden" id="sortName" name="sortName">
							<input type="hidden" id="sortType" name="sortType">
							<input type='hidden' id='pageNum' name='pageNum'/>
							<input type='hidden' id='pageSize' name='pageSize'/>
							<input type='hidden' id='sortTarget' name='sortTarget'/>
							<input type='hidden' id='sortValue' name='sortValue'/>
							<div id="view_grid_sub">
								<table id="allItemGrid"></table>
								<div id="gridPrdLstPopPager"></div>
							</div>
						</form>
					</div>
				</div>
				<div id="tabDiv4">
					<div class="sub_purple_01" style="margin-top: 0px;">
						<form id="groupItemForm" name="groupItemForm" onsubmit="return false;">
							<table width="100%" border="0" class="select_table">
								<tr>
									<td width="20%" class="table_title">
										<span>■</span>
										그룹 항목 목록
									</td>
									<td class="table_button" style="text-align: right; padding-right: 30px;">
										<span class="button white mlargeb auth_select" id="btn_Select" onclick="btn_Select_Sub2_onclick();">
											<button type="button">조회</button>
										</span>
									</td>
								</tr>
							</table>
							<table width="100%" border="0" class="list_table">
								<tr>
									<th>그룹</th>
									<td>
										<select name="test_item_group_no" id="test_item_group_no" class="w200px" onChange="btn_Select_Sub2_onclick();"></select>
									</td>
								</tr>
							</table>
							<input type="hidden" id="sortName" name="sortName">
							<input type="hidden" id="sortType" name="sortType">
							<input type='hidden' id='sortTarget' name='sortTarget'/>
							<input type='hidden' id='sortValue' name='sortValue'/>
							<div id="view_grid_main">
								<table id="groupItemGrid"></table>
							</div>
						</form>
					</div>
				</div>
				<div id="tabDiv5"></div>
				<div class="sub_purple_01 w100p" style="text-align: center; clear: both;">
					<button type="button" id="btn_Right" onclick="btn_Move(1);" class="btnDown"></button>
					<button type="button" id="btn_Left" onclick="btn_Move(3);" class="btnUp"></button>
				</div>
				<div class="sub_purple_01 w100p" id="itemDiv">
					<form id="itemForm" name="itemForm" onsubmit="return false;">
						<table width="100%" border="0" class="select_table">
							<tr>
								<td width="20%" class="table_title" nowrap="nowrap">
									<span style="font-size: 11px; margin-left: 15px; color: #b27ce0;">■</span>
									선택 항목
								</td>
								<td class="table_button" style="text-align: right; padding-right: 30px;">
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
						<div id="view_grid_sub3">
							<table id="itemGrid"></table>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</body>
</html>

<%
	/***************************************************************************************
	 * 시스템명 : DARI LIMS
	 * 업무명 	: 등급별 항목추가
	 * 파일명 	: sampleGradeP01.jsp
	 * 작성자 	: 송성수
	 * 작성일 	: 2019.12.04
	 * 설  명	: 품목별 등급별 항목추가 팝업
	 * 사용 페이지	: 등급설정
	 *---------------------------------------------------------------------------------------
	 * 변경일			변경자		변경내역 
	 *---------------------------------------------------------------------------------------
	 * 2019.12.04    송성수		최초 프로그램 작성         
	 * 
	 *---------------------------------------------------------------------------------------
	 ****************************************************************************************/
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<jsp:useBean id="currentDate" class="java.util.Date" />
<fmt:formatDate var="now" value="${currentDate}" pattern="YYYY-MM-dd" />

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

<script type="text/javascript" src="<c:url value='/script/jquery-1.11.0.min.js?time=${now}'/>"></script>
<script type="text/javascript" src="<c:url value='/script/jquery-ui.min.js?time=${now}'/>"></script>
<script type="text/javascript" src="<c:url value='/script/jquery.blockUI.js?time=${now}'/>"></script>
<script type="text/javascript" src="<c:url value='/script/jquery.form.js?time=${now}'/>"></script>
<script type="text/javascript" src="<c:url value='/script/jquery.message.js?time=${now}'/>"></script>
<script type="text/javascript" src="<c:url value='/script/jqgrid/grid.locale-kr.js?time=${now}'/>"></script>
<script type="text/javascript" src="<c:url value='/script/jqgrid/jquery.jqGrid.min.js?time=${now}'/>"></script>
<script type="text/javascript" src="<c:url value='/script/tree/jquery.fancytree-all.min.js?time=${now}'/>"></script>
<script type="text/javascript" src="<c:url value='/script/lims.com.js?time=${now}'/>"></script>
<script type="text/javascript" src="<c:url value='/script/lims.com.grid.js?time=${now}'/>"></script>

<title>LIMS</title>

<script type="text/javascript">
	var popupName = window.name; // 팝업창 이름 가져오기
	var indv_spec_seq;
	var prdlst_cd;
	var test_item_cd;
	var fnGridInit = false;
	var fnGridInitSub = false;
	var fnGridInitSub2 = false;
	
	$(function() {		
		var stringList = new Array(); 
		stringList = popupName.split("◆★◆");
		
		prdlst_cd = stringList[0];
		prdlst_nm = stringList[1];
		
		ajaxComboForm("testitm_lclas_cd", "", "ALL", "", "allItemForm"); // 항목 대분류
		
		// 전체 항목( 부모 창에서 시료 번호 + 시험기준 값 가져옴)
		grid('../master/selectTestItemAllList.lims', 'allItemForm', 'allItemGrid');
		
		// 선택된 항목
		grid('selectAcceptItemList.lims', 'itemForm', 'itemGrid');

		$(window).bind('resize', function() {
			$("#allItemGrid").setGridWidth($('#view_grid_main').width(), false);
		}).trigger('resize');
		$(window).bind('resize', function() {
			$("#itemGrid").setGridWidth($('#view_grid_sub3').width(), false);
		}).trigger('resize');

		fn_Enter_Search('allPrdForm', 'allPrdGrid');
		fn_Enter_Search('allItemForm', 'allItemGrid');

		$("#prdlst_cd").val(prdlst_cd);
		$("#prdlst_nm").val(prdlst_nm);
	
		
		var selGrid = "allItemGrid";
		var ids = $('#' + selGrid).jqGrid("getDataIDs");
		var nids = $('#' + selGrid).jqGrid("getDataIDs");

		btn_Select_Sub2_onclick();
		
	});

	function fnListLclasChange(obj){
		ajaxComboForm("testitm_mlsfc_cd", obj.value, "ALL", "", "allItemForm"); // 항목 중분류
	}

	
	// 항목 그리드
	var sel = false;
	function grid(url, form, grid) {
		$('#' + grid).jqGrid({
			datatype : function(json) {
				if (grid == 'allItemGrid') {
					fnGridInitSub ? fn_GridData(url, form, grid) : fnGridInitSub = true;
				}
			},
			multiselect : true,
 			height : '235',
 			rowNum : 10000,
 			rownumbers : true,
 			autowidth : false,
 			gridview : false,
 			shrinkToFit : false,
 			pager : "#"+grid+"Pager",
 			viewrecords : true,
 			scroll : true,
 			rowList:[50,100,200],
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
			colModel : [{
				label : '여부',
				name : 'kfda_yn',
				hidden : true
			}, {
				label : 'indv_spec_seq',
				name : 'indv_spec_seq',
				hidden : true
			}, {
				label : '품목코드',
				name : 'prdlst_cd'
			}, {
				label : '품목명',
				name : 'prdlst_nm',
				width : '150'
			}, {
				label : '항목대분류',
				name : 'testitm_lclas_nm',
				width : '150'
			}, {
				label : '항목중분류',
				name : 'testitm_mlsfc_nm',
				width : '150'
			}, {
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
			}],
			gridComplete : function() {
				var selGrid = "allItemGrid";
				var ids = $('#' + selGrid).jqGrid("getDataIDs");
				var nids = $('#' + selGrid).jqGrid("getDataIDs");
				for (var j in nids) {
					$('#' + selGrid).jqGrid('setCell', ids[j], 'prdlst_nm', $("#prdlst_nm").val());
					$('#' + selGrid).jqGrid('setCell', ids[j], 'prdlst_cd', $("#prdlst_cd").val());
				}
			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
			},
			onSelectAll : function(aRowids, status) {
			},
			onSelectRow : function(rowId, status, e) {
				var nowRow = $('#' + grid).getRowData(rowId);
				var test_item_cd = nowRow.test_item_cd;
				var prdlst_cd = nowRow.prdlst_cd;
			}
		});
		if (grid == 'itemGrid') {
			$('#' + grid).sortableRows(null);
		}
	}

	// 항목 추가하기
	function btn_Save_Sub2_onclick() {
		var grid = 'itemGrid';
		var ids = $('#' + grid).jqGrid("getDataIDs");		
		var data;
		var json = null;
		if (ids.length > 0) {
			data = fnGetGridAllData(grid);
			json = fnAjaxAction("insertGradeItem.lims", data);	
			
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

	// 저장 성공
	function fn_Success(json) {
		if (json == null) {
			$.showAlert('저장실패하였습니다.');
		} else {
			$.showAlert('저장이 완료되었습니다.');
			window.close();
		}
	}

	// 조회
	function btn_Select_onclick() {
		$('#grid').trigger('reloadGrid');
	}
	
	// > , < 버튼
	function btn_Move(m) {
		var left = 'allItemGrid';
		var right = 'itemGrid';
		switch (m) {
		case 1:
			var leftRowArr = $('#' + left).getGridParam('selarrrow');
			var rightIds = $('#' + right).jqGrid("getDataIDs");
			if (leftRowArr.length > 0) {
				var last_test_item_cd = null;
				for ( var w in leftRowArr) {
					var b = 0;
					var leftRow = $('#' + left).getRowData(leftRowArr[w]);
					var test_item_cd = leftRow.test_item_cd;
					var prdlst_cd = leftRow.prdlst_cd;
					for ( var i in rightIds) {
						var rightRow = $('#' + right).getRowData(rightIds[i]);
						if (test_item_cd == rightRow.test_item_cd && prdlst_cd == rightRow.prdlst_cd) {
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
							if (test_item_cd == rightRow.test_item_cd && prdlst_cd == rightRow.prdlst_cd) {
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
	
	// 품목 조회
	function btn_Select_Sub_onclick() {
		$('#allPrdGrid').trigger('reloadGrid');
	}
	
	// 조회
	function btn_Select_Sub2_onclick() {
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
				<div id="tabDiv1" style="padding-bottom: 0px;">
					<div class="sub_purple_01" style="margin-top: 0px;">
						<form id="allItemForm" name="allItemForm" onsubmit="return false;">
						<input name="prdlst_nm" id="prdlst_nm" type="hidden"/>
						<input name="prdlst_cd" id="prdlst_cd" type="hidden"/>
						<input name="indv_spec_seq" id="indv_spec_seq" type="hidden"/>
							<table width="100%" border="0" class="select_table" >
								<tr>
									<td width="20%" class="table_title">
										<span>■</span>
										항목 목록
									</td>
									<td class="table_button" style="text-align: right; padding-right: 30px;">
										<span class="button white mlargeb auth_select" id="btn_Select" onclick="btn_Select_Sub2_onclick();">
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
 							<input type="hidden" id="pageNum" name="pageNum"/>
 							<input type="hidden" id="pageSize" name="pageSize"/>
 							<input type="hidden" id="sortTarget" name="sortTarget"/> 
 							<input type="hidden" id="sortValue" name="sortValue"/> 
							<div id="view_grid_main">
								<table id="allItemGrid"></table>
 								<div id="gridPrdLstPopPager"></div> 
							</div>
						</form>
					</div>
				</div>
				<div class="sub_purple_01 w100p" style="text-align: center; clear: both;" id="itemDivArrow">
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
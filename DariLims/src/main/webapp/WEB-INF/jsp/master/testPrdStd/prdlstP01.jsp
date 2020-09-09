
<%
	/***************************************************************************************	
	 * 업무명 	: 검사기준복사를 위한 불러오기 팝업(품목조회)	
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
		
		ajaxComboForm("htrk_prdlst_cd", "CP1", "CHOICE", "", "form");
		getGrid('selectPrdLstList.lims', 'form', 'grid');
		
		$(window).bind('resize', function() {
			$("#grid").setGridWidth($('#view_grid_prd').width(), false);
		}).trigger('resize');

		fn_Enter_Search('form', 'grid');

		$("#prdlst_cd").val(prdlst_cd);
		$("#prdlst_nm").val(prdlst_nm);
		
		var selGrid = "allItemGrid";
		var ids = $('#' + selGrid).jqGrid("getDataIDs");

	//	btn_Select_Sub2_onclick();
		
		function search(keyCode){
			if(keyCode == 13){
				btn_Search_onclick();
			}
		};
	});

	function fnListLclasChange(obj){
		ajaxComboForm("testitm_mlsfc_cd", obj.value, "ALL", "", "allItemForm"); // 항목 중분류
	}

	
	// 항목 그리드
	var sel = false;
	function getGrid(url, form, grid) {
		$('#' + grid).jqGrid({
			datatype : function(json) {
				if (grid == 'grid') {
					fnGridInitSub ? fn_GridData(url, form, grid) : fnGridInitSub = true;
				}
			},
			height : '500',
			rowNum : -1,
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
 			colModel : [ {
 				label : '품목코드',
 				name : 'prdlst_cd',
 				key : true,
 				hidden : true
 			}, {
 				label : '품목분류',
 				width : '100',
 				align : 'center',
 				name : 'htrk_prdlst_nm'
 			}, {
 				label : '품목명',
 				width : '300',
 				hidden : true,
 				name : 'prdlst_nm'
 			}, {
 				label : '품목한글명',
 				width : '300',
 				name : 'kor_nm'
 			}, {
 				label : '품목영문명',
 				width : '200',
 				name : 'eng_nm'
 			}, {
 				label : '레벨',
 				width : '60',
 				align : 'center',
 				name : 'lv',
 				hidden : true
 			}, {
 				label : '품목여부',
 				width : '100',
 				name : 'prdlst_yn',
 				hidden : true
 			}, {
 				label : '속성한글명',
 				width : '100',
 				name : 'piam_kor_nm',
 				align : 'center',
 				hidden : true
 			}, {
 				label : '조합품목여부',
 				width : '100',
 				name : 'mxtr_prdlst_yn',
 				hidden : true
 			}, {
 				label : '사용여부',
 				width : '100',
 				name : 'use_yn',
 				hidden : true
 			},  {
 				label : '유효개시일자',
 				width : '100',
 				name : 'vald_begn_dt',
 				align : 'center',
 				hidden : true
 			}, {
 				label : '유효종료일자',
 				width : '100',
 				name : 'vald_end_dt',
 				align : 'center',
 				hidden : true
 			}, {
 				label : '최종수정일',
 				width : '100',
 				name : 'last_updt_dtm',
 				hidden : true
 			}, {
 				label : '정의',
 				width : '100',
 				name : 'dfn',
 				hidden : true
 			}, {
 				label : '비고',
 				width : '200',
 				name : 'rm',
 				hidden : true
 			}, {
 				label : 'kfda_yn',
 				hidden : true,
 				name : 'kfda_yn'
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
				$("#prdlst_cd_origin").val(nowRow.prdlst_cd);
			}
		});
		if (grid == 'itemGrid') {
			$('#' + grid).sortableRows(null);
		}
	}
	
	// 품목 조회
	function btn_Search_onclick() {
		$('#grid').setGridParam({page: 1});
		$('#grid').trigger('reloadGrid');
	}
	
	// 선택
	function btn_Select_onclick() {
		var grid = 'grid';
		var ids = $('#' + grid).jqGrid("getDataIDs");		
		var data;
		var json = null;
		
		if (confirm("저장하시겠습니까?")) {
			var json = fnAjaxAction("saveCopySpec.lims", $('#form').serialize());
			if (json == null) {
				alert('저장 실패되었습니다.');
			} else {
				alert('저장이 완료되었습니다.');
				opener.btn_Search_onclick('');
				window.close();
			}
		}
		
	}


</script>
</head>
<body id="popBody" onunload="opener.fnBasicEndLoading();">
	<div class="popUp">
		<div class="pop_area pop_intro">
			<h2>품목별 검사기준불러오기</h2>
			<div class="sub_purple_01" style="margin-top: 0px;">
				<form id="form" name="form" onsubmit="return false;">
				<input name="prdlst_nm" id="prdlst_nm" type="hidden"/>
				<input name="prdlst_cd" id="prdlst_cd" type="hidden"/>
				<input name="prdlst_cd_origin" id="prdlst_cd_origin" type="hidden"/>
					<table width="100%" border="0" class="select_table" >
					<tr>
						<td width="20%" class="table_title">
							<span>■</span>
							품목 목록
						</td>
						<td class="table_button" style="text-align: right; padding-right: 30px;">
							<span class="button white mlargeb auth_select" id="btn_Search" onclick="btn_Search_onclick();">
								<button type="button">조회</button>
							</span>
							<span class="button white mlargeb auth_select" id="btn_Select" onclick="btn_Select_onclick();">
								<button type="button">선택</button>
							</span>
						</td>
					</tr>
				</table>
				<!-- 조회 테이블 -->
				<table  class="list_table" >
					<tr>
						<th>품목구분</th>
						<td>
							<select name="htrk_prdlst_cd" id="htrk_prdlst_cd" style="width: 45%"></select>
						</td>
					</tr>
					<tr>
						<th>품목명</th>
						<td>
							<input type="text" id="kor_nm" name="kor_nm"/>
						</td>
					</tr>
					<tr style='display:none;'>
						<th>식약처기준 여부</th>
						<td> 
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
				<div id="view_grid_prd">
					<table id="grid"></table>
					<div id="gridPager"></div>
				</div>
				</form>
			</div>
		</div>
	</div>
</body>
</html>
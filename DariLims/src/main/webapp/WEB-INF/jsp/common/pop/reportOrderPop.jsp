
<%
	/***************************************************************************************
	 * 시스템명 	: 통합장비관제시스템
	 * 업무명 		: (접수) 항목추가
	 * 파일명 		: reqIitemChoicePop.jsp
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
	var dept_cd;
	var prdlst_cd; // 품목코드
	var test_req_seq;
	
	$(function() {
		var stringList = new Array(); 
		stringList = popupName.split("◆★◆");
		
		test_sample_seq = stringList[0];
		test_item_cd = stringList[1];		
		type = stringList[2];
		test_req_seq = stringList[3];

		ajaxComboForm("testitm_lclas_cd", "", "ALL", "", "allItemForm"); // 항목 대분류	

		// seq
		if(test_req_seq != null && test_req_seq != ""){
			$("#allItemForm").find("#test_req_seq").val(test_req_seq);
		}
		
		// 항목목록
		grid('../accept/selectReportOrder.lims', 'allItemForm', 'allItemGrid');
		
	 	$(window).bind('resize', function() { 
		    $("#allItemGrid").setGridWidth($('#view_grid_sub').width(), false); 
		}).trigger('resize');
	 	
		fn_Enter_Search('allItemForm', 'allItemGrid');
	});

	function fnListLclasChange(obj){
		ajaxComboForm("testitm_mlsfc_cd", obj.value, "ALL", "", "allItemForm"); // 항목 중분류
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
				width : '120'
			}, {
				label : '항목중분류',
				name : 'testitm_mlsfc_nm',
				width : '120'
			}, {
				label : '항목코드',
				name : 'test_item_cd',
				width : '80'
			}, {
				label : '성적서 표시 순서',
				name : 'report_order',
				formatter : 'integer',
				width : '120',
				align : 'center',
				hidden : true
			}, {
				label : '항목명',
				name : 'test_item_nm',
				width : '150'
			}, {
				type : 'not',
				label : '항목영문명',
				name : 'test_item_eng_nm',
				width : '150'
			}, {
  				label : 'unit_code',
				name : 'unit_code',
				width : '100',
				hidden : true
			}, {
  				label : 'unit',
				name : 'unit',
				width : '100'
			}, {	
  				label : 'test_method_code',
				name : 'test_method_code',
				width : '100',
				hidden : true
			}, {	
				label : '항목별시험방법',
				name : 'test_method_nm',
				width : '100'
			}, {	
				label : 'account_no',
				name : 'account_no',
				width : '100',
				hidden : true
			}, {	
				label : '계산식',
				name : 'formula_no',
				width : '100'
			}, {
				label : 'numrow',
				name : 'numrow',
				width : '120',
				key : true
			}],  
			height : '400',
			rowNum : 5000,
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
			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
			},
			onSelectAll : function(aRowids, status) {
			},
			onSelectRow : function(rowId, status, e) {
			}
		});
		jQuery("#allItemGrid").sortableRows();  
	}

	//조회
	function btn_Select_Sub3_onclick() {
		$('#allItemGrid').setGridParam({page: 1});
		$('#allItemGrid').trigger('reloadGrid');
	}
	
	// 저장
	function btn_Save_Sub2_onclick(grid) {
		var grid = 'allItemGrid';
		var json = null;
		
		var ids = $('#' + grid).jqGrid("getDataIDs");
		
		
			//var row = $('#' + grid).getRowData(ids[i]);
		//var rowDatas = $('#' + grid).getRowData();
		
 		for ( var j = 0; j <ids.length; j++ ) {
			var row = $('#' + grid).getRowData(ids[j]);
			var data = 'test_req_seq=' + test_req_seq +'&test_item_cd=' + row.test_item_cd + "&report_order=" + (j+1)
						  + '&unit_code=' + row.unit_code + '&test_method_code=' + row.test_method_code + '&account_no=' + row.account_no  ;
			json = fnAjaxAction('../accept/updateOrder.lims', data);	 
		}  
 		
		
		if (json == null) {
			$.showAlert('저장 실패하였습니다.');
		} else {
			$.showAlert('추가 완료하였습니다.');
		}

		// 콜백함수
		opener.fnpop_callback();
		// 닫기
		window.close();
 
	}
</script>
</head>
<body id="popBody" onunload="opener.fnBasicEndLoading();">
	<div class="popUp">
		<div class="pop_area pop_intro">
			<h2>성적서 표시 순서 일괄 변경</h2>
				<div id="tabDiv3">
					<div class="sub_purple_01" style="margin-top: 0px;">
						<form id="allItemForm" name="allItemForm" onsubmit="return false;">
							<table width="100%" border="0" class="select_table" >
								<tr>
									<td width="20%" class="table_title">
										<span>■</span>
										항목 목록
									</td>
									<td class="table_button" style="text-align: right; padding-right: 30px;">
										<span class="button white mlargeb auth_select" id="btn_Select" onclick="btn_Select_Sub3_onclick();">
											<button type="button">조회</button>
										</span>
										<span class="button white mlargeg auth_save" id="btn_Save_Sub2" onclick="btn_Save_Sub2_onclick('allItemGrid');">
											<button type="button">저장</button>
										</span>
										<span class="button white mlargep" id="btn_Cancel" onclick="window.close();">
											<button type="button">닫기</button>
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
							</table>
							<input type="hidden" id="sortName" name="sortName">
							<input type="hidden" id="sortType" name="sortType">
							<input type='hidden' id='pageNum' name='pageNum'/>
							<input type='hidden' id='pageSize' name='pageSize'/>
							<input type='hidden' id='sortTarget' name='sortTarget'/>
							<input type='hidden' id='sortValue' name='sortValue'/>
							<input type='hidden' id='test_req_seq' name='test_req_seq'/>
							<div id="view_grid_sub">
								<table id="allItemGrid"></table>
								<div id="gridPrdLstPopPager"></div>
							</div>
						</form>
					</div>
				</div>
		</div>
	</div>
</body>
</html>
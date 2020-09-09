
<%
	/***************************************************************************************
	 * 시스템명 	: 통합장비관제시스템
	 * 업무명 		: 견적서템플릿
	 * 파일명 		: estimateTemplatePop.jsp
	 * 작성자 		: 최은향
	 * 작성일 		: 2016.01.21
	 * 설  명		: 
	 *---------------------------------------------------------------------------------------
	 * 변경일		 변경자		변경내역 
	 *---------------------------------------------------------------------------------------
	 * 2016.01.21    최은향		최초 프로그램 작성         
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
<script type="text/javascript" src="<c:url value='/script/lims.pop.js'/>"></script>
<title>LIMS</title>
<script type="text/javascript">
	var popupName = window.name; // 팝업창 이름 가져오기
	var arrTem = new Array;
	//var fnGridInit = false;
	
	$(function() {
		arrTem = popupName.split("★●★");
		templateGrid('selectEstimateTemplateList.lims', 'templateForm', 'templateGrid');
		itemTemplateGrid('selectEstimateItemTemplateList.lims', 'itemTemplateForm', 'itemTemplateGrid');
		itemFeeTemplateGrid('selectEstimateItemFeeTemplateList.lims', 'itemFeeTemplateForm', 'itemFeeTemplateGrid');
		
		$(window).bind('resize', function() {
			$("#templateGrid").setGridWidth($('#view_grid_main').width(), false);
		}).trigger('resize');
		$(window).bind('resize', function() {
			$("#itemTemplateGrid").setGridWidth($('#view_grid_sub1').width(), false);
		}).trigger('resize');
		$(window).bind('resize', function() {
			$("#itemFeeTemplateGrid").setGridWidth($('#view_grid_sub2').width(), false);
		}).trigger('resize');
		
		
		fn_Enter_Search('templateForm', 'templateGrid');
		fn_Enter_Search('itemTemplateForm', 'itemTemplateGrid');
		fn_Enter_Search('itemFeeTemplateForm', 'itemFeeTemplateGrid');
	});
	
	// 템플릿 리스트
	var lastRowId;
	function templateGrid(url, form, grid) {
		$('#' + grid).jqGrid({
			datatype : function(json) {
				fnGridData(url, form, grid);
			},
			height : '210',
			autowidth : true,
			loadonce : true,
			mtype : "POST",
			gridview : true,
			shrinkToFit : false,
			rowNum : -1,
			rownumbers : true,
			colModel : [ {
				label : '템플릿명',
				name : 'est_title',
				width : '200',
				editable : true
			}, {
				label : 'est_temp_no',
				name : 'est_temp_no',
				key : true,
				hidden : true
			}, {
				label : '견적구분',
				name : 'est_gubun',
				align : 'center',
				hidden : true,
				width : '80'
			}, {
				label : '견적구분',
				name : 'est_gubun_nm',
				align : 'center',
				width : '80'
			}, {
				label : '견적신청인',
				name : 'est_charger_nm',
				align : 'center',
				width : '80'
			}, {
				label : '작성자',
				name : 'creater_id',
				align : 'center',
				width : '80'
			}],
			gridComplete : function() {
				$('#btn_Choice').hide();
				fnSelectFirst(grid);
			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
			},
			onCellSelect : function(rowId, iCol, cellcontent, e) {
			},
			onSelectRow : function(rowId, status, e) {
				if (rowId && rowId != lastRowId) {
					$('#' + grid).jqGrid('restoreRow', lastRowId);
					lastRowId = rowId;
				}
				var row = $('#' + grid).getRowData(rowId);
				$("#itemTemplateForm").find("#est_temp_no").val(row.est_temp_no);
				$("#itemTemplateForm").find("#est_gubun").val(row.est_gubun);
				$("#itemFeeTemplateForm").find("#est_temp_no").val(row.est_temp_no);
				$('#itemTemplateGrid').trigger('reloadGrid');
				$('#itemFeeTemplateGrid').trigger('reloadGrid');
				$('#btn_Choice').show();
				
			},
			ondblClickRow : function(rowId, iRow, iCol, e) {
			}
		});
	}
	
	// 항목별
	function itemTemplateGrid(url, form, grid) {
		$('#' + grid).jqGrid({
			datatype : function(json) {
				fnGridData(url, form, grid);
			},
			height : '120',
			autowidth : true,
			loadonce : true,
			mtype : "POST",
			gridview : true,
			shrinkToFit : false,
			rowNum : -1,
			rownumbers : true,
			footerrow: true,
			colModel : [  {
				label : '견적번호',
				name : 'est_temp_no',
				width : '100',
				hidden : true
			}, {
				label : '견적항목번호',
				name : 'est_temp_item_no',
				hidden : true,
				width : '80',
				key : true
			}, {
				label : '견적품목명',
				name : 'prdlst_nm',
				width : '170'
			}, {
				label : '견적품목코드',
				name : 'prdlst_cd',
				align : 'center',
				hidden : true
			}, {
				label : '견적항목명',
				name : 'test_item_nm',
				width : '200'
			}, {
				label : '견적항목코드',
				name : 'test_item_cd',
				align : 'center',
				hidden : true
			}, {
				label : 'est_temp_item_no',
				name : 'est_temp_item_no',
				key : true,
				hidden : true
			}, {
				label : '수량',
				width : '80',
				editable : false,
				align : 'right',
				formatter: 'number',
				formatoptions: { thousandsSeparator: ",", decimalPlaces: 0, defaultValue: '0' }, 
				name : 'est_qty'
			}, {
				label : '단가(원)',
				width : '80',
				align : 'right',
				editable : false,
				formatter: 'currency', 
				formatoptions: { thousandsSeparator: ',', decimalPlaces: 0, defaultValue: '0'},
				name : 'est_price'
			}, {
				label : '합계(원)',
				width : '100',
				editable : false,
				align : 'right',
				formatter: 'currency', 
				formatoptions: { prefix: '\\', suffix: '', thousandsSeparator: ',', decimalPlaces: 0, defaultValue: '0'},
				name : 'est_price_total'
			}, {
				label : '비고',
				name : 'est_item_desc',
				editable : true,
				width : '200'
			}, {
				label : '규격',
				name : 'est_item_spec',
				editable : true,
				width : '200',
				hidden : true
			} ],
			gridComplete : function() {
				// 하단 합계 부분
				var sum1 = $("#" + grid).jqGrid('getCol', 'est_qty', false, 'sum');
				var sum2 = $("#" + grid).jqGrid('getCol', 'est_price', false, 'sum');
				var sum3 = $("#" + grid).jqGrid('getCol', 'est_price_total', false, 'sum');
				$("#" + grid).jqGrid('footerData', 'set', {test_item_nm: '합&nbsp;&nbsp;계 : ', est_qty:sum1, est_price_total:sum3} );
				
				// 스타일 주기 
				$('table.ui-jqgrid-ftable tr:first').children('td').css('background-color', '#dfeffc');	// 배경색
				$('table.ui-jqgrid-ftable tr:first').children('td').css('font-weight', 'normal'); 		// 폰트 스타일
				$('table.ui-jqgrid-ftable tr:first td:eq(6), table.ui-jqgrid-ftable tr:first td:eq(10)').css('font-weight', 'bold'); // 합계, 총계

				// 합계 정렬
				$('table.ui-jqgrid-ftable tr:first td:eq(6)').css("text-align","right");	// 합계
			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
			},
			onCellSelect : function(rowId, iCol, cellcontent, e) {
			},
			onSelectRow : function(rowId, status, e) {
				if (rowId && rowId != lastRowId) {
					$('#' + grid).jqGrid('restoreRow', lastRowId);
					lastRowId = rowId;
				}
			},
			ondblClickRow : function(rowId, iRow, iCol, e) {
			}
		});
	}
	
	// 수수료
	function itemFeeTemplateGrid(url, form, grid) {
		$('#' + grid).jqGrid({
			datatype : function(json) {
				fnGridData(url, form, grid);
			},
			height : '120',
			autowidth : true,
			loadonce : true,
			mtype : "POST",
			gridview : true,
			shrinkToFit : false,
			rowNum : -1,
			rownumbers : true,
			footerrow: true,
			colModel : [ {
				label : '견적번호',
				name : 'est_temp_no',
				width : '100',
				hidden : false
			}, {
				label : '견적항목번호',
				name : 'est_fee_no',
				hidden : true,
				width : '80',
				key : true
			}, {
				label : '견적항목명',
				name : 'est_fee_nm',
				width : '200',
				editable : true
			}, {
				label : '수량',
				width : '80',
				editable : true,
				align : 'right',
				formatter: 'number',
				formatoptions: { thousandsSeparator: ",", decimalPlaces: 0, defaultValue: '0' }, 
				name : 'est_fee_qty'
			}, {
				label : '단가(원)',
				width : '80',
				align : 'right',
				editable : true,
				formatter: 'currency', 
				formatoptions: { thousandsSeparator: ',', decimalPlaces: 0, defaultValue: '0'},
				name : 'est_fee_price'
			},  {
				label : '합계(원)',
				width : '100',
				editable : false,
				align : 'right',
				formatter: 'currency', 
				formatoptions: { prefix: '\\', suffix: '', thousandsSeparator: ',', decimalPlaces: 0, defaultValue: '0'},
				name : 'est_fee_price_total'
			}, {
				label : '비고',
				name : 'est_fee_desc',
				editable : true,
				width : '200'
			} ],
			gridComplete : function() {
				// 하단 합계 부분
				var sum1 = $("#" + grid).jqGrid('getCol', 'est_fee_qty', false, 'sum');
				var sum3 = $("#" + grid).jqGrid('getCol', 'est_fee_price_total', false, 'sum');
				$("#" + grid).jqGrid('footerData', 'set', {est_fee_nm: '합&nbsp;&nbsp;계 : ', est_fee_qty:sum1, est_fee_price_total:sum3} );
			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
			},
			onCellSelect : function(rowId, iCol, cellcontent, e) {
			},
			onSelectRow : function(rowId, status, e) {
				if (rowId && rowId != lastRowId) {
					$('#' + grid).jqGrid('restoreRow', lastRowId);
					lastRowId = rowId;
				}
			},
			ondblClickRow : function(rowId, iRow, iCol, e) {
			}
		});
	}
	
	// 선택
	function btn_Choice_onclick() {
		var est_org_no = $("#est_org_no").val();
		
		if (est_org_no == null || est_org_no == '') {
			if (confirm('업체를 선택해 주세요.')) { 
				btn_search_onclick();
			}
			return false;
		}
		
		var grid = 'templateGrid';
		var rowId = $('#' + grid).getGridParam('selrow');
		if (rowId == null) {
			$.showAlert('선택된 행이 없습니다.');
		} else {
			$('#' + grid).jqGrid('restoreRow', rowId);
			var row = $('#' + grid).getRowData(rowId);
			//alert(row.est_temp_no);
			
			if (confirm("선택 하시겠습니까?")) {
				var url = 'insertSelectEstimateTemplate.lims';
				var data = '&est_temp_no='+row.est_temp_no+'&est_org_no='+est_org_no;
				var json = fnAjaxAction(url, data);
				if (json == null) {
					$.showAlert('실패되었습니다.');
				} else {
					//$.showAlert('완료되었습니다.');
					opener.tem_callback();
					window.close();
				}
			}	
		}
	}
	
	// 견적업체
	function btn_search_onclick(){
		fnpop_reqOrgChoicePop("templateForm", "750", "550", "견적업체_TEMP");
		fnBasicStartLoading();
	}
	
	// 견적업체 선택 콜백
	function fnpop_callback(){
		fnBasicEndLoading();
	}
	
	// 항목 그리드 조회
	function btn_Tem_Select_onclick() {
		$('#templateGrid').trigger('reloadGrid');
	}
	
	// 콜백함수
// 	function fnpop_callback(returnParam){
// 		//$('#templateGrid').trigger('reloadGrid');
// 		fnBasicEndLoading();
// 	}
	
	function fn_IdTextClear(textId, textId2) {
		if ($("#" + textId) != null || $("#" + textId2) != null) {
			$("#" + textId).val('');
			$("#" + textId2).val('');
		}
	}
</script>
</head>
<body id="popBody" onunload="opener.fnBasicEndLoading();">
	<div class="popUp">
		<div class="pop_area pop_intro">
			<h2>견적서 템플릿</h2>
			<div class="sub_purple_01" style="margin-top: 0px;">
				<form id="templateForm" name="templateForm" onsubmit="return false;">
					<table width="100%" border="0" class="select_table">
						<tr>
							<td width="20%" class="table_title">
								<span>■</span>
								템플릿 목록
							</td>
							<td class="table_button" style="text-align: right; padding-right: 30px;">
								<span class="button white mlargeb auth_select" id="btn_Select" onclick="btn_Tem_Select_onclick();">
									<button type="button">조회</button>
								</span>
								<span class="button white mlargeg auth_save" id="btn_Choice" onclick="btn_Choice_onclick();">
									<button type="button">템플릿 선택</button>
								</span>
								<!-- 
								<span class="button white mlargeb auth_save" id="btn_AddLine" onclick="btn_AddLine_onclick();">
									<button type="button">추가</button>
								</span>
								<span class="button white mlargeg auth_save" id="btn_Save" onclick="btn_Save_onclick();">
									<button type="button">저장</button>
								</span>
								-->
								<span class="button white mlargep" id="btn_Cancel" onclick="window.close();">
									<button type="button">닫기</button>
								</span>
							</td>
						</tr>
					</table>
					<table width="100%" border="0" class="list_table" >
						<tr>
							<th class="indispensable w150px">견적업체명</th>
							<td>
								<input name="est_org_no" id="est_org_no" type="hidden" value="${detail.est_org_no}"/>
								<input name="est_org_nm" id="est_org_nm" type="text" class="w150px inputCheck" readonly="readonly" style="background-color: #D5D5D5;" value="${detail.est_org_nm}"/>
								<img style="vertical-align: text-bottom; cursor: pointer;" src="<c:url value='/images/common/icon_search.png'/>" class="auth_select" id="btn_Req_Org1" onclick='btn_search_onclick();'/>
								<img src="<c:url value='/images/common/icon_stop.png'/>" id="idClear" style="cursor: pointer;vertical-align:text-bottom;" onClick='fn_IdTextClear("est_org_nm", "est_org_no")' />
							</td>
						</tr>
					</table>
					<input type="hidden" id="sortName" name="sortName">
					<input type="hidden" id="sortType" name="sortType">
					<div id="view_grid_main">
						<table id="templateGrid"></table>
					</div>
				</form>
			</div>
			
			<div class="sub_purple_01" style="margin-top: 0px;">
				<form id="itemTemplateForm" name="itemTemplateForm" onsubmit="return false;">
					<table width="100%" border="0" class="select_table">
						<tr>
							<td width="20%" class="table_title">
								<span>■</span>
								견적항목 목록
							</td>
							<td class="table_button" style="text-align: right; padding-right: 30px;">
								<!--
								<span class="button white mlargeb auth_select" id="btn_Select" onclick="btn_Tem_Select_onclick();">
									<button type="button">조회</button>
								</span>
								-->
							</td>
						</tr>
					</table>					
					<input type="hidden" id="sortName" name="sortName">
					<input type="hidden" id="sortType" name="sortType">
					<input type="hidden" id="est_temp_no" name="est_temp_no">
					<input type="hidden" id="est_gubun" name="est_gubun">
					<div id="view_grid_sub1">
						<table id="itemTemplateGrid"></table>
					</div>
				</form>
			</div>
			
			<div class="sub_purple_01" style="margin-top: 0px;">
				<form id="itemFeeTemplateForm" name="itemFeeTemplateForm" onsubmit="return false;">
					<table width="100%" border="0" class="select_table">
						<tr>
							<td width="20%" class="table_title">
								<span>■</span>
								템플릿 목록
							</td>
							<td class="table_button" style="text-align: right; padding-right: 30px;">
								<!--
								<span class="button white mlargeb auth_select" id="btn_Select" onclick="btn_Tem_Select_onclick();">
									<button type="button">조회</button>
								</span>
								-->
							</td>
						</tr>
					</table>
					<input type="hidden" id="sortName" name="sortName">
					<input type="hidden" id="sortType" name="sortType">
					<input type="hidden" id="est_temp_no" name="est_temp_no">
					<div id="view_grid_sub2">
						<table id="itemFeeTemplateGrid"></table>
					</div>
				</form>
			</div>			
		</div>
	</div>
</body>
</html>

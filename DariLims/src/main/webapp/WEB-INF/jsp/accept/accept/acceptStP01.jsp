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
	var test_req_seq;
	var fnGridInit = false;
	var fnGridInitSub = false;
	
	$(function() {		
		var stringList = new Array(); 
		stringList = popupName.split("◆★◆");
		
		test_req_seq = stringList[0];
		
		$('#itemForm').find('#test_req_seq').val(test_req_seq);

		// 스탠다드그리드	
		prdGrid('../master/selectStandardList.lims', 'allPrdForm', 'allPrdGrid');
		itemGrid('../master/selectStandardRItemListPop.lims', 'testPrdStdRevGridForm', 'testPrdStdRevGrid');
		 
		$("#alpreah_input").keydown(function(key) {
             if (key.keyCode == 13) {
            	 btn_Select_Sub_onclick();
             }
         });

		$('#testPrdStdRevGrid').clearGridData(); // 최초 조회시 데이터 안나옴
		
		fn_Enter_Search('allPrdForm', 'allPrdGrid');
	});

	// 품목 그리드
	function prdGrid(url, form, grid) {	
		$('#' + grid).jqGrid({
			datatype : function(json) {
				fnGridData(url, form, grid);
			},
			height : '250',
			autowidth : true,
			loadonce : true,
			mtype : "POST",
			gridview : false,
			shrinkToFit : false,
			rowNum : -1,
			rownumbers : true,
			colModel : [
				{label : '스탠다드코드',name : 'sm_code', width : '300'},
			 	{label : '스탠다드한글명',width : '300',name : 'sm_name'},
			 	{label : '스탠다드영문명',width : '300',name : 'sm_name_e'},
			 	{label : 'prdlst_cd',name : 'prdlst_cd', hidden: true}
			],
			gridComplete : function(data) {
				gridPrdLstPopComplete();
			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';} else {fnSortCol(form, index, sortorder);}
			},			
			onSelectRow : function(rowId, status, e) {
				var row = $('#' + grid).getRowData(rowId);
				$("#testPrdStdRevGridForm").find("#sm_name").val(row.sm_name);
				$("#testPrdStdRevGridForm").find("#sm_code").val(row.sm_code);
				
				btn_Search_onclick(1);
			},
			ondblClickRow : function(rowId, iRow, iCol, e) {	
				btn_Prd_Choice_Onclick(grid);
			}
		});
	}
	
	// 항목 그리드
	var sel = false;
	function itemGrid(url, form, grid) {	
		$('#' + grid).jqGrid({
			datatype : function(json) {
				fnGridData(url, form, grid);
			},
			height : '220',
			autowidth : true,
			loadonce : true,
			mtype : "POST",
			gridview : false,
			shrinkToFit : false,
			rowNum : -1,
			rownumbers : true,
			colModel : [{
				type : 'not',
				label : '<input type="checkbox" id="chk" onclick="fn_chk(\'' + grid + '\' , \'' + form + '\');" />',
				name : 'chk',
				width : '40',
				sortable : false,
				align : 'center',
				formatter : "checkbox",
				formatoptions : {
					disabled : false
				}
			}, {
				label : 'standard_spec_seq',
				name : 'standard_spec_seq',
				hidden : true
				
			}, {
				label : 'sm_code',
				name : 'sm_code',
				hidden : true,
				width : '250'
				
			}, {
				label : '스탠다드명',
				name : 'sm_name',
				width : '200'
			}			
			,  {
				label : '항목코드',
				name : 'testitm_cd',
				width : '100'
			}, {
				label : '대분류',
				name : 'testitm_lclas_nm',
				width : '100'
			}, {
				label : '중분류',
				name : 'testitm_mlsfc_nm',
				width : '100'
			}, {
				label : '항목명',
				name : 'testitm_nm',
				width : '250'
			}, {
				label : '항목영문명',
				name : 'eng_nm',
				width : '200'
			}, {
				label : '정렬순서',
				name : 'item_order',
				width : '100'
			}, {
				label : 'unit_cd',
				name : 'unit_cd',
				hidden : true
			}, {
				label : '단위',
				name : 'unit_nm',
				width : '100'
			}, {
				label : 'test_method_no',
				name : 'test_method_no',
				hidden : true
			}, {
				label : '시험방법',
				name : 'test_method_nm',
				width : '150'
			}, {
				label : 'formula_no',
				name : 'formula_no',
				hidden : true
			}, {
				label : '계산식',
				name : 'formula_nm',
				width : '150'
			}, {
				label : 'oxide_cd',
				name : 'oxide_cd',
				hidden : true
			}, {
				label : '산화물측정방법',
				name : 'oxide_content',
				width : '250',
				hidden : true
			}, {
				label : '세부항목',
				name : 'fnprt_itm_incls_yn',
				width : '70'
			}, {
				label : 'jdgmnt_fom_cd',
				name : 'jdgmnt_fom_cd',
				hidden : true
			}, {
				label : '결과값형태<span class="indispensableGrid"></span>',
				name : 'jdgmnt_fom_nm',
				editable : true,
				width : '80',
				align : 'center'
			}, {
				label : 'base_cd',
				name : 'base_cd',
				hidden : true
			}, {
				label : 'BASE',
				name : 'base_nm',
				editable : true,
				width : '80',
				align : 'center'
			}, {
				label : '기준값<span class="indispensableGrid"></span>',
				name : 'spec_val',
				classes : 'imeon'
			}, {
				label : '표기자리수',
				name : 'vald_manli',
				width : '70',
				align : 'right'
			}, {
				label : '기준하한값',
				name : 'mimm_val',
				width : '70',
				align : 'right'
			}, {
				label : 'mimm_val_dvs_cd',
				name : 'mimm_val_dvs_cd',
				hidden : true
			}, {
				label : '하한값구분',
				name : 'mimm_val_dvs_nm',
				width : '70',
				align : 'center'
			}, {
				label : '기준상한값',
				name : 'mxmm_val',
				width : '70',
				align : 'right'
			}, {
				label : 'mxmm_val_dvs_cd',
				name : 'mxmm_val_dvs_cd',
				hidden : true
			}, {
				label : '상한값구분',
				name : 'mxmm_val_dvs_nm',
				width : '70',
				align : 'center'
			}, {
				label : 'choic_fit',
				name : 'choic_fit', 
				hidden : true
			}, {
				label : '기준적합값',
				name : 'choic_fit_nm', 
				width : '100'
			}, {
				label : 'choic_impropt',
				name : 'choic_impropt',
				hidden : true
			}, {
				label : '기준부적합값',
				name : 'choic_impropt',
				width : '100'
			}, {
				label : '정량하한값',
				name : 'loq_lval',
				width : '100'
			}, {
				label : '정량하한표기',
				name : 'loq_lval_mark',
				width : '100'
			}, {
				label : '정량상한값',
				name : 'loq_hval',
				width : '100'
			}, {
				label : '정량상한표기',
				name : 'loq_hval_mark',
				width : '100'
			}, {
				label : '성적서 표기',
				name : 'report_flag',
				width : '100',
				edittype : "select",
				editoptions : {
					value : 'Y:표시함;N:표시안함'
				},
				formatter : 'select'
			}, {
				label : '수수료',
				name : 'fee',
				width : '80',
				align : 'right',
				formatter : 'integer',
				hidden : true
			}, {
				label : '수수료그룹코드',
				name : 'fee_group_no',
				hidden : true
			}, {
				type : 'not',
				label : '수수료그룹',
				name : 'fee_group_nm',
				width : '120',
				hidden : true
			}, {
				label : 'indv_spec_seq',
				name : 'indv_spec_seq',
				hidden : true
			}, {
				label : 'kfda_yn',
				name : 'kfda_yn',
				hidden : true
			}, {
				label : 'del_st_spec',
				name : 'del_st_spec',
				hidden : true
			}],
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
		if (grid == 'itemGrid') {
			$('#' + grid).sortableRows(null);
		}
	}
	
	// 선택시 이벤트
	function btn_Prd_Choice_Onclick(grid) {
		var grid = 'allPrdGrid';
		var rowId = $('#' + grid).jqGrid('getGridParam', "selrow");
		var data;
		var json = null;
		if(rowId != null){
			var row = $('#' + grid).getRowData(rowId);
			var sm_code = row.sm_code;
			var prdlst_cd = row.prdlst_cd;
			
			var ids = $('#testPrdStdRevGrid').jqGrid("getDataIDs");
			var cnt = 0;
			if (ids.length > 0) {
				for ( var i in ids) {
					var row = $('#testPrdStdRevGrid').getRowData(ids[i]);
					if (row.chk == 'Yes') {
						cnt++;
					}
				}
			}
			
			if(cnt == 0){
				$.showAlert('항목을 선택하여 주세요.');
				return;
			}
			
			data = fnGetGridCheckData('testPrdStdRevGrid') + '&test_req_seq=' + test_req_seq + '&sm_code=' + sm_code + '&prdlst_cd=' + prdlst_cd;
			
			json = fnAjaxAction("insertStdItemGrid.lims", data);
			if (json == null) {
				$.showAlert('추가 실패하였습니다.');
			} else {				
				$.showAlert('추가 완료하였습니다.');
				// 콜백함수
				opener.fnpop_callback2(data);
				// 닫기
				window.close();
			}
		}else{
			$.showAlert('선택된 행이 없습니다.');
			return;
		}
	}
	
	// 조회버튼 클릭 이벤트
	function btn_Search_onclick(type) {
		fnEditRelease('testPrdStdRevGrid');
		$('#testPrdStdRevGrid').trigger('reloadGrid');

		$("#fnprtItemGridForm").find("#sm_name").val("");
		$("#fnprtItemGridForm").find("#sm_code").val("");
		$("#fnprtItemGridForm").find("#standard_spec_seq").val("");
		btn_Search2_onclick(1);
	}

	function btn_Search2_onclick(type) {
		fnEditRelease('fnprtItemGrid');
		$('#fnprtItemGrid').trigger('reloadGrid');
	}
	
	function gridPrdLstPopComplete(){	
		$(window).bind('resize', function() {
			$("#allPrdGrid").setGridWidth($('#view_grid_prd').width(), false);
		}).trigger('resize');
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
		$('#allPrdGrid').trigger('reloadGrid');
		$('#itemGrid').clearGridData();
	}
	
	// 항목 조회
	function btn_Select_Sub_onclick() {
		$('#testPrdStdRevGrid').trigger('reloadGrid');
	}
	
</script>
</head>
<body id="popBody" onunload="opener.fnBasicEndLoading();">
	<div class="popUp">
		<div class="pop_area pop_intro">
			<h2>스탠다드 품목추가</h2>
			<div id="">
				<div id="tabDiv0">
					<div class="sub_purple_01" style="margin-top: 0px;">
						<form id="allPrdForm" name="allPrdForm" onsubmit="return false;">
							<table class="select_table" >
								<tr>
									<td width="20%" class="table_title">
										<span>■</span>
										스탠다드 목록
									</td>
									<td class="table_button" style="text-align: right; padding-right: 30px;">
										<span class="button white mlargeb auth_select" id="btn_Select" onclick="btn_Select_onclick();">
											<button type="button">조회</button>
										</span>
									</td>
								</tr>
							</table>
							<!-- 조회 테이블 -->
							<table  class="list_table" >
								<tr>
									<th>스탠다드명</th>
									<td>
										<input type="text" name="sm_name" />
									</td>
								</tr>
							</table>
							<input type="hidden" id="use_flag" name="use_flag" value='Y'>
							<input type="hidden" id="sortName" name="sortName">
							<input type="hidden" id="sortType" name="sortType">
							<div id="view_grid_prd">
								<table id="allPrdGrid"></table>
							</div>
						</form>
					</div>
				</div>
				<div style="margin-top:50px">
				</div>
				<div class="sub_blue_01" style="margin-top:0px;">
					<div class="sub_blue_01">
						<form id="testPrdStdRevGridForm" name="testPrdStdRevGridForm" onsubmit="return false;">
						<table class="select_table" >
							<tr>
								<td width="20%" class="table_title">
									<span>■</span>
									스탠다드 항목 목록
								</td>
								<td class="table_button" style="text-align: right; padding-right: 30px;">
									<span class="button white mlargeg auth_select" id="btn_Prd_Select" onclick="btn_Prd_Choice_Onclick('allPrdGrid');">
										<button type="button">선택</button>
									</span>
									<span class="button white mlargeb auth_select" id="btn_Select_sub" onclick="btn_Select_Sub_onclick();">
										<button type="button">조회</button>
									</span>
								</td>
							</tr>
						</table>
						<table  class="list_table" >
							<tr>
								<th>항목명</th>
								<td>
									<input type="text" id="alpreah_input" name="testitm_nm" />
								</td>
							</tr>
						</table>
						<div id="view_grid_rev">
							<table id="testPrdStdRevGrid"></table>
						</div>
						<input type="hidden" id="standard_spec_seq" name="standard_spec_seq">
						<input type="hidden" id="sortName" name="sortName">
						<input type="hidden" id="sortType" name="sortType">
						<input type="hidden" id="sm_code" name="sm_code">
						<input type="hidden" id="sm_name" name="sm_name">
						</form>
					</div>	
				</div>
			</div>
		</div>
	</div>
</body>
</html>
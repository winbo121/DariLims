
<%
	/***************************************************************************************
	 * 시스템명 : 통합장비관제시스템
	 * 업무명 	: 등급별 품목-항목추가
	 * 파일명 	: selfGradeChoicePop.jsp
	 * 작성자 	: 송성수
	 * 작성일 	: 2019.11.27
	 * 설  명	: 등급별 설정에  등록된 품목 & 항목 리스트
	 * 사용 페이지	: 접수등록
	 *---------------------------------------------------------------------------------------
	 * 변경일			변경자		변경내역 
	 *---------------------------------------------------------------------------------------
	 * 2019.11.27    최은향		최초 프로그램 작성         
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
	var test_req_seq;
	var fnGridInit = false;
	var fnGridInitSub = false;
	
	$(function() {		
		var stringList = new Array(); 
		stringList = popupName.split("◆★◆");
		
		test_req_seq = stringList[0];
		
		$('#itemForm').find('#test_req_seq').val(test_req_seq);

		// 품목그리드	
		prdGrid('../master/selectPrdLstList.lims', 'allPrdForm', 'allPrdGrid');
		itemGrid('../master/selectSampleGradeListPop.lims', 'testPrdStdRevGridForm', 'testPrdStdRevGrid');
		
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
				{label : '품목코드', name : 'prdlst_cd', hidden: true},
			 	{label : '품목분류', name : 'htrk_prdlst_nm', width : '200'},
			 	{label : '품목한글명', name : 'kor_nm', width : '200'},
			 	{label : '품목영문명', name : 'eng_nm', width : '200'},
			 	{label : '최대등급', name : 'max_grade', width : '100', align : 'center'}
			],
			gridComplete : function(data) {
				gridPrdLstPopComplete();
			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';} else {fnSortCol(form, index, sortorder);}
			},			
			onSelectRow : function(rowId, status, e) {
				var row = $('#' + grid).getRowData(rowId);
				$("#testPrdStdRevGridForm").find("#prdlst_cd").val(row.prdlst_cd);
				
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
				label : 'prdlst_cd',
				name : 'prdlst_cd',
				hidden : true,
				width : '250'
			}, {
				label : '품목명',
				name : 'kor_nm',
				hidden : true
				
			}, {
				label : 'grade_seq',
				name : 'grade_seq',
				hidden : true
			}, {
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
				width : '150'
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
				classes : 'test_method_no',
				hidden : true
			}, {
				label : '시험방법',
				name : 'test_method_nm',
				classes : 'test_method_nm'
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
				width : '250'
			}, {
				label : '표기자리수',
				name : 'vald_manli',
				width : '70',
				align : 'right'
			}, {
				label : '등급1 값',
				name : 'grade1',
				width : '80'
			}, {
				label : 'grade1_range',
				name : 'grade1_range',
				hidden : true
			}, {
				label : '등급1 범위',
				name : 'grade1_nm',
				width : '80'
			}, {
				label : '등급2 값',
				name : 'grade2',
				width : '80'
			}, {
				label : 'grade2_range',
				name : 'grade2_range',
				hidden : true
			}, {
				label : '등급2 범위',
				name : 'grade2_nm',
				width : '80'
			}, {
				label : '등급3 값',
				name : 'grade3',
				width : '80'
			}, {
				label : 'grade3_range',
				name : 'grade3_range',
				hidden : true
			}, {
				label : '등급3 범위',
				name : 'grade3_nm',
				width : '80'
			}, {
				label : '등급4 값',
				name : 'grade4',
				width : '80'
			}, {
				label : 'grade4_range',
				name : 'grade4_range',
				hidden : true
			}, {
				label : '등급4 범위',
				name : 'grade4_nm',
				width : '80'
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
				label : 'grade_at',
				name : 'grade_at',
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
				var nowRow = $('#' + grid).getRowData(rowId);
				var test_item_cd = nowRow.test_item_cd;
				var prdlst_cd = nowRow.prdlst_cd;
				var indv_spec_seq = nowRow.indv_spec_seq;
				
				if (grid != 'itemGrid') {   
					var b = false;
					var ids = $('#' + grid).getGridParam('selarrrow');
					if (ids.length > 1) {
						for ( var r in ids) {
							if (ids[r] != rowId) {
								var row = $('#' + grid).getRowData(ids[r]);
								if (test_item_cd == row.test_item_cd && prdlst_cd == row.prdlst_cd && indv_spec_seq == row.indv_spec_seq) {
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
			var max_grade = row.max_grade;
			
			data = fnGetGridAllData('testPrdStdRevGrid') + '&test_req_seq=' + test_req_seq + '&prdlst_cd=' + prdlst_cd + '&max_grade=' + max_grade;
			
			json = fnAjaxAction("insertGrdItemGrid.lims", data);
			if (json == null) {
				$.showAlert('추가 실패하였습니다.');
			} else {				
				$.showAlert('추가 완료하였습니다.');
				// 콜백함수
				opener.fnpop_callback(data);
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

		$("#fnprtItemGridForm").find("#prdlst_cd").val("");
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
		$('#grid').trigger('reloadGrid');
	}
	
	// 품목 조회
	function btn_Select_Sub_onclick() {
		$('#allPrdGrid').trigger('reloadGrid');
	}
	
</script>
</head>
<body id="popBody" onunload="opener.fnBasicEndLoading();">
	<div class="popUp">
		<div class="pop_area pop_intro">
			<h2>등급 품목추가</h2>
			<div id="">
				<div id="tabDiv0">
					<div class="sub_purple_01" style="margin-top: 0px;">
						<form id="allPrdForm" name="allPrdForm" onsubmit="return false;">
							<table class="select_table" >
								<tr>
									<td width="20%" class="table_title">
										<span>■</span>
										품목 목록
									</td>
									<td class="table_button" style="text-align: right; padding-right: 30px;">
										<span class="button white mlargeg auth_select" id="btn_Prd_Select" onclick="btn_Prd_Choice_Onclick('allPrdGrid');">
											<button type="button">선택</button>
										</span>
										<span class="button white mlargeb auth_select" id="btn_Select" onclick="btn_Select_Sub_onclick();">
											<button type="button">조회</button>
										</span>
									</td>
								</tr>
							</table>
							<!-- 조회 테이블 -->
							<table  class="list_table" >
								<tr>
									<th>품목명</th>
									<td>
										<input type="text" name="kor_nm" />
									</td>
								</tr>
							</table>
							<input type="hidden" id="use_yn" name="use_yn" value='Y'>
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
						<table  class="select_table" >
							<tr>
								<td width="20%" class="table_title">
									<span>■</span>
									기준규격 목록
								</td>
							</tr>
						</table>
						<div id="view_grid_rev">
							<table id="testPrdStdRevGrid"></table>
						</div>
						<input type="hidden" id="sortName" name="sortName">
						<input type="hidden" id="sortType" name="sortType">
						<input type="hidden" id="prdlst_cd" name="prdlst_cd">
						</form>
					</div>	
				</div>
			</div>
		</div>
	</div>
</body>
</html>

<%
	/***************************************************************************************
	 * 시스템명 : 통합장비관제시스템
	 * 업무명 	: 품목별 항목추가
	 * 파일명 	: prdItemChoicePop.jsp
	 * 작성자 	: 최은향
	 * 작성일 	: 2015.12.23
	 * 설  명	: 품목 & 항목을 선택하는 팝업
	 * 사용 페이지	: 품목별 수수료, 견적관리, 검사기준관리
	 *---------------------------------------------------------------------------------------
	 * 변경일			변경자		변경내역 
	 *---------------------------------------------------------------------------------------
	 * 2015.12.23    최은향		최초 프로그램 작성         
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
	var arrPrd = new Array(); 
	var dept;
	var popupName = window.name; // 팝업창 이름 가져오기
	var test_sample_seq;
	var test_item_cd;
	var test_std_no;
	var est_no;
	var pageType;
	var std_no;
	var prdlst_cd;
	var fnGridInit = false;
	var fnGridInitSub = false;
	var fnGridInitSub2 = false;
	
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
		prdlst_cd = stringList[5];
		create_dept_cd = stringList[6];
		
		arr = test_item_cd.split(",");
		arrPrd = prdlst_cd.split(",");
		
		ajaxComboForm("htrk_prdlst_cd", "CP1", "CHOICE", "", "allPrdForm");
		ajaxComboForm("testitm_lclas_cd", "", "ALL", "", "allItemForm"); // 항목 대분류
		
		// 품목그리드	
		prdGrid('../master/selectPrdLstList.lims', 'allPrdForm', 'allPrdGrid');
		
		// 전체 항목
		grid('../master/selectTestItemAllList.lims', 'allItemForm', 'allItemGrid');
		
		// 선택된 항목
		grid('selectAcceptItemList.lims', 'itemForm', 'itemGrid');

		ajaxComboForm("dept_cd", "", "ALL", null, 'allItemForm');
		ajaxComboForm("dept_cd", "", "ALL", null, 'groupForm');
		ajaxComboForm("test_item_type", "C20", "ALL", "", "allItemForm");

		$('#itemDivTabs').tabs({
			create : function(event, ui) {
				if($('#prdlst_cd').val() != '' && $('#prdlst_cd').val() != null ){
					$('#itemDivTabs').tabs("disable", 1);					
				} else {
					$('#itemDivTabs').tabs("enable", 1);					
				}
				$('#itemDivTabs').tabs("disable", 2);
				$('#itemDivArrow').hide();
				$('#itemDiv').hide();					
				$('#itemDiv').width($('#itemDiv').width() - 20);
				
				$(window).bind('resize', function() {
					$("#allPrdGrid").setGridWidth($('#view_grid_prd').width(), false);
				}).trigger('resize');
				$(window).bind('resize', function() {
					$("#allItemGrid").setGridWidth($('#view_grid_main').width(), false);
				}).trigger('resize');
				$(window).bind('resize', function() {
					$("#itemGrid").setGridWidth($('#view_grid_sub3').width(), false);
				}).trigger('resize');
			},
			activate : function(event, ui) {
				// 다시 작업 예정
			 	if ($('#itemDivTabs').tabs('option', 'active') == 1){
					if($('#prdlst_cd').val() == '' || $('#prdlst_cd').val() == null ){
						$('#itemDivTabs').tabs({active : 0});						
						alert("선택된 품목이 없습니다.");
						return false;
					}
				}
				
				$('#itemDivArrow').show();
				$('#itemDiv').show();					
				if($('#itemDivTabs').tabs('option', 'active') == 0){
					$('#itemDivArrow').hide();
					$('#itemDiv').hide();					
				}
				//$('#itemDiv').width($('#itemDiv').width() - 40);
				$(window).bind('resize', function() {
					$("#allPrdGrid").setGridWidth($('#view_grid_prd').width(), false);
				}).trigger('resize');
				$(window).bind('resize', function() {
					$("#allItemGrid").setGridWidth($('#view_grid_main').width(), false);
				}).trigger('resize');
				$(window).bind('resize', function() {
					$("#itemGrid").setGridWidth($('#view_grid_sub3').width(), false);
				}).trigger('resize');
			}
		});
		fn_Enter_Search('allPrdForm', 'allPrdGrid');
		fn_Enter_Search('allItemForm', 'allItemGrid');
	});

	function fnListLclasChange(obj){
		ajaxComboForm("testitm_mlsfc_cd", obj.value, "ALL", "", "allItemForm"); // 항목 중분류
	}
	
	// 품목 그리드
	function prdGrid(url, form, grid) {	
		$('#' + grid).jqGrid({
			datatype : function(json) {
				fn_GridData(url, form, grid);
				//fnGridInit ? fnGridData(url, form, grid) : fnGridInit = true;
			},
			colModel : [ 
						{label : '품목코드',name : 'prdlst_cd',//key : true,hidden : true
						}, {label : '최상위코드',width : '80',align : 'center',name : 'htrk_prdlst_cd',hidden : true
						}, {label : '최상위품목명',width : '100',align : 'center',name : 'htrk_prdlst_nm',hidden : true
						}, {label : '상위코드',width : '50',name : 'hrnk_prdlst_cd',hidden : true
						}, {label : '품목명',width : '300',hidden : true,name : 'prdlst_nm'
						}, {label : '품목한글명',width : '300',name : 'kor_nm'
						}, {label : '품목영문명',width : '200',name : 'eng_nm'
						}, {label : '레벨',width : '60',align : 'center',hidden : true,name : 'lv'
						}, {label : '품목여부',width : '100',name : 'prdlst_yn',align : 'center'
						}, {label : '속성한글명',width : '100',name : 'piam_kor_nm',align : 'center'
						}, {label : '정의',width : '100',name : 'dfn',align : 'center'
						}, {label : '조합품목여부',width : '100',name : 'mxtr_prdlst_yn',align : 'center'	
						}, {label : '사용여부',width : '100',name : 'use_yn',align : 'center'
						}, {label : '유효개시일자',width : '100',name : 'vald_begn_dt',align : 'center'	
						}, {label : '유효종료일자',width : '100',name : 'vald_end_dt',align : 'center'	
						}, {label : '비고',width : '200',name : 'rm',align : 'center'	
						}, {label : '최종수정일',width : '100',name : 'last_updt_dtm',align : 'center'
						} ],
					height : '620',
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
			gridComplete : function(data) {
				gridPrdLstPopComplete();
			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';} else {fnSortCol(form, index, sortorder);}
			},			
			onSelectRow : function(rowId, status, e) {				
			},
			ondblClickRow : function(rowId, iRow, iCol, e) {				
				btn_Prd_Choice_Onclick(grid);
			}
		});
	}
	
	function gridPrdLstPopComplete(){	
		$(window).bind('resize', function() {
			$("#allPrdGrid").setGridWidth($('#view_grid_prd').width(), false);
		}).trigger('resize');
	}

	// 선택시 이벤트
	function btn_Prd_Choice_Onclick(grid) {
		var rowId = $('#' + grid).getGridParam('selrow');
		if (rowId != null) {
			var row = $('#' + grid).getRowData(rowId);
			//alert(row.prdlst_yn);
			if (row.prdlst_yn == "아니요"){
				$.showAlert('품목유형이 아닙니다.');
				return false;
			} else {
				// 002 = 식약처
				if(std_no == '002'){
					$('#allItemForm').find('#kfda_yn').val('Y');
				} else {
					$('#allItemForm').find('#kfda_yn').val('N');
				}					
				// 
				$("#prdlst_nm").val(row.kor_nm); //
				$("#prdlst_cd").val(row.prdlst_cd); //
				
				var selGrid = "allItemGrid";
				var ids = $('#' + selGrid).jqGrid("getDataIDs");
				var nids = $('#' + selGrid).jqGrid("getDataIDs");
				for (var j in nids) {
					$('#' + selGrid).jqGrid('setCell', ids[j], 'prdlst_nm', row.kor_nm);
					$('#' + selGrid).jqGrid('setCell', ids[j], 'prdlst_cd', row.prdlst_cd);
				}			
				// 텝 이동
				$('#itemDivTabs').tabs({active : 1});
				btn_Select_Sub2_onclick();
			}
		} else {
			$.showAlert('선택된 행이 없습니다.');
		}
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
			colModel : [{
				label : '여부',
				name : 'kfda_yn',
				hidden : true
			}, {
				label : '품목코드',
				name : 'prdlst_cd',
				hidden : true
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
					//$('#' + selGrid).jqGrid('setCell', ids[j], 'kfda_yn', $("#kfda_yn").val());
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
				
				if (grid != 'itemGrid') {
					var b = false;
					
					if ($.inArray(prdlst_cd, arrPrd) != -1 && $.inArray(test_item_cd, arr) != -1) {
						$.showAlert('이미 존재하는 항목입니다.');
						$('#' + grid).jqGrid('setSelection', rowId, false);
					} else {
						var ids = $('#' + grid).getGridParam('selarrrow');
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
						
						ids = $('#itemGrid').jqGrid("getDataIDs");
						if (ids.length > 0) {
							for ( var r in ids) {
								var row = $('#itemGrid').getRowData(ids[r]);
								
								if (test_item_cd == row.test_item_cd && prdlst_cd == row.prdlst_cd) {
									b = true;
								}
							}
						}
						if (b) {
							$.showAlert('이미 선택된 항목입니다.');
							$('#' + grid).jqGrid('setSelection', rowId, false);
						}
					}
				} else if (grid == 'itemGrid') {
					if (!sel) {
						sel = true;
						var test_item_group_no = nowRow.test_item_group_no;
						var ids = $('#' + grid).jqGrid("getDataIDs");
						if (ids.length > 0) {
							for ( var r in ids) {
								var row = $('#' + grid).getRowData(ids[r]);
								if (test_item_group_no == row.test_item_group_no) {
									if (test_item_cd != row.test_item_cd) {
										$('#' + grid).jqGrid('setSelection', ids[r], true);
									}
								}
							}
							sel = false;
						}
					}
				}
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
			if ( pageType == "TESTSTDPOP" || pageType == "TESTSTD" ) { // 검사기준관리항목추가
				data = fnGetGridAllData(grid) + "&pageType=" + pageType;
				json = fnAjaxAction("insertTestStdPrdItem.lims", data);					
			} else if(pageType == "EST"){ // 견적항목추가
				data = fnGetGridAllData(grid) + '&test_sample_seq=' + test_sample_seq+"&pageType="+pageType;
				json = fnAjaxAction('../accept/insertItemGrid.lims', data);
			} else if(pageType == "PRDFEE") { // 품목별 항목수수료 PRDFEE
				data = fnGetGridAllData(grid) + "&test_std_no=" + std_no + "&pageType="+pageType;
				json = fnAjaxAction('../accept/insertItemGrid.lims', data);							
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
			if ($('#itemDivTabs').tabs('option', 'active') == 2) {
				left = 'groupGridSub';
				var gRow = $('#groupGrid').getRowData($('#groupGrid').getGridParam('selrow'));
				var rightIds = $('#' + right).jqGrid("getDataIDs");
				var leftIds = $('#' + left).jqGrid("getDataIDs");
				var b = 0;
				for ( var i in rightIds) {
					var rightRow = $('#' + right).getRowData(rightIds[i]);
					if (gRow.test_item_group_no == rightRow.test_item_group_no) {
						b = 1;
					}
					for ( var z in leftIds) {
						var leftRow = $('#' + left).getRowData(leftIds[z]);
						if (leftRow.test_item_cd == rightRow.test_item_cd) {
							b = 2;
						}
					}
				}
				for ( var z in leftIds) {
					var leftRow = $('#' + left).getRowData(leftIds[z]);
					if ($.inArray(leftRow.prdlst_cd, arrPrd) != -1 && $.inArray(leftRow.test_item_cd, arr) != -1) {
						b = 3;
					}
				}
				if (b == 1) {
					$.showAlert('이미 선택된 그룹입니다.');
				} else if (b == 2) {
					$.showAlert('선택된 항목이 그룹에 존재합니다.');
				} else if (b == 3) {
					$.showAlert('존재하는 항목이 그룹에 존재합니다.');
				} else {
					for ( var i in leftIds) {
						var row = $('#' + left).getRowData(leftIds[i]);
						var id = fnNextRowId(right);
						$('#' + right).jqGrid('addRowData', id, row, 'last');
						$('#' + right).setCell(id, 'test_item_group_no', gRow.test_item_group_no);
						$('#' + right).setCell(id, 'test_item_group_nm', gRow.test_item_group_nm);
						//$('#' + right).setCell(id, 'test_sample_seq', $('#itemForm').find('#test_sample_seq').val());
					}
				}
			} else {
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
				<ul>
					<li><a href="#tabDiv0">품목</a></li>
					<li><a href="#tabDiv1">개별 항목</a></li>
				</ul>
				<div id="tabDiv0">
					<div class="sub_purple_01" style="margin-top: 0px;">
						<form id="allPrdForm" name="allPrdForm" onsubmit="return false;">
							<table width="100%" border="0" class="select_table" >
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
									<th>품목구분</th>
									<td>
										<select name="htrk_prdlst_cd" id="htrk_prdlst_cd" style="width: 45%"></select>
									</td>
									<th>품목명</th>
									<td>
										<input type="text" name="kor_nm" />
									</td>
								</tr>
								<tr>
									<th>품목여부</th>
									<td>
										<label><input type='radio' name='prdlst_yn' value='' style="width: 20px"/>전체</label> 
										<label><input type='radio' name='prdlst_yn' value='Y' style="width: 20px" checked="checked"/>예</label>
										<label><input type='radio' name='prdlst_yn' value='N' style="width: 20px" />아니오</label>
									</td>
									<th>사용여부</th>
									<td>
										<label><input type='radio' name='use_yn' value='' style="width: 20px"/>전체</label> 
										<label><input type='radio' name='use_yn' value='Y' style="width: 20px" checked="checked"/>사용</label>
										<label><input type='radio' name='use_yn' value='N' style="width: 20px" />미사용</label>
									</td>
								</tr>
							</table>
							<input type='hidden' id="kfda_yn" name='kfda_yn' value='N'/>
							<input type="hidden" id="sortName" name="sortName">
							<input type="hidden" id="sortType" name="sortType">
							<input type='hidden' id='pageNum' name='pageNum'/>
							<input type='hidden' id='pageSize' name='pageSize'/>
							<input type='hidden' id='sortTarget' name='sortTarget'/>
							<input type='hidden' id='sortValue' name='sortValue'/>
							<div id="view_grid_prd">
								<table id="allPrdGrid"></table>
								<div id="gridPrdLstPopPager"></div>
							</div>
						</form>
					</div>
				</div>
				<div id="tabDiv1" style="padding-bottom: 0px;">
					<div class="sub_purple_01" style="margin-top: 0px;">
						<form id="allItemForm" name="allItemForm" onsubmit="return false;">
						<input name="prdlst_nm" id="prdlst_nm" type="hidden" class="inputhan" />
						<input name="prdlst_cd" id="prdlst_cd" type="hidden" class="inputhan" />
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
							<input type="hidden" id="test_std_no" name="test_std_no" value="001">
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

<%
	/***************************************************************************************
	 * 시스템명 : 통합장비관제시스템
	 * 업무명 	: 식약처 기준별 품목-항목추가
	 * 파일명 	: mfdsStdItemChoicePop.jsp
	 * 작성자 	: 최은향
	 * 작성일 	: 2015.12.29
	 * 설  명	: 식약처 공통 기준(CMMN_SPEC)에 등록된 품목 & 항목 선택 팝업
	 * 사용 페이지	: 접수등록(현재사용안함)
	 *---------------------------------------------------------------------------------------
	 * 변경일			변경자		변경내역 
	 *---------------------------------------------------------------------------------------
	 * 2015.12.29    최은향		최초 프로그램 작성         
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
	var test_req_no;
	var test_sample_seq;
	var test_item_cd;
	var test_std_no;
	var est_no;
	var pageType;
	var std_no;
	var fnGridInit = false;
	var fnGridInitSub = false;
	
	$(function() {		
		var stringList = new Array();
		stringList = popupName.split("◆★◆");
		
		test_sample_seq = stringList[0];
		est_no = stringList[0];
		std_no = stringList[0];		
		test_item_cd = stringList[1];		
		pageType = stringList[3];
		test_req_no = stringList[4];
		test_std_no = stringList[5];
		$('#allItemForm').find('#test_sample_seq').val(test_sample_seq);
		$('#allItemForm').find('#test_req_no').val(test_req_no);
		$('#allItemForm').find('#test_std_no').val(test_std_no);
		
		arr = test_item_cd.split(",");
		//alert(test_item_cd);
		//ajaxComboForm("htrk_prdlst_cd", "", "NON", "", "allPrdForm"); // 품목 대분류
		ajaxComboForm("prdlst_kind1_cd", "CP1", "CHOICE", "", "allPrdForm");
		ajaxComboForm("prdlst_kind2_cd", "CP2", "CHOICE", "", "allPrdForm");
		ajaxComboForm("testitm_lclas_cd", "", "NON", "", "allItemForm"); // 항목 대분류
		
		$('#allItemForm').find('#test_std_no').val(test_std_no);
		/* if ($('#allItemForm').find('#test_std_no').val() == '') {
			$('#allItemForm').find('input[id=std_flag]').each(function(index, entry) {
				if ($(this).val() == 'N') {
					$(this).prop("checked", true);
				} else {
					$(this).prop("checked", false);
				}
			});
		} */
		/* $('#allItemForm').find('#std_flag').click(function() {
			if (test_std_no == '') {
				alert("기준정보가 없습니다.");
				$('#allItemForm').find('input[id=std_flag]').each(function(index, entry) {
					if ($(this).val() == 'N') {
						$(this).prop("checked", true);
					} else {
						$(this).prop("checked", false);
					}
				});
			}
		}); */

		dept = fnGridCombo('dept', 'ALL');
		
		// 품목그리드
		//master/selectPopAllPrdList.lims
		prdGrid('../master/selectPrdLstList.lims', 'allPrdForm', 'allPrdGrid');
		
		// 전체 항목( 부모 창에서 시료 번호 + 시험기준 값 가져옴)		
		grid('selectPopAllMfdsStdItemList.lims', 'allItemForm', 'allItemGrid');
		
		// 선택된 항목
		//grid('selectAcceptItemList.lims', 'itemForm', 'itemGrid');

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
		
		
		// 그리드 조회
		$("#YN input, #YN2 input").click(function() {
			//alert("ttt");
			$('#allItemGrid').trigger('reloadGrid');
		});
		
		fn_Enter_Search('allPrdForm', 'allPrdGrid');
		fn_Enter_Search('allItemForm', 'allItemGrid');
	});
	
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
					fnGridInitSub ? fnGridData(url, form, grid) : fnGridInitSub = true;
				}
			},
			height : '620',
			autowidth : true,
			loadonce : true,
			mtype : "POST",
			gridview : true,
			shrinkToFit : false,
			rowNum : -1,
			rownumbers : true,
			multiselect : false,
			colModel : [{
				label : '여부',
				name : 'kfda_yn',
				hidden : true
			},{
				label : '품목코드',
				name : 'prdlst_cd',
				hidden : true
			}, {
				label : '품목명',
				name : 'prdlst_nm',
				width : '180'
			}, {
				label : '항목대분류',
				name : 'test_item_type',
				width : '180'
			}, {
				label : '항목명',
				name : 'test_item_nm',
				width : '200'
			}, {
				type : 'not',
				label : '항목영문명',
				name : 'test_item_eng_nm',
				width : '200'
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
					$('#' + selGrid).jqGrid('setCell', ids[j], 'kfda_yn', $("#kfda_yn").val());
// 					$('#' + selGrid).jqGrid('setCell', ids[j], 'prdlst_nm', $("#prdlst_nm").val());
// 					$('#' + selGrid).jqGrid('setCell', ids[j], 'prdlst_cd', $("#prdlst_cd").val());
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
				var b = false;
				
				if (prdlst_cd == nowRow.prdlst_cd && $.inArray(test_item_cd, arr) != -1) {
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
			}
		});
		if (grid == 'itemGrid') {
			$('#' + grid).sortableRows(null);
		}
	}

	// 식약처 항목 추가하기
	function btn_Save_Sub2_onclick() {
		var grid = 'allItemGrid';
		var ids = $('#' + grid).jqGrid("getDataIDs");		
		var data;
		var json;
		if (ids.length > 0) {
			/*
			* 분기해야됨
			* pageType == "FEE" 사용하는지 확인
			* 품목등록 방식변경으로 식약처품목 버튼이나 자가품목 버튼에서 등록시 반드시 신규등록임
			* 업데이트(항목추가)가 아니므로  test_sample_seq 넘기면 안됨
			* 아니면 pageType 으로 분기하도록 수정
			*/
			data = fnGetGridAllData(grid) + '&test_sample_seq=' + test_sample_seq + "&pageType=" + pageType + "&test_std_no=" + test_std_no
				+ "&test_req_no=" + test_req_no + "&prdlst_cd=" + $('#prdlst_cd').val()+ "&type=mfds";
			json = fnAjaxAction('insertItemGrid.lims', data);
			
			if (json == null) {
				$.showAlert('추가 실패하였습니다.');
			} else {				
				$.showAlert('추가 완료하였습니다.');
				opener.fnpop_callbackMfds();// 콜백함수
				window.close();// 닫기
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
		
	// 품목 조회
	function btn_Select_Sub_onclick() {
		$('#allPrdGrid').trigger('reloadGrid');
	}
	
	// 조회
	function btn_Select_Sub2_onclick() {
		$('#allItemGrid').trigger('reloadGrid');
	}
</script>
</head>
<body id="popBody" onunload="opener.fnBasicEndLoading();">
	<div class="popUp">
		<div class="pop_area pop_intro">
			<h2>식약처기준 항목추가</h2>
			<div id="itemDivTabs">
				<ul>
					<li><a href="#tabDiv0">품목</a></li>
					<li><a href="#tabDiv1">식약처기준 항목</a></li>
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
							<table class="list_table">
								<tr>
									<th>품목구분</th>
									<td>
										<select name="prdlst_kind1_cd" id="prdlst_kind1_cd" style="width: 45%"></select>
										<select name="prdlst_kind2_cd" id="prdlst_kind2_cd" style="width: 45%"></select>
									</td>
									<th>품목명</th>
									<td>
										<input type="text" name="kor_nm" />
									</td>
									<th>품목여부</th>
									<td>
										<label><input type='radio' name='prdlst_yn' value='' style="width: 20px" checked="checked"/>전체</label> 
										<label><input type='radio' name='prdlst_yn' value='Y' style="width: 20px"/>예</label>
										<label><input type='radio' name='prdlst_yn' value='N' style="width: 20px"/>아니오</label>
									</td>
									<th>사용여부</th>
									<td>
										<label><input type='radio' name='use_yn' value='' style="width: 20px"/>전체</label> 
										<label><input type='radio' name='use_yn' value='Y' style="width: 20px"  checked="checked"/>사용</label>
										<label><input type='radio' name='use_yn' value='N' style="width: 20px"/>미사용</label>
									</td>
								</tr>
							</table>
							<input name="kfda_yn" id="kfda_yn" type="hidden" value="Y"/>
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
							<table width="100%" border="0" class="select_table">
								<tr>
									<td width="20%" class="table_title">
										<span>■</span>
										항목 목록
									</td>
									<td class="table_button" style="text-align: right; padding-right: 30px;">
										<!--
										<span class="button white mlargeb auth_select" id="btn_Select" onclick="btn_Select_Sub2_onclick();">
											<button type="button">조회</button>
										</span>
										-->
										<span class="button white mlargeg auth_save" id="btn_Save_Sub2" onclick="btn_Save_Sub2_onclick();">
											<button type="button">추가</button>
										</span>
										<span class="button white mlargep" id="btn_Cancel" onclick="window.close();">
											<button type="button">닫기</button>
										</span>
									</td>
								</tr>
							</table>
							<table width="100%" border="0" class="list_table">
								<!--
								<tr>
									<th>항목명</th>
									<td>
										<input name="test_item_nm" type="text" class="inputhan" />
									</td>
									<th>항목유형</th>
									<td>
										<select name="test_item_type" id="test_item_type" class="w200px"></select>
									</td>
									<th>기준여부</th>
									<td nowrap="nowrap">
										<input name="std_flag" id="std_flag" type="radio" value="Y" checked="checked" />
										예
										<input name="std_flag" id="std_flag" type="radio" value="N" />
										아니요
									</td>
								</tr>
								<tr>
									<th>시험자</th>
									<td>
										<input name="user_nm" type="text" class="inputhan" />
									</td>
									<th>부서</th>
									<td>
										<select name="dept_cd" id="dept_cd" class="w200px"></select>
									</td>
									<th>KOLAS</th>
									<td nowrap="nowrap">
										<input name="kolas_flag" type="radio" value="" checked="checked" />
										전체
										<input name="kolas_flag" type="radio" value="Y" />
										예
										<input name="kolas_flag" type="radio" value="N" />
										아니요
									</td>
								</tr>
								-->
								<tr id="YN">
									<th style="width: 15%;">위해여부</th>
									<td nowrap="nowrap">
										<input name="prdlst_nm" id="prdlst_nm" type="hidden" class="inputhan" />
										<input name="prdlst_cd" id="prdlst_cd" type="hidden" class="inputhan" />
										<input name="kfda_yn" id="kfda_yn" type="hidden"/>
										
										<input name="injry_yn" id="injry_y" type="radio" value="Y"/>
										예
										<input name="injry_yn" id="injry_n" type="radio" value="N" checked="checked"/>
										아니요
									</td>
									<th style="width: 15%;">세부항목포함여부</th>
									<td nowrap="nowrap">
										<input name="fnprt_itm_incls_yn" id="fnprt_itm_incls_y" type="radio" value="Y"/>
										예
										<input name="fnprt_itm_incls_yn" id="fnprt_itm_incls_n" type="radio" value="N" checked="checked"/>
										아니요
									</td>
									<th style="width: 15%;">자품검사시험항목여부</th>
									<td nowrap="nowrap">
										<input name="ntr_prsec_itm_yn" id="ntr_prsec_itm_y" type="radio" value="Y"/>
										예
										<input name="ntr_prsec_itm_yn" id="ntr_prsec_itm_n" type="radio" value="N" checked="checked"/>
										아니요
									</td>									
								</tr>
								<tr id="YN2">
									<th>감시시험항목여부</th>
									<td nowrap="nowrap">
										<input name="montrng_testitm_yn" id="montrng_testitm_y" type="radio" value="Y"/>
										예
										<input name="montrng_testitm_yn" id="montrng_testitm_n" type="radio" value="N" checked="checked"/>
										아니요
									</td>
									<th>중점검사시험항목여부</th>
									<td nowrap="nowrap">
										<input name="emphs_prsec_testitm_yn" id="emphs_prsec_testitm_y" type="radio" value="Y"/>
										예
										<input name="emphs_prsec_testitm_yn" id="emphs_prsec_testitm_n" type="radio" value="N" checked="checked"/>
										아니요
									</td>
									<th>공전외시험항목여부</th>
									<td nowrap="nowrap">
										<input name="rvlv_else_testitm_yn" id="rvlv_else_testitm_y" type="radio" value="Y"/>
										예
										<input name="rvlv_else_testitm_yn" id="rvlv_else_testitm_n" type="radio" value="N" checked="checked"/>
										아니요
									</td>									
								</tr>
							</table>
							<input type="hidden" id="test_req_no" name="test_req_no">
							<input type="hidden" id="test_sample_seq" name="test_sample_seq">
							<input type="hidden" id="test_std_no" name="test_std_no">
							<input type="hidden" id="sortName" name="sortName">
							<input type="hidden" id="sortType" name="sortType">
							<div id="view_grid_main">
								<table id="allItemGrid"></table>
							</div>
						</form>
					</div>
				</div>			
			</div>
		</div>
	</div>
</body>
</html>
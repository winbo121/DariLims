
<%
	/***************************************************************************************
	 * 시스템명 	: 통합장비관제시스템
	 * 업무명 		: 시약/실험기구 등록
	 * 파일명 		: buyingConfirmationPop.jsp
	 * 작성자 		: 최은향
	 * 작성일 		: 2015.02.24
	 * 설  명		: 구매상품 팝업 화면
	 *---------------------------------------------------------------------------------------
	 * 변경일		 변경자		변경내역 
	 *---------------------------------------------------------------------------------------
	 * 2015.02.24    최은향		최초 프로그램 작성         
	 * 
	 *---------------------------------------------------------------------------------------
	 ****************************************************************************************/
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html id="popHtml" class="minH170">
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
<script type="text/javascript" src="<c:url value='/script/lims.pop.js'/>"></script>
<script type="text/javascript" src="<c:url value='/script/lims.com.grid.js'/>"></script>
<title>LIMS</title>
<script type="text/javascript">
	var obj;
	var arr;
	$(function() {	
		/* obj = window.dialogArguments;
		arr = obj.ids; */
		h_mtlr_info = fnGridCommonCombo('C42', null);
		
		ajaxComboForm("m_mtlr_info", "", "All", "", 'form'); // 중분류 검색창 초기화용
		
		grid(fn_getConTextPath()+'/popReagentsGlassInfoList.lims', 'form', 'grid');
		grid(fn_getConTextPath()+'/selectBuyingRequestList.lims', 'requestForm', 'requestGrid');	
		
		$('#tabDiv2').width($('#tabDiv2').width() - 40);
		$('#tabDiv3').width($('#tabDiv3').width() - 40);
		
		$(window).bind('resize', function() {
			$("#grid").setGridWidth($('#view_grid_main').width(), false);
		}).trigger('resize');
		$(window).bind('resize', function() {
			$("#requestGrid").setGridWidth($('#view_grid_sub2').width(), false);
		}).trigger('resize');
		
		// 엔터키 눌렀을 경우
		fn_Enter_Search('form', 'grid');
		
	 	//라디오버튼 체인지 했을때
	 	$("input[type=radio]").change(function(e){
			btn_Search_onclick();
		});
	 	
		// 팝업 윈도우 close버튼으로 닫을때 이벤트
		$(window).on("beforeunload", function(){
	    });
	});
	
	function grid(url, form, grid) {
		var allselect = false;
		$('#' + grid).jqGrid({
			datatype : function(json) {
				if(grid == 'requestGrid') {					
				} else
					fnGridData(url, form, grid);
			},
			height : '240',
			autowidth : true,
			loadonce : true,
			mtype : "POST",
			gridview : true,	
			shrinkToFit : false,
			rowNum : -1,
			rownumbers : true,
			multiselect : true,
			colModel : [ {
				label : '시약실험기구코드',
				name : 'mtlr_no',
				align : 'center',
				width : '100',
				key : true,
				hidden : true
			}, {
				label : '마스터여부',
				width : '70',
				align : 'center',
				name : 'master_yn'
			}, {
				/* label : '물품구분',
				width : '80',
				align : 'center',
				name : 'mtlr_flag'
			}, { */
				label : '대분류',
				width : '80',
				name : 'h_mtlr_info'
// 				formatter : 'select',
// 				edittype : "select",
// 				formatter : function(value){
// 					if(value == "C42"){
// 						return '시약류';  
// 					} else if(value == "C43") {
// 						return '소모품류';
// 					} else {
// 						return '';
// 					}
// 				}
// 				editoptions : {
// 					value : h_mtlr_info
// 				}
			}, {
				label : '중분류',
				width : '80',
				name : 'm_mtlr_info'
				//formatter : 'select',
				//edittype : "select",
				//editoptions : {
				//	value : m_mtlr
				//}
// 				hidden : true
			}, {
				label : '시약/실험기구명',
				width : '150',
				name : 'item_nm'
			}, {
				label : '제조사',
				width : '150',
				name : 'spec1'
			}, {
				label : 'Cas no.',
				width : '150',
				name : 'spec2'
			}, {
				label : 'Cat # (제품번호)',
				width : '200',
				name : 'spec_etc'
			}, {								
				label : 'Lot # (로트번호)',
				width : '200',
				name : 'use'
			}, {
				label : '용량',
				width : '100',
				align : 'center',
				name : 'mtlr_vol'
			}, {
				label : '단위',
				width : '100',
				align : 'center',
				name : 'unit'
			}, {
				label : '내용',
				width : '200',
				name : 'content'
			},  {				
				label : '비고',
				width : '200',
				name : 'etc'
			}],
			emptyrecords : '데이터가 존재하지 않습니다.',
			gridComplete : function() {
				allselect = false;
				$('#btn_Insert').show();
			},
			onSortCol : function(index, iCol, sortorder) {				
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
			},
			onSelectRow : function(rowId, status, e) {
				if(grid == 'grid') {
					// 선택항목에 선택되어 있는 항목들 체크
					var ids = $('#requestGrid').jqGrid("getDataIDs");
					for ( var i in ids) {
						if (rowId == ids[i]) {
							$.showAlert("선택 항목 목록에 존재하는 항목입니다.");
							$('#' + grid).jqGrid('setSelection', rowId, false);
							return 'stop';
						}
					}
					// 부모창에서 받아온 항목들 체크
					var check = stdTestItems(rowId);
					if(check) {
						$.showAlert("구매요청 목록에 존재하는 항목입니다.");
						$('#' + grid).jqGrid('setSelection', rowId, false);
					}
				}
			},
			onSelectAll : function(selar, status) {
				if(!allselect) {
					var i = 0;
					for(var row in selar) {				
						var pre_ids = window.dialogArguments["idsReq"];
						for (var k in pre_ids) {							
							if(pre_ids[k] == selar[row]) {
								$('#' + grid).jqGrid('setSelection', selar[row], false);
								i++;
							}
						}
						var sel_ids = $('#requestGrid').jqGrid("getDataIDs");
						for (var j in sel_ids) {							
							if(sel_ids[j] == selar[row]) {
								$('#' + grid).jqGrid('setSelection', selar[row], false);
								i++;
							}
						}
					}			
					if(i > 0) {
						$.showAlert("구매요청 목록및 선택항목에 존재하는 항목들이 있습니다.");
					}					
				} else {
					$("#" + grid).jqGrid('resetSelection');
				}
				allselect = !allselect;
			},
			ondblClickRow : function(rowId, iRow, iCol, e) {	
			}
		});
	}
	
	// 대분류 콤보
	function comboReload() {
		//alert($("#h_mtlr_info").val());
		if($("#h_mtlr_info").val() == "C42"){
			ajaxComboForm("m_mtlr_info", "C42", "All", "", 'form'); // 중분류			
		}else if($("#h_mtlr_info").val() == "C43"){
			ajaxComboForm("m_mtlr_info", "C43", "All", "", 'form'); // 중분류
		}
	}
	
	// 부모창에서 받아온 선택된 시험항목들
	function stdTestItems(rowId) {
		var check = false;
		var pre_ids = window.dialogArguments["idsReq"];
		
		for (var i in pre_ids) {
			if(pre_ids[i] == rowId)
				check = true;
		}		
		return check;
	}
	
	// 조회버튼 클릭 이벤트
	function btn_Search_onclick() {
		$('#grid').trigger('reloadGrid');
	}
	
	// 선택클릭이벤트
	function btn_Save_Sub2_onclick() {
		var returnValue = new Array();
		var selar = $("#requestGrid").jqGrid('getDataIDs');
		if(selar.length > 0) {
			var i = 0;
			for(var row in selar) {
				var r = $('#requestGrid').jqGrid('getRowData', selar[row]);
				returnValue[i] = r;
				i++;
			}
			window.returnValue = returnValue;
			opener.fnpop_callback(returnValue);
			window.close();
		} else {
			$.showAlert('선택된 행이 없습니다.');
		}
	}
	
	// 이동
	function btn_Move(m) {
		var up = 'grid';
		var down = 'requestGrid';
		switch (m) {
		case 1:
			var rowArr = $('#' + up).getGridParam('selarrrow');
			if (rowArr.length > 0) {
				for ( var i in rowArr) {
					var row = $('#' + up).getRowData(rowArr[i]);
					//alert(row.h_mtlr_info);
					$('#' + down).jqGrid('addRowData', rowArr[i], row, 'last');
				}
				for (var i = rowArr.length - 1; i >= 0; i--) {
					$('#' + up).jqGrid('setSelection', rowArr[i], false);
				}
			} else {
				$.showAlert('선택된 행이 없습니다.');
			}
			break;
		case 3:
			var rowArr = $('#' + down).getGridParam('selarrrow');
			if (rowArr.length > 0) {
				for (var i = rowArr.length - 1; i >= 0; i--) {
					$('#' + down).jqGrid('delRowData', rowArr[i]);
				}
			} else {
				$.showAlert('선택된 행이 없습니다.');
			}
			break;
		}
	}
	
	// 닫기클릭이벤트
	function btn_Close_onclick() {
		window.close();		
	}
	
	// 시약실험기구 popup열기
	function btn_New_onclick() {
		fnBasicStartLoading();
		fnpop_buyingNeedTargetPop('requestGrid', 650, 325);
		/* var obj = new Object();
		obj.msg1 = fn_getConTextPath()+'/reagents/popReagentsInsert.lims';
		var popup = fnShowModalWindow("popMain.lims",obj, 700, 310);
		if (popup != null) {
			var rowData = popup;
			$('#requestGrid').jqGrid('addRowData', rowData.mtlr_no, rowData, 'last');
		} */
	}
</script>
</head>
<body id="popBody" onunload="opener.fnBasicEndLoading();">
<div class="popUp">
	<div class="pop_area pop_intro">
	<h2>시약/실험기구 등록</h2>
		<div id="tabDiv2" style="margin-top: 20px;">
			<form id="form" name="form" onsubmit="return false;">
				<div class="sub_purple_01">
					<table  class="select_table" >
						<tr>
							<td width="20%" class="table_title">
								<span>■</span>
								시약/실험기구목록
							</td>
							<td class="table_button" style="text-align: right; padding-right: 30px;">
								<span class="button white mlargep auth_select" id="btn_Select" onclick="btn_Search_onclick();">
									<button type="button">조회</button>
								</span>
								<span class="button white mlargep" id="btn_Close" onclick="btn_Close_onclick();">
									<button type="button">닫기</button>
								</span>
							</td>
						</tr>
					</table>
					<table  class="list_table" >
					<tr>
						<th>대분류</th>
						<td>
							<select name="h_mtlr_info" id="h_mtlr_info" style="width:95px"	onchange="comboReload()">
								<option value=" ">전체</option>
								<option value="C42">시약류</option>
								<option value="C43">소모품류</option>
							</select>
		<!-- 					<select name="h_mtlr_info" id="h_mtlr_info"></select> -->
						</td>
						<th>중분류</th>
						<td>
							<select name="m_mtlr_info" id="m_mtlr_info" style="width:115px"></select>
		<!-- 					<select name="m_mtlr_info" id="m_mtlr_info"></select> -->
						</td>
						<th>시약/실험기구명</th>
						<td>
							<input name="item_nm" type="text" class="inputhan"/>
						</td>
						<th>마스터여부</th>
						<td>
							<label><input type='radio' name='master_yn' value='Y' style="width:20px" checked="checked"/>예</label>
							<label><input type='radio' name='master_yn' value='N' style="width:20px"/>아니오</label>
						</td>
					</tr>
				</table>
				</div>
				<input type="hidden" id="sortName" name="sortName">
				<input type="hidden" id="sortType" name="sortType">
				<div id="view_grid_main">
					<table id="grid"></table>
				</div>
			</form>
		</div>
		
		<div style="clear:both; padding-top:25px; text-align:center;">
			<button type="button" id="btn_Right" onclick="btn_Move(1);" class="btnDown"></button>
			<button type="button" id="btn_Left" onclick="btn_Move(3);" class="btnUp"></button>
		</div>
		
		<div id="tabDiv3">
			<form id="requestForm" name="requestForm" onsubmit="return false;">
				<div class="sub_blue_01">
					<table  class="select_table" >
						<tr>
							<td width="20%" class="table_title" nowrap="nowrap">
								<span>■</span>
								선택 시약/실험기구
							</td>
							<td class="table_button" style="text-align: right; padding-right: 30px;">
								<span class="button white mlargeb auth_save" id="btn_New" onclick="btn_New_onclick();">
									<button type="button">시약/실험기구등록</button>
								</span>
								<span class="button white mlargeg auth_save" id="btn_Save_Sub2" onclick="btn_Save_Sub2_onclick();">
									<button type="button">선택완료</button>
								</span>						
							</td>
						</tr>
					</table>
				</div>
				<input type="hidden" id="sortName" name="sortName">
				<input type="hidden" id="sortType" name="sortType">
				<div id="view_grid_sub2">
					<table id="requestGrid"></table>
				</div>
			</form>
		</div>
	</div>
</div>
</body>
</html>
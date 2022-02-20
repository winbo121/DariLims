<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<link rel="stylesheet" media="screen" type="text/css" href="<c:url value='/css/common/sub.css'/>" />
<script type="text/javascript" src="<c:url value='/script/lims.com.accept.js'/>"></script>
<script type="text/javascript">
	var fnGridInit = false;
	
	$(function() {
		/* 세부권한검사 */
		fn_auth_check();
		ajaxComboForm("htrk_prdlst_cd", "CP1", "CHOICE", "", "mainForm");
		
		
		gridMain('master/selectProtcList.lims', 'mainForm', 'gridMain');
		
		// 엔터키 눌렀을 경우(그리드 조회)
		fn_Enter_Search('mainForm', 'gridMain');
	
		//그리드 width조절하기
		$(window).bind('resize', function() {
			$("#gridMainPager").setGridWidth($('#sub_purple_01').width(), true);
		}).trigger('resize');
	});
	
	
	// 
	function gridMain(url, form, grid) {
		$('#' + grid).jqGrid({
			datatype : function(json) {
				fnGridInit ? fn_GridData(url, form, grid) : fnGridInit = true;
			},
			height : '250',
			rowNum : -1,
			rownumbers : true,
			autowidth : true,
			gridview : false,
			shrinkToFit : true,
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
				width : '150',
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
				align : 'center'
			}, {
				label : '속성한글명',
				width : '100',
				name : 'piam_kor_nm',
				align : 'center',
				hidden : true
			}, {
				label : '시험항목담당자',
				width : '100',
				name : 'charger_user_nm',
				align : 'center'
			}, {
				label : '조합품목여부',
				width : '100',
				name : 'mxtr_prdlst_yn',
				align : 'center'
			}, {
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
				label : '사용여부',
				width : '100',
				name : 'use_yn',
				align : 'center'
			}, {
				label : '최종수정일',
				width : '100',
				name : 'last_updt_dtm',
				align : 'center'
			}, {
				label : '정의',
				width : '100',
				name : 'dfn',
				align : 'center'
			}, {
				label : '비고',
				width : '200',
				name : 'rm',
				align : 'center'	
			}, {
				label : 'kfda_yn',
				hidden : true,
				name : 'kfda_yn'
			} ],
			emptyrecords : '데이터가 존재하지 않습니다.',
			gridComplete : function() {
			},
			onSortCol : function(index, iCol, sortorder) {
				//if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
			},
			onSelectRow : function(rowId, status, e) {
				fnViewPage('master/selectProtcDetail.lims', 'detailDiv', 'pageType=detail&prdlst_cd=' + rowId);
			}
		});
	}
	
	
	function btn_New_onclick() {
		$("#detailDiv").empty();
		fnViewPage('master/selectProtcDetail.lims', 'detailDiv', 'pageType=insert');
	}
	
	
	
	function btn_Select_onclick(){
		$('#gridMain').setGridParam({page: 1});
		$('#gridMain').trigger('reloadGrid');
	}
	
	
	function btn_new_pop() {
		/* var rowId = $('#reqSampleGrid').getGridParam('selrow');
		
		if (rowId == null) {
			$.showAlert('한개의 품목을 선택해 주세요.');
		} else {
			var sampleRow = $('#reqSampleGrid').getRowData(rowId);
			var ids = $('#reqItemGrid').jqGrid("getDataIDs");
			var param = "";
			var arr = new Array();
			for ( var i in ids) {
				var row_ids = $('#reqItemGrid').getRowData(ids[i]);
				arr[i] = row_ids.test_item_cd;
			}
			param = $('#reqItemForm').find('#test_sample_seq').val() + "◆★◆" + removeArrayDuplicate(arr) 
					+ "◆★◆" +  sampleRow.test_std_no + "◆★◆" + $("#saveType").val()
					+ "◆★◆" + "" + "◆★◆" + $('#reqSampleGrid').getRowData(rowId).test_sample_seq 
					+ "◆★◆" + $('#reqDetailForm').find('#dept_cd').val()
					+ "◆★◆" + $('#reqItemForm').find('#prdlst_cd').val()
					+ "◆★◆" + $('#reqDetailForm').find('#test_req_seq').val(); */
		/* var sampleRow = $('#reqSampleGrid').getRowData(rowId);
		var ids = $('#reqItemGrid').jqGrid("getDataIDs"); */
		var param = "";
		var arr = new Array();
		for ( var i in ids) {
			var row_ids = $('#reqItemGrid').getRowData(ids[i]);
			arr[i] = row_ids.test_item_cd;
		}
		
		param = $('#reqItemForm').find('#test_sample_seq').val() + "◆★◆" + removeArrayDuplicate(arr) 
				+ "◆★◆" +  sampleRow.test_std_no + "◆★◆" + $("#saveType").val()
				+ "◆★◆" + "" + "◆★◆" + $('#reqSampleGrid').getRowData(rowId).test_sample_seq 
				+ "◆★◆" + $('#reqDetailForm').find('#dept_cd').val()
				+ "◆★◆" + $('#reqItemForm').find('#prdlst_cd').val()
				+ "◆★◆" + $('#reqDetailForm').find('#test_req_seq').val();
		 var param = "항목관리";
		pro_pop_open("reqItemForm", "1000", "867", param);
	}
	
	function pro_pop_open(formName, width, height, popupName) {
		var url = "master/protItemChoice.lims";
		var option = "";
		var openPopup = "";
		if (option == null || option == "") {
		}
		option = "toolbar=no, location=no, menubar=no, scrollbars=yes, status=no, resizable=yes, top=50%, left=50%, width="+width+"px, height="+height+"px" ;
		openPopup = window.open(url, popupName, option);
	}
	
	
</script>
<form id="mainForm" name="mainForm" onsubmit="return false;">
	<div class="sub_purple_01">
		<table  class="select_table" >
			<tr>
				<td class="table_title">
					<span>■</span>
					품목조회
				</td>
				<td class="table_button">
					<span class="button white mlargep auth_save" id="btn_SelItem" onclick="btn_new_pop();">
						<button type="button">팝업</button>
					</span>
					<span class="button white mlargep auth_select" id="btn_Select" onclick="btn_Select_onclick();">
						<button type="button">조회</button>
					</span>
					<span class="button white mlargep auth_save" id="btn_New" onclick="btn_New_onclick();">
						<button type="button">추가</button>
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
				<td colspan="3">
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
				<th style='display:none;'>식약처기준 여부</th>
				<td style='display:none;'> 
					<label><input type='radio' name='kfda_yn' value='Y' style="width: 20px"/>예</label>
					<label><input type='radio' name='kfda_yn' value='N' style="width: 20px" checked="checked"/>아니오</label>
				</td>
			</tr>
		</table>
	</div>
		<input type="hidden" id="sortName" name="sortName">
		<input type="hidden" id="sortType" name="sortType">
		<input type='hidden' id='pageNum' name='pageNum'/>
		<input type='hidden' id='pageSize' name='pageSize'/>
		<input type='hidden' id='sortTarget' name='sortTarget'/>
		<input type='hidden' id='sortValue' name='sortValue'/>
	<div id="view_grid_main">
		<table id="gridMain"></table>
		<div id="gridMainPager"></div>
	</div>
	<table id="search"></table>
</form> 
<div id="detailDiv"></div>
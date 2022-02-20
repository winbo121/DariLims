
<%
	/***************************************************************************************
	 * 시스템명 	: 통합장비관제시스템
	 * 업무명 		: 견적관리 견적 상세
	 * 파일명 		: estimateL02.jsp
	 * 작성자 		: 윤상준
	 * 작성일 		: 2015.09.10
	 * 설  명		: 견적 상세 화면
	 *---------------------------------------------------------------------------------------
	 * 변경일		변경자		변경내역 
	 *---------------------------------------------------------------------------------------
	 * 2015.09.10   윤상준		최초 프로그램 작성         
	 * 
	 *---------------------------------------------------------------------------------------
	 ****************************************************************************************/
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html >
<link rel="stylesheet" media="screen" type="text/css" href="<c:url value='/css/common/sub.css'/>" />
<script type="text/javascript">
	
	var est_fee_gubun;
	fnDatePickerImg('startDt');
	
	$(function() {
		estimateItemGrid('accept/selectEstimateItemList.lims', 'estimateItemForm', 'estimateItemGrid');
		
		estimateItemFeeGrid('accept/selectEstimateItemFeeList.lims', 'estimateItemFeeForm', 'estimateItemFeeGrid');
		
		//엔터키 눌렀을 경우
		fn_Enter_Search('estimateItemForm', 'estimateItemGrid');

		fnDatePickerImg('batchDate');
		//그리드 사이즈 
		$(window).bind('resize', function() {
			$("#estimateItemGrid").setGridWidth($('#view_grid_sub1').width(), true);
		}).trigger('resize');
		$(window).bind('resize', function() {
			$("#estimateItemFeeGrid").setGridWidth($('#view_grid_sub2').width(), true);
		}).trigger('resize');
		
		//견적구분 - 장비대여/시험분석
		var selRow = $("#estimateGrid").getGridParam('selrow');
		var est_gubun = $('#estimateGrid').jqGrid('getCell', selRow, 'est_gubun');

 		fn_show_type('estimateItemForm', est_gubun);
 		fn_showL_type('estimateItemFeeForm', est_gubun);
	});

	function estimateItemGrid(url, form, grid) {
		var lastRowId;
		var allselect = false;
		//var gridNm = grid;
		$('#' + grid).jqGrid({
			datatype : function(json) {
				fnGridData(url, form, grid);
			},
			height : '230',
			autowidth : true,
			loadonce : true,
			mtype : "POST",
			gridview : true,
			shrinkToFit : true,
			rowNum : -1,
			rownumbers : true,
			footerrow: true,
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
				type : 'not',
				label : ' ',
				name : 'icon',
				width : '20',
				sortable : false,
				align : 'center'
			}, {
				label : 'crud',
				name : 'crud',
				hidden : true
			}, {
				label : '견적번호',
				name : 'est_no',
				width : '100',
				hidden : false,
				align : 'center'
			}, {
				label : '견적항목번호',
				name : 'est_item_no',
				hidden : false,
				width : '80',
				key : true,
				align : 'center'
			}, {
				label : '견적품목명',
				name : 'prdlst_nm',
				width : '200',
				align : 'center'
			}, {
				label : '견적품목코드',
				name : 'prdlst_cd',
				align : 'center',
				hidden : true
			}, {
				label : '견적항목코드',
				name : 'test_item_cd',
				width : '200',
				align : 'center'
			}, {
				label : '견적항목명',
				name : 'test_item_nm',
				width : '200',
				align : 'center'
			}, {
				label : '견적항목코드',
				name : 'test_item_cd',
				align : 'center',
				hidden : true
			}, {
				label : '수량',
				width : '80',
				editable : true,
				align : 'right',
				formatter: 'number',
				formatoptions: { thousandsSeparator: ",", decimalPlaces: 0, defaultValue: '1' }, 
				name : 'est_qty'
			}, {
				label : '단가(원)',
				width : '80',
				align : 'right',
				editable : true,
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
			},
// 			{
// 				label : '처리기한',
// 				name : 'est_deadline_date',
// 				width : '80',
// 				align : 'center',
// 				editable : true,
// 				editoptions : {
// 					dataInit : function(elem) {
// 						fnDatePicker(elem.getAttribute('id'));
// 					}
// 				}	
// 			}, 
			{
				label : '비고',
				name : 'est_item_desc',
				editable : true,
				width : '200',
				align : 'center'
			}, {
				label : '규격',
				name : 'est_item_spec',
				editable : true,
				width : '200',
				hidden : true
			} ],
			emptyrecords : '데이터가 존재하지 않습니다.',
			gridComplete : function() {
				// 하단 합계 부분
				var sum1 = $("#" + grid).jqGrid('getCol', 'est_qty', false, 'sum');
				var sum2 = $("#" + grid).jqGrid('getCol', 'est_price', false, 'sum');
				var sum3 = $("#" + grid).jqGrid('getCol', 'est_price_total', false, 'sum');
				$("#" + grid).jqGrid('footerData', 'set', {test_item_nm: '합&nbsp;&nbsp;계 : ', est_qty:sum1, est_price_total:sum3} );
				
				// 스타일 주기 
				$('#gbox_estimateItemGrid table.ui-jqgrid-ftable tr:first').children('td').css('background-color', '#dfeffc');	// 배경색
				$('#gbox_estimateItemGrid table.ui-jqgrid-ftable tr:first').children('td').css('font-weight', 'normal'); 		// 폰트 스타일
				$('#gbox_estimateItemGrid table.ui-jqgrid-ftable tr:first td:eq(10), #gbox_estimateItemGrid table.ui-jqgrid-ftable tr:first td:eq(12)').css('font-weight', 'bold'); // 합계, 총계
				
			/* 	$('table.ui-jqgrid-ftable tr:first td:eq(4)').css('width','490px'); // 합계 width
				$('table.ui-jqgrid-ftable tr:first td:eq(9)').css('width','780px'); // 총계 width */
				
				// 합계 정렬
				$('#gbox_estimateItemGrid table.ui-jqgrid-ftable tr:first td:eq(8)').css("text-align","right");	// 합계
				
				//마지막행 포커스 주기
				//$('#' + grid + ' tr:last').focus();
			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
				if (editCount()) {
					if (!confirm('저장하지 않은 정보는 사라집니다. 정렬하시겠습니까?')) {
						return 'stop';
					}
				}
			},
			onSelectRow : function(rowId, status, e) {
				fnEditRelease(grid);
				/*fnGridEdit(grid, rowId, ""); */
			},
			ondblClickRow : function(rowId, iRow, iCol, e) {
				fnEditRelease('estimateItemGrid');
				//var grid = 'estimateItemGrid';
				//alert(gridNm);
				
				fnGridEdit(grid, rowId, fn_price_event);
			},
			onCellSelect : function(rowId, iCol, cellcontent, e) {
			},			
			afterEditCell : function(rowId, rowdata, rowelem) {
			}
		});
	}
	
	function fn_price_event(rowId){
		editChange = true;
		var gridNm = 'estimateItemGrid';
		var price = '_est_price'; 
		var qty = '_est_qty'; 
		var total = 'est_price_total';
		
		$('#' + gridNm).setCell(rowId, 'chk', 'Yes');
		
		// 단가변경
		$('#' + rowId + price).keyup(function() {
			var val1 = $("#" + rowId + qty).val();
			var val2 = $("#" + rowId + price).val();
			var totalCal = Math.floor(val1 * val2 * 0.1)
			if (totalCal < 1) {totalCal == 0} else {totalCal = totalCal * 10}
			$('#' + gridNm).setCell(rowId, total, totalCal);
		});
		$('#' + rowId + qty).keyup(function() {
			var val1 = $("#" + rowId + qty).val();
			var val2 = $("#" + rowId + price).val();
			var totalCal = Math.floor(val1 * val2 * 0.1)
			if (totalCal < 1) {totalCal == 0} else {totalCal = totalCal * 10}
			$('#' + gridNm).setCell(rowId, total, totalCal);
		});
	}
	
	// 항목수수료목록
	function estimateItemFeeGrid(url, form, grid) {
		//var gridNm = grid;
		$('#' + grid).jqGrid({
			datatype : function(json) {
				fnGridData(url, form, grid);
			},
			height : '100',
			autowidth : true,
			loadonce : true,
			mtype : "POST",
			gridview : true,
			shrinkToFit : true,
			rowNum : -1,
			rownumbers : true,
			footerrow: true,
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
				type : 'not',
				label : ' ',
				name : 'icon',
				width : '20',
				sortable : false,
				align : 'center'
			}, {
				label : 'crud',
				name : 'crud',
				hidden : true
			},{
				label : '견적번호',
				name : 'est_no',
				width : '100',
				hidden : false,
				align : 'center'
			}, {
				label : '견적항목번호',
				name : 'est_fee_no',
				hidden : false,
				width : '80',
				key : true,
				align : 'center'
			}, {
				label : '견적항목명',
				name : 'est_fee_nm',
				width : '200',
				editable : true,
				align : 'center'
			}, 
// 			{
// 				label : '견적항목명',
// 				name : 'est_fee_nm',
// 				width : '200',
// 				editable : true,
// 				edittype : "select",
// 				editoptions : {
// 					value : est_fee_gubun
// 				},
// 				formatter : 'select'
// 			},
			{
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
				width : '200',
				align : 'center'
			} ],
			emptyrecords : '데이터가 존재하지 않습니다.',
			gridComplete : function() {
				// 하단 합계 부분
				var sum1 = $("#" + grid).jqGrid('getCol', 'est_fee_qty', false, 'sum');
				//var sum2 = $("#" + grid).jqGrid('getCol', 'est_fee_price', false, 'sum');
				var sum3 = $("#" + grid).jqGrid('getCol', 'est_fee_price_total', false, 'sum');
				$("#" + grid).jqGrid('footerData', 'set', {est_fee_nm: '합&nbsp;&nbsp;계 : ', est_fee_qty:sum1, est_fee_price_total:sum3} );
				
				// 스타일 주기 
				$('#gbox_estimateItemFeeGrid table.ui-jqgrid-ftable tr:first').children('td').css('background-color', '#dfeffc');	// 배경색 #dfeffc'
				$('#gbox_estimateItemFeeGrid table.ui-jqgrid-ftable tr:first').children('td').css('font-weight', 'normal'); 		// 폰트 스타일
				$('#gbox_estimateItemFeeGrid table.ui-jqgrid-ftable tr:first td:eq(7), #gbox_estimateItemFeeGrid table.ui-jqgrid-ftable tr:first td:eq(9)').css('font-weight', 'bold'); // 합계, 총계
				
				// 합계 정렬
				$('#gbox_estimateItemFeeGrid table.ui-jqgrid-ftable tr:first td:eq(6)').css("text-align","right");	// 합계
				
// 				var sum1 = $("#" + grid).jqGrid('getCol', 'est_fee_price', false, 'sum');
// 				$("#" + grid).jqGrid('footerData', 'set', {est_fee_nm: '합&nbsp;&nbsp;계 : ', est_fee_price:sum1} );
			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
				if (editCount()) {
					if (!confirm('저장하지 않은 정보는 사라집니다. 정렬하시겠습니까?')) {
						return 'stop';
					}
				}
			},
			onSelectRow : function(rowId, status, e) {
				fnEditRelease(grid);
				/*fnGridEdit(grid, rowId, ""); */
			},
			ondblClickRow : function(rowId, iRow, iCol, e) {
				fnEditRelease('estimateItemFeeGrid');
				//var grid = 'estimateItemFeeGrid';
				//alert(grid);
				fnGridEdit(grid, rowId, fn_item_price_event);
			},
			onSelectAll : function(selar, status) {
				
			},			
			afterInsertRow : function(rowId, rowdata, rowelem) {
				/* if (rowdata.state == 'C39005') {
					for (key in rowdata) {
						$('#estimateItemGrid').jqGrid('setCell', rowId, key, '', {
							color : 'blue'
						});
					}
				} else {
					for (key in rowdata) {
						$('#estimateItemGrid').jqGrid('setCell', rowId, key, '', {
							color : 'red'
						});
					}
				} */
			}
		});
	}

	
	function fn_item_price_event(rowId){
		editChange = true;
	
		var gridNm = 'estimateItemFeeGrid';
		var price = '_est_fee_price'; 
		var qty = '_est_fee_qty'; 
		var total = 'est_fee_price_total';
		
		$('#' + gridNm).setCell(rowId, 'chk', 'Yes');
		
		// 단가변경
		$('#' + rowId + price).keyup(function() {
			var val1 = $("#" + rowId + qty).val();
			var val2 = $("#" + rowId + price).val();
			var totalCal = Math.floor(val1 * val2 * 0.1)
			if (totalCal < 1) {totalCal == 0} else {totalCal = totalCal * 10}
			$('#' + gridNm).setCell(rowId, total, totalCal);
		});
		$('#' + rowId + qty).keyup(function() {
			var val1 = $("#" + rowId + qty).val();
			var val2 = $("#" + rowId + price).val();
			var totalCal = Math.floor(val1 * val2 * 0.1)
			if (totalCal < 1) {totalCal == 0} else {totalCal = totalCal * 10}
			$('#' + gridNm).setCell(rowId, total, totalCal);
		});
	}
	
	function fn_estimateItemPop(pageType){		
		if(pageType == 'item' || pageType == 'inst'){			
			var rowId = $("#estimateGrid").getGridParam('selrow');
			var est_gubun = $('#estimateGrid').jqGrid('getCell', rowId, 'est_gubun');
			
			if(est_gubun == "C57001"){ //시험분석
				fn_itemChoice('item');
			}else if(est_gubun == "C57002"){ //장비대여
				fn_itemChoice('inst');
			}		
		}
		
		if(pageType == 'fee'){
			var grid = 'estimateItemFeeGrid';
			$('#' + grid).jqGrid('addRow', {
				rowID : 0,
				position : 'last'
			});
			fnGridEdit(grid, 0, fn_item_price_event);
			$('#' + grid).setCell(0, 'crud', 'c');
			$('#' + grid).setCell(0, 'est_no', $("#est_no").val());

			$('#' + 0 + '_crud').focus();
			$('#btn_fee_add').hide();
			$('#btn_delete_fee').hide();
		}
	}
	
	// 항목 추가 시 팝업 이벤트
	function fn_itemChoice(gubun) {		
		var rowId = $("#estimateGrid").getGridParam('selrow');
		if(fnIsEmpty(rowId)){
			alert("선택된 견적이 없습니다.");
			return;
		}
		
		var ids = $('#estimateItemGrid').jqGrid("getDataIDs");
		var param = "";
		var arr = new Array();
		var arrPrd = new Array();
		
		for ( var i in ids) {
			var row_ids = $('#estimateItemGrid').getRowData(ids[i]);
			arr[i] = row_ids.test_item_cd;
		}
		
		for ( var j in ids) {
			var row_ids = $('#estimateItemGrid').getRowData(ids[j]);
			arrPrd[j] = row_ids.prdlst_cd;
		}
		
		param = rowId + "◆★◆" + removeArrayDuplicate(arr) 
				+ "◆★◆001◆★◆" + "EST"
				+ "◆★◆" + "" + "◆★◆" + removeArrayDuplicate(arrPrd)
				+ "◆★◆" + "";
		
		if(gubun=="item"){
			fnpop_selfStdItemChoicePop("reqItemForm", "1000", "867", param);
		}else if(gubun=="inst"){
			fnpop_instChoicePop("reqItemForm", "1000", "867", param);
		}
	}
	
	// 자식 -> 부모창 함수 호출
	function fnpop_callback(returnParam){
		$('#estimateItemGrid').trigger('reloadGrid');
		//fnBasicEndLoading();
	}
	
	function fnpop_estimateItemPop(popupName, pageType, selEst){
		
		var url = "accept/estimateItemPop.lims?pageType="+pageType+"&est_no="+selEst;
		var option = "toolbar=no, location=no, menubar=no, scrollbars=no, status=no, resizable=yes";
		var iwidth = "600";
		var iheight = "400";
		var itop = ($(window).height() - iheight) / 2;
		var ileft = ($(window).width() - iwidth) / 2;
		option += ", width=" + iwidth + ", height=" + iheight + ", top=" + itop + ", left=" + ileft;
		
		openPopup = window.open(encodeURI(url), popupName, option);
		
	}
	
	function fnpop_callback(returnParam){
		$('#estimateGrid').trigger('reloadGrid');
		fnBasicEndLoading();
	}
	
	function btn_Save_Sub_onclick(type){
		var grid ="";
		var url = "";
		if(type == 'item'){
			grid = 'estimateItemGrid';
			url = 'accept/saveEstimateItem.lims';
		}
		if(type == 'fee'){
			grid = 'estimateItemFeeGrid';
			url = 'accept/saveEstimateItemFee.lims';
		}
		fnEditRelease(grid);
		var ids = $('#' + grid).jqGrid("getDataIDs");
		var c = 0;
		for ( var i in ids) {
			var row = $('#' + grid).getRowData(ids[i]);
			if (row.crud != '') {
				c++;
			}
		}
		if (c == 0) {
			alert('변경된 내역이 없습니다.');
		} else {
			var data = fnGetGridAllData(grid);
			var json = fnAjaxAction(url, data);
			if (json == null) {
				alert('error');
			} else {
				alert('저장이 완료되었습니다.');
				if(type == 'fee'){
					$('#btn_fee_add').show();
					$('#btn_delete_fee').show();
				}
				
				$('#'+grid).trigger('reloadGrid');
			}
		}
		
	}
	
	function btn_delete_Sub_onclick(type){
		var grid ="";
		var url = "";
		if(type == 'item'){
			grid = 'estimateItemGrid';
			url = 'accept/saveEstimateItem.lims';
		}
		if(type == 'fee'){
			grid = 'estimateItemFeeGrid';
			url = 'accept/saveEstimateItemFee.lims';
		}
		
		
		
		var ids = $('#' + grid).jqGrid("getDataIDs");
		var c = 0;
		for ( var i in ids) {
			var row = $('#' + grid).getRowData(ids[i]);
			if (row.chk == 'Yes') {
				c++;
				//fnGridEdit(grid, row, "");
				$('#' + grid).setCell(ids[i], 'crud', 'd');
			}
		}
		fnEditRelease(grid);
		if (c == 0) {
			alert('변경된 내역이 없습니다.');
		} else {
			if(confirm("선택하신 항목을 삭제하시겠습니까?")){
				var data = fnGetGridCheckData(grid);
				var json = fnAjaxAction(url, data);
				if (json == null) {
					alert('error');
				} else {
					alert('선택하신 항목이 삭제되었습니다.');
					$('#'+grid).trigger('reloadGrid');
				}
			}
			
		}
	}
	
	//항목추가
 	function fn_estimateItemChoice() {
		var rowId = $('#estimateGrid').getGridParam('selrow');
		if (rowId == null) {
			$.showAlert('견적을 선택해 주세요.');
		} else {
			var estimateRow = $('#estimateGrid').getRowData(rowId);
			var ids = $('#estimateItemGrid').jqGrid("getDataIDs");
			var param = "";
			var arr = new Array();
			for ( var i in ids) {
				var row_ids = $('#estimateItemGrid').getRowData(ids[i]);
				arr[i] = row_ids.test_item_cd;
			}
			param = $('#estimateItemForm').find('#est_no').val() + "◆★◆" + removeArrayDuplicate(arr) 
					+ "◆★◆" +  estimateRow.test_std_no + "◆★◆" + $("#saveType").val()
					+ "◆★◆" + "" + "◆★◆" + $('#estimateGrid').getRowData(rowId).est_no ; 
					+ "◆★◆" + $('#estimateItemGrid').find('#est_item_no').val(); 
//					+ "◆★◆" + $('#reqItemForm').find('#prdlst_cd').val()
//					+ "◆★◆" + $('#reqDetailForm').find('#test_req_seq').val() 
			
			fnpop_stdItemChoicePop("estimateItemForm", "1000", "867", param);
							
			fnBasicStartLoading();
		}
	} 
	
	// 장비대여/시험분석
	function fn_show_type(form, flag) {		
		if (flag == 'C57002' ){ 
			$('#' + form).find("#btn_AddItem").hide();//항목추가
			$('#' + form).find("#btn_inst_add").show();//장비추가
			$('#' + form).find("#btn_item_add").hide();//프로토콜항목추가
			
			jQuery("#estimateItemGrid").jqGrid("setLabel", "est_item_no", "견적장비번호");
			jQuery("#estimateItemGrid").jqGrid("setLabel", "test_item_cd", "견적장비코드");
			jQuery("#estimateItemGrid").jqGrid("setLabel", "test_item_nm", "견적장비명");
		} else if (flag == 'C57001'){	
			$('#' + form).find("#btn_AddItem").show();
			$('#' + form).find("#btn_inst_add").hide();
			$('#' + form).find("#btn_item_add").show();
			
			jQuery("#estimateItemGrid").jqGrid("setLabel", "est_item_no", "견적항목번호");
			jQuery("#estimateItemGrid").jqGrid("setLabel", "test_item_cd", "견적항목코드");
			jQuery("#estimateItemGrid").jqGrid("setLabel", "test_item_nm", "견적항목명");
		}
	}
	
	// 장비대여/시험분석
	function fn_showL_type(form, flag) {		
		if (flag == 'C57002' ){ 
			$('#' + form).find("#btn_fee_add").hide();//항목수수료 추가
			$('#' + form).find("#btn_fee2_add").show();//

			jQuery("#estimateItemFeeGrid").jqGrid("setLabel", "est_fee_no", "견적장비번호");
			jQuery("#estimateItemFeeGrid").jqGrid("setLabel", "est_fee_nm", "견적장비명");
		} else if (flag == 'C57001'){	
			$('#' + form).find("#btn_fee2_add").hide();//항목수수료 추가
			$('#' + form).find("#btn_fee_add").show();//
			
			jQuery("#estimateItemFeeGrid").jqGrid("setLabel", "est_fee_no", "견적항목번호");
			jQuery("#estimateItemFeeGrid").jqGrid("setLabel", "est_fee_nm", "견적항목명");
		}
	}
	
	
	//처리기한 일괄입력
// 	function btn_Date_onclick() {
		
// 		$("#dialog").dialog({
// 			buttons : [ {
// 				text : "일괄입력",
// 				click : function() {
// 					var startDate = $('#startDt').val();
					
// 					var ids = $('#estimateItemGrid').jqGrid("getDataIDs");
// 					if (ids.length > 0) {
// 						for ( var i in ids) {
// 							fnGridEdit('estimateItemGrid', ids[i], null);
// 							$('#estimateItemGrid').jqGrid('setCell', ids[i], 'crud', 'u');
// 							$('#estimateItemGrid').jqGrid('setCell', ids[i], 'est_deadline_date', startDate);
// 						}
// 						fnEditRelease('estimateItemGrid');
// 					} else {
// 						alert('선택된 행이 없습니다.');
// 					}
// 					$('#dialog').dialog("destroy");
// 				}
// 			}, {
// 				text : "취소",
// 				click : function() {
// 					$('#dialog').dialog("destroy");
// 				}
// 			} ]
// 		});
// 	}

</script>
<form id="estimateItemForm" name="estimateItemForm" onsubmit="return false;">
	<div class="sub_blue_01">
		<table  class="select_table" >
			<tr>
				<td class="table_title">
					<span>■</span>
					견적항목목록
				</td>
				<td class="table_button">
 					<span class="button white mlargeb auth_save" id="btn_AddItem" onclick="fn_estimateItemChoice();">
						<button type="button">항목추가</button>
					</span> 
					<span class="button white mlargep auth_save" id="btn_item_add" onclick="fn_estimateItemPop('item');">
						<button type="button">프로토콜항목추가</button>
					</span>
					<span class="button white mlargep auth_save" id="btn_inst_add" onclick="fn_estimateItemPop('inst');">
						<button type="button">장비추가</button>
					</span>
					<span class="button white mlarger auth_save" id="btn_delete_Sub" onclick="btn_delete_Sub_onclick('item');">
						<button type="button">삭제</button>
					</span>
					<span class="button white mlargeg auth_save" id="btn_Save_Sub" onclick="btn_Save_Sub_onclick('item');">
						<button type="button">저장</button>
					</span>
				</td>
			</tr>
		</table>
	</div>

	<input type="hidden" id="sortName" name="sortName">
	<input type="hidden" id="sortType" name="sortType">
	<input type="hidden" id="dept_cd" name="dept_cd" value="${session.dept_cd}">
	<input type="hidden" id="est_no" name="est_no" value="${detail.est_no}">
	<input type="hidden" id="est_gubun" name="est_gubun" value="${detail.est_gubun}">
	<div id="view_grid_sub1">
		<table id="estimateItemGrid"></table>
	</div>
</form>
<form id="estimateItemFeeForm" name="estimateItemFeeForm" onsubmit="return false;">
	<div class="sub_blue_01">
		<table  class="select_table" >
			<tr>
				<td class="table_title">
					<span>■</span>
					항목수수료목록
				</td>

				<td class="table_button">
					<span class="button white mlargep auth_save" id="btn_fee_add" onclick="fn_estimateItemPop('fee');">
						<button type="button">항목수수료추가</button>
					</span>
					<span class="button white mlargep auth_save" id="btn_fee2_add" onclick="fn_estimateItemPop('fee');">
						<button type="button">장비수수료추가</button>
					</span>
					<span class="button white mlarger auth_save" id="btn_delete_fee" onclick="btn_delete_Sub_onclick('fee');">
						<button type="button">삭제</button>
					</span>
					<span class="button white mlargeg auth_save" id="btn_Save_fee" onclick="btn_Save_Sub_onclick('fee');">
						<button type="button">저장</button>
					</span>
				</td>
			</tr>
		</table>
	</div>
	<input type="hidden" id="sortName" name="sortName">
	<input type="hidden" id="sortType" name="sortType">
	<input type="hidden" id="dept_cd" name="dept_cd" value="${session.dept_cd}">
	<input type="hidden" id="est_no" name="est_no" value="${detail.est_no}">
	<input type="hidden" id="est_gubun" name="est_gubun" value="${detail.est_gubun}">
	<input type="hidden"  id="saveType" name="saveType" value="estimate">
	<div id="view_grid_sub2">
		<table id="estimateItemFeeGrid"></table>
	</div>
</form>
<div id="dialog" style="display: none;">
	<table>
		<tr>
			<th>처리기한</th>
			<td>
				<input name="startDt" id="startDt" type="text" class="w80px" readonly="readonly" />
				<img src="<c:url value='/images/common/calendar_del.png'/>" id="startDateStop" style="cursor: pointer;" onClick='fn_TextClear("startDt")' />
			</td>
		</tr>
	</table>
</div>


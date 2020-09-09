
<%
	/***************************************************************************************
	 * 시스템명 	: 통합장비관제시스템
	 * 업무명 		: 구매요청(승인)
	 * 파일명 		: buyingConfirmationL01.jsp -> purchaseConfirmL01.jsp
	 * 작성자 		: 최은향
	 * 작성일 		: 2015.02.24
	 * 설  명		: 구매요청(승인) 리스트 조회 화면
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
<!DOCTYPE html >
<link rel="stylesheet" media="screen" type="text/css" href="<c:url value='/css/common/sub.css'/>" />
<script type="text/javascript">
	var editable = true;
	var deptcd;
	var buy_sts;
	var m_mtlr;
	var m_mtlr_C42 = fnGridCommonCombo('C42', null);
	var m_mtlr_C43 = fnGridCommonCombo('C43', null);
	m_mtlr_C43 = m_mtlr_C43.slice(1);
	var mtlr_mst_no;
	var deptNm;

	$(function() {
		/* 세부권한검사 */
		fn_auth_check();
		
		deptNm = '${session.dept_nm}';
		
		m_mtlr = m_mtlr_C42 + m_mtlr_C43;

		buy_sts = fnGridCommonCombo('C39', null);
		deptcd = fnGridCombo('dept', null);

		checkYear('ALL', new Date().getFullYear(), 'sel_buy_year'); // 구매년도
		ajaxComboForm("buy_q", "C14", "", "", 'purchaseInfoForm'); // 구매분기
		ajaxComboForm("buy_sts", "C39", "ALL", "", 'purchaseInfoForm'); // 진행상태

		purchaseInfoGrid('reagents/purchaseInfoList.lims', 'purchaseInfoForm', 'purchaseInfoGrid');
		$('#purchaseInfoGrid').clearGridData(); // 최초 조회시 데이터 안나옴
		fn_Enter_Search('purchaseInfoForm', 'purchaseInfoGrid');

		ajaxComboForm("dept_cd", "", "ALL", null, 'purchaseReqForm');
		//ajaxComboForm("office_cd", "", "ALL", null, 'purchaseReqForm'); // 사업소별
		
		purchaseReqGrid('reagents/purchaseReqList.lims', 'purchaseReqForm', 'purchaseReqGrid');
		fn_Enter_Search('purchaseReqForm', 'purchaseReqGrid');

		// 그리드 사이즈 
		$(window).bind('resize', function() {
			$("#purchaseInfoGrid").setGridWidth($('#view_grid_main').width(), true);
		}).trigger('resize');

		$(window).bind('resize', function() {
			$("#purchaseReqGrid").setGridWidth($('#view_grid_sub').width(), false);
		}).trigger('resize');

		
		/* fn_show_type($('#purchaseReqForm').find("#req_dept_office").val()); */
	});

	// 대분류 콤보
	function comboReload() {
		if ($("#h_mtlr_info").val() == "C42") {
			ajaxComboForm("m_mtlr_info", "C42", "All", "", 'purchaseReqForm'); // 중분류			
		} else if ($("#h_mtlr_info").val() == "C43") {
			ajaxComboForm("m_mtlr_info", "C43", "All", "", 'purchaseReqForm'); // 중분류
		}
	}

	// 구매년도 SELECT
	function checkYear(type, year, id) {
		var name = id;
		if (type == 'ALL') {
			$('#' + name).append($('<option />').val('').html('전체'));
		}
		for (var i = new Date().getFullYear() + 5; i > new Date().getFullYear() - 5; i--) {
			if (year == i) {
				$('#' + name).append($('<option selected />').val(i).html(i + ' 년'));
			} else
				$('#' + name).append($('<option />').val(i).html(i + ' 년'));
		}
	}

	function btn_Select_onclick() {
		$('#purchaseInfoGrid').trigger('reloadGrid');
		$('#purchaseReqForm').find('#mtlr_mst_no').val('');
		$('#purchaseReqGrid').clearGridData();
	}

	function purchaseInfoGrid(url, form, grid) {
		var lastRowId = 0;
		$('#' + grid).jqGrid({
			datatype : function(json) {
				fnGridData(url, form, grid);
			},
			height : '115',
			autowidth : false,
			loadonce : true,
			mtype : "POST",
			gridview : true,
			shrinkToFit : true,
			rowNum : -1,
			rownumbers : true,
			colModel : [ {
				label : '구매정보번호',
				name : 'mtlr_mst_no',
				key : true,
				hidden : true
			}, {
				label : '진행상태',
				width : '60',
				name : 'buy_sts',
				align : 'center',
				formatter : 'select',
				edittype : "select",
				editoptions : {
					value : buy_sts
				}
			}, {
				label : '구매명칭',
				width : '250',
				name : 'buy_title'
			}, {
				label : '구매년도',
				width : '60',
				name : 'buy_year',
				align : 'center'
			}, {
				label : '구매분기',
				width : '60',
				name : 'buy_q',
				align : 'center'
			}, {
				label : '수요조사시작일',
				width : '110',
				name : 'buy_date',
				align : 'center'
			}, {
				label : '수요조사종료일',
				width : '110',
				name : 'dmd_date',
				align : 'center'
			}, {
				label : '구매비고',
				width : '350',
				name : 'buy_etc'
			} ],
			gridComplete : function() {
				$('#btn_excel').hide();
				$('#btn_search').hide();
				$('#btn_save').hide();
				$('#btn_add').hide();
				$('#btn_update').hide();
				$('#btn_confirm').hide();
			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
			},
			onSelectRow : function(rowId, status, e) {
				$('#purchaseReqForm').find('#mtlr_mst_no').val(rowId);
				mtlr_mst_no = $('#purchaseReqForm').find('#mtlr_mst_no').val();
				$('#purchaseReqGrid').trigger('reloadGrid');
				var row = $('#purchaseInfoGrid').getRowData(rowId);

				$('#btn_excel').show();
				$('#btn_search').show();
				//$('#btn_save').show();
				$('#btn_add').show();
				$('#btn_update').show();
				$('#btn_confirm').show();

				if (row.buy_sts == 'C39004') {
					$('#btn_save').hide();
					$('#btn_add').hide();
					$('#btn_update').hide();
					$('#btn_confirm').hide();
					editable = false;
				} else {
					editable = true;
				}
			}
		});
	}

	function purchaseReqGrid(url, form, grid) {
		var lastRowId = 0;
		$('#' + grid).jqGrid({
			datatype : function(json) {
				if ('' != $('#purchaseReqForm').find('#mtlr_mst_no').val()) {
					fnGridData(url, form, grid);
				}
			},
			height : '405',
			autowidth : false,
			loadonce : true,
			mtype : "POST",
			gridview : false,
			shrinkToFit : true,
			rowNum : -1,
			rownumbers : true,
			colModel : [ {
				label : '구매요청코드',
				width : '140',
				name : 'mtlr_req_no',
				hidden : true
			}, {
				type : 'not',
				label : ' ',
				name : 'icon',
				width : '20',
				align : 'center',
				frozen : true
			}, {
				label : 'crud',
				name : 'crud',
				hidden : true,
				frozen : true
			}, {
				type : 'not',
				label : '마스터여부',
				width : '70',
				name : 'master_yn',
				align : 'center'
			}, {
				type : 'not',
				label : '대분류',
				width : '60',
				align : 'center',
				name : 'h_mtlr_info',
			/* formatter : 'select',
			edittype : "select",
			editoptions : {
				value : h_mtlr_info
			} */
			}, {
				type : 'not',
				label : '중분류',
				width : '100',
				align : 'center',
				name : 'm_mtlr_info'
			// 				,
			// 				formatter : 'select',
			// 				edittype : "select",
			// 				editoptions : {
			// 					value : m_mtlr
			// 				}
			}, {
				type : 'not',
				label : '시약실험기구명',
				width : '250',
				name : 'item_nm'
			}, {
				label : '시약실험기구코드',
				width : '140',
				name : 'mtlr_no',
				hidden : true
			}, {
				label : '요청부서명',
				width : '120',
				name : 'create_dept',
				align : 'center',
				edittype : "select",
				editoptions : {
					value : deptcd
				}
			}, {
				label : '요청자',
				align : 'center',
				width : '80',
				name : 'user_id'
			}, {
				type : 'not',
				label : '요청수량',
				width : '60',
				align : 'right',
				name : 'req_qty',
				editrules : {
					number : true
				},
				classes : 'number_css'
			// 				,index:'req_qty',
			// 				formatter:'integer',
			// 				formatoptions : {thousandsSeparator:"," ,
			// 					summaryType:'sum',summaryTpl:'Totals:'}
			}, {
				label : '확정수량',
				width : '80',
				name : 'fix_qty',
				align : 'right',
				//editable : true,
				editrules : {
					//required : true	// 필수값
					number : true
				},
				classes : 'number_css'
			}, {
				label : '단가(원)',
				width : '70',
				align : 'right',
				//editable : true,
				name : 'cost',
				editrules : {
					number : true
				},
				classes : 'number_css'
			}, {
				type : 'not',
				label : '제조사',
				width : '180',
				type : 'not',
				align : 'center',
				name : 'spec1'
			}, {
				type : 'not',
				label : 'Cas no.',
				width : '180',
				type : 'not',
				align : 'center',
				name : 'spec2'
			}, {
				type : 'not',
				label : 'Cat # (제품번호)',
				width : '180',
				type : 'not',
				align : 'center',
				name : 'spec_etc'
			}, {
				type : 'not',
				label : 'Lot # (로트번호)',
				width : '200',
				align : 'center',
				name : 'use',
				hidden : true
			}, {
				type : 'not',
				label : '용량',
				width : '160',
				align : 'center',
				name : 'mtlr_vol'
			}, {
				type : 'not',
				label : '단위',
				width : '100',
				align : 'center',
				name : 'unit'
			}, {
				type : 'not',
				label : '비고',
				width : '250',
				name : 'etc'
			}, {
				label : '구매정보번호',
				width : '140',
				name : 'mtlr_mst_no',
				hidden : true
			}, {
				type : 'not',
				label : '승인구분',
				width : '80',
				name : 'appr_flag',
				hidden : true
			}, {
				type : 'not',
				label : '검수일자',
				width : '140',
				align : 'center',
				name : 'create_date',
				hidden : true
			}, {
				type : 'not',
				label : '정렬순서',
				width : '140',
				name : 'ord_no',
				hidden : true
			}, {
				type : 'not',
				label : '구매그룹코드',
				width : '140',
				name : 'buy_grp_cd',
				hidden : true
			} ],
			gridComplete : function() {
			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
				if (!confirm('저장하지 않은 정보는 사라집니다. 정렬하시겠습니까?')) {
					return 'stop';
				}
			},
			onSelectRow : function(rowId, status, e) {
				if (rowId && rowId != lastRowId) {
					lastRowId = rowId;
					fnEditRelease('purchaseReqGrid');
				}
			},
			ondblClickRow : function(rowId, iRow, iCol, e) {
				if (editable) {
					fnGridEdit(grid, rowId, buying_Row_Click);
					var colArr = $('#' + grid).jqGrid('getGridParam', 'colModel');
					$('#' + rowId + '_' + colArr[iCol].name).focus();
				}
			},
			afterInsertRow : function(rowId, rowdata, rowelem) {
				var row = $('#' + grid).getRowData(rowId);
				var fixQty = row.fix_qty;
				var cost = row.cost;
				if (fixQty != '' && cost != '') {
					for (key in rowdata) {
						$('#purchaseReqGrid').jqGrid('setCell', rowId, key, '', {
							color : 'blue'
						});
					}
				}

			}
		});
	}

	// 구매 요청 목록 조회
	function btn_Search_sub_onclick() {
		$('#purchaseReqGrid').trigger('reloadGrid');
	}

	// 저장 이벤트
	function btn_Save_sub_onclick() {
		var grid = 'purchaseReqGrid';
		fnEditRelease(grid);
		if (!confirm('저장 하시겠습니까?')) {
		} else {
			var ids = $('#' + grid).jqGrid("getDataIDs");
			for ( var i in ids) {
				var row = $('#' + grid).getRowData(ids[i]);

				if (row.fix_qty == '' && row.cost != '') {
					alert(row.item_nm + '\n의 확정수량을 입력해주세요.');
					fnGridEdit(grid, ids[i], buying_Row_Click);
					$("#" + ids[i] + "_fix_qty").focus();
					return false;
				}
				if (row.fix_qty != '' && row.cost == '') {
					alert(row.item_nm + '\n의 단가를 입력해주세요.');
					fnGridEdit(grid, ids[i], buying_Row_Click);
					$("#" + ids[i] + "_cost").focus();
					return false;
				}
			}
			var data = fnGetGridAllData('purchaseReqGrid');
			var json = fnAjaxAction('reagents/savePurchaseConfirm.lims?mtlr_mst_no=' + mtlr_mst_no, data);
			if (json == null) {
				alert("저장 실패하였습니다.");
			} else {
				alert('저장 완료되었습니다.');
				var ids = $('#purchaseReqGrid').jqGrid("getDataIDs");
				for ( var i in ids) {
					var row = $('#purchaseReqGrid').getRowData(ids[i]);
					if (row.fixQty != '' && row.cost != '') {
						for (key in row) {
							$('#purchaseReqGrid').jqGrid('setCell', ids[i], key, '', {
								color : 'blue'
							});
						}
					}
				}
				btn_Search_sub_onclick();
			}
		}
	}

	// 구매 확정 이벤트
	function btn_Confirm_onclick() {
		var grid = "#purchaseInfoGrid";
		var rowId = $(grid).getGridParam('selrow');
		var mtlr_no;

		var rowData = $(grid).jqGrid('getRowData', rowId);
		mtlr_no = rowData.mtlr_no;

		//alert(rowData.mtlr_no);

		if (rowId == null) {
			alert('선택된 행이 존재하지 않습니다.');
		} else {
			if (!confirm('구매확정 하시겠습니까?')) {

			} else {
				var data = 'mtlr_mst_no=' + rowId + '&mtlr_no=' + mtlr_no;
				var json = fnAjaxAction('reagents/purchaseConfirm.lims', data);

				var ids = $(grid).jqGrid("getDataIDs");

				// 				if (ids.length > 0) {					
				// 					for ( var i = ids.length - 1; i >= 0; i-- ) {
				// 						var row = $(grid).getRowData(ids[i]);

				// 						if(row.cost == "" || row.cost == null){
				// 							alert("가격을 입력해주세요.")
				// 							return false;
				// 						}

				// 						if(row.fix_qty == "" || row.fix_qty == null){
				// 							alert("확정수량을 입력해주세요.")
				// 							return false;
				// 						}
				// 					}
				// 				}				

				if (json == null) {
					alert("구매확정 실패하였습니다.");
				} else {
					if (json == 1) {
						alert('구매확정 완료되었습니다.');
						btn_Select_onclick();
					} else {
						var c = null;
						var vArr = json.split('◆★◆');
						if (vArr[1] == 'null') {
							alert(vArr[0] + '\n의 확정수량을 입력해주세요.');
							c = 'fix_qty';
						} else if (vArr[2] == 'null') {
							alert(vArr[0] + '\n의 단가를 입력해주세요.');
							c = 'cost';
						}
						var ids = $('#purchaseReqGrid').jqGrid("getDataIDs");
						for ( var i in ids) {
							var row = $('#purchaseReqGrid').getRowData(ids[i]);
							if (row.mtlr_req_no == vArr[3]) {
								fnGridEdit('purchaseReqGrid', ids[i], buying_Row_Click);
								$("#" + ids[i] + "_" + c).focus();
							}
						}
					}
				}
			}
		}
	}

	function btn_Modify_sub_onclick() {
		fnEditRelease('purchaseReqGrid');
		
		fnpop_updatePurchaseConfirmPop('purchaseReqGrid', 700, 360);
		
		/* var rowId = $('#purchaseReqGrid').getGridParam('selrow');
		if (rowId == null) {
			alert('선택된 행이 존재하지 않습니다.');
		} else {
			var row = $('#purchaseReqGrid').getRowData(rowId);
			if (row.master_yn == "일반") {
				var obj = new Object();
				obj.ids = row.mtlr_no;
				obj.msg1 = 'reagents/popUpdatePurchaseConfirm.lims?key=' + row.mtlr_no + '&mtlr_req_no=' + row.mtlr_req_no;
				var popup = fnShowModalWindow("popMain.lims", obj, 700, 360);
				if (popup == 'reloadGrid') {
					$('#purchaseReqGrid').trigger('reloadGrid');
				}
			} else {
				alert('마스터입니다.');
			}
		} */
	}

	// 구매리스트추가 등록팝업
	function btn_Reagents_Info_onclick() {
		//alert(mtlr_mst_no);
		if (mtlr_mst_no == null || mtlr_mst_no == "") {
			alert("구매 요청 리스트를 선택해 주세요.");
			return false;
		}
		fnEditRelease('purchaseReqGrid');
		
		fnBasicStartLoading();
		fnpop_popBuyingConfirmationManagePop('purchaseReqGrid', 1000, 788);
		
		/*  
		var rowId = $('#purchaseInfoGrid').getGridParam('selrow');
		// 		var reqId = $('#purchaseReqGrid').getGridParam('selrow');
		var reqId = $('#purchaseReqGrid').jqGrid("getDataIDs");
		var obj = new Object();

		obj.msg1 = 'reagents/popBuyingConfirmationManage.lims';
		obj.ids = rowId;
		obj.idsReq = reqId;

		var mtlr_no = $('#purchaseReqGrid').jqGrid("getDataIDs");

		for ( var j in mtlr_no) {
			var rowData = $('#purchaseReqGrid').jqGrid('getRowData', mtlr_no[j]);
			obj.idsReq[j] = rowData.mtlr_no;
			//alert(rowData.mtlr_no);
		}

		obj.rows = $("#purchaseReqGrid").jqGrid('getRowData');
		var popup = fnShowModalWindow("popMain.lims", obj, 1000, 788);
		if (popup != null) {
			for (var i = 0; i < popup.length; i++) {
				var row = popup[i];
				row.create_dept = deptNm;
				row.crud = 'c';
				row.icon = gridC;
				$('#purchaseReqGrid').jqGrid('addRowData', row.mtlr_no, row, 'last');
				if (row.appr_flag == 'C39001') { // 구매요청
					$('#btn_Save').show();
				}
			}
		} */
	}
	
	function fnpop_callback(returnValue){
		var popup = returnValue;
		if (popup != null) {
			for (var i = 0; i < popup.length; i++) {
				var row = popup[i];
				row.create_dept = deptNm;
				row.crud = 'c';
				row.icon = gridC;
				$('#purchaseReqGrid').jqGrid('addRowData', row.mtlr_no, row, 'last');
				if (row.appr_flag == 'C39001') { // 구매요청
					$('#btn_Save').show();
				}
			}
		}
	}

	// Validation 체크
	function buying_Row_Click(rowId) {
		var fix_qty_id = rowId + "_fix_qty";
		var cost_id = rowId + "_cost";

		// 확정수량
		$('#' + fix_qty_id).keyup(function() {
			var fixQty = $('#' + fix_qty_id).val();
			var cost = $('#' + cost_id).val();
			if (!fnIsNumeric(fixQty)) {
				alert("숫자만 입력가능합니다.");
				$('#' + fix_qty_id).val('');
			}

			if (fixQty == '0') {
				$('#' + fix_qty_id).val('');
			}
			fixQty = $('#' + fix_qty_id).val();
			var row = $('#purchaseReqGrid').getRowData(rowId);
			if (fixQty != '' && cost != '') {
				for (key in row) {
					$('#purchaseReqGrid').jqGrid('setCell', rowId, key, '', {
						color : 'blue'
					});
				}
			} else {
				for (key in row) {
					$('#purchaseReqGrid').jqGrid('setCell', rowId, key, '', {
						color : 'black'
					});
				}
			}
			$('#' + fix_qty_id).focus();
		});

		// 단가
		$('#' + cost_id).keyup(function() {
			var fixQty = $('#' + fix_qty_id).val();
			var cost = $('#' + cost_id).val();
			if (!fnIsNumeric(cost)) {
				alert("숫자만 입력가능합니다.");
				$('#' + cost_id).val('');
			}

			if (cost == '0') {
				$('#' + cost_id).val('');
			}
			cost = $('#' + cost_id).val();
			var row = $('#purchaseReqGrid').getRowData(rowId);
			if (fixQty != '' && cost != '') {
				for (key in row) {
					$('#purchaseReqGrid').jqGrid('setCell', rowId, key, '', {
						color : 'blue'
					});
				}
			} else {
				for (key in row) {
					$('#purchaseReqGrid').jqGrid('setCell', rowId, key, '', {
						color : 'black'
					});
				}
			}
			$('#' + cost_id).focus();
		});
	}

	// 엑셀다운로드
	function btn_Excel_onclick() {
		var url = location.host + location.pathname.substring(0, location.pathname.lastIndexOf('/', location.pathname.length - 1));
		ifrmexcel.location.href = "http://" + url + "/reagents/excelDownloadPurchaseConfirm.lims?mtlr_mst_no=" + $('#purchaseReqForm').find('#mtlr_mst_no').val();
		/* var grid = 'purchaseReqGrid';
		var arr = new Array();
		arr.push('chk');
		arr.push('icon');
		$('#' + grid).hideCol(arr);

		var data = fn_Excel_Data_Make(grid);
		fn_Excel_Download(data);
		$('#' + grid).showCol(arr);

		$(window).bind('resize', function() {
			$("#purchaseReqGrid").setGridWidth($('#view_grid_sub').width(), false);
		}).trigger('resize'); */
		// 		var data = fn_Excel_Data_Make('purchaseReqGrid');
		// 		fn_Excel_Download(data);
	}
	function btn_ExcelUpload_onclick() {
		$("#dialog").dialog({
			width : 320,
			height : 150,
			resizable : false,
			title : 'EXCEL 업로드',
			modal : true,
			open : function(event, ui) {
				$(window).bind('resize', function() {
					$("#userGrid").setGridWidth($('#view_grid_sub1').width(), true);
				}).trigger('resize');
			},
			buttons : [ {
				text : "업로드",
				click : function() {
					fnAjaxFileAction('reagents/excelUploadPurchaseConfirm.lims', 'excelForm', fn_suc);
				}
			}, {
				text : "취소",
				click : function() {
					$(this).dialog("destroy");
				}
			} ]
		});
	}
	function fn_suc(json) {
		if (json == null) {
			alert("업로드 실패하였습니다.");
		} else if (json == '1') {
			alert("업로드 성공하였습니다.");
			$('#m_file').val('');
			$('#dialog').dialog("destroy");
			btn_Select_onclick();
		} else {
			alert(json);
		}
	}
	
/* 	// 부서 & 사업소 선택
	function fn_show_type(req_dept_office) {
		var th = 'typeThSearch';
		var form = 'purchaseReqForm';
		
		//alert(req_dept_office);
		
		if(req_dept_office == 'd'){
			//$('#' + th).text('요청부서명');
			$('#' + form).find("#dept_cd").show();
			$('#' + form).find("#office_cd").hide();
			$('#' + form).find("#office_cd").val('');
		}else{
			//$('#' + th).text('요청사업소명');
			$('#' + form).find("#dept_cd").hide();
			$('#' + form).find("#office_cd").show();
			$('#' + form).find("#dept_cd").val('');
		}
	}	 */
</script>

<!-- 구매정보목록 그리드 -->
<div class="sub_purple_01 w100p" id="view_grid_main">
	<form id="purchaseInfoForm" name="purchaseInfoForm" onsubmit="return false;">
		<table  class="select_table" >
			<tr>
				<td class="table_title">
					<span>■</span>
					구매 정보 목록
				</td>
				<td class="table_button">
					<span class="button white mlargep auth_select" id="btn_Select" onclick="btn_Select_onclick();">
						<button type="button">조회</button>
					</span>
					<span class="button white mlargeg auth_save" onclick="btn_Confirm_onclick();" id="btn_confirm">
						<button type="button">구매확정</button>
					</span>
				</td>
			</tr>
		</table>
		<table  class="list_table" >
			<tr>
				<th>진행상태</th>
				<td>
					<select id="buy_sts" name="buy_sts" class="w120px"></select>
				</td>
				<th>구매명칭</th>
				<td>
					<input id="buy_title" name="buy_title" type="text" class="w300px" />
				</td>
				<th>구매년도</th>
				<td>
					<select name="buy_year" id="sel_buy_year" class="w120px"></select>
					<!-- 					<input id="buy_year" name="buy_year" value="" type="text" style="width: 120px;" /> -->
				</td>
				<th>구매분기</th>
				<td>
					<input id="buy_q_val" type="hidden" class="inputhan" value="${detail.buy_q}" />
					<select id="buy_q" name="buy_q" style="border: 1px solid #afafaf;" class="w120px"></select>
				</td>
			</tr>
		</table>
		<input type="hidden" id="sortName" name="sortName">
		<input type="hidden" id="sortType" name="sortType">
		<table id="purchaseInfoGrid"></table>
	</form>
</div>

<!-- 구매요청목록 그리드 -->
<div class="sub_blue_01 w100p" id="view_grid_sub">
	<form id="purchaseReqForm" name="purchaseReqForm" onsubmit="return false;">
		<table border="0" class="select_table" >
			<tr>
				<td class="table_title">
					<span>■</span>
					구매 요청 목록
				</td>
				<td class="table_button">					
					<span class="button white mlargeb auth_select" id="btn_Select" onclick="btn_Search_sub_onclick();">
						<button type="button">조회</button>
					</span>
					<span class="button white mlargeg auth_save" onclick="btn_Save_sub_onclick();" id="btn_save">
						<button type="button">저장</button>
					</span>
<!-- 					<span class="button white mlargeg auth_save" onclick="btn_Reagents_Info_onclick();" id="btn_add">
						<button type="button">추가</button>
					</span>
					<span class="button white mlarger auth_save" onclick="btn_Modify_sub_onclick();" id="btn_update">
						<button type="button">수정</button>
					</span> -->
					<span class="button white mlargeb auth_save" onclick="btn_ExcelUpload_onclick();">
						<button type="button">EXCEL 업로드</button>
					</span>
					<span class="button white mlargeb auth_save" onclick="btn_Excel_onclick();" id="btn_excel">
						<button type="button">EXCEL 다운</button>
					</span>
				</td>
			</tr>
		</table>
		<table  class="list_table" >
			<tr>
				<th>대분류</th>
				<td>
					<select name="h_mtlr_info" id="h_mtlr_info" style="width: 80px" onchange="comboReload()">
						<option value=" ">전체</option>
						<option value="C42">시약류</option>
						<option value="C43">소모품류</option>
					</select>
				</td>
				<th>중분류</th>
				<td>
					<select name="m_mtlr_info" id="m_mtlr_info" style="width: 90px"></select>
				</td>				
				<th id="typeThSearch">
<!-- 					<input name="req_dept_office" id="req_dept_office" type="radio" value="d" checked="checked" onClick="fn_show_type($(this).val())"/> -->
					<label for="req_dept_office">요청부서명</label>
<!-- 					<input name="req_dept_office" id="req_dept_office2" type="radio" value="o" onClick="fn_show_type($(this).val())"/> -->
<!-- 					<label for="req_dept_office2">요청사업소명</label> -->
				</th>
				<td>
					<select name="dept_cd" id="dept_cd" class="w120px"></select>
<!-- 					<select name="office_cd" id="office_cd" class="w120px"></select> -->
				</td>				
			</tr>
			<tr>
				<th>시약실험기구명</th>
				<td>
					<input id="item_kor_nm" name="item_kor_nm" type="text" style="width: 300px;" />
				</td>
				<th>Cas no.</th>
				<td colspan="3">
					<input id="spec2" name="spec2" type="text" style="width: 300px;" />
				</td>
			</tr>
		</table>
		<input type="hidden" id="sortName" name="sortName">
		<input type="hidden" id="sortType" name="sortType">
		<input type="hidden" id="mtlr_mst_no" name="mtlr_mst_no">
		<table id="purchaseReqGrid"></table>
	</form>
</div>

<div id="dialog" style="display: none;">
	<div class="sub_blue_01 w100p">
		<form id="excelForm" name="excelForm" onsubmit="return false;">
			<input type="file" id="m_file" name="m_file">
		</form>
	</div>
</div>
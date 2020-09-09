<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	/***************************************************************************************
	 * 시스템명 	: 통합장비관제시스템
	 * 업무명 		: 수수료입금확인
	 * 파일명 		: commissiontCheckL01.jsp
	 * 작성자 		: 허태원
	 * 작성일 		: 2015.10.16
	 * 설  명		: 수수료입금확인 리스트 화면
	 *---------------------------------------------------------------------------------------
	 * 변경일		 변경자		변경내역 
	 *---------------------------------------------------------------------------------------
	 * 2015.10.16    허태원		최초 프로그램 작성         
	 * 
	 *---------------------------------------------------------------------------------------
	 ****************************************************************************************/
%>
<link rel="stylesheet" media="screen" type="text/css" href="<c:url value='/css/common/sub.css'/>" />
<style>
input[type=text] {
	ime-mode: active;
}
</style>
<script type="text/javascript">
	var fnGridInit = false;
	var fnGridSubInit = false;
	var payment_method;
	$(function() {
		/* 세부권한검사 */
		fn_auth_check();
		
		fnDatePickerImg('startDate');
		fnDatePickerImg('endDate');
		
		fnDatePickerImg('depositSdate');
		fnDatePickerImg('depositEdate');
		
		fnDatePickerImg('taxSdate');
		fnDatePickerImg('taxEdate');
		
		fnDatePickerImg('deposit_date');
		fnDatePickerImg('tax_invoice_date');
		
		$('#btn_Deposit').hide();
		
		//업체목록
		commissionOrgGrid('accept/selectCommissionCheckList.lims', 'commissionOrgForm', 'commissionOrgGrid');
		$('#commissionOrgGrid').clearGridData(); // 최초 조회시 데이터 안나옴
		
		payment_method = fnGridCommonCombo("C88", "ALL");
		
		//그리드 사이즈 
	 	$(window).bind('resize', function() { 
		    $("#commissionOrgGrid").setGridWidth($('#view_grid_top').width(), false); 
		}).trigger('resize');
		
	 	//업체 상세목록
	 	commissionDetailGrid('accept/selectCommissionDetailList.lims', 'commissionDetailForm', 'commissionDetailGrid');		
		//그리드 사이즈 
	 	$(window).bind('resize', function() { 
		    $("#commissionDetailGrid").setGridWidth($('#view_grid_middle').width(), false); 
		}).trigger('resize');		
		
		// 엔터키 눌렀을 경우
		fn_Enter_Search('commissionOrgForm', 'commissionOrgGrid');
		
	 	// 엔터키 눌렀을 경우
	 	fn_Enter_Search('commissionDetailForm', 'commissionDetailGrid');
		

	});
	
	//업체목록
	function commissionOrgGrid(url, form, grid) {
		$('#' + grid).jqGrid({
			datatype : function(json) {
				fnGridInit ? fn_GridData(url, form, grid) : fnGridInit = true;
			},
			height : '230',
			autowidth : true,
			gridview : true,
			shrinkToFit : true,
			rowNum : 10000,
			rownumbers : true,
			//pager : "#"+grid+"Pager",
			footerrow: true, 
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
				label : 'row_num',
				name : 'row_num',
				hidden : true,
				key : true
			}, {
				label : '업체번호',
				name : 'req_org_no',
				hidden : true
			}, {
				label : '계산서업체번호',
				name : 'req_org_no3',
				hidden : true
			}, {
				label : '업체구분',
				name : 'org_type',
				align : 'center',
				width : '100'
			}, {
				label : '업체명',
				name : 'tax_req_org_nm',
				width : '200',
				align : 'center'
			}, {
				label : '사업자등록번호',
				name : 'tax_biz_no',
				width : '100',
				align : 'center'
			}, {
				label : '업체명',
				name : 'org_nm',
				width : '200',
				align : 'center'
			}, {
				label : '사업자등록번호',
				name : 'req_biz_no',
				width : '100',
				align : 'center'
			}, {
				label : '총수수료(원)',
				name : 'commission_amt_tot',
				width : '100',
				formatter : 'integer',
				formatoptions : {
					thousandsSeparator : ","
				},
				align : 'right'
			}, {
				label : '완납금액(원)',
				name : 'deposit_amt_tot',
				width : '100',
				formatter : 'integer',
				formatoptions : {
					thousandsSeparator : ","
				},
				align : 'right'
			}, {
				label : '미납금액(원)',
				name : 'default_amt_tot',
				width : '100',
				formatter : 'integer',
				formatoptions : {
					thousandsSeparator : ","
				},
				align : 'right'
			}, {
				label : '설명',
				name : 'org_desc',
				width : '150',
				align : 'center'
			}, {
				label : '대표전화',
				name : 'pre_tel_num',
				width : '100',
				align : 'center'
			}, {
				label : '담당자',
				name : 'req_nm',
				align : 'center',
				width : '80'
			}, {
				label : '담당자전화번호',
				name : 'req_tel',
				width : '120',
				align : 'center'	
			} ],
			gridComplete : function() {
				var sum1 = $("#" + grid).jqGrid('getCol', 'commission_amt_tot', false, 'sum');
				var sum2 = $("#" + grid).jqGrid('getCol', 'deposit_amt_tot', false, 'sum');
				var sum3 = $("#" + grid).jqGrid('getCol', 'default_amt_tot', false, 'sum');
				$("#" + grid).jqGrid('footerData', 'set', {req_biz_no: '합&nbsp;&nbsp;계 : ', commission_amt_tot:sum1, deposit_amt_tot:sum2,default_amt_tot:sum3} );
				
				$('#gbox_commissionOrgGrid table.ui-jqgrid-ftable tr:first').children('td').css('background-color', '#dfeffc');	
				$('#gbox_commissionOrgGrid table.ui-jqgrid-ftable tr:first').children('td').css('font-weight', 'normal'); 		
				
			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
			},
			onSelectRow : function(rowId, status, e) {
				sOrg_Cls = $("#commissionOrgForm input[type='radio'][name=org_cls]:checked").val();
				sReq_Org_No = '';
				sSave_Req_Org_No = '';
				sSave_Req_Org_No = $('#commissionOrgGrid').getRowData(rowId).req_org_no;
				if (sOrg_Cls == 'REQ'){
					sReq_Org_No = $('#commissionOrgGrid').getRowData(rowId).req_org_no;
				}else if (sOrg_Cls == 'TAX'){
					sReq_Org_No = $('#commissionOrgGrid').getRowData(rowId).req_org_no3;
				}else{
					$.showAlert("업체구분을 선택해주세요.");
				}
				$("#commissionDetailForm").find("#org_cls").val(sOrg_Cls);
				$("#commissionDetailForm").find("#req_org_no").val(sReq_Org_No);
				$("#commissionDetailForm").find("#save_req_org_no").val(sSave_Req_Org_No);
				$("#commissionDetailGrid").trigger('reloadGrid');
			}
		});
		
		$('#' + grid).jqGrid('setGroupHeaders', {
			useColSpanStyle : true,
			groupHeaders : [ {
				startColumnName : 'tax_req_org_nm',
				numberOfColumns : 2,
				titleText : '세금계산서발행처'
			},{
				startColumnName : 'org_nm',
				numberOfColumns : 2,
				titleText : '의뢰업체'
			} ]
		});
	}
	
	//의뢰 목록
	var lastRowId;
	function commissionDetailGrid(url, form, grid) {
		$('#' + grid).jqGrid({
			datatype : function(json) {
				fnGridSubInit ? fn_GridData(url, form, grid) : fnGridSubInit = true;
			},
			height : '230',
			autowidth : true,
			loadonce : true,
			mtype : "POST",
			gridview : true,
			shrinkToFit : true,
			rowNum : -1,
			rownumbers : true,
			colModel : [ {
				type : 'not',
				label : ' ',
				name : 'icon',
				width : '20',
				align : 'center',
				sortable : false,
				frozen : true
			}, {
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
				label : '접수번호',
				name : 'test_req_no',
				align : 'center',
				width : '100'
			}, {
				label : 'crud',
				name : 'crud',
				hidden : true,
				frozen : true
			}, {
				label : 'test_req_seq',
				name : 'test_req_seq',
				hidden : true,
				key : true
			}, {
				label : '제목',
				name : 'title',
				width : '150',
				align : 'center'
			}, {
				label : '검체명',
				name : 'sample_reg_nm',
				width : '100',
				align : 'center'
			}, {
				label : '품목명',
				name : 'prdlst_nm',
				width : '100',
				align : 'center'
			}, {
				label : '의뢰자',
				name : 'req_nm',
				align : 'center',
				width : '80'
			}, {
				label : '접수일자',
				name : 'sample_arrival_date',
				align : 'center',
				width : '80'
			}, {
				label : '진행상태',
				name : 'state',
				align : 'center',
				width : '100'
			}, {
				label : '수수료(원)',
				name : 'commission_amt_det',
				width : '100',
				formatter : 'integer',
				formatoptions : {
					thousandsSeparator : ","
				},
				align : 'right'
			}, {
				label : '입금액(원)',
				name : 'deposit_amt',
				width : '100',
				formatter : 'integer',
				formatoptions : {
					thousandsSeparator : ","
				},
				align : 'right'
			}, {
				label : '미납금액(원)',
				name : 'default_amt',
				width : '100',
				formatter : 'integer',
				formatoptions : {
					thousandsSeparator : ","
				},
				align : 'right'
			}, {
				label : '입금일자',
				name : 'deposit_date',
				width : '100',
				align : 'center',
				editable : true,
				editoptions : {
					dataInit : function(elem) {
						fnDatePicker(elem.getAttribute('id'));
					},
					readonly : "readonly"
				},
				align : 'center'
			}, {
				type : 'not',
				label : ' ',
				name : 'deposit_date_del',
				sortable : false,
				width : '20',
				align : 'center',
				formatter : deleteImageFormat
			}, {
				label : '납부확인',
				name : 'commission_amt_flag',
				width : '100',
				align : 'center',
				editable : true,
				editoptions : {
					value : 'Y:완납;N:미납;'
				},
				formatter : 'select'
			}, {
				label : '결제방법',
				name : 'payment_method',
				width : '80',
				align : 'center',
				edittype : "select",
				editable : true,
				editoptions : {
					value : payment_method
				},
				formatter : 'select'			
			}, {
				label : '발행여부',
				name : 'tax_invoice_flag',
				width : '80',
				align : 'center',
				edittype : "select",
				editable : true,
				editoptions : {
					value : 'Y:발행;N:미발행'
				},
				formatter : 'select'				
			}, {
				label : '발행일자',
				name : 'tax_invoice_date',
				width : '100',
				align : 'center',
				editable : true,
				editoptions : {
					dataInit : function(elem) {
						fnDatePicker(elem.getAttribute('id'));
					},
					readonly : "readonly"
				}
			}, {
				type : 'not',
				label : ' ',
				name : 'tax_invoice_date_del',
				sortable : false,
				width : '20',
				align : 'center',
				formatter : deleteImageFormat
			}, {
				label : '성적서발행일',
				width : '100',
				align : 'center',
				name : 'last_report_date'
			}],
			emptyrecords : '데이터가 존재하지 않습니다.',
			gridComplete : function() {
			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
				if (!confirm('저장하지 않은 정보는 사라집니다. 정렬하시겠습니까?')) {
					return 'stop';
				}
			},
			onCellSelect : function(rowId, iCol, cellcontent, e) {
				var colArr = $('#' + grid).jqGrid('getGridParam', 'colModel');
				var col = colArr[iCol].name;
				
				if (col == 'deposit_date_del') {
					$('#' + grid).jqGrid('setCell', rowId, 'deposit_date', null);
					commissionDetailGridEdit(grid, rowId);
				} else if (col == 'tax_invoice_date_del'){
					$('#' + grid).jqGrid('setCell', rowId, 'tax_invoice_date', null);
					commissionDetailGridEdit(grid, rowId);
				}
			},
			onSelectRow : function(rowId, status, e) {
				
				$('#commissionDetailForm').find('#test_seq_req').val(jQuery("#"+grid).jqGrid('getGridParam','selarrrow'));
				
				if (rowId && rowId != lastRowId) {
					fnEditRelease(grid);
					lastRowId = rowId;
				}
			},
			ondblClickRow : function(rowId, iRow, iCol, e) {
				fnEditRelease(grid);
				commissionDetailGridEdit(grid, rowId);
				var colArr = $('#' + grid).jqGrid('getGridParam', 'colModel');
				$('#' + rowId + '_' + colArr[iCol].name).focus();				
			}
		});
		$('#' + grid).jqGrid('setGroupHeaders', {
			useColSpanStyle : true,
			groupHeaders : [ {
				startColumnName : 'tax_invoice_flag',
				numberOfColumns : 2,
				titleText : '세금계산서'
			} ]
		});
	}
	
	// 업체목록 조회버튼 클릭 이벤트
	function btn_Search_onclick(){		
		$('#commissionOrgGrid').setGridParam({page: 1});
		$('#commissionOrgGrid').trigger('reloadGrid');
		$("#commissionDetailForm").find("#req_org_no").val('');
		//$('#commissionDetailGrid').trigger('reloadGrid');

		var rowId = $('#commissionDetailGrid').getGridParam('selrow');
		
		$('#reqListGrid').trigger('reloadGrid');
	}
	
	//의뢰목록 조회
	function btn_Search_Sub_onclick(){
		
		var rowId = $('#commissionDetailGrid').getGridParam('selrow');
		
		var req_org_no = $("#commissionDetailForm").find("#req_org_no").val();
		
		if(req_org_no != null && req_org_no != ''){
			$('#commissionDetailGrid').trigger('reloadGrid');	
		}else{
			alert('업체를 선택하여 주십시오.');
			return;
		}		
	}
	
	// 에디트모드
	function commissionDetailGridEdit(grid, rowId) {		
		var row = $('#' + grid).getRowData(rowId);
		
		if (row.crud != 'n') {
			$('#' + grid).setCell(rowId, 'icon', gridU);
			$('#' + grid).setCell(rowId, 'crud', 'u');
		}
		editable('');
	}
	
	// 업데이트 아이콘 생성
	function commissionDetailGridEditCell(grid, rowId) {
		var row = $('#' + grid).getRowData(rowId);
		if (row.crud != 'n') {
			$('#' + grid).setCell(rowId, 'icon', gridU);
			$('#' + grid).setCell(rowId, 'crud', 'u');
		}
	}
	
	// 셀 수정 여부
	function editable(e) {
		var grid = 'commissionDetailGrid';
		var rowId = $('#' + grid).jqGrid('getGridParam', 'selrow');
		var arr = new Array();
		// 결과값형태
		var row = $("#" + grid).jqGrid('getRowData', rowId);
		arr.push('deposit_amt');
		arr.push('deposit_date');
		arr.push('tax_invoice_flag');
		arr.push('tax_invoice_date');
		arr.push('payment_method');

		for ( var column in row) {
			if ($.inArray(column, arr) !== -1) {
				$("#" + grid).jqGrid('setColProp', column, {
					editable : true
				});
			} else {
				$("#" + grid).jqGrid('setColProp', column, {
					editable : false
				});
			}
		}
		if (e != '') {
			for ( var column in row)
				if (column != 'test_item_nm' && column != 'test_item_cd' && column != 'crud' && column != 'icon')
					$("#" + grid).jqGrid('setCell', rowId, column, null);
		}
		$("#" + grid).jqGrid('editRow', rowId);
	}
	
	// CRUD 체크
	function editCount() {
		var grid = 'commissionDetailGrid';
		var check = false;
		var ids = $('#' + grid).jqGrid("getDataIDs");
		for ( var i in ids) {
			var row = $('#' + grid).getRowData(ids[i]);
			if (row.crud == 'n' || row.crud == 'd' || row.crud == 'u')
				check = true;
		}
		return check;
	}
	
	//납부 저장
	function btn_Insert_onclick(){
		var grid = 'commissionDetailGrid';
		fnEditRelease(grid);
		var data;
		var ids = $('#' + grid).jqGrid("getDataIDs");
		if (ids.length > 0) {
			data = fnGetGridAllData(grid);
		} else {
			alert("의뢰 목록이 존재하지 않습니다.");
			return;
		}
		
		/* if (!editCount()) {
			alert("변경된 의뢰 목록이 없습니다.");
			return;
		} */
		
		var b = true;
		var b2 = true;
		var b3 = true;
		if (ids.length > 0) {
			for ( var i in ids) {
				var row = $('#' + grid).getRowData(ids[i]);
				if (row.crud == 'u' && parseInt(row.commission_amt_det) < parseInt(row.deposit_amt)) {
					b = false;
				}
				if(row.crud == 'u' && parseInt(row.commission_amt_det) == 0){
				//	b2 = false;
				}
				if(parseInt(row.crud != 'u' && row.default_amt) < 0){
					b3 = false;
				}
			}
		}
		
		if(!b2){
			alert('선택된 의뢰는 입금할 수수료가 없습니다.');
			return;
		}else if(!b){
			alert('입금액이 수수료보다 큽니다.');
			return;
		}else if(!b3){
			alert('입금액이 초과되었습니다.');
			return;
		}else{
			data += '&req_org_no=' + $("#commissionDetailForm").find("#save_req_org_no").val();
			
			var json = fnAjaxAction('accept/saveCommissionDeposit.lims', data);
			if (json == null) {
				$.showAlert("저장 실패하였습니다.");
			} else {
				$.showAlert("", {
					type : 'insert'
				});
				btn_Search_Sub_onclick();
			}
		}
	}
	
	// 엑셀 다운로드
	function btn_Excel_onclick() {
		var bigDivName = null;
		var bigDivData = null;
		var rowId = $('#commissionOrgGrid').getGridParam('selrow');  
		var row = $('#commissionOrgGrid').getRowData(rowId);
		bigDivName = '업체명';
		bigDivData = row.org_nm;
		var data = fn_Excel_Data_Make('commissionDetailGrid', bigDivName, bigDivData);
		fn_Excel_Download(data);
	}

	function btn_Receipt_onclick() {
		var grid = 'commissionDetailGrid';		
		var rowId = $('#'+grid).getGridParam('selrow');
		
		if (rowId != null) {
			$("#dialog").dialog({
				width : 660,
				height : 130,
				resizable : false,
				title : '출력물 개정 정보',
				modal : true,
				open : function(event, ui) {
					$(".ui-dialog-titlebar-close").hide();
					var data = "printGbn=C60007";
					fnViewPage('/revisionPop.lims', 'dialog', data);
				},
				buttons : [
				{
					text : "미리보기",
					click : function() {
						// 필수 체크
						if(formValidationCheck("revisionPopForm")){			
							return;
						} else {
							var fileNm = $("#revisionPopForm").find("#doc_seq").val() + "_V" 
									   + $("#revisionPopForm").find("#doc_seq option:checked").text() + ".mrd";
							
						  	var test_req_seq = $('#commissionDetailGrid').getGridParam('selrow'); 
							
							html5Viewer(fileNm, "/rp ["+test_req_seq+"] " , false);
							
						}
					}
				},  
				{
					text : "출력",
					click : function() {
						var fileNm = $("#revisionPopForm").find("#doc_seq").val() + "_V" 
						   + $("#revisionPopForm").find("#doc_seq option:checked").text() + ".mrd";
						
					  	var test_req_seq = $('#commissionDetailGrid').getGridParam('selrow'); 
						
						html5Viewer(fileNm, "/rp ["+test_req_seq+"] " , false);
					}
				}, 
				{
					text : "취소",
					click : function() {
						$('#dialog').dialog("destroy");
					}
				}]
			});
		} else {
			$.showAlert('선택된 행이 없습니다.');
		}
		
	}

	function btn_Transaction_onclick(arg) {
		var grid = 'commissionDetailGrid';
		var data = "";
		var ids = $('#' + grid).jqGrid("getDataIDs");
		if (ids.length > 0) {
			for ( var i in ids) {
				var row = $('#' + grid).getRowData(ids[i]);				
				data += row.test_req_seq + ',';
			}
			data = data.substr(0, data.length - 1);
		} else {
			alert("출력대상이 존재하지 않습니다.");
			return;
		}
		var url = "";
		if(arg == "A"){
			url = "transactionDetails.lims?req_org_no=" + $("#commissionDetailForm").find("#req_org_no").val()+"&test_req_seq="+data+"&doc_seq=16-036"+"&org_cls="+sOrg_Cls;
		}else{
			url = "transactionStatement.lims?req_org_no=" + $("#commissionDetailForm").find("#req_org_no").val()+"&test_req_seq="+data+"&doc_seq=16-037"+"&org_cls="+sOrg_Cls;
		}
		$('#excelReportForm').attr({action:url, method:'post'}).submit();
	}	
	
	//일괄저장 적용버튼
	function btn_lumpApply_onclick() {
		var grid = 'commissionDetailGrid';
		var ids = $('#' + grid).jqGrid("getDataIDs");
		var rowCnt = 0;

		for ( var i in ids) {
			var row = $('#' + grid).getRowData(ids[i]);
			if (row.chk == 'Yes') {
				rowCnt++;
			}
		}

		if (rowCnt == 0) {
			alert("선택된 항목이 없습니다.");
			return;
		} else {
			var deposit_amt = $('#lumpApplyForm').find('#deposit_amt').val();
			var deposit_date = $('#lumpApplyForm').find('#deposit_date').val();
			var tax_invoice_flag = $('#lumpApplyForm').find('#tax_invoice_flag').val();
			var tax_invoice_date = $('#lumpApplyForm').find('#tax_invoice_date').val();
			
			var nids = $('#' + grid).jqGrid("getDataIDs");
			
			for ( var j in nids) {
				var nrow = $('#' + grid).getRowData(nids[j]);				
				if (nrow.chk == 'Yes') {					
					$('#' + grid).jqGrid('setCell', nids[j], 'deposit_amt', deposit_amt);					
					$('#' + grid).jqGrid('setCell', nids[j], 'deposit_date', deposit_date);
					$('#' + grid).jqGrid('setCell', nids[j], 'tax_invoice_flag', tax_invoice_flag);
					$('#' + grid).jqGrid('setCell', nids[j], 'tax_invoice_date', tax_invoice_date);
					commissionDetailGridEdit(grid, nids[j]);
				}
			}
						
		}
	}
	
	
</script>
<div>
	<form id="commissionOrgForm" name="commissionOrgForm" onsubmit="return false;">
		<div class="sub_purple_01">
			<table class="select_table" >
			<tr>
				<td class="table_title">
					<span>■</span>
					업체목록
				</td>
				<td class="table_button">
					<span class="button white mlargep auth_select" id="btn_Select" onclick="btn_Search_onclick();">
						<button type="button">조회</button>
					</span>
				</td>
			</tr>
		</table>
		<table class="list_table" >
			<tr>
				<th>업체구분</th>
				<td width="25%">
					<label><input type='radio' id="org_cls" name='org_cls' value='TAX' style="width: 20px" checked />세금계산서발행처</label> 
					<label><input type='radio' id="org_cls" name='org_cls' value='REQ' style="width: 20px" />의뢰처</label>
				</td>
				<th>업체명</th>
				<td>
					<input name="org_nm" type="text" class="inputhan" class='w300px' />
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
		<div id="view_grid_top">
			<table id="commissionOrgGrid"></table>
			<div id="commissionOrgGridPager"></div>
		</div>
	</form>
	
	<form id="commissionDetailForm" name="commissionDetailForm" onsubmit="return false;">
		<div class="sub_purple_01">
			<table class="select_table" >
			<tr>
				<td class="table_title">
					<span>■</span>
					의뢰목록
				</td>
				<td class="table_button">
					<span class="button white mlargep auth_select" id="btn_Select" onclick="btn_Search_Sub_onclick();">
						<button type="button">조회</button>
					</span>
					<span class="button white mlargeg auth_save" id="btn_Insert_" onclick="btn_Insert_onclick();">
						<button type="button">저장</button>
					</span>
					<span class="button white mlargeb auth_select" onclick="btn_Receipt_onclick();">
						<button type="button">접수증</button>
					</span>
					<!-- <span class="button white mlargeb auth_select" onclick="btn_Transaction_onclick('A');">
						<button type="button">거래내역서</button>
					</span>
					<span class="button white mlargeb auth_select" onclick="btn_Transaction_onclick('B');">
						<button type="button">거래명세서</button>
					</span> -->
					<span class="button white mlargeb auth_select" onclick="btn_Excel_onclick();">
						<button type="button">EXCEL</button>
					</span>
				</td>
			</tr>
		</table>
		<table class="list_table" >
			<tr>
				<th>접수번호</th>
				<td>
					<input name="test_req_no" type="text" class="inputhan" class='w300px' />
				</td>
				<th>접수일자</th>
				<td>
					<input name="startDate" id="startDate" type="text" class="w80px" readonly="readonly" />
					<img src="<c:url value='/images/common/calendar_del.png'/>" id="startDateStop" style="cursor: pointer;" onClick='fn_TextClear("startDate")' /> ~
					<input name="endDate" id="endDate" type="text" class="w80px" readonly="readonly" />
					<img src="<c:url value='/images/common/calendar_del.png'/>" id="endDateStop" style="cursor: pointer;" onClick='fn_TextClear("endDate")' />
				</td>
				<th>진행상태</th>
				<td>
					<select name="state" id="state" class="w100px">
						<option value="">전체</option>
						<option value="A">의뢰</option>
						<option value="Z">접수대기</option>
						<option value="B">접수완료</option>
						<option value="C">결과입력완료</option>
						<option value="D">결과확인완료</option>
						<option value="E">결과승인대기</option>
						<option value="F">결과승인완료</option>
					</select>
				</td>
			</tr>
			<tr>
				<th>입금일자</th>
				<td>
					<input name="depositSdate" id="depositSdate" type="text" class="w80px" readonly="readonly" />
					<img src="<c:url value='/images/common/calendar_del.png'/>" id="depositSdateStop" style="cursor: pointer;" onClick='fn_TextClear("depositSdate")' /> ~
					<input name="depositEdate" id="depositEdate" type="text" class="w80px" readonly="readonly" />
					<img src="<c:url value='/images/common/calendar_del.png'/>" id="depositEdateStop" style="cursor: pointer;" onClick='fn_TextClear("depositEdate")' />
				</td>
				<th>세금계산서 발행일자</th>
				<td>
					<input name="taxSdate" id="taxSdate" type="text" class="w80px" readonly="readonly" />
					<img src="<c:url value='/images/common/calendar_del.png'/>" id="taxSdateStop" style="cursor: pointer;" onClick='fn_TextClear("taxSdate")' /> ~
					<input name="taxEdate" id="taxEdate" type="text" class="w80px" readonly="readonly" />
					<img src="<c:url value='/images/common/calendar_del.png'/>" id="taxEdateStop" style="cursor: pointer;" onClick='fn_TextClear("taxEdate")' />
				</td>
				<th>입금상태</th>
				<td>
					<select name="commission_amt_flag" id="commission_amt_flag" class="w100px">
						<option value="">전체</option>
						<option value="Y">완납</option>
						<option value="N">미납</option>
					</select>
				</td>
			</tr>
			<tr>
				<th>세금계산서발행여부</th>
				<td>
					<select name="tax_invoice_flag" id="tax_invoice_flag" class="w100px">
						<option value="">전체</option>
						<option value="Y">발행</option>
						<option value="N">미발행</option>
					</select>
				</td>
				<th>의뢰자명</th>
				<td>
					<input name="req_nm" type="text" class="inputhan" class='w300px' />
				</td>
			</tr>
		</table>
		</div>	
		<input type="hidden" id="sortName" name="sortName">
		<input type="hidden" id="sortType" name="sortType">
		<input type="hidden" id="req_org_no" name="req_org_no">
		<input type="hidden" id="save_req_org_no" name="save_req_org_no">
		<input type='hidden' id='org_cls' name='org_cls'/>
 		<div id="view_grid_middle">
			<table id="commissionDetailGrid"></table>
		</div> 
	</form>
	<form id="excelReportForm" name="excelReportForm"></form>
</div>

<div class="sub_purple_01 w100p">
	<form id="lumpApplyForm" name="lumpApplyForm" onsubmit="return false;">
		<table width="100%" border="0" class="select_table">
			<tr>
				<td width="20%" class="table_title">
					<span>■</span>
					일괄입력
				</td>
				<td class="table_button" style="text-align: right; padding-right: 30px;">
					<span class="button white mlargeg auth_select" id="btn_lumpApply" onclick="btn_lumpApply_onclick();">
						<button type="button">적용</button>
					</span>
				</td>
			</tr>
		</table>
		<table width="100%" border="0" class="list_table">
			<tr>
				<th>입금액(원)</th>
				<td>
					<input name="deposit_amt" id="deposit_amt" type="text" class="w100px" value="" />
				</td>
				<th>입금일자</th>
				<td>
					<input name="deposit_date" id="deposit_date" type="text" class="w80px" readonly="readonly" />
					<img src="<c:url value='/images/common/calendar_del.png'/>" id="depositdateStop" style="cursor: pointer;" onClick='fn_TextClear("deposit_date")' />
				</td>
				<th>세금계산서발행여부</th>
				<td>
					<select name="tax_invoice_flag" id="tax_invoice_flag" class="w100px">
						<option value="">전체</option>
						<option value="Y">발행</option>
						<option value="N">미발행</option>
					</select>
				</td>
				<th>세금계산서발행일자</th>
				<td>
					<input name="tax_invoice_date" id="tax_invoice_date" type="text" class="w80px" readonly="readonly" />
					<img src="<c:url value='/images/common/calendar_del.png'/>" id="tax_invoice_dateStop" style="cursor: pointer;" onClick='fn_TextClear("tax_invoice_date")' />
				</td>
			</tr>
		</table>
	</form>
</div>

<div id="dialog"></div>
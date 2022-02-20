
<%
	/***************************************************************************************
	 * 시스템명 	: 대덕분석기술연구소
	 * 업무명 		: 전자세금계산서발행
	 * 파일명 		: commissionTaxInvoicePop.jsp
	 * 작성자 		: 송성수
	 * 작성일 		: 2015.02.26
	 * 설  명		: 
	 *---------------------------------------------------------------------------------------
	 * 변경일		 변경자		변경내역 
	 *---------------------------------------------------------------------------------------
	 * 2019.11.11  송성수		최초 프로그램 작성         
	 *---------------------------------------------------------------------------------------
	 ****************************************************************************************/
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<jsp:useBean id="currentDate" class="java.util.Date" />
<fmt:formatDate var="now" value="${currentDate}" pattern="YYYY-MM-dd" />

<!DOCTYPE html>
<html id="popHtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<link rel="stylesheet" media="screen" type="text/css" href="<c:url value='/css/jquery-ui.css'/>" />
<link rel="stylesheet" media="screen" type="text/css" href="<c:url value='/css/jqgrid/ui.jqgrid.css'/>" />
<link rel="stylesheet" media="screen" type="text/css" href="<c:url value='/css/common/common.css'/>" />
<link rel="stylesheet" media="screen" type="text/css" href="<c:url value='/css/common/sub.css'/>" />

<script type="text/javascript" src="<c:url value='/script/jquery-1.11.0.min.js?time=${now}'/>"></script>
<script type="text/javascript" src="<c:url value='/script/jquery-ui.min.js?time=${now}'/>"></script>
<script type="text/javascript" src="<c:url value='/script/jquery.blockUI.js?time=${now}'/>"></script>
<script type="text/javascript" src="<c:url value='/script/jquery.form.js?time=${now}'/>"></script>
<script type="text/javascript" src="<c:url value='/script/jquery.message.js?time=${now}'/>"></script>
<script type="text/javascript" src="<c:url value='/script/jqgrid/grid.locale-kr.js?time=${now}'/>"></script>
<script type="text/javascript" src="<c:url value='/script/jqgrid/jquery.jqGrid.min.js?time=${now}'/>"></script>
<script type="text/javascript" src="<c:url value='/script/lims.com.js?time=${now}'/>"></script>
<script type="text/javascript" src="<c:url value='/script/lims.com.grid.js?time=${now}'/>"></script>

<title>대덕분석기술연구소 실험실정보관리시스템</title>

<script type="text/javascript">
	var fnGridInit = false;

	$(function() {
		//업체 상세목록
	 	commissionTaxGrid('selectListCommissionTaxInvoiceListSmp.lims', 'commissionTaxForm', 'commissionTaxGrid');		
		//그리드 사이즈 
	 	$(window).bind('resize', function() { 
		    $("#commissionTaxGrid").setGridWidth($('#view_grid_sub').width(), false); 
		}).trigger('resize');

	 	// 엔터키 눌렀을 경우
	 	fn_Enter_Search('commissionTaxForm', 'commissionTaxGrid');
	 	
	});
	//의뢰 목록
	var lastRowId;
	function commissionTaxGrid(url, form, grid) {
		var toDay = formatDate(new Date());
		
		var newRows = new Array();
		
		$('#' + grid).jqGrid({
			datatype : function(json) {
				for (var i=0; i<opener.rowDatas.length; i++) {
					var rowData = opener.rowDatas[i];
					var newRowData = {};
					var supplyCost = rowData.commission_amt_det;
					var prdTax = parseInt(rowData.commission_amt_tot) - parseInt(supplyCost); 
					
					newRowData.testReqNo = rowData.test_req_no;
					newRowData.testReqSeq = rowData.test_req_seq;
					newRowData.invoiceeCorpNum = rowData.tax_biz_no;
					newRowData.invoiceeCorpName = rowData.tax_req_org_nm;
					newRowData.invoiceeCeoName = rowData.pre_man;
					newRowData.invoiceeAddr = rowData.addr;
					newRowData.invoiceeBizType = rowData.biz_type;
					newRowData.invoiceeBizClass = rowData.biz_class;
					newRowData.writeDate = toDay;
					newRowData.supplyCostTotal = supplyCost;
					newRowData.taxTotal = prdTax;
					newRowData.totalAmount = rowData.commission_amt_tot;
					newRowData.remark1 = '';
					newRowData.prdPurchaseDt = toDay;
					newRowData.prdItem = rowData.sample_reg_nm;
					newRowData.prdSupplyCost = supplyCost;
					newRowData.prdTax = prdTax;
					newRowData.prdRemark = '';
					newRowData.purposeType = '청구';
					newRowData.pay_nm = rowData.pay_nm;
					newRowData.pay_tel = rowData.pay_tel;
					newRowData.pay_email = rowData.pay_email;
					newRowData.pageType = opener.pageType;
					newRowData.taxInvoiceSeq = rowData.tax_invoice_seq;
					
					newRows.push(newRowData);
				}
				$('#' + grid).clearGridData();
				$('#' + grid)[0].addJSONData(newRows);
			},
			height : '500',
			autowidth : true,
			loadonce : true,
			mtype : "POST",
			gridview : true,
			shrinkToFit : false,
			rowNum : -1,
			rownumbers : true,
			cellEdit : true,
			cellsubmit : 'clientArray',
			colModel : [ {
				label : '접수번호',
				name : 'testReqNo',
				align : 'center',
				width : '100'
				
			}, {
				label : 'testReqSeq',
				name : 'testReqSeq',
				hidden : true
			},{
				label : '사업자등록번호',
				name : 'invoiceeCorpNum',
				align : 'center',
				width : '100',
				editable : true
			}, {
				label : '상호',
				name : 'invoiceeCorpName',
				width : '80',
				editable : true
			}, {
				label : '대표자',
				name : 'invoiceeCeoName',
				width : '80',
				editable : true
			}, {
				label : '사업장 주소',
				name : 'invoiceeAddr',
				width : '150',
				editable : true
			}, {
				label : '업태',
				name : 'invoiceeBizType',
				width : '100',
				editable : true
			}, {
				label : '종목',
				name : 'invoiceeBizClass',
				width : '100',
				editable : true
			},{
				label : '결제담당자',
				name : 'pay_nm',
				width : '150',
				editable : true
			}, {
				label : '전화번호',
				name : 'pay_tel',
				width : '150',
				editable : true
			}, {
				label : '이메일',
				name : 'pay_email',
				width : '150',
				editable : true
			}, {
				label : '작성일자',
				name : 'writeDate',
				width : '150',
				editable : true,
				editoptions: {dataInit: function (el) {$(el).datepicker({controlType: 'select',dateFormat: "yy-mm-dd"}); }}
			}, {
				label : '공급가액합계',
				name : 'supplyCostTotal',
				hidden : true
			}, {
				label : '세액합계',
				name : 'taxTotal',
				hidden : true
			}, {
				label : '공급가액',
				name : 'prdSupplyCost',
				width : '150',
				editable : true
			}, {
				label : '세액',
				name : 'prdTax',
				width : '150',
				editable : true
			}, {
				label : '합계금액',
				name : 'totalAmount',
				width : '150',
				editable : true
			}, {
				label : '품목비고',
				name : 'prdRemark',
				width : '150',
				editable : true
			}, {
				label : '비고',
				name : 'remark1',
				width : '150',
				editable : true
			}, {
				label : '거래일자',
				name : 'prdPurchaseDt',
				width : '150',
				editable : true,
				editoptions: {dataInit: function (el) {$(el).datepicker({controlType: 'select',dateFormat: "yy-mm-dd"}); }}
			}, {
				label : '검체명',
				name : 'prdItem',
				width : '150',
				editable : true
			}, {
				label : '영수/청구',
				name : 'purposeType',
				width : '80',
				editable : true,
				edittype : 'select',
				editrules : {required : true},
				editoptions : {value: "1:청구 ; 2:영수", defaultValue:'청구'}
			}, {
				label : '발행결과',
				name : 'result',
				width : '150',
				editable : false
			}, {
				label : '비고',
				name : 'resultReson',
				width : '150',
				editable : false
			}, {
				label : 'pageType',
				name : 'pageType',
				hidden : true
			}, {
				label : 'taxInvoiceSeq',
				name : 'taxInvoiceSeq',
				hidden : true
			}],
			emptyrecords : '데이터가 존재하지 않습니다.',
			gridComplete : function() {
			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
			}
			,afterEditCell : function(rowid,cellname,value,iRow,iCol) {
				$("#"+rowid+"_"+cellname).blur(function(){
			        $("#grid").jqGrid("saveCell",iRow,iCol);
			    });
			}
			,onSelectCell: function (rowid, celname, value, iRow, iCol) {
            },
		});
		
		$('#' + grid).jqGrid('setGroupHeaders', {
			useColSpanStyle : true,
			groupHeaders : [{
				startColumnName : 'invoiceeCorpNum',
				numberOfColumns : 9,
				titleText : '공급받는자정보'
			},{
				startColumnName : 'item',
				numberOfColumns : 7,
				titleText : '품목정보'
			}]
		});
		
		
	}
	
	//세금계산서 발행
	function btn_invoice_publish_onclick(){
		
		if (!confirm("전자세금계산서를 발행하시겠습니까?")) {
			return false;
		}
		
		var url = 'commissionTaxInvoiceRegistIssue.lims';
		var rows = $('#commissionTaxGrid').jqGrid('getDataIDs');
		
		for (var i=0; i<rows.length; i++) {
			var rowId = rows[i];
		    var iRow = $('#' + rowId)[0].rowIndex;
		    $("#commissionTaxGrid").jqGrid("editCell", iRow, 1, false);
		    
		    var rowData = jQuery('#commissionTaxGrid').jqGrid ('getRowData', rowId);
		    
		    var result = fnAjaxAction(url,rowData);
		    var resultCode = "0";
		    if(result.resultCode != null){
		    	resultCode = result.resultCode;
		    }
		    if (result.resultCode == "0") {
		    	rowData.result = "발행실패";
		    	rowData.resultReson = result.message;
		    }
		    else if (result.resultCode == "1") {
		    	rowData.result = "발행성공";
		    	rowData.resultReson = result.confirmNum;
		    	$("#btn_invoice_publish").hide();
		    	opener.btn_Search_onclick();
		    }
		    $('#commissionTaxGrid').jqGrid('setRowData', rowId, rowData);
		}
		
		alert("세금계산서 발행이 완료되었습니다. 리스트 우측 발행결과를 확인해 주세요.");		
	}
	
	function editLink(cellValue, options, rowdata, action) {
	    return '<button onclick=editcall("' + rowdata.date + '","' + rowdata.custID + '","' + rowdata.custName + '")>edit</button>';
	}
	function editcall(date, custID, custName) {
	    $("#datepicker").val(date)
	    $("#Text1").val(custID)
	    $("#Text2").val(custName)
	}
	function formatDate(date) {
	    var d = new Date(date),
	    	year = d.getFullYear(),
	        month = '' + (d.getMonth() + 1),
	        day = '' + d.getDate();
	        

	    if (month.length < 2) month = '0' + month;
	    if (day.length < 2) day = '0' + day;

	    return [year, month, day].join('-');
	}
</script>
</head>
<body id="popBody" onunload="opener.fnBasicEndLoading();">
<div class="popUp">
	<div class="popUp">
		<div class="pop_area pop_intro">
			<h2>전자세금계산서발행</h2>
			<div>
				<form id="commissionTaxForm" name="commissionTaxForm" onsubmit="return false;">
					<div class="sub_purple_01" style="margin-top: 0px;">
						<table width="100%" border="0" class="select_table">
							<tr>
								<td width="20%" class="table_title">
									<span style="font-size: 11px; margin-left: 15px; color: #b27ce0;">■</span> 발급대상목록
								</td>
								<td class="table_button" style="text-align: right; padding-right: 30px;">
									<span class="button white mlargep auth_select" id="btn_invoice_publish" onclick="btn_invoice_publish_onclick();">
										<button type="button">세금계산서발행</button>
									</span>
									<span class="button white mlargep" id="btn_Cancel" onclick="window.close();">
										<button type="button">닫기</button>
									</span>
								</td>
							</tr>
						</table>
					</div>
					<div id="view_grid_sub">
						<table id="commissionTaxGrid"></table>
					</div>
					
					<input type="hidden" id="testReqNoLst" name="testReqNoLst">
					
				</form>
			</div>
		</div>
	</div>
</div>
</body>
</html>
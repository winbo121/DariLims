<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	/***************************************************************************************
	 * 시스템명 	: 통합장비관제시스템
	 * 업무명 		: 세금계산서 발행내역 조회
	 * 파일명 		: CommissionCheckL02.jsp
	 * 작성자 		: 김상하
	 * 작성일 		: 2016.05.12
	 * 설  명		: 세금계산서 발행내역 리스트 화면
	 *---------------------------------------------------------------------------------------
	 * 변경일		 변경자		변경내역 
	 *---------------------------------------------------------------------------------------
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
	var fnGridHisInit = false;
	
	var rowDatas = new Array();
	var pageType;
	
	$(function() {
		
		
		/* 세부권한검사 */
		fn_auth_check();

		$('#tabs').tabs({
			active : 0
		});
		
		ajaxComboForm("req_class", "C70", "", "", "commissionDetailForm");
		ajaxComboForm("dept_cd", "", "", null, 'commissionDetailForm');
		ajaxComboForm("sales_dept_cd", "", "", null, 'commissionDetailForm');
		ajaxComboForm("sales_user_id", $('#commissionOrgForm').find("#sales_dept_cd").val(), "", "", 'commissionDetailForm');
		
		$('#commissionDetailForm').find("#sales_dept_cd").change(function() {
			ajaxComboForm("sales_user_id", $('#commissionDetailForm').find("#sales_dept_cd").val(), "CHOICE", "", 'commissionDetailForm');
		});

		fnDatePickerImg('startDate');
		fnDatePickerImg('endDate');
		
		fnDatePickerImg('taxSdate');
		fnDatePickerImg('taxEdate');
		
		fnDatePickerImg('invoiceSDate');
		fnDatePickerImg('invoiceEDate');
		
		fnDatePickerImg('depositSdate');
		fnDatePickerImg('depositEdate');
		
		
		
	 	//의뢰목록
	 	commissionDetailGrid('accept/selectTaxInvoiceList.lims', 'commissionDetailForm', 'commissionDetailGrid');		
		//그리드 사이즈 
	 	$(window).bind('resize', function() { 
		    $("#commissionDetailGrid").setGridWidth($('#view_grid_middle').width(), false); 
		}).trigger('resize');

	 	// 엔터키 눌렀을 경우
	 	fn_Enter_Search('commissionDetailForm', 'commissionDetailGrid');
	 	
	 	
	 	/* 전자세금계산서 발행이력 */
	 	//의뢰목록
	 	commissionTaxHisGrid('accept/selectTaxInvoiceHisList.lims', 'commissionDetailFormHis', 'commissionTaxHisGrid');		
		//그리드 사이즈 
	 	$(window).bind('resize', function() { 
		    $("#commissionTaxHisGrid").setGridWidth($('#view_grid_his').width(), false); 
		}).trigger('resize');

		
		
		//탭 클릭시 이벤트
	 	$('#tabs').tabs({
			create : function(event, ui) {
				$(window).bind('resize', function() {
					$("#commissionDetailGrid").setGridWidth($('#view_grid_middle').width(), false);
				}).trigger('resize');
				$(window).bind('resize', function() {
					$("#commissionTaxHisGrid").setGridWidth($('#view_grid_his').width(), false);
				}).trigger('resize');
			},
			activate : function(event, ui) {
				$(window).bind('resize', function() {
					$("#commissionDetailGrid").setGridWidth($('#view_grid_middle').width(), false);
				}).trigger('resize');
				$(window).bind('resize', function() {
					$("#commissionTaxHisGrid").setGridWidth($('#view_grid_his').width(), false);
				}).trigger('resize');
			}
		});
	});

	//의뢰 목록
	var lastRowId;
	function commissionDetailGrid(url, form, grid) {
		$('#' + grid).jqGrid({
			datatype : function(json) {
				fnGridInit ? fn_GridData(url, form, grid) : fnGridInit = true;
			},
			height : '500',
			autowidth : false,
			loadonce : true,
			mtype : "POST",
			gridview : true,
			shrinkToFit : false,
			rowNum : -1,
			rownumbers : true,
			colModel : [ {
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
				width : '100',
				key : true
			}, {
				label : 'test_req_seq',
				name : 'test_req_seq',
				hidden : true
			}, {
				label : '의뢰분류',
				name : 'req_class',
				align : 'center',
				width : '200'
			}, {
				label : '제목',
				name : 'title',
				width : '150',
				align : 'center'
			}, {
				label : '검체명',
				name : 'sample_reg_nm',
				align : 'center',
				width : '100'
			}, {
				label : '특급여부',
				name : 'express_flag',
				align : 'center',
				width : '60'
			}, {
				label : '세금계산서발행처',
				name : 'tax_req_org_nm',
				align : 'center',
				width : '200'
			}, {
				label : '사업자번호',
				name : 'tax_biz_no',
				align : 'center'
			}, {
				label : '의뢰처',
				name : 'org_nm',
				align : 'center',
				width : '200'
			},
			{
				label : '업체담당자',
				name : 'req_nm',
				width : '100',
				align : 'center',
			},
			{	
				label : '접수일자',
				name : 'sample_arrival_date',
				align : 'center',
				width : '80'
			}, {
				label : '진행상태',
				name : 'state',
				align : 'center',
				width : '100',
				hidden : true
			}, {
				label : 'fee_auto_flag',
				name : 'fee_auto_flag',
				hidden : true
			}, {
				label : 'fee_tot_est',
				name : 'fee_tot_est',
				width : '100',
				formatter : 'integer',
				formatoptions : {
					thousandsSeparator : ","
				},
				align : 'right',
				hidden : true
			}, {
				label : 'fee_tot_item',
				name : 'fee_tot_item',
				width : '100',
				formatter : 'integer',
				formatoptions : {
					thousandsSeparator : ","
				},
				align : 'right',
				hidden : true
			}, {
				label : '수수료(VAT포함)',
				name : 'commission_amt_tot',
				width : '150',
				formatter : 'integer',
				formatoptions : {
					thousandsSeparator : ","
				},
				align : 'right'
			}, {
				label : '공급가액',
				name : 'commission_amt_det',
				width : '150',
				formatter : 'integer',
				formatoptions : {
					thousandsSeparator : ","
				},
				align : 'right'
			}, {
				label : '입금금액',
				name : 'deposit_amt',
				width : '100',
				formatter : 'integer',
				formatoptions : {
					thousandsSeparator : ","
				},
				align : 'right'
			}, {	
				label : '입금일자',
				name : 'deposit_date',
				align : 'center',
				width : '80'
			}, {
				label : '부서',
				name : 'sales_dept_cd',
				width : '80',
				align : 'center'	
			}, {
				label : '담당자',
				name : 'sales_user_id',
				width : '100',
				align : 'center',
			}, {
				label : '발행여부',
				name : 'tax_invoice_flag',
				width : '80',
				align : 'center'	
			}, {
				label : '발행일자',
				name : 'tax_invoice_date',
				width : '100',
				align : 'center',
			},			
			{
				label : '주소',
				name : 'addr',
				width : '100',
				align : 'center',
				hidden : true
			}, {
				label : '종목',
				name : 'biz_type',
				width : '100',
				align : 'center',
				hidden : true
			}, {
				label : '업태',
				name : 'biz_class',
				width : '100',
				align : 'center',
				hidden : true
			}, {
				label : 'EMAIL',
				name : 'email',
				width : '100',
				align : 'center',
				hidden : true
			}, {
				label : '연락처',
				name : 'charger_tel',
				width : '100',
				align : 'center',
				hidden : true
			}, {
				label : '대표자',
				name : 'pre_man',
				width : '100',
				align : 'center',
				hidden : true
			}, {
				label : '담당자',
				name : 'pay_nm',
				width : '150',
				hidden : true
			}, {
				label : '전화번호',
				name : 'pay_tel',
				width : '150',
				hidden : true
			}, {
				label : '이메일',
				name : 'pay_email',
				width : '150',
				hidden : true
			}, {
				label : 'tax_invoice_seq',
				name : 'tax_invoice_seq',
				hidden : true
			}],
			emptyrecords : '데이터가 존재하지 않습니다.',
			gridComplete : function() {
			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
			}
		});
		$('#' + grid).jqGrid('setGroupHeaders', {
			useColSpanStyle : true,
			groupHeaders : [ {
				startColumnName : 'sales_dept_cd',
				numberOfColumns : 2,
				titleText : '영업담당'
			}, {
				startColumnName : 'tax_invoice_flag',
				numberOfColumns : 2,
				titleText : '세금계산서'
			} ]
		});
	}

	//전자세금계산서발행이력
	var lastRowIdHis;
	function commissionTaxHisGrid(url, form, grid) {
		$('#' + grid).jqGrid({
			datatype : function(json) {
				fnGridHisInit ? fn_GridData(url, form, grid) : fnGridHisInit = true;
			},
			height : '500',
			autowidth : true,
			loadonce : true,
			mtype : "POST",
			gridview : true,
			shrinkToFit : false,
			rowNum : -1,
			rownumbers : true,
			colModel : [{
				label : '접수번호',
				name : 'testReqNo',
				align : 'center',
				width : '100'
			}, {
				label : '발행번호',
				name : 'taxInvoiceSeq',
				align : 'center',
				width : '100'
			}, {
				label : 'test_req_seq',
				name : 'testReqSeq',
				hidden : true
			}, {
				label : '사업자등록번호',
				name : 'invoiceeCorpNum',
				align : 'center',
				width : '100'
			}, {
				label : '상호',
				name : 'invoiceeCorpName',
				width : '80',
				align : 'center'
			}, {
				label : '대표자',
				name : 'invoiceeCeoName',
				width : '80',
				align : 'center'
			}, {
				label : '사업장 주소',
				name : 'invoiceeAddr',
				width : '200'
			}, {
				label : '업태',
				name : 'invoiceeBizType',
				width : '100',
				align : 'center'
			}, {
				label : '종목',
				name : 'invoiceeBizClass',
				width : '100',
				align : 'center'
			}, {
				label : '담당자',
				name : 'invoiceeContactName',
				width : '80',
				align : 'center'
			}, {
				label : '연락처',
				name : 'invoiceeTel',
				width : '150',
				align : 'center'
			}, {
				label : '이메일',
				name : 'invoiceeEmail',
				width : '150',
				align : 'center'
			}, {
				label : '작성일자',
				name : 'writeDate',
				width : '150',
				align : 'center'
			}, {
				label : '거래일자',
				name : 'prdPurchaseDt',
				width : '150',
				align : 'center'
			}, {
				label : '품목명',
				name : 'prdItemName',
				width : '150',
				align : 'center'
			}, {
				label : '품목비고',
				name : 'prdRemark',
				width : '150',
				align : 'center'
			}, {
				label : '공급가액',
				name : 'supplyCostTotal',
				width : '150',
				align : 'center'
			}, {
				label : '세액',
				name : 'taxTotal',
				width : '150',
				align : 'center'
			}, {
				label : '합계금액',
				name : 'totalAmount',
				width : '150',
				align : 'center'
			}, {
				label : '비고',
				name : 'remark',
				width : '150',
				align : 'center'
			}, {
				label : '영수/청구',
				name : 'purposeType',
				width : '80',
				align : 'center'
			}, {
				label : '발행구분',
				name : 'taxInvoiceFlag',
				width : '150',
				align : 'center'
			}, {
				label : '발행결과',
				name : 'taxInvoiceResult',
				width : '150',
				align : 'center'
			}, {
				label : '발행결과메시지',
				name : 'taxInvoiceResultMsg',
				width : '300',
				align : 'center'
			}],
			emptyrecords : '데이터가 존재하지 않습니다.',
			gridComplete : function() {
			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
			}
		});
		
		$('#' + grid).jqGrid('setGroupHeaders', {
			useColSpanStyle : true,
			groupHeaders : [{
				startColumnName : 'invoiceeCorpNum',
				numberOfColumns : 9,
				titleText : '공급받는자정보'
			},{
				startColumnName : 'purposeType',
				numberOfColumns : 4,
				titleText : '발행정보'
			}]
		});
	}
	
	function btn_Search_onclick(){
		$('#commissionDetailGrid').trigger('reloadGrid');
	}
	function btn_Select_His_onclick (){
		$('#commissionTaxHisGrid').trigger('reloadGrid');
	}
	
	//전자세금계산서발행(건별)
	function btn_Tax_per_smp_onclick(gbn) {
		rowDatas = [];
		pageType = "";
		var chk1 = true;
		var chk2 = true;
		var rows = $('#commissionDetailGrid').jqGrid('getDataIDs');
		
		for (var i=0; i<rows.length; i++) {
			var rowId = rows[i];
		    var rowData = jQuery('#commissionDetailGrid').jqGrid ('getRowData', rowId);		    
		    
		    if(rowData.chk == "Yes") {
		    	rowDatas.push(rowData);
		    }
		}
		
		for( var j=0; j<rowDatas.length; j++){
			console.log(rowDatas[j].tax_invoice_flag);
			if(rowDatas[j].tax_invoice_flag == "발행" && gbn == "I"){
				chk1 = false;
			}else if(rowDatas[j].tax_invoice_flag == "미발행" && gbn == "U"){
				chk2 = false;
			}	
		}
		
		if(chk1 == false){
			alert('이미 발행된 건이 있습니다. 수정발행하여 주세요.');
			return;
		}
		
		if(chk2 == false){
			alert('미발행건이 있습니다. 발행을 먼저 해주세요.');
			return;
		}
		
		pageType = gbn;
		
		if (rowDatas.length == 0) {
			alert('검체를 체크해주세요.');
			return;
		} else {
			fnBasicStartLoading();
			fnpop_commissionTaxInvoicePerSmpPop("commissionTaxInvoicePerSmp","1280", "1024");			
		}
	}
	
	// 엑셀 다운로드
	function btn_Excel_onclick() {
		var bigDivName = "세금계산서";
		var bigDivData = "세금계산서";
		var data = fn_Excel_Data_Make2('commissionDetailGrid', bigDivName, bigDivData);
		fn_Excel_Download(data);
	}
</script>

<div id="tabs">
	<ul>
		<li id="tab2">
			<a href="#tabDiv1">세금계산서발행</a>
		</li>
		<li id="tab1">
			<a href="#tabDiv2">세금계산서발행이력</a>
		</li>
	</ul>
	<div id="tabDiv1">
	
		<form id="commissionDetailForm" name="commissionDetailForm" onsubmit="return false;">
			<div class="sub_purple_01">
				<table class="select_table" >
				<tr>
					<td class="table_title">
						<span>■</span>
						의뢰목록
					</td>
					<td class="table_button">
						<span class="button white mlargep auth_select" id="btn_Select" onclick="btn_Search_onclick();">
							<button type="button">조회</button>
						</span>
						<span class="button white mlargeb auth_select" onclick="btn_Excel_onclick();">
							<button type="button">EXCEL</button>
						</span>
						<span class="button white mlargep auth_select" id="btn_Tax_per_smp1" onclick="btn_Tax_per_smp_onclick('I');">
							<button type="button">최초발행</button>
						</span>
						<span class="button white mlargep auth_select" id="btn_Tax_per_smp2" onclick="btn_Tax_per_smp_onclick('U');">
							<button type="button">수정발행</button>
						</span>
					</td>
				</tr>
			</table>
			<table class="list_table">
				<tr>
					<th>의뢰분류</th>
					<td>
						<select name="req_class" id="req_class" class="w200px inputCheck"></select>
					</td>
					<th>접수일자</th>
					<td>
						<input name="startDate" id="startDate" type="text" class="w80px" readonly="readonly" />
						<img src="<c:url value='/images/common/calendar_del.png'/>" id="startDateStop" style="cursor: pointer;" onClick='fn_TextClear("startDate")' /> ~
						<input name="endDate" id="endDate" type="text" class="w80px" readonly="readonly" />
						<img src="<c:url value='/images/common/calendar_del.png'/>" id="endDateStop" style="cursor: pointer;" onClick='fn_TextClear("endDate")' />
					</td>
					<th>접수번호</th>
					<td>
						<input name="test_req_no" type="text" class="inputhan" class='w200px' />
					</td>
				</tr>
				<tr>
					<th>세금계산서 발행여부</th>
					<td>
						<select name="tax_invoice_flag" id="tax_invoice_flag" class="w100px inputCheck">
						<option value="">전체</option>
						<option value="Y">발행</option>
						<option value="N">미발행</option>
						</select>
					</td>
					<th>세금계산서 발행일자</th>
					<td>
						<input name="taxSdate" id="taxSdate" type="text" class="w80px" readonly="readonly" />
						<img src="<c:url value='/images/common/calendar_del.png'/>" id="taxSdateStop" style="cursor: pointer;" onClick='fn_TextClear("taxSdate")' /> ~
						<input name="taxEdate" id="taxEdate" type="text" class="w80px" readonly="readonly" />
						<img src="<c:url value='/images/common/calendar_del.png'/>" id="taxEdateStop" style="cursor: pointer;" onClick='fn_TextClear("taxEdate")' />
					</td>
					<th>업체명</th>	
					<td>								 
						<label><input type='radio' name='org_cls' value='TAX' style="width: 20px" checked="checked" />세금계산서발행처</label> 
						<label><input type='radio' name='org_cls' value='REQ' style="width: 20px" />의뢰처</label>
						&nbsp;&nbsp;
						<input name="org_nm" type="text" class="w200px inputhan"/>
					</td>
				</tr>
				<tr>
					<th>시험부서</th>
					<td>
						<select name="dept_cd" id="dept_cd" class="w200px inputCheck"></select>
					</td>
					<th>영업부서</th>
					<td>
						<select name="sales_dept_cd" id="sales_dept_cd" class="w200px inputCheck"></select>
						<select name="sales_user_id" id="sales_user_id" class="w200px inputCheck"></select>
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
					<th>제목</th>
					<td>
						<input name="title" type="text" class="w200px inputhan"/>
					</td>
					<th>품목명</th>
					<td>
						<input name="prdlst_nm" type="text" class="w200px inputhan"/>
					</td>
					<th>입금일자</th>
					<td>
						<input name="depositSdate" id="depositSdate" type="text" class="w80px" readonly="readonly" />
						<img src="<c:url value='/images/common/calendar_del.png'/>" id="depositSdateStop" style="cursor: pointer;" onClick='fn_TextClear("depositSdate")' /> ~
						<input name="depositEdate" id="depositEdate" type="text" class="w80px" readonly="readonly" />
						<img src="<c:url value='/images/common/calendar_del.png'/>" id="depositEdateStop" style="cursor: pointer;" onClick='fn_TextClear("depositEdate")' />
					</td>
				</tr>
				<tr>
				<th>업체담당자</th>
				<td colspan="5">
					<input type="text" name="req_nm" class="w200px inputhan">
				</td>
				</tr>
			</table>
			</div>	
			<input type="hidden" id="sortName" name="sortName">
			<input type="hidden" id="sortType" name="sortType">
			<div id="view_grid_middle">
				<table id="commissionDetailGrid"></table>
			</div>
		</form>
	</div>
	<div id="tabDiv2">
		<form id="commissionDetailFormHis" name="commissionDetailFormHis" onsubmit="return false;">
			<div class="sub_purple_01">
			<table class="select_table" >
				<tr>
					<td class="table_title">
						<span>■</span>
						전자세금계산서발행목록
					</td>
					<td class="table_button">
						<span class="button white mlargep auth_select" id="btn_Select_His" onclick="btn_Select_His_onclick();">
							<button type="button">조회</button>
						</span>
					</td>
				</tr>
			</table>
			<table class="list_table">
				<tr>
					<th>접수번호</th>
					<td>
						<input name="testReqNo" type="text" class="inputhan" class='w200px' style="width: 200px" />
					</td>
					<th>일자</th>
						
					<td>
						<label><input type='radio' name='invoiceDate' value='WRITE' style="width: 20px" checked="checked" />작성일자</label> 
						<label><input type='radio' name='invoiceDate' value='PURCHASE' style="width: 20px" />거래일자</label>
						<label><input type='radio' name='invoiceDate' value='PUBLISH' style="width: 20px" />발행일자</label>
					</td>
					<td>
						<input name="invoiceSDate" id="invoiceSDate" type="text" class="w80px" readonly="readonly" />
						<img src="<c:url value='/images/common/calendar_del.png'/>" id="invoiceSDateStop" style="cursor: pointer;" onClick='fn_TextClear("invoiceSDate")' /> ~
						<input name="invoiceEDate" id="invoiceEDate" type="text" class="w80px" readonly="readonly" />
						<img src="<c:url value='/images/common/calendar_del.png'/>" id="invoiceEDateStop" style="cursor: pointer;" onClick='fn_TextClear("invoiceEDate")' />
					</td>
					<th>업체명</th>	
					<td>								 
						<input name="invoicerCorpName" type="text" class="w200px inputhan"/>
					</td>
					<th>품목명</th>
					<td>
						<input name="prdItem" type="text" class="w200px inputhan"/>
					</td>
				</tr>
			</table>
			</div>	
			<input type="hidden" id="sortName" name="sortName">
			<input type="hidden" id="sortType" name="sortType">
			
			<div id="view_grid_his">
				<table id="commissionTaxHisGrid"></table>
			</div>
		</form>
	</div>
	
	
	

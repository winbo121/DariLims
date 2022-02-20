<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	/***************************************************************************************
	 * 시스템명 	: 통합장비관제시스템
	 * 업무명 		: 성과급계산 조회(미사용)
	 * 파일명 		: CommissionBonusL01.jsp
	 * 작성자 		: 김상하
	 * 작성일 		: 2016.05.12
	 * 설  명		: 수수료성과급 리스트 화면	 
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
	
	$(function() {
		/* 세부권한검사 */
		fn_auth_check();

		ajaxComboForm("req_class", "C70", "", "", "commissionDetailForm");
		ajaxComboForm("dept_cd", "", "", null, 'commissionDetailForm');

		ajaxComboForm("sales_dept_cd", "", "${session.dept_cd}", null, 'commissionDetailForm');
		ajaxComboForm("sales_user_id", $('#commissionDetailForm').find("#sales_dept_cd").val(), "${session.user_id}", "", 'commissionDetailForm');

		$("#sales_dept_cd option").not(":selected").attr("disabled", "disabled");	
		$("#sales_user_id option").not(":selected").attr("disabled", "disabled");

		$('#commissionDetailForm').find("#sales_dept_cd").change(function() {
			ajaxComboForm("sales_user_id", $('#commissionDetailForm').find("#sales_dept_cd").val(), "CHOICE", "", 'commissionDetailForm');
		});
		
		fnDatePickerImg('startDate');
		fnDatePickerImg('endDate');

		fnDatePickerImg('taxSdate');
		fnDatePickerImg('taxEdate');
		
	 	//업체 상세목록
	 	commissionDetailGrid('accept/selectBonusList.lims', 'commissionDetailForm', 'commissionDetailGrid');		
		//그리드 사이즈 
	 	$(window).bind('resize', function() { 
		    $("#commissionDetailGrid").setGridWidth($('#view_grid_middle').width(), false); 
		}).trigger('resize');

	 	// 엔터키 눌렀을 경우
	 	fn_Enter_Search('commissionDetailForm', 'commissionDetailGrid');
	});

	//의뢰 목록
	var lastRowId;
	function commissionDetailGrid(url, form, grid) {
		$('#' + grid).jqGrid({
			datatype : function(json) {
				fnGridInit ? fn_GridData(url, form, grid) : fnGridInit = true;
			},
			height : '500',
			autowidth : true,
			loadonce : true,
			mtype : "POST",
			gridview : true,
			shrinkToFit : false,
			rowNum : -1,
			rownumbers : true,
			colModel : [ {
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
				label : '제목',
				name : 'title',
				width : '150'
			}, {
				label : '의뢰분류',
				name : 'req_class',
				align : 'center',
				width : '150'
			}, {
				label : '품목명',
				name : 'prdlst_nm',
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
			}, {
				label : '성적서발행일',
				width : '100',
				name : 'last_report_date'
			}, {	
				label : '의뢰일자',
				name : 'req_date',
				align : 'center',
				width : '80'
			}, {
				label : '진행상태',
				name : 'state',
				align : 'center',
				width : '100',
				hidden : true
			}, {	
				label : '항목수',
				name : 'item_cnt',
				align : 'center',
				width : '50'
			}, {
				label : '수수료(원)',
				name : 'commission_amt_det',
				width : '100',
				formatter : 'integer',
				formatoptions : {
					thousandsSeparator : ","
				}
			}, {
				label : '1.품목수수료',
				name : 'prdlst_fee',
				width : '100',
				formatter : 'integer',
				hidden : true,
				formatoptions : {
					thousandsSeparator : ","
				}
			}, {
				label : '부서기본수수료',
				name : 'dept_fee',
				width : '100',
				formatter : 'integer',
				formatoptions : {
					thousandsSeparator : ","
				}
			}, {
				label : '성과급(원)',
				name : 'bonus_fee',
				width : '100',
				formatter : 'integer',
				formatoptions : {
					thousandsSeparator : ","
				}
			}, {
				label : '수수료미납금액',
				name : 'default_amt_tot',
				width : '100',
				formatter : 'integer',
				formatoptions : {
					thousandsSeparator : ","
				}
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

	function btn_Search_onclick(){
		$('#commissionDetailGrid').trigger('reloadGrid');
	}
	
	// 엑셀 다운로드
	function btn_Excel_onclick() {
		var bigDivName = "세금계산서";
		var bigDivData = "세금계산서";
		var data = fn_Excel_Data_Make2('commissionDetailGrid', bigDivName, bigDivData);
		fn_Excel_Download(data);
	}
	
</script>
<div>
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
				</td>
			</tr>
		</table>
		<table class="list_table" >
			<tr>
				<th>의뢰분류</th>
				<td>
					<select name="req_class" id="req_class" class="w200px inputCheck"></select>
				</td>
				<th>의뢰일자</th>
				<td>
					<input name="startDate" id="startDate" type="text" class="w80px" readonly="readonly" />
					<img src="<c:url value='/images/common/calendar_del.png'/>" id="startDateStop" style="cursor: pointer;" onClick='fn_TextClear("startDate")' /> ~
					<input name="endDate" id="endDate" type="text" class="w80px" readonly="readonly" />
					<img src="<c:url value='/images/common/calendar_del.png'/>" id="endDateStop" style="cursor: pointer;" onClick='fn_TextClear("endDate")' />
				</td>
				<th>접수번호</th>
				<td>
					<input name="test_req_no" type="text" class="w200px inputhan"/>
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
					<input name="org_nm" type="text" class="w100px inputhan"/>
				</td>
			</tr>
			<tr>
				<th>시험부서</th>
				<td>
					<select name="dept_cd" id="dept_cd" class="w200px inputCheck"></select>
				</td>
				<th>영업부서</th>
				<td>
					<select name="sales_dept_cd" id="sales_dept_cd" class="w150px inputCheck"></select>
					<select name="sales_user_id" id="sales_user_id" class="w100px inputCheck"></select>
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
		</table>
		</div>	
		<input type="hidden" id="sortName" name="sortName">
		<input type="hidden" id="sortType" name="sortType">
		<div id="view_grid_middle">
			<table id="commissionDetailGrid"></table>
		</div>
	</form>
</div>
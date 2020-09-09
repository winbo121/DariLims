
<%
	/***************************************************************************************
	 * 시스템명 	: 통합장비관제시스템
	 * 업무명 		: 수불현황
	 * 파일명 		: reagentsGlassStateL01.jsp
	 * 작성자 		: 석은주
	 * 작성일 		: 2015.02.16
	 * 설  명		: 수불현황 목록 조회 화면
	 *---------------------------------------------------------------------------------------
	 * 변경일		 변경자		변경내역 
	 *---------------------------------------------------------------------------------------
	 * 2015.02.16    석은주		최초 프로그램 작성         
	 * 
	 *---------------------------------------------------------------------------------------
	 ****************************************************************************************/
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html >
<link rel="stylesheet" media="screen" type="text/css" href="<c:url value='/css/common/sub.css'/>" />
<style>
</style>
<script type="text/javascript">
// 	var m_mtlr_code;	
	
	$(function() {
		/* 세부권한검사 */
		fn_auth_check();
		
		var deptCd = '${session.dept_cd}';
		
		ajaxComboForm("dept_cd", "", "All", "", 'reagentsStateForm'); // 관리부서
// 		ajaxComboForm("office_cd", "", "${session.dept_cd}", "", 'reagentsStateForm'); // 사업소별
		
		ajaxComboForm("m_mtlr_info", "", "All", "", 'reagentsStateForm'); // 중분류
		checkYear('sel_buy_year');  //구매년도
		
		reagentsStateGrid('reagents/selectReagentsGlassStateList.lims', 'reagentsStateForm', 'reagentsStateGrid');
		$('#reagentsStateGrid').clearGridData(); // 최초 조회시 데이터 안나옴
				
		// 엔터키 눌렀을 경우
		fn_Enter_Search('reagentsStateForm', 'reagentsStateGrid');
		
	 	//그리드 사이즈 
		$(window).bind('resize', function() { 
		    $("#reagentsStateGrid").setGridWidth($('#view_grid_mState').width(), false); 
		}).trigger('resize');
	 	
	 	
/* 	 	if(deptCd.substring(0,4) == 'LIMS'){
			fn_show_type('o');
	 	}else{
			fn_show_type('d');
		} */
	 	
	});
	function reagentsStateGrid(url, form, grid) {
		var lastRowId = 0;
		$('#' + grid).jqGrid({
			datatype : function(json) {
				fnGridData(url, form, grid);
			},
			height : '247',
			autowidth : true,
			loadonce : true,
			mtype : "POST",
			gridview : true,
			shrinkToFit : false,
			rowNum : -1,
			rownumbers : true,
			colModel : [ {
				label : '시약실험기구수불번호',
				name : 'inout_no',				
				hidden : true,
				key : true,
				search : false
			}, {				
				label : '부서코드',
				name : 'dept_cd',
				hidden : true
			}, {
				label : '부서명',
				width : '120',
				align : 'center',
				name : 'dept_nm'
			}, {
				label : '대분류',
				width : '80',
				align : 'center',
				name : 'h_mtlr_info'
			}, {
				label : '중분류',
				width : '100',
				align : 'center',
				name : 'm_mtlr_info'
			}, {								
				label : '시약실험기구코드',
				name : 'mtlr_no',				
				align : 'center',
				hidden : true
			}, {
				label : '품명',
				width : '200',
				name : 'item_nm'
			}, {
				label : '재고수량',
				name : 'tot_qty',
				width : '60',
				align : 'right',
				classes:'number_css'
			}, {				
				label : '제조사',
				width : '200',
				align : 'center',
				name : 'spec1'
			}, {
				label : 'Cas no.',
				width : '200',
				align : 'center',
				name : 'spec2'
			}, {
				label : 'Cat # (제품번호)',
				width : '200',
				align : 'center',
				name : 'spec_etc'
			}, {
				label : 'Lot # (로트번호)',
				width : '200',
				align : 'center',
				name : 'use',
				hidden : true
			}, {
				label : '용량',
				width : '80',
				align : 'center',
				name : 'mtlr_vol'
			}, {
				label : '단위',
				width : '60',
				align : 'center',
				name : 'unit'
			},  {
				label : '내용',
				width : '200',
				name : 'content'
			/* }, { */
			/* 	label : '수불구분',
				name : 'inout_flag',
				align : 'center'
			}, { */				
			/* 	label : '입고수량',
				name : 'in_qty',
				align : 'center'
			}, {
				label : '출고수량',
				name : 'out_qty',
				align : 'center'
			}, { */				
			/* 	label : '입고일자',
				name : 'in_date'
			}, {
				label : '출고일자',
				name : 'out_date'
			}, { */
			/* 	label : '과장결재',
				name : 'manager_sign'
			}, {
				label : '담당결재',
				name : 'charger_sign' */
			}, { 
			 	label : '수불적요',
				name : 'inout_txt',
				width : '200'
			} ],
			emptyrecords: '데이터가 존재하지 않습니다.',
			gridComplete : function() {
				lastRowId = 0;
// 				fnSelectFirst(grid);
			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
			},
			onSelectRow : function(rowId, status, e) {
				if (rowId && rowId != lastRowId) {	
					lastRowId = rowId;
					var rowData = $('#' + grid).jqGrid ('getRowData', rowId);
					var param = 'mtlr_no=' + rowData.mtlr_no + '&dept_cd=' + rowData.dept_cd;
					fnViewPage('reagents/reagentsGlassStateDetail.lims', 'detail', param);
				}
			}
		});
	}	
	//조회버튼 클릭 이벤트
	function btn_Search_onclick() {
		$('#detail').empty();		
		$('#reagentsStateGrid').trigger('reloadGrid');		
	}
	
	function checkYear(id) {
		var name = id;		
		$('#' + name).append($('<option />').val('').html('전체'));		
		for (var i = new Date().getFullYear() + 5; i > new Date().getFullYear() - 5; i--)
			$('#' + name).append($('<option />').val(i).html(i));		
	}
	// 대분류 콤보
	function comboReload() {
		//alert($("#h_mtlr_info").val());
		if($("#h_mtlr_info").val() == "C42"){
			ajaxComboForm("m_mtlr_info", "C42", "All", "", 'reagentsStateForm'); // 중분류			
		}else if($("#h_mtlr_info").val() == "C43"){
			ajaxComboForm("m_mtlr_info", "C43", "All", "", 'reagentsStateForm'); // 중분류
		}
	}
	
	// 대분류 콤보(detail)
	function comboReload_detail() {
		//alert($("#h_mtlr_info_detail").val());
		if($("#h_mtlr_info_detail").val() == "C42"){
			ajaxComboForm("m_mtlr_info", "C42", "${detail.m_mtlr_info}", "", 'reagentsGlassInfoDetail'); // 중분류			
		}else if($("#h_mtlr_info_detail").val() == "C43"){
			ajaxComboForm("m_mtlr_info", "C43", "${detail.m_mtlr_info}", "", 'reagentsGlassInfoDetail'); // 중분류
		}
	}	

	// 부서 & 사업소 선택
/* 	function fn_show_type(req_dept_office) {
		var th = 'typeThSearch';
		var form = 'reagentsStateForm';
		
		//alert(req_dept_office);
		
		if(req_dept_office == 'd'){
			//$('#' + th).text('요청부서명');
			$('#' + form).find("#dept_cd").show();
			$('#' + form).find("#office_cd").hide();
			$('#' + form).find("#office_cd").val('');
			$('#' + form).find("#req_dept_office").prop('checked',true);
			$('#' + form).find("#req_dept_office2").removeAttr('checekd');
			
		}else{
			//$('#' + th).text('요청사업소명');
			$('#' + form).find("#dept_cd").hide();
			$('#' + form).find("#office_cd").show();
			$('#' + form).find("#dept_cd").val('');
			$('#' + form).find("#req_dept_office2").prop('checked',true);
			$('#' + form).find("#req_dept_office").removeAttr('checekd');
		}
	} */
</script>
<div id="reagentsStateDiv">
	<form id="reagentsStateForm" name="reagentsStateForm" onsubmit="return false;">
		<div class="sub_purple_01">
			<table  class="select_table" >
				<tr>
					<td width="20%" class="table_title">
						<span>■</span>
						시약/실험기구수불목록 
					</td>
					<td class="table_button" style="text-align: right; padding-right: 30px;">
						<span class="button white mlargep auth_select" id="btn_Select" onclick="btn_Search_onclick();">
							<button type="button">조회</button>
						</span>
					</td>
				</tr>
			</table>
			<table  class="list_table" >
			<tr>
				<th id="typeThSearch">
<!-- 					<input name="req_dept_office" id="req_dept_office" type="radio" value="d" checked="checked" onClick="fn_show_type($(this).val())"/> -->
					<label for="req_dept_office">부서명</label>
<!-- 					<input name="req_dept_office" id="req_dept_office2" type="radio" value="o" onClick="fn_show_type($(this).val())"/> -->
<!-- 					<label for="req_dept_office2">사업소명</label> -->
				</th>
				<td>
					<select name="dept_cd" id="dept_cd" class="w120px"></select>
<!-- 					<select name="office_cd" id="office_cd" class="w120px"></select> -->
				</td>				
				<!-- 			
				<th>부서</th>
 				<td>
 					<select class="w120px" name="dept_cd" id="dept_cd"></select>
 				</td> 
 				-->
				<th>대분류</th>
				<td>
					<select class="w100px" name="h_mtlr_info" id="h_mtlr_info" onchange="comboReload()">
						<option value="">전체</option>
						<option value="C42">시약류</option>
						<option value="C43">소모품류</option>
					</select>
				</td>
				<th>중분류</th>
				<td>
					<select class="w100px" name="m_mtlr_info" id="m_mtlr_info"></select>
				</td>
				<th>품명</th>
				<td>
					<input name="item_nm" type="text" class="w200px" />
				</td>		
				<th>구매년도</th>
				<td>
					<select class="w80px" name="buy_year" id="sel_buy_year"></select>
				</td>
			</tr>
			<tr>
			<th>Cas no.</th>
				<td colspan='9'>
					<input name="spec2" type="text" class="w200px" />
				</td>
			</tr>
		</table>
		</div>
	
		<input type="hidden" id="sortName" name="sortName">
		<input type="hidden" id="sortType" name="sortType">
		<div id="view_grid_mState">
			<table id="reagentsStateGrid"></table>
		</div>
	</form>
</div>
<form id="detail" onsubmit="return false;"></form>




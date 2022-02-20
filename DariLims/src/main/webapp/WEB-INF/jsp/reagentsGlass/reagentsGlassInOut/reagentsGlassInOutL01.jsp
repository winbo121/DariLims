
<%
	/***************************************************************************************
	 * 시스템명 	: 통합장비관제시스템
	 * 업무명 		: 시약/실험기구 수불
	 * 파일명 		: reagentsGlassInOutL01.jsp
	 * 작성자 		: 석은주
	 * 작성일 		: 2015.02.25
	 * 설  명		: 시약/실험기구 수불 목록 조회 화면
	 *---------------------------------------------------------------------------------------
	 * 변경일		 변경자		변경내역 
	 *---------------------------------------------------------------------------------------
	 * 2015.02.25    석은주		최초 프로그램 작성         
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
	var editChange = false;
	var m_mtlr_info;
	var deptCd;
	
	$(function() {
		/* 세부권한검사 */
		fn_auth_check();
		
		deptCd = '${session.dept_cd}';
		
		ajaxComboForm("dept_cd", "", "CHOICE", "", 'form'); // 관리부서
		
		ajaxComboForm("m_mtlr_info", "", "All", "", 'form'); // 중분류
		
		var m_mtlr_C42 = fnGridCommonCombo('C42', null);
		var m_mtlr_C43 = fnGridCommonCombo('C43', null);
		m_mtlr_C43 = m_mtlr_C43.slice(1);
		m_mtlr_info = m_mtlr_C42 + m_mtlr_C43;
	
		grid('reagents/selectReagentsGlassInOutList.lims', 'form', 'rgInOutGrid');
		$('#rgInOutGrid').clearGridData(); // 최초 조회시 데이터 안나옴
		
		// 엔터키 눌렀을 경우
		fn_Enter_Search('form', 'rgInOutGrid');
		
	 	//그리드 사이즈 
		$(window).bind('resize', function() { 
		    $("#rgInOutGrid").setGridWidth($('#view_grid_main').width(), false); 
		}).trigger('resize');
	 	
		var form = 'form';		
		if(deptCd.substring(0,4) == 'LIMS'){
			// 사업소
			$('#' + form).find("#office_cd").show();
			$('#' + form).find("#dept_cd").hide();
			$('#' + form).find("#dept_cd").val('');
		}else{
			// 부서
			$('#' + form).find("#dept_cd").show();
			$('#' + form).find("#office_cd").hide();
			$('#' + form).find("#office_cd").val('');
		};
	});
	
	function grid(url, form, grid) {
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
				name : 'm_mtlr_info',
				formatter : 'select',
				edittype : "select",
				editoptions : {
					value : m_mtlr_info
				}
			}, {				
				label : '시약실험기구코드',
				name : 'mtlr_no',
				align : 'center',
				key : true,
				hidden : true
			}, {
				label : '시약/실험기구명',
				width : '250',
				name : 'item_nm'
			}, {
				label : '재고수량',
				name : 'tot_qty',
				width : '70',
				align : 'right',
				classes:'number_css'
			}, {
				label : '제조사',
				width : '180',
				align : 'center',
				name : 'spec1'
			}, {
				label : 'Cas no.',
				width : '180',
				align : 'center',
				name : 'spec2'
			}, {	
				label : 'Cat # (제품번호)',
				width : '180',
				align : 'center',
				name : 'spec_etc'
			}, {
				label : 'Lot # (로트번호)',
				width : '180',
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
				width : '80',
				align : 'center',
				name : 'unit'
			}, {
				label : '내용',
				width : '200',
				name : 'content'			
			} ],
			emptyrecords: '데이터가 존재하지 않습니다.',
			gridComplete : function() {
				lastRowId = 0;
				editChange = false;
			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}				
			},
			beforeSelectRow : function(rowId, e) {				
 				if (rowId && rowId != lastRowId) {
 					if(editChange) {	 						
 						if (!confirm('수정중인 수불현황은 사라집니다. 이동하시겠습니까?')) 
 							return;						
 					} 					
				}
 				editChange = false;
	 			return true;
			},
			onSelectRow : function(rowId, status, e) {				
				if (rowId && rowId != lastRowId) {	
					lastRowId = rowId;
					var param = 'mtlr_no=' + $('#' + grid).jqGrid ('getRowData', rowId).mtlr_no + '&dept_cd=' + $('#' + grid).jqGrid ('getRowData', rowId).dept_cd;
					fnViewPage('reagents/reagentsGlassInOutDetail.lims', 'detail', param);
				}
			}
		});
	}	
	//조회버튼 클릭 이벤트
	function btn_Search_onclick() {		
		if(editChange) {	 						
				if (!confirm('수정중인 수불현황은 사라집니다. 이동하시겠습니까?')) 
					return;						
			}
		$('#detail').empty();		
		$('#rgInOutGrid').trigger('reloadGrid');		
	}
	
	//부서신규물품구매 클릭이벤트
	function btn_New_Dept_Insert_onclick() {
		if(editChange) {	 						
			if (!confirm('수정중인 수불현황은 사라집니다. 이동하시겠습니까?'))
				return 'stop';						
		}
		editChange = false;
 		btn_Search_onclick();
 		fnEditRelease('grid');
		$('#inOutGrid').trigger('reloadGrid');
		
		//var deptCd = $('#form').find('#dept_cd').val(); 상단 셀렉트 부서값 , deptCd는 상단의 세션 부서 값
		var selar = $("#rgInOutGrid").jqGrid('getDataIDs');
		var param = "";
		var arr = new Array();
		for(var i in selar) {
			var row = $('#rgInOutGrid').jqGrid('getRowData', selar[i]);
			arr[i] = row.mtlr_no;
		}		
		param = removeArrayDuplicate(arr) + '★●★' + deptCd;
		
		fnpop_reagentsGlassInOutPop('form', 950, 615, param);
		fnBasicStartLoading();
		
	}

	function fnpop_callback(){
		btn_Search_onclick();
		fnBasicEndLoading();
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
</script>
<div id="inOutDiv">
	<form id="form" name="form" onsubmit="return false;">
		<div class="sub_purple_01">
			<table  class="select_table" >
				<tr>
					<td width="40%" class="table_title">
						<span>■</span>
						시약/실험기구수불목록
					</td>
					<td class="table_button" style="text-align: right; padding-right: 30px;">
						<span class="button white mlargep auth_select" id="btn_Select" onclick="btn_Search_onclick();">
							<button type="button">조회</button>
						</span>
						<span class="button white mlargep auth_save" id="btn_New_Dept_Insert" onclick="btn_New_Dept_Insert_onclick();">
							<button type="button">부서구매물품등록</button>
						</span>
					</td>
				</tr>
			</table>
			<table  class="list_table" >
			<tr>
				<th>부서명</th>
				<td>
					<select name="dept_cd" id="dept_cd" class="w120px"></select>
				</td>
				<th>대분류</th>
				<td>
					<select name="h_mtlr_info" id="h_mtlr_info" onchange="comboReload()" class="w100px">
						<option value="">전체</option>
						<option value="C42">시약류</option>
						<option value="C43">소모품류</option>
					</select>
				</td>
				<th>중분류</th>
				<td>
					<select name="m_mtlr_info" id="m_mtlr_info" class="w120px"></select>
				</td>
				<th>품명</th>
				<td>
					<input name="item_nm" type="text" class="inputhan w200px"/>
				</td>
				<th>Cas no.</th>
				<td>
					<input name="spec2" type="text" class="inputhan w100px" />
				</td>	 							
			</tr>
		</table>
		</div>
		<input type="hidden" id="sortName" name="sortName" />
		<input type="hidden" id="sortType" name="sortType" />
		<div id="view_grid_main">	
			<table id="rgInOutGrid"></table>
		</div>	
	</form>
</div>
<form id="detail" onsubmit="return false;"></form>





<%
	/***************************************************************************************
	 * 시스템명 	: 통합장비관제시스템
	 * 업무명 		: 구매품목현황
	 * 파일명 		: buyingProductStateL01.jsp
	 * 작성자 		: 최은향
	 * 작성일 		: 2015.03.03
	 * 설  명		: 구매품목현황 리스트 조회 화면
	 *---------------------------------------------------------------------------------------
	 * 변경일		 변경자		변경내역 
	 *---------------------------------------------------------------------------------------
	 * 2015.03.03    최은향		최초 프로그램 작성         
	 * 
	 *---------------------------------------------------------------------------------------
	 ****************************************************************************************/
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html >
<link rel="stylesheet" media="screen" type="text/css" href="<c:url value='/css/common/sub.css'/>" />
<script type="text/javascript">
	var deptcd;
	var state;
	var m_mtlr;
	var m_mtlr_C42 = fnGridCommonCombo('C42', null);
	var m_mtlr_C43 = fnGridCommonCombo('C43', null);
	m_mtlr_C43 = m_mtlr_C43.slice(1);
	var m_mtlr_code;

	$(function() {
		/* 세부권한검사 */
		fn_auth_check();
		
		ajaxComboForm("m_mtlr_info", "", "All", "", 'buyingProductStateForm'); // 중분류 검색창 초기화용
		m_mtlr = m_mtlr_C42 + m_mtlr_C43;
		ajaxComboForm("dept_cd", "", "ALL", null, 'buyingProductStateForm'); // 관리부서
		//ajaxComboForm("office_cd", "", "ALL", null, 'buyingProductStateForm'); // 사업소별
		//ajaxComboForm("buy_q", "C14", "", "", 'buyingProductStateForm');
		deptcd = fnGridCombo('dept', null);

		//checkYear('ALL', '', 'sel_buy_year'); // 구매년도
		checkYear('ALL', new Date().getFullYear(), 'sel_buy_year'); // 구매년도
		ajaxComboForm("buy_q", "C14", "", "", 'buyingProductStateForm'); // 구매분기
		ajaxComboForm("state_f", "C39", "C39004", "", 'buyingProductStateForm'); // 진행상태

		//checkYear(10, 'sel_buy_year'); // 구매년도
		state = fnGridCommonCombo('C39', null); // 진행상태

		// 구매확정
		grid('reagents/buyingProductStateList.lims', 'buyingProductStateForm', 'buyingProductStateGrid');
		$('#buyingProductStateGrid').clearGridData(); // 최초 조회시 데이터 안나옴

		//그리드 width조절하기
		$(window).bind('resize', function() {
			$("#buyingProductStateGrid").setGridWidth($('#view_grid_main').width(), false);
		}).trigger('resize');

		// 엔터키 눌렀을 경우(그리드 조회)
		fn_Enter_Search('buyingProductStateForm', 'buyingProductStateGrid');
		
/* 		fn_show_type($('#buyingProductStateForm').find("#req_dept_office").val()); */
	});

	// 대분류 콤보
	function comboReload() {
		if ($("#h_mtlr_info").val() == "C42") {
			ajaxComboForm("m_mtlr_info", "C42", "All", "", 'buyingProductStateForm'); // 중분류			
		} else if ($("#h_mtlr_info").val() == "C43") {
			ajaxComboForm("m_mtlr_info", "C43", "All", "", 'buyingProductStateForm'); // 중분류
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

	// 조회
	function btn_Select_onclick() {
		$('#buyingProductStateGrid').trigger('reloadGrid');
	}

	// 구매품목현황
	function grid(url, form, grid) {
		$('#' + grid).jqGrid({
			datatype : function(json) {
				fnGridData(url, form, grid);
			},
			height : '575',
			autowidth : false,
			loadonce : true,
			mtype : "POST",
			gridview : true,
			shrinkToFit : true,
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
			},{
				label : '시약번호',
				width : '80',
				name : 'mtlr_no',
				hidden : true
			}, {
				label : '구매확정번호',
				width : '80',
				name : 'mtlr_cnfr_no',
				key : true,
				hidden : true
			}, {
				label : '구매정보번호',
				width : '110',
				name : 'mtlr_mst_no',
				hidden : true
			}, {
				label : '대분류',
				width : '60',
				align : 'center',
				name : 'h_mtlr_info'
			}, {
				label : '중분류',
				width : '100',
				align : 'center',
				name : 'm_mtlr_info'
			}, {
				label : '시약/실험기구명',
				width : '250',
				name : 'item_nm'
			}, {
				label : '제조사',
				width : '100',
				align : 'center',
				name : 'spec1'
			}, {
				label : 'Cas no.',
				width : '150',
				align : 'center',
				name : 'spec2'
			}, {
				label : 'Cat # (제품번호)',
				width : '300',
				align : 'center',
				name : 'spec_etc'
			}, {
				label : '구매분기',
				width : '80',
				align : 'center',
				name : 'buy_q'
			}, {
				label : '구매년도',
				width : '80',
				align : 'center',
				name : 'buy_year'
			}, {
				label : '확정수량',
				width : '70',
				align : 'right',
				name : 'fix_qty',
				classes : 'number_css'
			}, {
				label : '요청부서명',
				width : '140',
				name : 'dept_cd'
// 				,
// 				edittype : "select",
// 				editoptions : {
// 					value : deptcd
// 				},
// 				formatter : "select"
			}, {
				label : '단가',
				name : 'cost',
				width : '60',
				align : 'right',
				classes : 'number_css'
			}, {
				label : '검수일자',
				width : '80',
				name : 'confirm_date',
				align : 'center'
			}, {
				label : '진행상태',
				width : '80',
				name : 'state',
				align : 'center',
				edittype : "select",
				editoptions : {
					value : state
				},
				formatter : "select"
			} ],
			emptyrecords : '데이터가 존재하지 않습니다.',
			gridComplete : function() {
				fnCheckAction(grid);
			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
			},
			onSelectRow : function(rowId, status, e) {
				fnEditRelease('buyingProductStateGrid');
			},
			ondblClickRow : function(rowId, iRow, iCol, e) {
				fnEditRelease('buyingProductStateGrid');
				$('#' + grid).jqGrid('editRow', rowId, true);
			}
		});
	}

	// 리스트 조회 이벤트
	function btn_Select_onclick() {
		$('#buyingProductStateGrid').trigger('reloadGrid');
	}

	function btn_Excel_onclick() {
		var data = fn_Excel_Data_Make('buyingProductStateGrid');
		fn_Excel_Download(data);
	}
	
	// 라벨 출력 ( 현재 사용안함)
	function btn_Label_onclick(){
		var ids = $('#buyingProductStateGrid').jqGrid("getDataIDs");
		if (ids.length == 0){
			$.showAlert('조회된 행이 없습니다.');
		} else {
			var mtlrDatas ="";
			var mtlr_cnt = 0;
			for ( var i in ids) {
				var row = $('#buyingProductStateGrid').getRowData(ids[i]);
				if (row.chk == 'Yes') {
					mtlrDatas+= "'" + row.mtlr_no+"',";
					mtlr_cnt ++;
				}
			}
			if(mtlrDatas == ""){
				alert('선택된 행이 없습니다.');
				return;
			}
			var param = "/rp ["+ mtlrDatas.substring(0, mtlrDatas.length -1) +"] /rnpu";
		    fn_RDViewMtlrLabel("Mtlr_label", param, true, true, 650, 450);
		}
	}
	
/* 	// 부서 & 사업소 선택
	function fn_show_type(req_dept_office) {
		var th = 'typeThSearch';
		var form = 'buyingProductStateForm';
		
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
	} */
</script>

<form id="buyingProductStateForm" name="buyingProductStateForm" onsubmit="return false;">
	<div class="sub_purple_01">
		<table  class="select_table" >
			<tr>
				<td width="20%" class="table_title">
					<span>■</span>
					구매품목현황
				</td>
				<td class="table_button">
					<!-- 
					<span class="button white mlargep" id="btn_Select" onclick="btn_Label_onclick();">
								<button type="button">라벨출력</button>
					</span>
					 -->					
					<span class="button white mlargep auth_select" id="btn_Select" onclick="btn_Select_onclick();">
						<button type="button">조회</button>
					</span>
					<span class="button white mlargeb auth_select" onclick="btn_Excel_onclick();">
						<button type="button">EXCEL</button>
					</span>
				</td>
			</tr>
		</table>

		<!-- 조회 테이블 -->
		<table  class="list_table" >
			<tr>
				<th>대분류</th>
				<td>
					<select name="h_mtlr_info" id="h_mtlr_info" style="width: 95px" onchange="comboReload()">
						<option value=" ">전체</option>
						<option value="C42">시약류</option>
						<option value="C43">소모품류</option>
					</select>
				</td>
				<th>중분류</th>
				<td>
					<select name="m_mtlr_info" id="m_mtlr_info" style="width: 115px"></select>
				</td>
				<th style="min-width: 80px;">시약/실험기구명</th>
				<td>
					<input name="item_nm" type="text" class="w200px" />
				</td>
				<th style="min-width: 80px;">바코드</th>
				<td>
					<input name="mtlr_no" type="text" class="w100px" />
				</td>
			</tr>
			<tr>
				<th>구매분기</th>
				<td>
					<select name="buy_q" id="buy_q" class="w120px"></select>
				</td>
				<th>구매년도</th>
				<td>
					<select name="buy_year" id="sel_buy_year" class="w120px"></select>
				</td>
				<th id="typeThSearch">
			<!-- <input name="req_dept_office" id="req_dept_office" type="radio" value="d" checked="checked" onClick="fn_show_type($(this).val())"/> -->
					<label for="req_dept_office">요청부서명</label>
					
<!-- 					<input name="req_dept_office" id="req_dept_office2" type="radio" value="o" onClick="fn_show_type($(this).val())"/> -->
<!-- 					<label for="req_dept_office2">요청사업소명</label> -->
				</th>
				<td>
					<select name="dept_cd" id="dept_cd" class="w120px"></select>
<!-- 					<select name="office_cd" id="office_cd" class="w120px"></select> -->
				</td>
				<th>진행상태</th>
				<td>
					<select name="state" id="state_f" class="w120px"></select>
				</td>
			</tr>
			<tr>
			<th>Cas no.</th>
				<td colspan='7'>
					<input name="spec2" type="text" class="w100px" />
				</td>
			</tr>
		</table>
	</div>
	<input type="hidden" id="mode" name="mode" value="0">
	<input type="hidden" id="key" name="key">
	<input type="hidden" id="sortName" name="sortName">
	<input type="hidden" id="sortType" name="sortType">
	<div id="view_grid_main">
		<table id="buyingProductStateGrid"></table>
	</div>
</form>

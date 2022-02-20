
<%
	/***************************************************************************************
	 * 시스템명 	: 통합장비관제시스템
	 * 업무명 		: 수불 확인(결재)
	 * 파일명 		: receivePayPaymentL01.jsp
	 * 작성자 		: 최은향
	 * 작성일 		: 2015.02.24
	 * 설  명		: 수불 확인(결재) 리스트 조회 화면
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
	var deptcd;
	var buy_sts;
	$(function() {
		/* 세부권한검사 */
		fn_auth_check();
		
		ajaxComboForm("dept_cd", "", "ALL", null, 'receivePayPaymentForm'); // 관리부서
// 		ajaxComboForm("office_cd", "", "ALL", null, 'receivePayPaymentForm'); // 사업소
		
		ajaxComboForm("inout_flag", "C50", "ALL", "", 'receivePayPaymentForm'); // 수불구분

		buy_sts = fnGridCommonCombo('C50', null);
		deptcd = fnGridCombo('dept', null);
		// 구매확정
		receivePayPaymentGrid('reagents/receivePayPaymentList.lims', 'receivePayPaymentForm', 'receivePayPaymentGrid');
		$('#receivePayPaymentGrid').clearGridData(); // 최초 조회시 데이터 안나옴

		// 엔터키 눌렀을 경우(그리드 조회)
		fn_Enter_Search('receivePayPaymentForm', 'receivePayPaymentGrid');

		//그리드 width조절하기
		$(window).bind('resize', function() {
			$("#receivePayPaymentGrid").setGridWidth($('#view_grid_main').width(), true);
		}).trigger('resize');
		
/* 		fn_show_type($('#receivePayPaymentForm').find("#req_dept_office").val()); */
	});

	// 수불 확인(결재)
	function receivePayPaymentGrid(url, form, grid) {
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
			multiselect : true,
			rowNum : -1,
			rownumbers : true,
			colModel : [ {
				label : '시약실험기구수불번호',
				width : '110',
				name : 'inout_no',
				key : true,
				hidden : true
			}, {
				label : '수불승인',
				width : '80',
				name : 'appr_flag',
				align : 'center',
				formatter : function(value) {
					if (value == "Y") {
						return '승인';
					} else if (value == "N") {
						return '미승인';
					} else {
						return '';
					}
				}
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
				label : '수불구분',
				name : 'inout_flag',
				width : '80',
				align : 'center',
				formatter : 'select',
				edittype : "select",
				editoptions : {
					value : buy_sts
				}
			}, {
				label : '상세구분',
				width : '120',
				align : 'center',
				name : 'inout_flag_detail'
			}, {
				label : '입고수량',
				width : '70',
				align : 'right',
				name : 'in_qty',
				classes : 'number_css'
			}, {
				label : '출고수량',
				width : '70',
				align : 'right',
				name : 'out_qty',
				classes : 'number_css'
			}, {
				label : '입고금액',
				width : '70',
				align : 'right',
				name : 'price',
				classes : 'number_css'
			}, {
				label : '입/출고일자',
				name : 'in_date',
				align : 'center',
				width : '90'
			}, {
				label : '이관부서(사업소)명',
				width : '120',
				name : 'trs_dept_nm'
			}, {
				label : '이관부서(사업소) 코드',
				width : '120',
				name : 'trs_dept_cd',
				hidden : true
			}, {
				label : '과장결재',
				width : '80',
				name : 'manager_sign',
				align : 'center',
				formatter : function(value) {
					if (value == "0001") {
						return '결재완료';
					} else {
						return '';
					}
				},
				hidden : true
			}, {
				label : '담당결재',
				width : '80',
				name : 'charger_sign',
				align : 'center',
				formatter : function(value) {
					if (value == "0001") {
						return '결재완료';
					} else {
						return '';
					}
				},
				hidden : true
			} ],
			emptyrecords : '데이터가 존재하지 않습니다.',
			gridComplete : function() {
				fnCheckAction(grid);
			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
				// 				if (!confirm('저장하지 않은 정보는 사라집니다. 정렬하시겠습니까?')) {
				// 					return 'stop';
				// 				}
			},
			onSelectRow : function(rowId, status, e) {
				fnEditRelease('receivePayPaymentGrid');
			},
			ondblClickRow : function(rowId, iRow, iCol, e) {
				fnEditRelease('receivePayPaymentGrid');
				$('#' + grid).jqGrid('editRow', rowId, true);
			}
		});
	}

	// 승인(저장) 클릭 이벤트
	function btn_Save_Sub_onclick(state) {
		fnEditRelease('receivePayPaymentGrid');
		var rowArr = $('#receivePayPaymentGrid').jqGrid('getGridParam', 'selarrrow');
		if (rowArr.length > 0) {
			var data = 'gridData=';
			var ids = $('#receivePayPaymentGrid').jqGrid('getGridParam', 'selarrrow');
			for ( var i in ids) {
				var row = $('#receivePayPaymentGrid').getRowData(ids[i]);
				for ( var column in row) {
					var val = row[column];
					var cell = $('#receivePayPaymentGrid').getColProp(column);
					if (cell.index != 'not') {
						data += column + '●★●' + val + '■★■';
					}
				}
				data += 'disp_order●★●' + i + '■★■';
				data += '◆★◆';
			}
			//alert(data);
			//alert(state);
			if (state == 'save') {
				var json = fnAjaxAction('reagents/updateReceivePayPayment.lims?appr_flag=Y', data);
				if (json == null) {
					$.showAlert("저장 실패하였습니다.");
				} else {
					$.showAlert("", {
						type : 'insert'
					});
					btn_Select_onclick();
				}
			} else if (state == 'cancle') {
				var json = fnAjaxAction('reagents/updateReceivePayPayment.lims?appr_flag=N', data);
				if (json == null) {
					$.showAlert("저장 실패하였습니다.");
				} else {
					$.showAlert("", {
						type : 'insert'
					});
					btn_Select_onclick();
				}
			}
		} else {
			$.showAlert('선택된 행이 없습니다.');
		}
	}

	// 리스트 조회 이벤트
	function btn_Select_onclick() {
		$('#receivePayPaymentGrid').trigger('reloadGrid');
	}
	// 대분류 콤보
	function comboReload() {
		if ($("#h_mtlr_info").val() == "C42") {
			ajaxComboForm("m_mtlr_info", "C42", "ALL", "", 'receivePayPaymentForm'); // 중분류			
		} else if ($("#h_mtlr_info").val() == "C43") {
			ajaxComboForm("m_mtlr_info", "C43", "ALL", "", 'receivePayPaymentForm'); // 중분류
		} else {
			$("#m_mtlr_info").empty();
			$("#m_mtlr_info").append("<option value=''>전체</option>");
		}
	}
	//수불구분에 따른 수불상세구분 구분
	function comboDetailReload() {
		if ($("#inout_flag").val() == "C50001") {
			ajaxComboForm("inout_flag_detail", "C51", "ALL", "", 'receivePayPaymentForm'); // 입고분류			
		} else if ($("#inout_flag").val() == "C50002") {
			ajaxComboForm("inout_flag_detail", "C53", "ALL", "", 'receivePayPaymentForm'); // 출고분류
		} else {
			$("#inout_flag_detail").empty();
			ajaxComboDetailForm('C51', 'ALL');
			ajaxComboDetailForm('C53', '');
		}
	}
	
	// 수불상세구분 전체 조회
	function ajaxComboDetailForm(thisCode, type) {
		var url = fn_getConTextPath();
		url += '/commonCode/selectCommonCodeCombo.lims';
		$.ajax({
			url : url,
			type : 'POST',
			async : false,
			dataType : 'json',
			data : "code=" + thisCode,
			timeout : 5000,
			error : function() {
				alert('Error loading XML document');
			},
			success : function(json) {
				var select = $("#receivePayPaymentForm").find("#inout_flag_detail");
				if (type == "ALL") {
					select.append("<option value=''>전체</option>");
				}
				$(json).each(function(index, entry) {
					if (type == entry["code"] || type == entry["code_Name"]) {
						select.append("<option selected value='" + entry["code"] + "'>" + entry["code_Name"] + "</option>");
					} else {
						select.append("<option value='" + entry["code"] + "'>" + entry["code_Name"] + "</option>");
					}
				});
				select.trigger('change');// 강제로 이벤트 시키기
			}
		});
	}
	
	// 부서 & 사업소 선택
/* 	function fn_show_type(req_dept_office) {
		var th = 'typeThSearch';
		var form = 'receivePayPaymentForm';
		
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
<form id="receivePayPaymentForm" name="receivePayPaymentForm" onsubmit="return false;">
	<div class="sub_purple_01">
		<table  class="select_table" >
			<tr>
				<td width="20%" class="table_title">
					<span>■</span>
					수불 목록
				</td>
				<td class="table_button" style="text-align: right; padding-right: 30px;">
					<span class="button white mlargeb auth_select" id="btn_Select" onclick="btn_Select_onclick();">
						<button type="button">조회</button>
					</span>
					<span class="button white mlargeg auth_save" id="btn_Save" onclick="btn_Save_Sub_onclick('save');">
						<button type="button">승인</button>
					</span>
					<span class="button white mlarger auth_save" id="btn_Cancle" onclick="btn_Save_Sub_onclick('cancle');">
						<button type="button">승인취소</button>
					</span>
				</td>
			</tr>
		</table>

		<!-- 조회 테이블 -->
		<table  class="list_table" >
			<tr>
				<th>수불승인</th>
				<td>
					<select name="appr_flag" id="appr_flag" style="width: 115px">
						<option value="">전체</option>
						<option value="Y">승인</option>
						<option value="N" selected>미승인</option>
					</select>
				</td>
				<th style="min-width: 100px">시약/실험기구명</th>
				<td colspan="3">
					<input name="item_nm" type="text" style="width: 300px;" />
				</td>
				<th id="typeThSearch">
<!-- 					<input name="req_dept_office" id="req_dept_office" type="radio" value="d" checked="checked" onClick="fn_show_type($(this).val())"/> -->
					<label for="req_dept_office">이관부서명</label>
<!-- 					<input name="req_dept_office" id="req_dept_office2" type="radio" value="o" onClick="fn_show_type($(this).val())"/> -->
<!-- 					<label for="req_dept_office2">이관사업소명</label> -->
				</th>
				<td>
					<select name="dept_cd" id="dept_cd" class="w120px"></select>
<!-- 					<select name="office_cd" id="office_cd" class="w120px"></select> -->
				</td>
			</tr>
			<tr>
				<th>대분류</th>
				<td>
					<select name="h_mtlr_info" id="h_mtlr_info" style="width: 115px" onChange="comboReload()">
						<option value="">전체</option>
						<option value="C42">시약류</option>
						<option value="C43">소모품류</option>
					</select>
				</td>
				<th>중분류</th>
				<td>
					<select name="m_mtlr_info" id="m_mtlr_info" style="width: 115px">
						<option value=''>전체</option>
					</select>
				</td>
				<th>수불구분</th>
				<td>
					<select name="inout_flag" id="inout_flag" style="width: 65px" onChange="comboDetailReload()"></select>
				</td>
				<th>수불상세구분</th>
				<td>
					<select name="inout_flag_detail" id="inout_flag_detail" style="width: 155px"></select>
				</td>
			</tr>
		</table>
	</div>
	<input type="hidden" id="mode" name="mode" value="0">
	<input type="hidden" id="key" name="key">
	<input type="hidden" id="sortName" name="sortName">
	<input type="hidden" id="sortType" name="sortType">
	<div id="view_grid_main">
		<table id="receivePayPaymentGrid"></table>
	</div>
</form>

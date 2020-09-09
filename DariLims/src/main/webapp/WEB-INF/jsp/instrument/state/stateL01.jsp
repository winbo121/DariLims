
<%
	/***************************************************************************************
	 * 시스템명 	: 통합장비관제시스템
	 * 업무명 		: 현황조회
	 * 파일명 		: stateL01.jsp
	 * 작성자 		: 최은향
	 * 작성일 		: 2015.02.02
	 * 설  명		: 현황조회 리스트 조회 화면
	 *---------------------------------------------------------------------------------------
	 * 변경일		 변경자		변경내역 
	 *---------------------------------------------------------------------------------------
	 * 2015.02.02    최은향		최초 프로그램 작성         
	 * 
	 *---------------------------------------------------------------------------------------
	 ****************************************************************************************/
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html >
<link rel="stylesheet" media="screen" type="text/css" href="<c:url value='/css/common/sub.css'/>" />
<script type="text/javascript">
	$(function() {
		/* 세부권한검사 */
		fn_auth_check();
		
		// 등록일자
		fnDatePickerImg('startDate');
		fnDatePickerImg('endDate');

		ajaxComboForm("dept_cd", "", "ALL", null, 'machineForm'); // 관리부서
		//$("#dept_cd option").not(":selected").attr("disabled", "disabled"); // 로그인한 자의 관리부서 외의 항목 disabled

		// 등록 장비 목록(매칭된 *Controll.java 이름, 조회시 필요한 값이 넘어갈 폼 ID, 결과값이 보여질 폼 ID)
		grid('instrument/machine.lims', 'machineForm', 'machineGrid');
		$('#machineGrid').clearGridData(); // 최초 조회시 데이터 안나옴

		// 장비현황 목록
		//gridSub('instrument/state.lims', 'formSub', 'gridSub');

		// 엔터키 눌렀을 경우(그리드 조회)
		fn_Enter_Search('machineForm', 'machineGrid');

		// 그리드 width조절하기
		$(window).bind('resize', function() {
			$("#machineGrid").setGridWidth($('#view_grid_main').width(), false);
			$("#gridSub").setGridWidth($('#view_grid_sub').width(), true);
		}).trigger('resize');

		fnSelectFirst('machineGrid');
		fnDatePicker('instl_date_List');
		//fnDatePicker('inst_buy_date_List');
	});

	var lastRowId;
	// 등록 장비 목록
	function grid(url, form, grid) {
		$('#' + grid).jqGrid({
			datatype : function(json) {
				fnGridData(url, form, grid);
			},
			height : '600',
			autowidth : true,
			loadonce : true,
			mtype : "POST",
			gridview : true,
			shrinkToFit : false,
			rowNum : -1,
			rownumbers : true,
			colModel : [ {
				label : '시험장비번호',
				name : 'inst_no',
				key : true,
				hidden : true
			}, {
				label : '장비관리번호',
				width : '80',
				align : 'center',
				name : 'inst_mng_no'
			}, {
				label : '장비명',
				width : '150',
				name : 'inst_kor_nm'
			}, {
				label : '관리부서코드(정)',
				name : 'dept_cd',
				hidden : true
			}, {
				label : '관리부서',
				width : '100',
				name : 'dept_nm'
			}, {
				label : '관리자',
				align : 'center',
				width : '80',
				name : 'mng_nm'
			}, {
				label : '관리부서코드(부)',
				name : 'mng_sub_dept_cd',
				hidden : true
			}, {
				label : '관리부서',
				width : '100',
				name : 'mng_sub_dept_nm'
			}, {
				label : '관리자',
				align : 'center',
				width : '80',
				name : 'mng_sub_nm'
			}, {
				label : '구입일자',
				width : '100',
				align : 'center',
				name : 'inst_buy_date'
			}, {
				label : '구입가격',
				name : 'buy_cost',
				width : '100',
				align : 'right',
				formatter : 'integer',
				formatoptions : {
					thousandsSeparator : ","
				}
			}, {
				label : '자산번호',
				width : '100',
				name : 'ast_no'
			}, {
				label : '물품명(조달)',
				width : '100',
				name : 'inst_jd_nm'
			}, {
				label : '물품규격번호(조달)',
				width : '80',
				align : 'center',
				name : 'inst_jd_no'
			}, {
				label : '설치장소',
				width : '150',
				name : 'instl_plc'
			}, {
				label : '장비영문명',
				width : '150',
				name : 'inst_eng_nm'
			}, {
				label : '공급업체명',
				width : '150',
				name : 'inst_vnd_nm'
			}, {
				label : '공급업체전화번호',
				width : '110',
				name : 'inst_vnd_tel'
			}, {
				label : 'LAS기기여부',
				width : '80',
				name : 'las_yn',
				align : 'left',
				formatter : function(value) {
					if (value == "Y") {
						return 'LAS기기';
					} else {
						return '일반기기';
					}
				}
			}, {
				label : 'KOLAS여부',
				width : '80',
				name : 'kolas_yn',
				align : 'left',
				formatter : function(value) {
					if (value == "Y") {
						return 'KOLAS기기';
					} else {
						return '일반기기';
					}
				}
			}, {
				label : '교정주기',
				width : '60',
				name : 'cali_period'
			}, {
				label : '내용년수',
				width : '60',
				name : 'end_year'
			}, {
				label : '보조기기',
				width : '150',
				name : 'sub_inst'
			}, {
				label : '분야용도',
				width : '150',
				name : 'fld_use'
			}, {
				label : '매뉴얼',
				width : '150',
				name : 'manual'
			}, {
				label : '소프트웨어',
				width : '150',
				name : 'software'
			}, {
				label : '전원',
				width : '30',
				name : 'pwr'
			}, {
				label : '설치일자',
				width : '100',
				align : 'center',
				name : 'instl_date'
			}, {
				label : '제조국',
				width : '100',
				name : 'make_nation'
			}, {
				label : '사용여부',
				width : '60',
				name : 'use_flag',
				align : 'center',
				formatter : function(value) {
					if (value == "Y") {
						return '사용함';
					} else {
						return '사용안함';
					}
				}
			} ],
			emptyrecords : '데이터가 존재하지 않습니다.',
			gridComplete : function() {
				$('#btn_Save_Sub1').hide();
				$('#btn_Delete_Sub1').hide();
				$('#btn_Select_Sub1').hide();
				$('#btn_New_Sub1').hide();
				fnSelectFirst(grid);
			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
			},
			onSelectRow : function(rowId, status, e) {
				$('#btn_Save_Sub1').hide();
				$('#btn_New_Sub1').show();
				$('#btn_Select_Sub1').show(); // 그리드2의 [조회] 버튼
				// 				if (rowId && rowId != lastRowId) {
				// 					caliPeriod = $('#machineGrid').getRowData(rowId).cali_period;					
				// 					$('#' + grid).jqGrid('restoreRow', lastRowId);
				// 					lastRowId = rowId;
				// 					$('#formSub').find('#inst_no').val(rowId);			
				// 					$('#gridSub').trigger('reloadGrid');
				// 					$('#detail').empty();
				// 				}
			},
			ondblClickRow : function(rowId, iRow, iCol, e) {
				//btn_Print_onclick(); RD 파일보기
			}
		});
		$('#' + grid).jqGrid('setGroupHeaders', {
			useColSpanStyle : true,
			groupHeaders : [ {
				startColumnName : 'dept_nm',
				numberOfColumns : 2,
				titleText : '정'
			}, {
				startColumnName : 'mng_sub_dept_nm',
				numberOfColumns : 2,
				titleText : '부'
			} ]
		});
	}

	// 추가 등록 버튼
	function btn_New_Sub1_onclick() {
		var rowId = $('#machineGrid').getGridParam('selrow');
		if (rowId == '') {
			//alert();
		} else {
			fnViewPage('instrument/stateD01.lims', 'detail', 'pageType=insert&inst_no=' + rowId);
			$('#detail').find('#inst_no').val(rowId);
			$('#btn_Save_Sub1').show();
			$('#btn_Delete_Sub1').hide();
			$('#btn_New_Sub1').hide();
		}
	}

	// 저장버튼(저장 & 수정) 클릭 이벤트
	function btn_Insert_onclick() {
		var inst_no = $('#detail').find('#inst_no').val();
		var id = $('#detail').find('#use_no').val();
		var url;
		var param = $('#detail').serialize();

		if (inst_no != '' || inst_no != null) {
			// 등록
			if (id == '' || id == null) {
				url = 'instrument/insertState.lims';
				// 수정
			} else {
				url = 'instrument/updateState.lims?key=' + id;
			}
			//alert($('#detail').serialize()); // java 파라미터값 확인용
			var json = fnAjaxAction(url, param);
			if (json == null) {
				$.showAlert("저장 실패하였습니다.");
			} else {
				$('#machineForm').find('#inst_no').val(json);
				$('#formSub').find('#use_no').val(json);
				$.showAlert("", {
					type : 'insert'
				});
				btn_Select_Sub1_onclick();
			}
		}
	}

	// 삭제버튼 클릭 이벤트
	function btn_Delete_onclick() {
		if (!confirm("삭제하시겠습니까?")) {
			return false;
		}
		var param = $('#detail').serialize();
		var json = fnAjaxAction('instrument/deleteState.lims', param);
		if (json == null) {
			$.showAlert("삭제 실패하였습니다.");
		} else {
			$.showAlert("", {
				type : 'delete'
			});
			$('#detail').empty();
			$('#machineGrid').trigger('reloadGrid');
			$('#gridSub').trigger('reloadGrid');
		}
	}

	// 장비 리스트 조회 이벤트
	function btn_Select_onclick() {
		var rowId = $('#machineGrid').getGridParam('selrow');
		$('#machineGrid').jqGrid('restoreRow', rowId);
		$('#machineGrid').trigger('reloadGrid');
		$("#gridSub").jqGrid("clearGridData", true);
		$('#detail').empty();
		$('#btn_Save_Sub1').hide();
		$('#btn_Delete_Sub1').hide();
		$('#btn_Select_Sub1').hide(); // 그리드2의 [조회] 버튼
		$('#btn_New_Sub1').hide(); // 그리드2의 [추가] 버튼
	}

	// 교정 장비 리스트 조회 이벤트
	function btn_Select_Sub1_onclick() {
		$('#btn_Save_Sub1').hide();
		$('#btn_Delete_Sub1').hide();
		$('#btn_New_Sub1').show();
		$('#btn_Select_Sub1').show(); // 그리드2의 [조회] 버튼
		$('#gridSub').trigger('reloadGrid');
		$('#detail').empty();
	}

	// RD 다운로드 (현재 사용안함)
	function btn_Print_onclick() {
		var rowId = $('#machineGrid').getGridParam('selrow');
		var row = $('#machineGrid').getRowData(rowId);
		var param = '[' + row.inst_no + ']';
		//alert(param);
		fn_RDView('machine', param, true, false, 900, 900);
	}

	// 엑셀다운로드
	function btn_Excel_onclick() {
		var data = fn_Excel_Data_Make('machineGrid');
		fn_Excel_Download(data);
	}
</script>
<form id="machineForm" name="machineForm" onsubmit="return false;">
	<div class="sub_purple_01">
		<table  class="select_table" >
			<tr>
				<td width="20%" class="table_title">
					<span>■</span>
					장비 목록
				</td>
				<td class="table_button">
					<span class="button white mlargep auth_select" id="btn_Select" onclick="btn_Select_onclick();">
						<button type="button">조회</button>
					</span>
					<!-- 
					<span class="button white mlargeb" id="btn_Prient" onclick="btn_Print_onclick();">
						<button type="button">상세</button>
					</span>
					-->
					<span class="button white mlargeb auth_select" onclick="btn_Excel_onclick();">
						<button type="button">EXCEL</button>
					</span>
					<!-- 
					<span class="button white mlargep" id="btn_Add" onclick="fn_ViewPage('insert');">
						<button type="button">추가</button>
					</span>
					 -->
				</td>
			</tr>
		</table>

		<!-- 조회 테이블 -->
		<table  class="list_table" >
			<tr>
				<th>장비관리번호</th>
				<td>
					<input name="inst_mng_no" type="text" style="width: 150px;" />
				</td>
				<th>장비명/영문명</th>
				<td>
					<input name="inst_kor_nm" type="text" style="width: 160px;" />
				</td>
				<th>장비구입일자</th>
				<td>
					<input name="startDate" id="startDate" type="text" style="text-align: center; width: 60px;" readonly="readonly" />
					<img src="<c:url value='/images/common/calendar_del.png'/>" id="startDateStop" style="cursor: pointer;" onClick='fn_TextClear("startDate")' /> ~
					<input name="endDate" id="endDate" type="text" style="text-align: center; width: 60px;" readonly="readonly" />
					<img src="<c:url value='/images/common/calendar_del.png'/>" id="endDateStop" style="cursor: pointer;" onClick='fn_TextClear("endDate")' />
					<!-- 					<input name="inst_buy_date" id="inst_buy_date_List" type="text" style="width: 80px; text-align: center;" /> -->
				</td>
				<th>공급업체명</th>
				<td>
					<input name="inst_vnd_nm" type="text" style="width: 160px;" />
				</td>
			</tr>

			<tr>
				<th>LAS기기여부</th>
				<td>
					<select name="las_yn" style="width: 115px">
						<option value="">전체</option>
						<option value="N">일반기기</option>
						<option value="Y">LAS기기</option>
					</select>
				</td>
				<th>KOLAS여부</th>
				<td>
					<select name="kolas_yn" style="width: 115px">
						<option value="">전체</option>
						<option value="N">일반기기</option>
						<option value="Y">KOLAS기기</option>
					</select>
				</td>
				<th>관리부서(정/부)</th>
				<td>
					<select name="dept_cd" id="dept_cd" style="width: 173px"></select>
				</td>
				<th>관리자(정/부)</th>
				<td>
					<input name="admin_user" type="text" style="width: 160px;" />
				</td>
			</tr>
			<tr>
				<th>물품명(조달)</th>
				<td>
					<input name="inst_jd_nm" type="text" style="width: 150px;" />
				</td>
				<th>물품규격번호(조달)</th>
				<td>
					<input name="inst_jd_no" type="text" style="width: 160px;" />
				</td>
				<th>자산번호</th>
				<td>
					<input name="ast_no" type="text" style="width: 160px;" />
				</td>
				<th>사용여부</th>
				<td>
					<label><input type='radio' name='use_flag' value='' style="width: 20px" />전체</label> <label><input type='radio' name='use_flag' value='Y' style="width: 20px" checked="checked" />사용함</label> <label><input type='radio' name='use_flag' value='N' style="width: 20px" />사용안함</label>
				</td>
			</tr>
			<tr>
				<th>구입가격</th>
				<td colspan="3">
					<input name="buy_cost_start" type="text" class="w80px" />
					원 ~
					<input name="buy_cost_end" type="text" class="w80px" />
					원
				</td>
				<th>사용일지대상여부</th>
				<td colspan="3">
					<label><input type='radio' name='use_his_flag' value='' style="width: 20px" checked="checked" />전체</label> <label><input type='radio' name='use_his_flag' value='Y' style="width: 20px" />대상</label> <label><input type='radio' name='use_his_flag' value='N' style="width: 20px" />미대상</label>
					<!-- <select name="use_his_flag" id="use_his_flag" class="w100px">
							<option value="">전체</option>
							<option value='Y'>대상</option>
							<option value='N'>미대상</option>
					</select> -->
				</td>
			</tr>
		</table>
	</div>
	<input type="hidden" id="sortName" name="sortName">
	<input type="hidden" id="sortType" name="sortType">
	<div id="view_grid_main">
		<table id="machineGrid"></table>
	</div>
</form>
<!-- 
<form id="formSub" name="formSub" onsubmit="return false;">
	<div class="sub_purple_01">
		<table  class="select_table" >
			<tr>
				<td width="20%" class="table_title">
					<span>■</span>
					장비 현황 목록
				</td>
				<td class="table_button">
					<span class="button white mlargep" id="btn_Select" onclick="btn_Select_Sub1_onclick();">
						<button type="button">조회</button>
					</span>
					<span class="button white mlargeb" id="btn_New_Sub1" onclick="btn_New_Sub1_onclick();">
					<button type="button">추가</button>
				</span>
				</td>
			</tr>
		</table>
	</div>
	<input type="hidden" id="inst_no" name="inst_no">
	<input type="hidden" id="pageType" name="pageType" value="sub">
	<input type="hidden" id="sortName" name="sortName">
	<input type="hidden" id="sortType" name="sortType">
	<div id="view_grid_sub">	
		<table id="gridSub"></table>
	</div>
</form>


<div class="sub_blue_01" >
	<form id="detail" name="detail" onsubmit="return false;"></form>
</div>
 -->

<%
	/***************************************************************************************
	 * 시스템명 	: 통합장비관제시스템
	 * 업무명 		: 수리등록
	 * 파일명 		: repairL01.jsp
	 * 작성자 		: 최은향
	 * 작성일 		: 2015.01.27
	 * 설  명		: 수리등록 리스트 조회 화면
	 *---------------------------------------------------------------------------------------
	 * 변경일		변경자		변경내역 
	 *---------------------------------------------------------------------------------------
	 * 2015.01.27    최은향		최초 프로그램 작성         
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

		ajaxComboForm("dept_cd", "", "${session.dept_cd}", null, 'machineForm'); // 관리부서

		// 등록 장비 목록(매칭된 *Controll.java 이름, 조회시 필요한 값이 넘어갈 폼 ID, 결과값이 보여질 폼 ID)
		grid('instrument/machine.lims', 'machineForm', 'machineGrid');
		$('#machineGrid').clearGridData(); // 최초 조회시 데이터 안나옴
		
		// 수리 장비 목록
		gridSub('instrument/repair.lims', 'formSub', 'gridSub');
		fnSelectFirst('machineGrid');
		var id;

		// 엔터키 눌렀을 경우(그리드 조회)
		fn_Enter_Search('machineForm', 'machineGrid');

		//그리드 width조절하기
		$(window).bind('resize', function() {
			$("#machineGrid").setGridWidth($('#view_grid_main').width(), false);
			$("#gridSub").setGridWidth($('#view_grid_sub').width(), true);
		}).trigger('resize');

		fnDatePicker('instl_date_List');
	});

	var lastRowId;
	// 등록 장비 목록
	function grid(url, form, grid) {
		$('#' + grid).jqGrid({
			datatype : function(json) {
				fnGridData(url, form, grid);
			},
			height : '248',
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
				label : '장비영문명',
				width : '150',
				name : 'inst_eng_nm'
			}, {
				label : '장비구입일자',
				width : '100',
				align : 'center',
				name : 'inst_buy_date'
			}, {
				label : '공급업체명',
				width : '150',
				name : 'inst_vnd_nm'
			}, {
				label : '공급업체전화번호',
				width : '110',
				name : 'inst_vnd_tel'
			}, {
				label : '주요부품',
				width : '150',
				name : 'main_part',
				hidden : true
			}, {
				label : '보조기기',
				width : '150',
				name : 'sub_inst'
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
				label : '교정주기',
				width : '60',
				name : 'cali_period'
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
				label : '설치장소',
				width : '150',
				name : 'instl_plc'
			}, {
				label : '구입가격',
				width : '100',
				align : 'right',
				name : 'buy_cost'
			}, {
				label : '제조국',
				width : '100',
				name : 'make_nation'
			}, {
				label : '특기사항',
				width : '150',
				name : 'cmt',
				hidden : true
			}, {
				label : '사진파일이름',
				width : '100',
				name : 'img_file_nm'
			}, {
				label : '자산번호',
				width : '100',
				name : 'ast_no'
			}, {
				label : '내용년수',
				width : '60',
				name : 'end_year'
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
			}, {
				label : '물품명(조달)',
				width : '100',
				name : 'inst_jd_nm'
			}, {
				label : '물품규격번호(조달)',
				width : '80',
				align : 'center',
				name : 'inst_jd_no'
			} ],
			emptyrecords : '데이터가 존재하지 않습니다.',
			gridComplete : function() {
				$('#btn_Save_Sub1').hide();
				$('#btn_Delete_Sub1').hide();
				$('#btn_Select_Sub1').hide();
				$('#btn_Add').hide();
				fnSelectFirst(grid);
			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
			},
			onSelectRow : function(rowId, status, e) {
				id = rowId;
				$('#btn_Save_Sub1').hide();
				$('#btn_Add').show();
				$('#btn_Select_Sub1').show(); // 그리드2의 [조회] 버튼
				//if (rowId && rowId != lastRowId) {
					$('#' + grid).jqGrid('restoreRow', lastRowId);
					lastRowId = rowId;
					$('#formSub').find('#inst_no').val(rowId);
					$('#gridSub').trigger('reloadGrid');
					$('#detail').empty();
				//}
			}
		});
	}

	// 수리 장비 목록
	function gridSub(url, form, grid) {
		$('#' + grid).jqGrid({
			datatype : function(json) {
				if ($('#' + form).find('#inst_no').val() != '') {
					fnGridData(url, form, grid);
				}
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
				label : '수리이력번호',
				name : 'rpr_no',
				key : true,
				hidden : true
			}, {
				label : '시험장비번호',
				width : '80',
				align : 'center',
				name : 'inst_no',
				hidden : true
			}, {
				label : '수리업체',
				width : '150',
				name : 'rpr_company'
			}, {
				label : '수리업체연락처',
				width : '110',
				name : 'rpr_tel'
			}, {
				label : '수리일자',
				width : '100',
				align : 'center',
				name : 'rpr_date',
				align : 'center'
			}, {
				label : '확인자',
				width : '50',
				align : 'center',
				name : 'rpr_user_nm'
			}, {
				label : '고장사유',
				width : '350',
				name : 'brk_reason'
			}, {
				label : '수리내용',
				width : '350',
				name : 'rpr_content'
			} ],
			emptyrecords : '데이터가 존재하지 않습니다.',
			gridComplete : function() {
				$('#btn_Select_Sub1').show();
				$('#btn_Insert').hide();
				$('#btn_Delete').hide();
			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
			},
			onSelectRow : function(rowId, status, e) {
				fnViewPage('instrument/repairD01.lims', 'detail', 'pageType=detail&rpr_no=' + rowId);
				$('#btn_Save_Sub1').show();
				$('#btn_Delete_Sub1').show();
				$('#btn_Add').show();
			}
		});
	}

	// 추가 등록 버튼
	function fn_ViewPage() {
		var rowId = $('#machineGrid').getGridParam('selrow');
		if (rowId == '') {
			//alert();
		} else {
			fnViewPage('instrument/repairD01.lims', 'detail', 'pageType=insert&inst_no=' + rowId);
			$('#detail').find('#inst_no').val(rowId);
			$('#btn_Save_Sub1').show();
			$('#btn_Delete_Sub1').hide();
			$('#btn_Add').hide();
		}
	}

	// 저장버튼(저장 & 수정) 클릭 이벤트
	function btn_Insert_onclick() {
		var id = $('#detail').find('#rpr_no').val();
		var inst_no = $('#detail').find('#inst_no').val();

		// 벨리데이션 체크
		var rprDate = $('#detail').find('#rpr_date').val();

		if (rprDate == null || rprDate == "" || rprDate.length != 10) { // null인지 비교한 뒤
			$.showAlert('날짜를 정확히 입력하세요'); // 경고창을 띄우고
			$('#detail').find('#rpr_date').focus(); // 해당태그에 포커스를 준뒤
			return false; // false를 리턴합니다.
		}

		// 모든 벨리데이션 체크에 이상이 없으면		
		if (inst_no != '' || inst_no != null) {
			var url;
			var param = $('#detail').serialize();

			// 등록			
			if (id == '' || id == null) {
				url = 'instrument/insertRepair.lims';
				// 수정
			} else {
				url = 'instrument/updateRepair.lims?key=' + id;
			}
			var json = fnAjaxAction(url, param);
			if (json == null) {
				$.showAlert("저장 실패하였습니다.");
			} else {
				$('#machineForm').find('#inst_no').val(json);
				$('#formSub').find('#rpr_no').val(json);
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
		var json = fnAjaxAction('instrument/deleteRepair.lims', param);
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
		$('#gridSub').trigger('reloadGrid');
		$('#detail').empty();
		$('#btn_Save_Sub1').hide();
		$('#btn_Delete_Sub1').hide();
		$('#btn_Select_Sub1').hide(); // 그리드2의 [조회] 버튼
		$('#btn_Add').hide(); // 그리드2의 [추가] 버튼
	}

	// 수리 장비 리스트 조회 이벤트
	function btn_Select_Sub1_onclick() {
		$('#btn_Save_Sub1').hide();
		$('#btn_Delete_Sub1').hide();
		$('#btn_Add').show();
		$('#btn_Select_Sub1').show(); // 그리드2의 [조회] 버튼
		$('#gridSub').trigger('reloadGrid');
		$('#detail').empty();
	}

	// 확인자 아이디 등록팝업
	function btn_Pop_AdminChoice() {
		
		fnBasicStartLoading();		
		fnpop_UserInfoPop("detail", "500", "500", "repair", '');
	}
	
	function fnpop_callback(){
		
	}
	
	// 엑셀 다운로드
	function btn_Excel_onclick() {
		var bigDivName = null;
		var bigDivData = null;
		var rowId = $('#machineGrid').getGridParam('selrow');  
		var row = $('#machineGrid').getRowData(rowId);
		bigDivName = '장비명';
		bigDivData = row.inst_kor_nm;
		var data = fn_Excel_Data_Make2('gridSub', bigDivName, bigDivData);
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
					<label><input type='radio' name='use_flag' value='' style="width: 20px" checked="checked" />전체</label> <label><input type='radio' name='use_flag' value='Y' style="width: 20px" />사용함</label> <label><input type='radio' name='use_flag' value='N' style="width: 20px" />사용안함</label>
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

<form id="formSub" name="formSub" onsubmit="return false;">
	<div class="sub_purple_01">
		<table  class="select_table" >
			<tr>
				<td width="20%" class="table_title">
					<span>■</span>
					장비 수리 목록
				</td>
				<td class="table_button">
					<span class="button white mlargep auth_select" id="btn_Select" onclick="btn_Select_Sub1_onclick();">
						<button type="button">조회</button>
					</span>					
					<span class="button white mlargep auth_save" id="btn_Add" onclick="fn_ViewPage('insert');">
						<button type="button">추가</button>
					</span>
					<span class="button white mlargeb auth_select" onclick="btn_Excel_onclick();">
						<button type="button">EXCEL</button>
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

<div class="sub_blue_01">
	<form id="detail" name="detail" onsubmit="return false;"></form>
</div>
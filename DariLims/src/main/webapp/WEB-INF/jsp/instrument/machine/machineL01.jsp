
<%
	/***************************************************************************************
	 * 시스템명 	: 통합장비관제시스템
	 * 업무명 		: 장비등록
	 * 파일명 		: machineL01.jsp
	 * 작성자 		: 최은향
	 * 작성일 		: 2015.01.21
	 * 설  명		: 장비등록 리스트 조회 화면
	 *---------------------------------------------------------------------------------------
	 * 변경일		 변경자		변경내역 
	 *---------------------------------------------------------------------------------------
	 * 2015.01.21	 최은향		최초 프로그램 작성         
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

		//$('#startDate').val(fnGetToday(12,0));
		//$('#endDate').val(fnGetToday(0,0));

		ajaxComboForm("dept_cd", "", "ALLNAME", null, 'machineForm'); // 관리부서
		//$("#dept_cd option").not(":selected").attr("disabled", "disabled"); // 로그인한 자의 관리부서 외의 항목 disabled
		
		//url명명 규칙(p.21) 
		grid('instrument/machine.lims', 'machineForm', 'machineGrid');
		$('#machineGrid').clearGridData(); // 최초 조회시 데이터 안나옴
		
		// 엔터키 눌렀을 경우(그리드 조회)
		fn_Enter_Search('machineForm', 'machineGrid');

		//그리드 width조절하기
		$(window).bind('resize', function() {
			$("#machineGrid").setGridWidth($('#view_grid_main').width(), false);
		}).trigger('resize');

		//fnSelectFirst('grid');		
		fnDatePicker('instl_date_List');
		//fnDatePicker('inst_buy_date_List');
	});

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
				label : '관리부서',
				width : '100',
				name : 'dept_nm'
			}, {
				label : '관리자',
				align : 'center',
				width : '80',
				name : 'mng_nm'
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
				label : '관리부서',
				width : '100',
				name : 'dept_nm2'
			}, {
				label : '관리자',
				align : 'center',
				width : '80',
				name : 'mng_nm2'
			}, {
				label : '관리부서',
				width : '100',
				name : 'mng_sub_dept_nm2'
			}, {
				label : '관리자',
				align : 'center',
				width : '80',
				name : 'mng_sub_nm2'
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
				label : '외부',
				width : '50',
				name : 'cali_io'
			}, {
				label : '내부',
				width : '50',
				name : 'cali_period'
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
				$('#btn_Add').show();
				$('#btn_Insert').hide();
			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
			},
			onSelectRow : function(rowId, status, e) {
				$('#btn_Add').show();
				$('#btn_Insert').hide();
				btn_Row_onclick();
				if ($('#machineGrid').getRowData(rowId).cali_period_flag == "불필요") {
					$("#cali_period_select").attr("disabled", true);
				} else {
					$("#cali_period_select").removeAttr("disabled");
				}
			}
		});
		$('#' + grid).jqGrid('setGroupHeaders', {
			useColSpanStyle : true,
			groupHeaders : [ {
				startColumnName : 'dept_nm',
				numberOfColumns : 2,
				titleText : '중간점검-정'
			}, {
				startColumnName : 'mng_sub_dept_nm',
				numberOfColumns : 2,
				titleText : '중간점검-부'
			}, {
				startColumnName : 'dept_nm2',
				numberOfColumns : 2,
				titleText : '교정-정'
			}, {
				startColumnName : 'mng_sub_dept_nm2',
				numberOfColumns : 2,
				titleText : '교정-부'
			}, {
				startColumnName : 'cali_io',
				numberOfColumns : 2,
				titleText : '교정주기'
			} ]
		});
	}

	// 저장버튼(저장 & 수정) 클릭 이벤트
	function btn_Insert_onclick() {
		var id = $('#detail').find('#inst_no').val();

		// 벨리데이션 체크
		var buyDate = $('#detail').find('#inst_buy_date_Detail').val();
		var setupDate = $('#detail').find('#instl_date_Detail').val();
		var radioCheck1 = $(':radio[id="las_yn"]:checked').val();
		var radioCheck2 = $(':radio[id="kolas_yn"]:checked').val();
		var endYear = $('#detail').find('#end_year').val();
		var intchk_date = $('#detail').find('#intchk_date').val();
		var crt_date = $('#detail').find('#crt_date').val();
		
		if (radioCheck1 == null || radioCheck1 == "") {
			$.showAlert('"LAS 기기여부"를 선택 하세요');
			$('#detail').find('#las_yn').focus();
			return false;
		}
		if (/[^0-9]/.test(endYear)) {
			$('#detail').find('#end_year').val(endYear.replace(/[^0-9]/g, "")); // 숫자 아닌 문자 삭제
			endYear = endYear.replace(/[^0-9]/g, "");
			$.showAlert('숫자만 입력하세요');
			$('#detail').find('#end_year').focus();
			return false;
		}
/* 		if (intchk_date == null || intchk_date == "" || crt_date == null || crt_date == "" ) { // null인지 비교한 뒤
			$.showAlert('차기점검일과 차기교정일을 정확히 입력하세요'); // 경고창을 띄우고
		
			return false; // false를 리턴합니다.
		} */
		
		//	교정-내부(중간점검) 가 필요일 경우 
		if($(":input:radio[name=cali_period_flag]:checked").val() == 'Y'){
			if($('#detail').find('#intchk_date').val() == '' || $('#detail').find('#intchk_date').val() == null) {
				$.showAlert('차기교정일자를 입력해주세요.');
				return false;
			}
		}
		//	교정-외부 가 필요일 경우 
		if($(":input:radio[name=cali_io_flag]:checked").val() == 'Y'){
			if($('#detail').find('#crt_date').val() == '' || $('#detail').find('#intchk_date').val() == null) {
				$.showAlert('차기점검일자를 입력해주세요.');
				return false;
			}
		}
	
		if (buyDate == null || buyDate == "" || buyDate.length != 10) { // null인지 비교한 뒤
			$.showAlert('날짜를 정확히 입력하세요'); // 경고창을 띄우고
			$('#detail').find('#inst_buy_date_Detail').focus(); // 해당태그에 포커스를 준뒤
			return false; // false를 리턴합니다.
		}
		

		// 필요체크여부		
		if ($(':radio[name="cali_period_flag"]:checked').val() == 'Y') {
			if ($("#cali_period_select").val() == '' || $("#cali_period_select").val() == null) {
				$.showAlert('교정주기를 선택하세요.');
				$('#detail').find('#cali_period_select').focus();
				return false;
			}
		}

		if (radioCheck2 == null || radioCheck2 == "") {
			$.showAlert('KOLAS 기기여부"를 선택 하세요');
			$('#detail').find('#kolas_yn').focus();
			return false;
		}

		if (setupDate == null || setupDate == "" || setupDate.length != 10) {
			$.showAlert('날짜를 정확히 입력하세요');
			$('#detail').find('#instl_date_Detail').focus();
			return false;
		}

		// 모든 벨리데이션 체크에 이상이 없으면
		// 등록
		if (id == '' || id == null) {
			// 이미지 파일이 있을때
			if ($('#detail').find('#m_img').val() != '') {
				var json = fnAjaxFileAction('instrument/insertMachine.lims', 'detail', fn_suc);
			} else {
				var param = $('#detail').serialize();
				var json = fnAjaxAction('instrument/insertMachine.lims', param);
				if (json == null) {
					$.showAlert("저장 실패하였습니다.");
				} else {
					$('#machineForm').find('#inst_no').val(json);
					$.showAlert("", {
						type : 'insert'
					});
					btn_Select_onclick();
				}
			}
			// 수정
		} else {
			// 이미지 파일이 있을때
			if ($('#detail').find('#m_img').val() != '') {
				var json = fnAjaxFileAction('instrument/updateMachine.lims?key=${detail.inst_no}', 'detail', fn_suc);
			} else {
				var param = $('#detail').serialize();
				var json = fnAjaxAction('instrument/updateMachine.lims?key=${detail.inst_no}', param);
				if (json == null) {
					$.showAlert("저장 실패하였습니다.");
				} else {
					$('#machineForm').find('#inst_no').val(json);
					$.showAlert("", {
						type : 'insert'
					});
					btn_Select_onclick();
				}
			}
		}
	}

	// 저장 이벤트
	function fn_suc(json) {
		if (json == null) {
			$.showAlert("저장 실패하였습니다.");
		} else {
			$('#machineForm').find('#inst_no').val(json);
			$.showAlert("", {
				type : 'insert'
			});
			btn_Select_onclick();
		}
	}

	// 해당줄 클릭 이벤트(상세페이지 보기)
	function btn_Row_onclick() {
		var param = 'key=' + $('#machineGrid').getGridParam('selrow');
		fnViewPage('instrument/machineD01.lims?pageType=detail', 'detail', param);
		
		var inst_no = $('#detail').find('#inst_no').val();
		var random = Math.random();		
		$('#img').html('<img src="instrument/machineImage.lims?inst_no='+ inst_no +'&random='+ random +'" style="width: 250px; height: 160px;" />');
		
		$('#btn_Add').show();
		$('#btn_Insert').show();
		return false;
	}

	// 삭제버튼 클릭 이벤트
	function btn_Delete_onclick() {
		if (!confirm("삭제하시겠습니까?")) {
			return false;
		}
		var param = $('#detail').serialize();
		var json = fnAjaxAction('instrument/deleteMachine.lims', param);
		if (json == null) {
			$.showAlert("삭제 실패하였습니다.");
		} else {
			$.showAlert("", {
				type : 'delete'
			});
			$('#detail').empty();
			$('#machineGrid').trigger('reloadGrid');
		}
	}

	// 추가버튼 클릭 이벤트
	function fn_ViewPage(pageType) {
		$('#detail').find('#inst_no').val(''); // 해당 seq 삭제
		//$('#machineGrid').trigger('reloadGrid'); // 셀클릭 해제
		$('#machineGrid').jqGrid('resetSelection');
		fnViewPage('instrument/machineD01.lims?pageType=' + pageType, 'detail', null);
		$('#btn_Add').show();
		$('#btn_Insert').show();
	}

	// 리스트 조회 이벤트
	function btn_Select_onclick() {
		$('#detail').empty();
		$('#machineGrid').trigger('reloadGrid');
	}

	// 이미지 업로드 이벤트
	function setFile() {
		$('#m_img').trigger('click');

		var name = $('#m_img').val();
		if (name != '') {
			name = name.substring(name.lastIndexOf('\\') + 1);
			$('#file_name').html(name);
		}
	}

	// 엑셀 다운로드
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
					<span class="button white mlargep auth_save" id="btn_Add" onclick="fn_ViewPage('insert');">
						<button type="button">추가</button>
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
<div class="sub_blue_01">
	<form id="detail" name="detail" onsubmit="return false;"></form>
</div>
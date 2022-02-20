
<%
	/***************************************************************************************
	 * 시스템명 	: 통합장비관제시스템
	 * 업무명 		: 사용일지
	 * 파일명 		: useLogL01.jsp
	 * 작성자 		: 최은향
	 * 작성일 		: 2015.03.25
	 * 설  명		: 사용일지 리스트 조회 화면
	 *---------------------------------------------------------------------------------------
	 * 변경일		 변경자		변경내역 
	 *---------------------------------------------------------------------------------------
	 * 2015.03.25    최은향		최초 프로그램 작성         
	 * 
	 *---------------------------------------------------------------------------------------
	 ****************************************************************************************/
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html >
<link rel="stylesheet" media="screen" type="text/css" href="<c:url value='/css/common/sub.css'/>" />
<style>
.ttt .ui-datepicker-calendar {
	display: none;
}
</style>
<script type="text/javascript">
	var machineNo;
	var useNo;

	$(function() {
		/* 세부권한검사 */
		fn_auth_check();
		
		// 장비목록 달력
		fnDatePickerImg('startDate');
		fnDatePickerImg('endDate');

		// 사용일지 달력
		$('#startDateSub').val(fnGetToday(1,0));
		$('#endDateSub').val(fnGetToday(0,0));
		//$('#startDateSub').val(fnGetToday(1,0).substring(0,7));
		//$('#endDateSub').val(fnGetToday(0,0).substring(0,7));

		fnDatePickerImg('startDateSub');
		fnDatePickerImg('endDateSub');

		//ajaxComboForm("dept_cd", "", "ALL", null, 'machineForm'); // 관리부서
		ajaxComboForm("dept_cd", "", "${session.dept_cd}", null, 'machineForm'); // 관리부서
		//$("#dept_cd option").not(":selected").attr("disabled", "disabled"); // 로그인한 자의 관리부서 외의 항목 disabled

		// 등록 장비 목록(매칭된 *Controll.java 이름, 조회시 필요한 값이 넘어갈 폼 ID, 결과값이 보여질 폼 ID)
		//grid('instrument/machineState.lims', 'machineForm', 'machineGrid');
		grid('instrument/machine.lims', 'machineForm', 'machineGrid');
		$('#machineGrid').clearGridData(); // 최초 조회시 데이터 안나옴

		// 장비현황 목록
		gridSub('instrument/useLog.lims', 'formSub', 'gridSub');
		$('#gridSub').clearGridData(); // 최초 조회시 데이터 안나옴

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
			height : '148',
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
				label : '관리부서',
				width : '100',
				name : 'dept_nm'
			}, {
				label : '관리부서코드',
				name : 'dept_cd',
				hidden : true
			}, {
				label : '관리자',
				align : 'center',
				width : '80',
				name : 'admin_user'
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
				$('#btn_New_Sub1').hide();
				fnSelectFirst(grid);
			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
			},
			onSelectRow : function(rowId, status, e) {
				$('#btn_Save_Sub1').hide();
				$('#btn_Delete_Sub1').hide();
				$('#btn_New_Sub1').show();
				$('#btn_Select_Sub1').show(); // 그리드2의 [조회] 버튼
				$('#formSub').find('#inst_no').val(rowId);
				//if (rowId && rowId != lastRowId) {
					caliPeriod = $('#machineGrid').getRowData(rowId).cali_period;
					$('#gridSub').jqGrid('restoreRow', lastRowId);
					$('#gridSub').trigger('reloadGrid');
					lastRowId = rowId;
				//}
			}
		});
	}

	// 사용일지 목록
	function gridSub(url, form, grid) {
		$('#' + grid).jqGrid({
			datatype : function(json) {
				if ($('#' + form).find('#inst_no').val() != '') {
					fnGridData(url, form, grid);
				}
			},
			height : '350',
			autowidth : true,
			loadonce : true,
			mtype : "POST",
			gridview : true,
			shrinkToFit : true,
			rowNum : -1,
			rownumbers : true,
			colModel : [ {
				label : '사용이력번호',
				name : 'use_no',
				key : true,
				hidden : true
			}, {
				label : '시험장비번호',
				name : 'inst_no',
				hidden : true
			}, {
				label : 'crud',
				name : 'crud',
				hidden : true
			}, {
				label : '사용시작일',
				width : '80',
				align : 'center',
				editable : true,
				editoptions : {
					dataInit : function(elem) {
						fnDatePicker(elem.getAttribute('id'));
					}
				},
				name : 'use_sdate'
			}, {
				label : '시',
				width : '30',
				align : 'center',
				editable : true,
				name : 'use_stime'
			}, {
				label : '사용종료일',
				type : 'not',
				width : '80',
				align : 'center',
				editable : true,
				editoptions : {
					dataInit : function(elem) {
						fnDatePicker(elem.getAttribute('id'));
					}
				},
				name : 'use_edate'
			}, {
				label : '시',
				width : '30',
				align : 'center',
				editable : true,
				name : 'use_etime'
			}, {
				label : '사용시간',
				width : '50',
				align : 'center',
				editable : true,
				name : 'use_time'
			}, {
				label : '사용목적',
				width : '150',
				editable : true,
				name : 'use_purpose'
			}, {
				label : '장비사용자ID',
				width : '80',
				name : 'his_user',
				classes : 'his_user',
				hidden : true
			}, {
				label : '장비사용자',
				width : '80',
				name : 'his_user_nm',
				classes : 'his_user_nm',
				type : 'not',				
				align : 'center',
				editoptions : {
					readonly : "readonly"
				}
			}, {
				type : 'not',
				label : ' ',
				name : 'his_user_pop',
				width : '20',
				align : 'center',
				classes : 'grid_cursor',
				formatter : imageFormat
			}, {
				type : 'not',
				label : ' ',
				name : 'his_user_del',
				width : '20',
				align : 'center',
				classes : 'grid_cursor',
				formatter : deleteImageFormat
			}, {
				label : '장비사용비고',
				width : '350',
				editable : true,
				name : 'use_etc'
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
			onCellSelect : function(rowId, iCol, cellcontent, e) {
				var row = $('#' + grid).getRowData(rowId);
				var colArr = $('#' + grid).jqGrid('getGridParam', 'colModel');
				var col = colArr[iCol].name;
				//var colId = colArr[iCol].id;

				//alert(colId);

				// 사용 종료일을 누르면,
				// 				if(colId == '0_use_edate'){
				// 					alert(row.use_sdate);
				// 					$('#' + grid).jqGrid('setCell', rowId, 'use_edate', row.use_sdate);
				// 					$('#' + grid).jqGrid('setCell', rowId, 'use_etime', row.use_stime + 1);
				// 				}

				// 사용자 팝업 아이콘을 누르면,
				if (col == 'his_user_pop' && (row.crud == 'u' || row.crud == 'c')) {
					btn_Pop_AdminChoice();
					/* var ret = btn_Pop_AdminChoice();
					if (ret != null && ret != '') {
						var arr = ret.split('■★■');
						for ( var r in arr) {
							var v = arr[r].split('●★●');
							if (r == '0') {
								$('#' + grid).jqGrid('setCell', rowId, 'his_user_nm', v[1]);
							}
							if (r == '1') {
								$('#' + grid).jqGrid('setCell', rowId, 'his_user', v[1]);
							}
						}
					} */
				} else if (col == 'his_user_del' && (row.crud == 'u' || row.crud == 'c')) {
					$('#' + grid).jqGrid('setCell', rowId, 'his_user_nm', null);
					$('#' + grid).jqGrid('setCell', rowId, 'his_user', null);
				}
			},
			onSelectRow : function(rowId, status, e) {
				if (rowId && rowId != lastRowId) {
					$('#' + grid).jqGrid('restoreRow', lastRowId);
					lastRowId = rowId;
					btn_Row_onclick();
				}
			},
			ondblClickRow : function(rowId, iRow, iCol, e) {
				$('#' + grid).setCell(rowId, 'crud', 'u');
				fnGridEdit(grid, rowId, fn_Row_Click);
				$('#' + grid).jqGrid('editRow', rowId, true);
				$('#btn_Save_Sub1').show();
				$('#btn_New_Sub1').hide();
			}
		});
	}

	// 해당줄 클릭 이벤트(상세페이지 보기)
	function btn_Row_onclick() {
		$('#btn_Delete_Sub1').show();
		$('#btn_New_Sub1').show();
		$('#btn_Save_Sub1').hide();
		return false;
	}

	// 추가 등록 버튼
	function btn_New_Sub1_onclick() {
		var rowId = $('#machineGrid').getGridParam('selrow');
		if (rowId == '') {
			//alert();
		} else {
			fnViewPage('instrument/useLogD01.lims', 'detail', 'pageType=insert&inst_no=' + rowId);
			$('#detail').find('#inst_no').val(rowId);
			$('#btn_Save_Sub1').show();
			$('#btn_Delete_Sub1').hide();
			$('#btn_New_Sub1').hide();
		}
	}

	// 저장버튼(저장 & 수정) 클릭 이벤트
	function btn_Insert_onclick() {
		var grid = 'gridSub';
		var rowId = $('#' + grid).getGridParam('selrow');
		var pageType = '';
		var inst_no = $('#formSub').find('#inst_no').val();
		var his_user = $('#' + grid).getRowData(rowId).his_user;
		
		if($('#0_use_sdate').val() == ''){
			$.showAlert("사용시작 일자를 입력하여 주십시오.");
			return;
		}
		if($('#0_use_stime').val() == ''){
			$.showAlert("사용시작 시간을 입력하여 주십시오.");
			return;
		}
		if($('#0_use_edate').val() == ''){
			$.showAlert("사용종료 일자를 입력하여 주십시오.");
			return;
		}
		if($('#0_use_etime').val() == ''){
			$.showAlert("사용종료 시간을 입력하여 주십시오.");
			return;
		}
		
		if (rowId == '' || rowId == null || rowId == '0' || rowId.substring(0, 3) == 'jqg') {
			pageType = 'insert';
		} else {
			pageType = 'update';
		}

		$('#' + grid).jqGrid('saveRow', rowId, successfunc, 'instrument/insertUseLog.lims', {
			pageType : pageType,
			use_no : rowId,
			inst_no : inst_no,
			his_user : his_user
		}, fn_Success_inserDetail, null, null);
	}

	// 저장 후 콜백 이벤트
	function fn_Success_inserDetail(json) {
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

	// 삭제버튼 클릭 이벤트
	function btn_Delete_onclick() {
		var grid = 'gridSub';
		var rowId = $('#' + grid).getGridParam('selrow');
		if (!confirm("삭제하시겠습니까?")) {
			return false;
		}
		var json = fnAjaxAction('instrument/deleteUseLog.lims?use_no=' + rowId, "");
		if (json == null) {
			$.showAlert("삭제 실패하였습니다.");
		} else {
			$.showAlert("", {
				type : 'delete'
			});
			//$('#machineGrid').trigger('reloadGrid');
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

	// 사용자 등록팝업
	function btn_Pop_AdminChoice() {
		
		fnBasicStartLoading();		
		fnpop_UserInfoPop("gridSub", "500", "500", 'userLog', '');
		
		/* var obj = new Object();
		obj.msg1 = 'userChoice.lims';
		return fnShowModalWindow("popMain.lims", obj, 720, 410); */

		// 		var form = 'detail';
		// 		var popup = popUserInfo();
		// 		if (popup != null) {
		// 			var arr = popup.split('■★■');
		// 			for ( var r in arr) {
		// 				var v = arr[r].split('●★●');
		// 				var id = v[0];
		// 				if (id == 'user_nm') {
		// 					id = 'his_user'; // 이름
		// 				} else if (id == 'user_id') {
		// 					id = 'his_user_nm';// ID
		// 				}
		// 				$('#' + form).find('#' + id).val(v[1]);
		// 			}
		// 		}
	}
	
	function fnpop_userLogcallback(){
		fnBasicEndLoading();
	}

	// 행추가
	function btn_AddLine_onclick() {
		var grid = 'gridSub';
		$('#' + grid).jqGrid('addRow', {
			rowID : 0,
			position : 'last'
		});
		fnGridEdit(grid, 0, fn_Row_Click(0));
		$('#' + grid).setCell(0, 'crud', 'c');

		$('#' + 0 + '_crud').focus();
		$('#btn_New_Sub1').hide();
		$('#btn_Save_Sub1').show();
		$('#btn_Delete_Sub1').hide();
		// 		$('#btn_Save').show();
		// 		$('#btn_Delete').hide();
	}

	function fn_Row_Click(rowId) {
		var use_stime = rowId + "_use_stime";
		var use_sdate = rowId + "_use_sdate";
		var use_etime = rowId + "_use_etime";
		var use_edate = rowId + "_use_edate";
		var use_time = rowId + "_use_time";

		$('#' + use_stime).keyup(function() {
			var hour = $('#' + use_stime).val();
			if (hour != '') {
				if (!fnIsNumeric(hour)) {
					$.showAlert('숫자만 입력가능합니다.');
					$('#' + use_stime).val(hour.substring(0, hour.length - 1));
				} else {
					if (hour.length > 2) {
						$('#' + use_stime).val(hour.substring(0, hour.length - 1));
					} else {
						if (Number(hour) > 23) {
							$.showAlert('0 ~ 23 까지만 입력가능합니다.');
							$('#' + use_stime).val('');
						}
					}
				}
			}
			$('#' + use_stime).focus();
		});
		$('#' + use_stime).blur(function() {
			var hour = $('#' + use_stime).val();
			if (hour.length == 1) {
				hour = '0' + hour;
			} else if (hour.length == 0) {
				hour = '00';
			}
			$('#' + use_stime).val(hour);
		});

		$('#' + use_etime).keyup(function() {
			var hour = $('#' + use_etime).val();
			if (hour != '') {
				if (!fnIsNumeric(hour)) {
					$.showAlert('숫자만 입력가능합니다.');
					$('#' + use_etime).val(hour.substring(0, hour.length - 1));
				} else {
					if (hour.length > 2) {
						$('#' + use_etime).val(hour.substring(0, hour.length - 1));
					} else {
						if (Number(hour) > 23) {
							$.showAlert('0 ~ 23 까지만 입력가능합니다.');
							$('#' + use_etime).val('');
						}
					}
				}
				var sDateTime = $('#' + use_sdate).val().replace(/-/gi, '') + $('#' + use_stime).val();
				var eDateTime = $('#' + use_edate).val().replace(/-/gi, '') + $('#' + use_etime).val();
				
				var syear = sDateTime.substr(0,4);
				var smonth = sDateTime.substr(4,2);
				var sday = sDateTime.substr(6,2);
				var shour = sDateTime.substr(8);
				
				var eyear = eDateTime.substr(0,4);
				var emonth = eDateTime.substr(4,2);
				var eday = eDateTime.substr(6,2);
				var ehour = eDateTime.substr(8);
				
				var sdate = new Date(syear, smonth, sday, shour);
				var edate = new Date(eyear, emonth, eday, ehour);
				
				var useDate = edate - sdate;
				
				useDate = useDate / 60 / 60 / 1000;
				$('#' + use_time).val(useDate);
				
			}
			$('#' + use_etime).focus();
		});
		
		$('#' + use_etime).blur(function() {
			var hour = $('#' + use_etime).val();
			if (hour.length == 1) {
				hour = '0' + hour;
			} else if (hour.length == 0) {
				hour = '00';
			}
			$('#' + use_etime).val(hour);
		});
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
				<td colspan="7">
					<input name="buy_cost_start" type="text" class="w80px" />
					원 ~
					<input name="buy_cost_end" type="text" class="w80px" />
					원
					<!-- 사용일지대상여부 = 'Y' 만 보이게 -->
					<input name="use_his_flag" value="Y" type="hidden" />
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
					사용일지
				</td>
				<td class="table_button">
					<span class="button white mlargep auth_select" id="btn_Select" onclick="btn_Select_Sub1_onclick();">
						<button type="button">조회</button>
					</span>
					<span class="button white mlargeb auth_save" id="btn_New_Sub1" onclick="btn_AddLine_onclick();">
						<button type="button">추가</button>
					</span>
					<span class="button white mlargeg auth_save" id="btn_Save_Sub1" onclick="btn_Insert_onclick();">
						<button type="button">저장</button>
					</span>
					<span class="button white mlarger auth_save" id="btn_Delete_Sub1" onclick="btn_Delete_onclick();">
						<button type="button">삭제</button>
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
				<th>사용기간</th>
				<td>
					<input name="startDate" id="startDateSub" type="text" style="text-align: center; width: 80px;" readonly="readonly" />
					<img src="<c:url value='/images/common/calendar_del.png'/>" id="startDateStop" style="cursor: pointer;" onClick='fn_TextClear("startDateSub")' /> ~
					<input name="endDate" id="endDateSub" type="text" style="text-align: center; width: 80px;" readonly="readonly" />
					<img src="<c:url value='/images/common/calendar_del.png'/>" id="endDateStop" style="cursor: pointer;" onClick='fn_TextClear("endDateSub")' />
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
<!-- 
<div class="sub_blue_01" >
	<form id="detail" name="detail" onsubmit="return false;"></form>
</div>
 -->
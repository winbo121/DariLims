
<%
	/***************************************************************************************
	 * 시스템명 	: 통합장비관제시스템
	 * 업무명 		: 교정등록
	 * 파일명 		: correctionL01.jsp
	 * 작성자 		: 최은향
	 * 작성일 		: 2015.01.29
	 * 설  명		: 교정등록 리스트 조회 화면
	 *---------------------------------------------------------------------------------------
	 * 변경일		변경자		변경내역 
	 *---------------------------------------------------------------------------------------
	 * 2015.01.29    최은향		최초 프로그램 작성         
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
		
		if("${pageType}" == "B"){
			$('#tabs').tabs({
				active : 0
			});
		}else{
			$('#tabs').tabs({
				active : 1
			});			
		}
		
		// 등록일자
		fnDatePickerImg('startDate');
		fnDatePickerImg('endDate');
		$('#cntType').val("${cntType}").attr("selected","selected")
		ajaxComboForm("dept_cd", "", "ALLNAME", null, 'machineForm'); // 관리부서

		// 등록 장비 목록(매칭된 *Controll.java 이름, 조회시 필요한 값이 넘어갈 폼 ID, 결과값이 보여질 폼 ID)
		grid('instrument/machine.lims', 'machineForm', 'machineGrid');
		
		
		
		// 교정 장비 목록
		gridSub('instrument/correction.lims', 'formSub', 'gridSub');
		// 중간점검 목록
		gridSub2('instrument/correction2.lims', 'formSub2', 'gridSub2');

		// 엔터키 눌렀을 경우(그리드 조회)
		fn_Enter_Search('machineForm', 'machineGrid');

		//그리드 width조절하기
		$(window).bind('resize', function() {
			$("#machineGrid").setGridWidth($('#view_grid_main').width(), false);
			$("#gridSub").setGridWidth($('#view_grid_sub').width(), true);
			$("#gridSub2").setGridWidth($('#view_grid_sub2').width(), true);
		}).trigger('resize');

		fnSelectFirst('machineGrid');
		fnDatePicker('instl_date_List');
	});

	//탭 클릭시 이벤트
 	$('#tabs').tabs({
		create : function(event, ui) {
			$(window).bind('resize', function() {
				$("#machineGrid").setGridWidth($('#view_grid_main').width(), false);
				$("#gridSub").setGridWidth($('#view_grid_sub').width(), true);
				$("#gridSub2").setGridWidth($('#view_grid_sub2').width(), true);
			}).trigger('resize');
		},
		activate : function(event, ui) {
			$(window).bind('resize', function() {
				$("#machineGrid").setGridWidth($('#view_grid_main').width(), false);
				$("#gridSub").setGridWidth($('#view_grid_sub').width(), true);
				$("#gridSub2").setGridWidth($('#view_grid_sub2').width(), true);
			}).trigger('resize');
		}
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
				label : 'inst_no',
				name : 'inst_no',
				width : '70',
				align : 'center',
				hidden : true,
				key : true
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
				label : '외부',
				width : '50',
				name : 'cali_io'
			}, {
				label : '내부',
				width : '50',
				name : 'cali_period'
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
				label : '설치장소',
				width : '150',
				name : 'instl_plc'
			}, {
				label : 'Serial no.',
				width : '100',
				align : 'right',
				name : 'serial_number'
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
			}, {
				label : '교정여부',
				width : '80',
				align : 'center',
				name : 'cali_period_flag'
			} ],
			emptyrecords : '데이터가 존재하지 않습니다.',
			gridComplete : function() {
				$('#btn_Save_Sub1').hide();
				$('#btn_Delete_Sub1').hide();
				$('#btn_Select_Sub1').hide();
				$('#btn_Add').hide();
				
				$('#btn_Save_Sub2').hide();
				$('#btn_Delete_Sub2').hide();
				$('#btn_Select_Sub2').hide();
				$('#btn_Add2').hide();
				fnSelectFirst(grid);
			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
			},
			onSelectRow : function(rowId, status, e) {
				$('#btn_Save_Sub1').hide();
				$('#btn_Add').show();
				$('#btn_Select_Sub1').show(); // 그리드2의 [조회] 버튼
				
				$('#btn_Save_Sub2').hide();
				$('#btn_Add2').show();
				$('#btn_Select_Sub2').show(); // 그리드2의 [조회] 버튼
				
				if (rowId) {
					$('#' + grid).jqGrid('restoreRow', lastRowId);
					lastRowId = rowId;
					$('#formSub').find('#inst_no').val(rowId);
					$('#formSub2').find('#inst_no').val(rowId);
					$('#gridSub').trigger('reloadGrid');
					$('#gridSub2').trigger('reloadGrid');
					
					$('#detail').empty();
					$('#detail2').empty();
				}
			}
		});
		
		$('#' + grid).jqGrid('setGroupHeaders', {
			useColSpanStyle : true,
			groupHeaders : [ {
				startColumnName : 'cali_io',
				numberOfColumns : 2,
				titleText : '교정주기'
			} ]
		});
	}

	// 교정 장비 목록
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
				label : '교정이력번호',
				name : 'crt_no',
				key : true
			}, {
				label : '교정결과',
				width : '100',
				name : 'crt_result'
			}, {
				label : '교정일자',
				width : '80',
				name : 'crt_date',
				align : 'center'
			}, {
				label : '교정기관',
				width : '300',
				name : 'crt_org'
			}, {
				label : '담당자(정)',
				width : '50',
				name : 'mng_nm',
				align : 'center'
			}, {
				label : '담당자(부)',
				width : '50',
				name : 'mng_sub_nm',
				align : 'center'
			}, {
				label : '차기교정일자',
				width : '80',
				name : 'nxt_crt_date',
				align : 'center'
			}, {
				label : '교정여부',
				width : '60',
				name : 'crt_yn',
				align : 'center',
				hidden : true,
				formatter : function(value) {
					if (value == "Y") {
						return '교정함';
					} else {
						return '교정안함';
					}
				}
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
				fnViewPage('instrument/correctionD01.lims', 'detail', 'pageType=detail&crt_no=' + rowId);
				$('#detail').find('#crt_no').val(rowId);
				$('#btn_Save_Sub1').show();
				$('#btn_Delete_Sub1').show();
				$('#btn_Add').show();
			}
		});
	}

	// 중간점검목록
	function gridSub2(url, form, grid) {
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
				label :  '점검이력번호',
				name : 'intchk_no',
				key : true
			}, {
				label : '중간점검결과',
				width : '100',
				name : 'intchk_result'
			}, {
				label : '중간점검일자',
				width : '80',
				name : 'intchk_date',
				align : 'center'
			}, {
				label : '점검기관',
				width : '300',
				name : 'intchk_org'
			}, {
				label : '담당자(정)',
				width : '50',
				name : 'mng_nm',
				align : 'center'
			}, {
				label : '담당자(부)',
				width : '50',
				name : 'mng_sub_nm',
				align : 'center'
			}, {
				label : '차기점검일자',
				width : '80',
				name : 'nxt_intchk_date',
				align : 'center'
			}, {
				label : '점검여부',
				width : '60',
				name : 'intchk_yn',
				align : 'center',
				hidden : true,
				formatter : function(value) {
					if (value == "Y") {
						return '점검함';
					} else {
						return '점검안함';
					}
				}
			} ],
			emptyrecords : '데이터가 존재하지 않습니다.',
			gridComplete : function() {
				$('#btn_Select_Sub2').show();
				$('#btn_Insert2').hide();
				$('#btn_Delete2').hide();
			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
			},
			onSelectRow : function(rowId, status, e) {
				fnViewPage('instrument/correctionD02.lims', 'detail2', 'pageType=detail&intchk_no=' + rowId);
				$('#detail2').find('#intchk_no').val(rowId);
				$('#btn_Save_Sub2').show();
				$('#btn_Delete_Sub2').show();
				$('#btn_Add2').show();
			}
		});
	}
	
	// 장비교정 추가 등록 버튼
	function fn_ViewPage() {
		var rowId = $('#machineGrid').getGridParam('selrow');
		if (rowId == '') {
		} else {
			fnViewPage('instrument/correctionD01.lims', 'detail', 'pageType=insert&inst_no=' + rowId + "&mng_gbn=B");
			
			$('#detail').find('#inst_no').val(rowId);
			$('#btn_Save_Sub1').show();
			$('#btn_Delete_Sub1').hide();
			$('#btn_Add').hide();
		}
	}
	
	// 중감점검 추가 등록 버튼
	function fn_ViewPage2() {
		var rowId = $('#machineGrid').getGridParam('selrow');
		if (rowId == '') {
		} else {
			fnViewPage('instrument/correctionD02.lims', 'detail2', 'pageType=insert&inst_no=' + rowId + "&mng_gbn=A");
			
			$('#detail2').find('#inst_no').val(rowId);
			$('#btn_Save_Sub2').show();
			$('#btn_Delete_Sub2').hide();
			$('#btn_Add2').hide();
		}
	}

	// 저장버튼(저장 & 수정) 클릭 이벤트
	function btn_Insert_onclick() {
		var inst_no = $('#detail').find('#inst_no').val();
		var id = $('#detail').find('#crt_no').val();

		// 벨리데이션 체크
		var crtDate = $('#detail').find('#crt_date').val();
		var nxtDate = $('#detail').find('#nxt_crt_date').val();

		if (crtDate == null || crtDate == "" || crtDate.length != 10) { // null인지 비교한 뒤
			$.showAlert('날짜를 정확히 입력하세요'); // 경고창을 띄우고
			$('#detail').find('#crt_date').focus(); // 해당태그에 포커스를 준뒤
			return false; // false를 리턴합니다.
		}
		if (nxtDate == null || nxtDate == "" || nxtDate.length != 10) {
			$.showAlert('날짜를 정확히 입력하세요');
			$('#detail').find('#nxt_crt_date').focus();
			return false;
		}
		
		if($('#detail').find('#mng_id').val() == ''){
			$.showAlert('담당자(정)가 없습니다.');
			return false;
		} 
		if($('#detail').find('#mng_sub_id').val() == ''){
			$.showAlert('담당자(부)가 없습니다.');
			return false;
		} 

		// 모든 벨리데이션 체크에 이상이 없으면		
		if (inst_no != '' || inst_no != null) {
			var url;
			var param = $('#detail').serialize();

			// 등록
			if (id == '' || id == null) {
				url = 'instrument/insertCorrection.lims';
				// 수정
			} else {
				url = 'instrument/updateCorrection.lims?key=' + id;
			}
			//alert($('#detail').serialize()); // java 파라미터값 확인용
			var json = fnAjaxAction(url, param);			
			if (json == null) {
				$.showAlert("저장 실패하였습니다.");
			} else {
				$('#machineForm').find('#inst_no').val(json);
				$('#formSub').find('#crt_no').val(json);
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
		var json = fnAjaxAction('instrument/deleteCorrection.lims', param);
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

	
	// 중간점검 저장버튼(저장 & 수정) 클릭 이벤트
	function btn_Insert2_onclick() {
		var inst_no = $('#detail2').find('#inst_no').val();
		var id = $('#detail2').find('#intchk_no').val();

		// 벨리데이션 체크
		var intchkDate = $('#detail2').find('#intchk_date').val();
		var nxtDate = $('#detail2').find('#nxt_intchk_date').val();

		if (intchkDate == null || intchkDate == "" || intchkDate.length != 10) { // null인지 비교한 뒤
			$.showAlert('날짜를 정확히 입력하세요'); // 경고창을 띄우고
			$('#detail2').find('#intchk_date').focus(); // 해당태그에 포커스를 준뒤
			return false; // false를 리턴합니다.
		}
		if (nxtDate == null || nxtDate == "" || nxtDate.length != 10) {
			$.showAlert('날짜를 정확히 입력하세요');
			$('#detail2').find('#nxt_intchk_date').focus();
			return false;
		}
		if($('#detail2').find('#mng_id').val() == ''){
			$.showAlert('담당자(정)가 없습니다.');
			return false;
		} 
		if($('#detail2').find('#mng_sub_id').val() == ''){
			$.showAlert('담당자(부)가 없습니다.');
			return false;
		} 

		// 모든 벨리데이션 체크에 이상이 없으면		
		if (inst_no != '' || inst_no != null) {
			var url;
			var param = $('#detail2').serialize();

			// 등록
			if (id == '' || id == null) {
				url = 'instrument/insertCorrection2.lims';
				// 수정
			} else {
				url = 'instrument/updateCorrection2.lims?key=' + id;
			}
			//alert($('#detail').serialize()); // java 파라미터값 확인용
			var json = fnAjaxAction(url, param);			
			if (json == null) {
				$.showAlert("저장 실패하였습니다.");
			} else {
				$('#machineForm').find('#inst_no').val(json);
				$('#formSub2').find('#intchk_no').val(json);
				$.showAlert("", {
					type : 'insert'
				});
				btn_Select_Sub2_onclick();
			}
		}
	}

	// 중간점검 삭제버튼 클릭 이벤트
	function btn_Delete2_onclick() {
		if (!confirm("삭제하시겠습니까?")) {
			return false;
		}
		var param = $('#detail2').serialize();
		var json = fnAjaxAction('instrument/deleteCorrection2.lims', param);
		if (json == null) {
			$.showAlert("삭제 실패하였습니다.");
		} else {
			$.showAlert("", {
				type : 'delete'
			});
			$('#detail2').empty();
			$('#machineGrid').trigger('reloadGrid');
			$('#gridSub2').trigger('reloadGrid');
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
		$('#btn_Add').hide(); // 그리드2의 [추가] 버튼
		
		$("#gridSub2").jqGrid("clearGridData", true);
		$('#detail2').empty();
		$('#btn_Save_Sub').hide();
		$('#btn_Delete_Sub2').hide();
		$('#btn_Select_Sub2').hide(); // 그리드2의 [조회] 버튼
		$('#btn_Add2').hide(); // 그리드2의 [추가] 버튼
	}

	// 교정 장비 리스트 조회 이벤트
	function btn_Select_Sub1_onclick() {
		$('#btn_Save_Sub1').hide();
		$('#btn_Delete_Sub1').hide();
		$('#btn_Add').show();
		$('#btn_Select_Sub1').show(); // 그리드2의 [조회] 버튼
		$('#gridSub').trigger('reloadGrid');
		$('#detail').empty();
	}
	
	// 중간점검 리스트 조회 이벤트
	function btn_Select_Sub2_onclick() {
		$('#btn_Save_Sub2').hide();
		$('#btn_Delete_Sub2').hide();
		$('#btn_Add2').show();
		$('#btn_Select_Sub2').show(); // 그리드2의 [조회] 버튼
		$('#gridSub2').trigger('reloadGrid');
		$('#detail2').empty();
	}

	// 교정자 등록팝업
	function btn_Pop_AdminChoice(form,popupName ) {
		
		fnBasicStartLoading();		
		fnpop_UserInfoPop(form, "500", "500", popupName, '');
		/* var form = 'detail';
		var popup = popUserInfo();
		if (popup != null) {
			var arr = popup.split('■★■');
			for ( var r in arr) {
				var v = arr[r].split('●★●');
				var id = v[0];
				if (id == 'user_nm') {
					id = 'crt_user_nm'; // 이름
				} else if (id == 'user_id') {
					id = 'crt_user_id';// ID
				}
				$('#' + form).find('#' + id).val(v[1]);
			}
		} */
	}
	
	function fnpop_callback(){
		
	}
	
	// 엑셀 다운로드
	function btn_Excel_onclick(grid,form) {
		var bigDivName = null;
		var bigDivData = null;
		var rowId = $('#machineGrid').getGridParam('selrow');  
		var row = $('#machineGrid').getRowData(rowId);
		bigDivName = '장비명';
		bigDivData = row.inst_kor_nm;
		var data = fn_Excel_Data_Make2(grid, bigDivName, bigDivData);
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
					<input name="admin_user" type="text" style="width: 160px;" value='<c:if test="${!empty pageType}">${admin_user }</c:if>'/>
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
				<th>Serial no.</th>
				<td>
					<input name="serial_number" type="text" class="w80px" />			
				</td>
				<th>사용일지대상여부</th>
				<td>
					<label><input type='radio' name='use_his_flag' value='' style="width: 20px" checked="checked" />전체</label> <label><input type='radio' name='use_his_flag' value='Y' style="width: 20px" />대상</label> <label><input type='radio' name='use_his_flag' value='N' style="width: 20px" />미대상</label>
					<!-- <select name="use_his_flag" id="use_his_flag" class="w100px">
							<option value="">전체</option>
							<option value='Y'>대상</option>
							<option value='N'>미대상</option>
					</select> -->
				</td>
				<th>교정주기</th>
				<td >
				<label><input type='radio' name='cali' value='' style="width: 20px" checked="checked" />전체</label> <label><input type='radio' name='cali' value='cali_period_flag' style="width: 20px" />내부</label> <label><input type='radio' name='cali' value='cali_io_flag' style="width: 20px" />외부</label>
				</td>
				<th>장비정보</th>
				<td>
				<select name="cntType" id="cntType">
				<option value="">선택</option>
				<option value="13">검교정일대기</option>
				<option value="15">검교정일초과</option>
				<option value="14">중간점검일대기</option>
				<option value="16">중간점검일초과</option>
				</select>				
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

<div id="tabs">
	<ul>
		<li id="tab1">
			<a href="#tabDiv1">장비교정목록</a>
		</li>
		<li id="tab2">
			<a href="#tabDiv2">중간점검목록</a>
		</li>
	</ul>


	<!-- 교정목록 탭 -->
	<div id="tabDiv1">
		
		<form id="formSub" name="formSub" onsubmit="return false;">
			<div class="sub_purple_01">
				<table  class="select_table" >
					<tr>
						<td width="20%" class="table_title">
							<span>■</span>
							장비 교정 목록
						</td>
						<td class="table_button">
							<span class="button white mlargep auth_select" id="btn_Select" onclick="btn_Select_Sub1_onclick();">
								<button type="button">조회</button>
							</span>
							<span class="button white mlargep auth_save" id="btn_Add" onclick="fn_ViewPage();">
								<button type="button">추가</button>
							</span>
							<span class="button white mlargeb auth_select" onclick="btn_Excel_onclick('gridSub','detail');">
								<button type="button">EXCEL</button>
							</span>
						</td>
					</tr>
				</table>
			</div>
			<input type="hidden" id="inst_no" name="inst_no">
			<input type="hidden" id="pageType" name="pageType" value="sub">
			<input type="hidden" id="sortName" name="sortName">
			<div id="view_grid_sub">
				<table id="gridSub"></table>
			</div>
		</form>
		
		<div class="sub_blue_01">
		
			<form id="detail" name="detail" onsubmit="return false;"></form>
		</div>
	
	</div>
	
	<!-- 중간점검 탭 -->
	<div id="tabDiv2">
		<form id="formSub2" name="formSub2" onsubmit="return false;">
			<div class="sub_purple_01">
				<table  class="select_table" >
					<tr>
						<td width="20%" class="table_title">
							<span>■</span>
							중간점검 목록
						</td>
						<td class="table_button">
							<span class="button white mlargep auth_select" id="btn_Select2" onclick="btn_Select_Sub2_onclick();">
								<button type="button">조회</button>
							</span>
							<span class="button white mlargep auth_save" id="btn_Add2" onclick="fn_ViewPage2();">
								<button type="button">추가</button>
							</span>
							<span class="button white mlargeb auth_select" onclick="btn_Excel_onclick('gridSub2','detail2');">
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
			<div id="view_grid_sub2">
				<table id="gridSub2"></table>
			</div>
		</form>
		
		<div class="sub_blue_01">
			<form id="detail2" name="detail2" onsubmit="return false;"></form>
		</div>
	</div>

</div>
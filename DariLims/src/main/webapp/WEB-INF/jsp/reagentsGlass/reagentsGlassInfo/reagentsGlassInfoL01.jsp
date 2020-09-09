
<%
	/***************************************************************************************
	 * 시스템명 	: 통합장비관제시스템
	 * 업무명 		: 시약/실험기구정보등록
	 * 파일명 		: reagentsGlassInfoL01.jsp
	 * 작성자 		: 최은향
	 * 작성일 		: 2015.02.17
	 * 설  명		: 시약/실험기구정보등록 리스트 조회 화면
	 *---------------------------------------------------------------------------------------
	 * 변경일		 변경자		변경내역 
	 *---------------------------------------------------------------------------------------
	 * 2015.02.17    최은향		최초 프로그램 작성         
	 * 
	 *---------------------------------------------------------------------------------------
	 ****************************************************************************************/
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html >
<link rel="stylesheet" media="screen" type="text/css" href="<c:url value='/css/common/sub.css'/>" />
<script type="text/javascript">
	var fnGridInit = false;
	var itemMsg = '<label style="font-weight: bold; font-size: 20px;">시약/실험기구 수정중입니다.</label>';
	//var h_mtlr;
	var m_mtlr;
	var m_mtlr_C42 = fnGridCommonCombo('C42', null);
	var m_mtlr_C43 = fnGridCommonCombo('C43', null);
	m_mtlr_C43 = m_mtlr_C43.slice(1);
	var m_mtlr_code;

	$(function() {
		/* 세부권한검사 */
		fn_auth_check();
		
		ajaxComboForm("m_mtlr_info", "", "All", "", 'form'); // 중분류 검색창 초기화용		
		m_mtlr = m_mtlr_C42 + m_mtlr_C43;
		
		ajaxComboForm("dept_cd", "", "${form.dept_cd}", "", 'form'); // 관리부서	
// 		ajaxComboForm("office_cd", "", "${form.dept_cd}", null, 'form'); // 사업소별
		
		ajaxComboForm("dept_cd", "", "${detail.dept_nm}", "", 'reagentsGlassInfoDetail'); // 관리부서
		//url명명 규칙(p.21) 
		grid('reagents/reagentsGlassInfo.lims', 'form', 'reagentsGlassInfoGrid');
		//$('#reagentsGlassInfoGrid').clearGridData(); // 최초 조회시 데이터 안나옴

		// 엔터키 눌렀을 경우(그리드 조회)
		fn_Enter_Search('form', 'reagentsGlassInfoGrid');

		//그리드 width조절하기
		$(window).bind('resize', function() {
			$("#reagentsGlassInfoGrid").setGridWidth($('#view_grid_main').width(), false);
		}).trigger('resize');
		
		//fn_show_type($('#form').find("#req_dept_office").val());
	});

	// 대분류 콤보
	function comboReload() {
		if ($("#h_mtlr_info").val() == "C42") {
			ajaxComboForm("m_mtlr_info", "C42", "All", "", 'form'); // 중분류			
		} else if ($("#h_mtlr_info").val() == "C43") {
			ajaxComboForm("m_mtlr_info", "C43", "All", "", 'form'); // 중분류
		}
	}

	// 대분류 콤보(detail)
	function comboReload_detail() {
		if ($("#h_mtlr_info_detail").val() == "C42") {
			ajaxComboForm("m_mtlr_info", "C42", "${detail.m_mtlr_info}", "", 'reagentsGlassInfoDetail'); // 중분류			
		} else if ($("#h_mtlr_info_detail").val() == "C43") {
			ajaxComboForm("m_mtlr_info", "C43", "${detail.m_mtlr_info}", "", 'reagentsGlassInfoDetail'); // 중분류
		} else {
			ajaxComboForm("m_mtlr_info", "", "${detail.m_mtlr_info}", "", 'reagentsGlassInfoDetail'); // 중분류
		}
	}
	
	function grid(url, form, grid) {
		$('#' + grid).jqGrid({
			datatype : function(json) {				
				fnGridInit ? fnGridData(url, form, grid) : fnGridInit = true;
			},
			height : '230',
			autowidth : false,
			loadonce : true,
			mtype : "POST",
			gridview : true,
			shrinkToFit : true,
			rowNum : -1,
			rownumbers : true,
			colModel : [ {
				label : '시약/실험기구코드',
				name : 'mtlr_no',
				key : true,
				hidden : true
			}, {
				label : '마스터여부',
				width : '80',
				name : 'master_yn',
				align : 'center',
				hidden : true
			}, {
				label : '대분류',
				width : '80',
				name : 'h_mtlr_info'
			//formatter : 'select',
			//edittype : "select"
			// 				formatter : function(value){
			// 					if(value == "C42"){
			// 						return '시약류';  
			// 					} else if(value == "C43") {
			// 						return '소모품류';
			// 					} else {
			// 						return '';
			// 					}
			// 				}
			// 				editoptions : {
			// 					value : h_mtlr
			// 				}
			}, {
				label : '중분류',
				width : '80',
				name : 'm_mtlr_info'
			}, {
				label : '시약/실험기구명',
				width : '250',
				name : 'item_nm'
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
				label : '등록일자',
				width : '100',
				align : 'center',
				name : 'create_date',
				hidden : true
			}, {
				label : '등록자명',
				width : '60',
				align : 'center',
				name : 'user_nm',
				hidden : true
			}, {
				label : '등록부서코드',
				width : '80',
				align : 'center',
				name : 'create_dept',
				hidden : true
			}, {
				label : '등록부서명',
				width : '130',
				name : 'dept_nm',
				hidden : true
			}, {
				label : '비고',
				width : '150',
				name : 'etc'
			} ],			
			emptyrecords : '데이터가 존재하지 않습니다.',			
			gridComplete : function() {
				$('#btn_Add').show();
				$('#btn_Insert').hide();
				//$('#btn_Delete').hide();
			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
			},
			onSelectRow : function(rowId, status, e) {
				// 대분류가 시약류면
				if ($('#reagentsGlassInfoGrid').getRowData(rowId).h_mtlr_info == '시약류') {
					m_mtlr_code = 'C42';
					// 대분류가 소모품류면
				} else if ($('#reagentsGlassInfoGrid').getRowData(rowId).h_mtlr_info == '소모품류') {
					m_mtlr_code = 'C43';
				}
				$('#btn_Add').show();
				$('#btn_Insert').hide();
				btn_Row_onclick();
				//fn_Div_Block('reagentsGlassInfoDiv', itemMsg);
			}
		});
	}

	// 그리드 block
	function fn_Div_Block(id, msg) {
		fnStartLoading(id, msg);
		$('.blockUI').click(function() {
			if (id == 'reagentsGlassInfoDiv') {
				//var grid = 'grid';
				if (!confirm("시약/실험기구를 되돌리시겠습니까?")) {
					return false;
				}
				fnStopLoading('reagentsGlassInfoDiv');
				btn_Select_onclick();
			}
		});
	}
		
	
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

	// 저장버튼(저장 & 수정) 클릭 이벤트
	function btn_Insert_onclick() {
		//var url;
		var id = $('#reagentsGlassInfoDetail').find('#mtlr_no').val();
		var param = $('#reagentsGlassInfoDetail').serialize();

		// 등록
		if (id == '' || id == null) {
			if ($('#reagentsGlassInfoDetail').find('#m_img').val() != '') {
				var json = fnAjaxFileAction('reagents/insertReagentsGlassInfo.lims', 'reagentsGlassInfoDetail', fn_suc);
			} else {
				var param = $('#reagentsGlassInfoDetail').serialize();
				var json = fnAjaxAction('reagents/insertReagentsGlassInfo.lims', param);
				if (json == null) {
					$.showAlert("저장 실패하였습니다.");
				} else {
					$('#reagentsGlassInfoDetail').find('#mtlr_no').val(json);
					$.showAlert("", {
						type : 'insert'
					});
					btn_Select_onclick();
				}
			}
			//url = 'reagents/insertReagentsGlassInfo.lims';
		// 수정
		} else {
			if ($('#reagentsGlassInfoDetail').find('#m_img').val() != '') {
				var json = fnAjaxFileAction('reagents/updateReagentsGlassInfo.lims', 'reagentsGlassInfoDetail', fn_suc);
			} else {
				var param = $('#reagentsGlassInfoDetail').serialize();
				var json = fnAjaxAction('reagents/updateReagentsGlassInfo.lims', param);
				if (json == null) {
					$.showAlert("저장 실패하였습니다.");
				} else {
					$('#reagentsGlassInfoDetail').find('#mtlr_no').val(json);
					$.showAlert("", {
						type : 'insert'
					});
					btn_Select_onclick();
				}
			}
			//url = 'reagents/updateReagentsGlassInfo.lims';
		}
// 		var json = fnAjaxAction(url, param);
// 		if (json == null) {
// 			$.showAlert("저장 실패하였습니다.");
// 		} else {
// 			$.showAlert("", {
// 				type : 'insert'
// 			});
// 			$('#reagentsGlassInfoDetail').empty();
// 			$('#reagentsGlassInfoGrid').trigger('reloadGrid');
// 			fnStopLoading('reagentsGlassInfoDiv');
// 		}
	}

	// 저장 이벤트
	function fn_suc(json) {
		if (json == null) {
			$.showAlert("저장 실패하였습니다.");
		} else {
			$('#reagentsGlassInfoDetail').find('#mtlr_no').val(json);
			$.showAlert("", {
				type : 'insert'
			});
			btn_Select_onclick();
		}
	}
	
	// 해당줄 클릭 이벤트(상세페이지 보기)	
	function btn_Row_onclick() {
		var param = 'key=' + $('#reagentsGlassInfoGrid').getGridParam('selrow');
		fnViewPage('reagents/reagentsGlassInfoD01.lims?pageType=detail', 'reagentsGlassInfoDetail', param);
		
		var mtlr_no = $('#reagentsGlassInfoDetail').find('#mtlr_no').val();		
		var random = Math.random();		
		$('#img').html('<img src="reagents/reagentsGlassImage.lims?mtlr_no='+ mtlr_no +'&random='+ random +'" style="width:800px;"/>');
		
		$('#btn_Add').show();
		$('#btn_Insert').show();
		return false;
	}

	// 삭제버튼 클릭 이벤트
	function btn_Delete_onclick() {
		if (!confirm('삭제 하시겠습니까?')) {
			return false;
		} else {
			var param = $('#reagentsGlassInfoDetail').serialize();
			fnAjaxAction('reagents/deleteReagentsGlassInfo.lims', param);
		}
	}

	// 리스트 조회 이벤트
	function btn_Select_onclick() {
		//document.getElementById("load_" + this.id).style.display="block";
		$('#reagentsGlassInfoDetail').empty();
		$('#reagentsGlassInfoGrid').trigger('reloadGrid');		
	}

	// 추가버튼 클릭 이벤트
	function fn_ViewPage(pageType) {
		$('#reagentsGlassInfoDetail').find('#mtlr_no').val(''); // 해당 seq 삭제
		//$('#reagentsGlassInfoGrid').trigger('reloadGrid'); // 셀클릭 해제
		$('#reagentsGlassInfoGrid').jqGrid('resetSelection');
		fnViewPage('reagents/reagentsGlassInfoD01.lims?pageType=' + pageType, 'reagentsGlassInfoDetail', null);
		$('#btn_Add').show();
		$('#btn_Insert').show();
		//$('#btn_Delete').hide();
	}

	// 엑셀다운로드
	function btn_Excel_onclick() {
		var data = fn_Excel_Data_Make('reagentsGlassInfoGrid');
		fn_Excel_Download(data);
	}
	
/* 	// 부서 & 사업소 선택
	function fn_show_type(req_dept_office) {
		var th = 'typeThSearch';
		var form = 'form';
		
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
<div id="reagentsGlassInfoDiv">
	<form id="form" name="form" onsubmit="return false;">
		<div class="sub_purple_01">
			<table  class="select_table" >
				<tr>
					<td width="30%" class="table_title">
						<span>■</span>
						시약/실험기구 등록
					</td>
					<td class="table_button">
						<span class="button white mlargep auth_select" id="btn_Select" onclick="btn_Select_onclick();">
							<button type="button">조회</button>
						</span>
						<span class="button white mlargeb auth_save" id="btn_Add" onclick="fn_ViewPage('insert');">
							<button type="button">추가</button>
						</span>
						<span class="button white mlargeb auth_select" onclick="btn_Excel_onclick();">
							<button type="button">EXCEL</button>
						</span>
					</td>
				</tr>
			</table>
			<table  class="list_table" >
				<tr>
					<th>대분류</th>
					<td>
						<select name="h_mtlr_info" id="h_mtlr_info" style="width: 123px" onchange="comboReload()">
							<option value=" ">전체</option>
							<option value="C42">시약류</option>
							<option value="C43">소모품류</option>
						</select>
					</td>
					<th>중분류</th>
					<td>
						<select name="m_mtlr_info" id="m_mtlr_info" style="width: 115px"></select>
					</td>
					<th style="min-width: 100px;">시약/실험기구명</th>
					<td colspan='3'>
						<input name="item_nm" type="text" style="width: 300px" />
					</td>
				</tr>
				<tr>
					<th>등록자명</th>
					<td>
						<input name="creater_id" type="text" style="width: 110px" />
					</td>
<!-- 
					<th id="typeThSearch">
					<input name="req_dept_office" id="req_dept_office" type="radio" value="d" checked="checked" onClick="fn_show_type($(this).val())"/> 
						<label for="req_dept_office">등록부서명</label>
 						<input name="req_dept_office" id="req_dept_office2" type="radio" value="o" onClick="fn_show_type($(this).val())"/> 
						<label for="req_dept_office2">등록사업소명</label> 
					</th>
					<td>
						<select name="dept_cd" id="dept_cd" class="w120px"></select>
 						<select name="office_cd" id="office_cd" class="w120px"></select>
					</td>-->
					<th>사용여부</th>
					<td>
						<label><input type='radio' name='use_flag' value='' style="width: 20px" />전체</label> <label><input type='radio' name='use_flag' value='Y' style="width: 20px" checked="checked" />사용함</label> <label><input type='radio' name='use_flag' value='N' style="width: 20px" />사용안함</label>
					</td>
					<th>Cas no.</th>
					<td>
						<input name="spec2" type="text" style="width: 110px" />
					</td>
				</tr>
				<tr>
				</tr>
			</table>
		</div>
		<input type="hidden" id="sortName" name="sortName">
		<input type="hidden" id="sortType" name="sortType">
		<div id="view_grid_main">
			<table id="reagentsGlassInfoGrid"></table>
		</div>
	</form>
</div>
<div class="sub_blue_01">
	<form id="reagentsGlassInfoDetail" name="reagentsGlassInfoDetail" onsubmit="return false;"></form>
</div>

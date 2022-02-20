
<%
	/***************************************************************************************
	 * 시스템명 : 통합장비관제시스템
	 * 업무명 	: 검사기준관리
	 * 파일명 	: sampleGradeL01.jsp
	 * 작성자 	: 최은향
	 * 작성일 	: 2015.12.22
	 * 설  명	: 검사기준관리 목록 조회 화면
	 *---------------------------------------------------------------------------------------
	 * 변경일		 변경자		변경내역 
	 *---------------------------------------------------------------------------------------
	 * 2015.12.22    최은향		최초 프로그램 작성         
	 * 
	 *---------------------------------------------------------------------------------------
	 ****************************************************************************************/
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html >
<link rel="stylesheet" media="screen" type="text/css" href="<c:url value='/css/common/sub.css'/>" />
<style>
.not-editable-cell {
	background-color: gray;
}

/* 한글우선입력 */
.imeon input {
	ime-mode: active;
}
</style>
<script type="text/javascript">
var fnGridInit = false;
var gradeRangeStd;
var gradeRangeStd;
var bSaveGrade;
var unit_cd;
var oxide_cd;
var grade_at;
$(function() {
	/* 세부권한검사 */
	fn_auth_check();

	ajaxComboForm("htrk_prdlst_cd", "CP1", "CHOICE", "", "allPrdForm");
	ajaxCombo('result_type', 'C31', 'ALL', '');
	ajaxCombo('unit_cd', 'C08', 'ALL', '');
	unit_cd = fnGridCommonCombo('C08', null);
	oxide_cd = fnGridCommonCombo('oxide_cd', null);
	grade_at = {'Y':'사용','N':'미사용'};
	
	gradeRangeStd = fnGridCommonCombo('C81', null);
	
	prdGrid('/master/selectPrdLstList.lims', 'allPrdForm', 'allPrdGrid');
	itemGrid('master/selectSampleGradeList.lims', 'testPrdStdRevGridForm', 'testPrdStdRevGrid');
	
	$(window).bind('resize', function() {
		$("#allPrdGrid").setGridWidth($('#sub_purple_01').width(), false);
	}).trigger('resize');
	//그리드 사이즈 
	$(window).bind('resize', function() {
		$("#testPrdStdRevGrid").setGridWidth($('#sub_blue_01').width(), false);
	}).trigger('resize');
	
	//엔터이벤트
	fn_Enter_Search('allPrdForm', 'allPrdGrid');
	$('#testPrdStdRevGrid').clearGridData(); // 최초 조회시 데이터 안나옴
});


// 품목 그리드
function prdGrid(url, form, grid) {	
	$('#' + grid).jqGrid({
		datatype : function(json) {
			fnGridInit ? fnGridData(url, form, grid) : fnGridInit = true;
		},
		height : '580',
		autowidth : false,
		loadonce : true,
		mtype : "POST",
		gridview : true,
		shrinkToFit : true,
		rowNum : -1,
		rownumbers : true,
		colModel : [ {
			label : '품목코드',
			name : 'prdlst_cd',
			key : true,
			hidden : true
		}, {
			label : '품목분류',
			width : '150',
			align : 'center',
			name : 'htrk_prdlst_nm'
		}, {
			label : '품목한글명',
			width : '200',
			name : 'kor_nm'
		}, {
			label : '품목영문명',
			width : '200',
			name : 'eng_nm'
		}, {
			label : '최대등급',
			name : 'max_grade',
			width : '100'
		} ],
	 	gridComplete : function(data) {
		}, 
		onSortCol : function(index, iCol, sortorder) {
			if(!com_auth_select){return 'stop';} else {fnSortCol(form, index, sortorder);}
		},			
		onSelectRow : function(rowId, status, e) {
			var row = $('#' + grid).getRowData(rowId);
			$("#testPrdStdRevGridForm").find("#prdlst_cd").val(row.prdlst_cd);
			$("#testPrdStdRevGridForm").find("#prdlst_nm").val(row.kor_nm);
			
			$("#max_grade").val(row.max_grade);
			
			maxGradeOnchange();
			
			btn_Search_onclick();
		},
		ondblClickRow : function(rowId, iRow, iCol, e) {
		}
	});
}

function itemGrid(url, form, grid) {
	var lastRowId = 0;
	$('#' + grid).jqGrid({
		datatype : function(json) {
			fnGridData(url, form, grid);
		},
		height : '590',
		autowidth : false,
		loadonce : true,
		mtype : "POST",
		gridview : true,
		shrinkToFit : false,
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
		    }, {
				type : 'not',
				label : ' ',
				name : 'icon',
				width : '20',
				align : 'center',
				frozen : true
			}, {
				label : 'crud',
				name : 'crud',
				hidden : true,
				frozen : true
			}, {
				label : 'prdlst_cd',
				name : 'prdlst_cd',
				hidden : true,
				width : '250'
			}, {
				label : '품목명',
				name : 'kor_nm',
				hidden : true
				
			}, {
				label : 'grade_seq',
				name : 'grade_seq',
				hidden : true
			}, {
				label : '항목코드',
				name : 'testitm_cd',
				width : '100'
			}, {
				label : '대분류',
				name : 'testitm_lclas_nm',
				width : '100'
			}, {
				label : '중분류',
				name : 'testitm_mlsfc_nm',
				width : '100'
			}, { 
				label : '항목명',
				name : 'testitm_nm',
				width : '150'
			}, {
				label : '정렬순서',
				name : 'item_order',
				width : '70',
				editable : true
			}, {
				label : '단위',
				classes : 'unit',
				name : 'unit_cd',
				sortable : false,
				width : '100',
				editable : true,
				edittype : "select",
				editoptions : {
					value : unit_cd
				},
				formatter : 'select'
			}, {
				label : 'test_method_no',
				name : 'test_method_no',
				classes : 'test_method_no',
				hidden : true
			}, {
				type : 'not',
				label : '시험방법',
				name : 'test_method_nm',
				classes : 'test_method_nm'
			}, {
				type : 'not',
				label : ' ',
				name : 'test_method_pop',
				sortable : false,
				width : '20',
				align : 'center',
				formatter : imageFormat
			}, {
				type : 'not',
				label : ' ',
				name : 'test_method_del',
				sortable : false,
				width : '20',
				align : 'center',
				formatter : deleteImageFormat
			}, {
				label : '산화물측정방법',
				name : 'oxide_cd',
				editable : true,
				edittype : "select",
				width : '300',
				editoptions : {
					value : oxide_cd
				},
				formatter : 'select'
			}, {
				label : '계산식 번호',
				name : 'formula_no',
				classes : 'formula_no',
				sortable : false,
				hidden : true
			}, {
				type : 'not',
				label : '계산식',
				name : 'formula_nm',
				classes : 'formula_nm',
				sortable : false
			}, {
				type : 'not',
				label : ' ',
				name : 'formula_pop',
				sortable : false,
				width : '20',
				align : 'center',
				formatter : imageFormat
			}, {
				type : 'not',
				label : ' ',
				name : 'formula_del',
				sortable : false,
				width : '20',
				align : 'center',
				formatter : deleteImageFormat
			}, {
				label : '등급사용',
				name : 'grade_at',
				editable : true,				
				edittype : "select",
				width : '100',
				editoptions : {
					value : grade_at
				},
				formatter : 'select',
				align : 'center'
			}, {
				label : '표기자리수',
				name : 'vald_manli',
				width : '70',
				align : 'right',
				editable : true
			}, {
				label : '등급1 값',
				name : 'grade1',
				width : '80',
				editable : true
			}, {
				label : '등급1 범위',
				name : 'grade1_range',
				width : '80',
				editable : true,
				edittype : "select",
				editoptions : {
					value : gradeRangeStd
				},
				formatter : 'select'
			}, {
				label : '등급2 값',
				name : 'grade2',
				width : '80',
				editable : true
			}, {
				label : '등급2 범위',
				name : 'grade2_range',
				width : '80',
				editable : true,
				edittype : "select",
				editoptions : {
					value : gradeRangeStd
				},
				formatter : 'select'
			}, {
				label : '등급3 값',
				name : 'grade3',
				width : '80',
				editable : true
			}, {
				label : '등급3 범위',
				name : 'grade3_range',
				width : '80',
				editable : true,
				edittype : "select",
				editoptions : {
					value : gradeRangeStd
				},
				formatter : 'select'
			}, {
				label : '등급4 값',
				name : 'grade4',
				width : '80',
				editable : true
			}, {
				label : '등급4 범위',
				name : 'grade4_range',
				width : '80',
				editable : true,
				edittype : "select",
				editoptions : {
					value : gradeRangeStd
				},
				formatter : 'select'
			}, {
				label : '정량하한값',
				name : 'loq_lval',
				width : '100',
				editable : true
			}, {
				label : '정량하한표기',
				name : 'loq_lval_mark',
				width : '100',
				editable : true
			}, {
				label : '정량상한값',
				name : 'loq_hval',
				width : '100',
				editable : true
			}, {
				label : '정량상한표기',
				name : 'loq_hval_mark',
				width : '100',
				editable : true
			}, {
				label : '성적서 표시 여부',
				name : 'report_flag',
				editable : true,
				width : '100',
				align : 'center',
				edittype : "select",
				editoptions : {
					value : 'Y:표시함;N:표시안함'
				},
				formatter : 'select'
			} ],
		emptyrecords : '데이터가 존재하지 않습니다.',
		gridComplete : function() {
		},
		onSortCol : function(index, iCol, sortorder) {
			if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
			if (!confirm('저장하지 않은 정보는 사라집니다. 정렬하시겠습니까?')) {
				return 'stop';
			}
		},
		beforeSelectRow : function(rowId, e) {
			if (rowId && rowId != lastRowId) {
				if (!valiCheck(lastRowId))
					return 'stop';
			}
			return true;
		},
		onCellSelect : function(rowId, iCol, cellcontent, e) {
			var colArr = $('#' + grid).jqGrid('getGridParam', 'colModel');
			var col = colArr[iCol].name;
			if (col == 'formula_pop') {
				fnpop_formulaPop(grid, "900", "500", rowId, "", "M", null);
				testPrdStdRevGridEditCell(grid, rowId);
			}
			else if (col == 'formula_del') {
				$('#' + grid).jqGrid('setCell', rowId, 'formula_no', null);
				$('#' + grid).jqGrid('setCell', rowId, 'formula_nm', null);
				testPrdStdRevGridEditCell(grid, rowId);
			}
			else if (col == 'test_method_pop') {
				fnpop_testMethodPop(grid, '900', '500', rowId);
				
			} else if (col == 'test_method_del') {
				$('#' + grid).jqGrid('setCell', rowId, 'test_method_nm', null);
				$('#' + grid).jqGrid('setCell', rowId, 'test_method_no', null);
				testPrdStdRevGridEdit(grid, rowId)
			}
		},
		onSelectRow : function(rowId, status, e) {
			if(grid == "testPrdStdRevGrid"){
				var row = $('#' + grid).getRowData(rowId);
				$("#insPrdForm").find("#prdlst_cd").val(row.prdlst_cd);
				$("#insPrdForm").find("#testitm_cd").val(row.testitm_Cd);
				$("#insPrdForm").find("#grade_seq").val(row.grade_seq);
				$("#insPrdForm").find("#testitm_nm").val(row.testitm_nm);
				$("#insPrdForm [name=testitmNm]").attr("readonly", true);
				$("#insPrdForm").find("#grade1").val(row.grade1);
				$("#insPrdForm").find("#grade2").val(row.grade2);
				$("#insPrdForm").find("#grade3").val(row.grade3);
				$("#insPrdForm").find("#grade4").val(row.grade4);
			}
			
			if (rowId && rowId != lastRowId) {
				fnEditRelease(grid);
				lastRowId = rowId;
			}
		},
		ondblClickRow : function(rowId, iRow, iCol, e) {
			fnEditRelease(grid);
			fnGridEdit(grid, rowId, fnRowClick);
			testPrdStdRevGridEdit(grid, rowId);
			
			var colArr = $('#' + grid).jqGrid('getGridParam', 'colModel');
			$('#' + rowId + '_' + colArr[iCol].name).focus();
		},
	});
	
	$('#' + grid).jqGrid('setGroupHeaders', {
		useColSpanStyle : true,
		groupHeaders : [ {
			startColumnName : 'item_order',
			numberOfColumns : 7,
			titleText : '프로토콜'
		} ]
	});
}

function fnRowClick(rowId) {
	//editChange = true;
	var grid = 'testPrdStdRevGrid';
	$('#' + grid).setCell(rowId, 'chk', 'Yes');
}

//에디트모드
function testPrdStdRevGridEdit(grid, rowId) {
	var row = $('#' + grid).getRowData(rowId);
	if (row.crud != 'n') {
		$('#' + grid).setCell(rowId, 'icon', gridU);
		$('#' + grid).setCell(rowId, 'crud', 'u');
		$('#' + grid).setCell(rowId, 'chk', 'Yes');
	}
}

//업데이트 아이콘 생성
function testPrdStdRevGridEditCell(grid, rowId) {
	var row = $('#' + grid).getRowData(rowId);
	if (row.crud != 'n') {
		$('#' + grid).setCell(rowId, 'icon', gridU);
		$('#' + grid).setCell(rowId, 'crud', 'u');
	}
}

//수수료그룹
function popFeeGroup() {
	var obj = new Object();
	obj.msg1 = 'master/feeGroup.lims';
	return fnShowModalWindow("popMain.lims", obj, 700, 370);
}

// 조회버튼 클릭 이벤트
function btn_Search_onclick() {
	$('#testPrdStdRevGrid').trigger('reloadGrid');
}

// 기준별 시험항목 목록에 수정, 삭제, 업데이트 된 항목이 있는지 확인
function editCount(grid) {
	var check = false;
	var ids = $('#' + grid).jqGrid("getDataIDs");
	for ( var i in ids) {
		var row = $('#' + grid).getRowData(ids[i]);
		if (row.crud == 'n' || row.crud == 'd' || row.crud == 'u')
			check = true;
	}
	return check;
}

// 시험항목추가 팝업
function btn_Add_onclick(form) {
	var prdlstCd = $("#"+form).find("#prdlst_cd").val();
	var prdlstNm = $("#"+form).find("#prdlst_nm").val();
	var indvSpecSeq = $("#"+form).find("#indv_spec_seq").val();
	
	if(form == "testPrdStdRevGridForm"){
		if(prdlstCd == "" || prdlstNm == ""){
			alert("품목을 선택해야 합니다.");
			return;
		}
	}
	param =  prdlstCd + "◆★◆" + prdlstNm + "◆★◆" + indvSpecSeq;

	var url = "/master/testSampleGradeChoice.lims";
	var height = "867";
	var width = "1000";
	var option = "toolbar=no, location=no, menubar=no, scrollbars=yes, status=no, resizable=yes, top=50%, left=50%, width=" + width + 'px, height=' + height +'px' ;
	openPopup = window.open(url, param, option);

	fnBasicStartLoading();
}


// 시험항목수정 팝업
function btn_Edit_onclick(form) {
	var prdlstCd = $("#"+form).find("#prdlst_cd").val();
	var prdlstNm = $("#"+form).find("#prdlst_nm").val();
	var indvSpecSeq = $("#"+form).find("#indv_spec_seq").val();
	
	if(form == "testPrdStdRevGridForm"){
		if(prdlstCd == "" || prdlstNm == ""){
			alert("품목을 선택해야 합니다.");
			return;
		}
	}else{
		if(prdlstCd == "" || prdlstNm == "" || indvSpecSeq == ""){
			alert("기준규격을 선택해야 합니다.");
			return;
		}
	}

	var rowId = $('#testPrdStdRevGrid').jqGrid('getGridParam', 'selrow');
	var row = $("#testPrdStdRevGrid").jqGrid('getRowData', rowId);
	var testitemCd = row.testitmCd;
		
	param =  prdlstCd + "◆★◆" + prdlstNm + "◆★◆" + indvSpecSeq + "◆★◆" + testitemCd;

	var url = "master/testSampleGradeChoice.lims";
	var height = "600";
	var width = "1000";
	var option = "toolbar=no, location=no, menubar=no, scrollbars=yes, status=no, resizable=yes, width=" + width + 'px, height=' + height +'px' ;
	openPopup = window.open(url, param, option);

	fnBasicStartLoading();
}

// 시험항목삭제
function btn_Del_onclick(form) {
	var rows = $('#testPrdStdRevGrid').jqGrid('getDataIDs');
	if (rows == null) {
		alert('항목을 체크해주세요.');
	}
	else if (!confirm("삭제하시겠습니까?")) {
		return false;
	}
	else {
		for (var i=0; i<rows.length; i++) {
			var rowId = rows[i];
		    var rowData = jQuery('#testPrdStdRevGrid').jqGrid ('getRowData', rowId);
		    
		    if(rowData.chk == "Yes") {
		    	var url = "/master/deleteSampleGradeTestItem.lims";
				var result = fnAjaxAction(url,rowData);
		    }
		}
		alert("삭제되었습니다.");
		fnEditRelease('testPrdStdRevGrid');
		$('#testPrdStdRevGrid').trigger('reloadGrid');
		
	}
}

// 자식 -> 부모창 함수 호출
function fnpop_callback(returnParam){
	btn_Search_onclick();
	fnBasicEndLoading();
}

// 기준값 validation체크
function valiCheck(rowId) {
	var check = true;
	return check;
}

function btn_reload_onclick() {
	$('#testPrdStdRevGrid').trigger('reloadGrid');
}

// 저장버튼 클릭이벤트
function btn_Update_onclick(grid) {
	bSaveGrade = true;
	var prdRowId = $('#allPrdGrid').jqGrid('getGridParam', 'selrow');
	var prdRow = $("#allPrdGrid").jqGrid('getRowData', prdRowId);
	fnEditRelease(grid);
	
	btn_Select_Sub_onclick();
	
	if ($("#max_grade").val() == '') {
		alert("최대등급을 설정해 주세요.");
		$("#max_grade").focus();
		return false;
	}
	
	var ids = $('#' + grid).jqGrid("getDataIDs");
	var max_grade = $("#max_grade").val();			
	/* for ( var i in ids ) {
		var row = $('#' + grid).getRowData(ids[i]);
		
		max_grade = $("#max_grade").val();
		
		switch(max_grade) {
			case "2":
				validateGrade(grid, row, ids[i], '1');
				validateGrade(grid, row, ids[i], '2');
				
				if (!bSaveGrade)
					return false;
			break;
			
			case "3":
				validateGrade(grid, row, ids[i], '1');
				validateGrade(grid, row, ids[i], '2');
				validateGrade(grid, row, ids[i], '3');
				
				if (!bSaveGrade)
					return false;
			break;
			
			case "4":
				validateGrade(grid, row, ids[i], '1');
				validateGrade(grid, row, ids[i], '2');
				validateGrade(grid, row, ids[i], '3');
				validateGrade(grid, row, ids[i], '4');
				
				if (!bSaveGrade)
					return false;
			break;
		}
		
	} */
	
	if (ids.length < 1) {
		$.showAlert("시험항목 목록이 존재하지 않습니다.");
		return;
	}

	if (!editCount(grid)) {
		alert("변경된 시험항목 목록이 없습니다.");
		return;
	}

	var revGrid = 'testPrdStdRevGrid';
	var data = fnGetGridCheckData(revGrid);
	var json = fnAjaxAction('master/updateGradeItem.lims', data);

	var maxData = 'max_grade=' + max_grade + '&prdlst_cd=' + prdRow.prdlst_cd;
	var maxJson = fnAjaxAction('master/updateSampleMaxGrde.lims', maxData);
	
	if ((json == null) || (maxJson == null)) {
		$.showAlert("저장 실패하였습니다.");
	} else {
		$.showAlert("", {
			type : 'insert'
		});
		btn_Search_onclick();
	}			
	
	return data;
}

//최대등급변동
function maxGradeOnchange() {
	var max_grade = $("#max_grade").val();
	
	fnEditRelease('testPrdStdRevGrid');
	
	switch(max_grade) {
		
		case "1":
			jQuery("#testPrdStdRevGrid").jqGrid('showCol',["grade1","grade1_range"]);
			jQuery("#testPrdStdRevGrid").jqGrid('hideCol',["grade2","grade2_range","grade3","grade3_range","grade4","grade4_range"]);
			break;
		
		case "2":
			jQuery("#testPrdStdRevGrid").jqGrid('showCol',["grade1","grade1_range","grade2","grade2_range"]);
			jQuery("#testPrdStdRevGrid").jqGrid('hideCol',["grade3","grade3_range","grade4","grade4_range"]);
			
			jQuery("#testPrdStdRevGrid").jqGrid("setColProp", "grade1_range", {editoptions: {value: gradeRangeStd}});
			jQuery("#testPrdStdRevGrid").jqGrid("setColProp", "grade2_range", {editoptions: {value: gradeRangeStd}});
			
			break;
		
		case "3":
			jQuery("#testPrdStdRevGrid").jqGrid('showCol',["grade1","grade1_range","grade2","grade2_range","grade3","grade3_range"]);
			jQuery("#testPrdStdRevGrid").jqGrid('hideCol',["grade4","grade4_range"]);
			
			jQuery("#testPrdStdRevGrid").jqGrid("setColProp", "grade1_range", {editoptions: {value: gradeRangeStd}});
			jQuery("#testPrdStdRevGrid").jqGrid("setColProp", "grade2_range", {editoptions: {value: gradeRangeStd}});
			jQuery("#testPrdStdRevGrid").jqGrid("setColProp", "grade3_range", {editoptions: {value: gradeRangeStd}});
			
			break;
		
		case "4":
			jQuery("#testPrdStdRevGrid").jqGrid('showCol',["grade1","grade1_range","grade2","grade2_range","grade3","grade3_range","grade4","grade4_range"]);
			
			jQuery("#testPrdStdRevGrid").jqGrid("setColProp", "grade1_range", {editoptions: {value: gradeRangeStd}});
			jQuery("#testPrdStdRevGrid").jqGrid("setColProp", "grade2_range", {editoptions: {value: gradeRangeStd}});
			jQuery("#testPrdStdRevGrid").jqGrid("setColProp", "grade3_range", {editoptions: {value: gradeRangeStd}});
			jQuery("#testPrdStdRevGrid").jqGrid("setColProp", "grade4_range", {editoptions: {value: gradeRangeStd}});
			break;
	}
}

function validateGrade(grid, row, rowId, grade) {
	var grade_value = eval('row.grade' + grade);
	var grade_range = eval('row.grade' + grade + '_range');
	
	if ($.trim(grade_value) == '') {
		alert(row.testitm_nm + ' 등급' + grade + '의 값을 입력해주세요.');
		fnGridEdit(grid, rowId, null);
		$("#" + rowId + "_grade" + grade).focus();
		bSaveGrade = false;
	}
	else if ($.trim(grade_range) == '') {
		alert(row.testitm_nm + ' 등급' + grade + '의 범위를 선택해주세요.');
		fnGridEdit(grid, rowId, null);
		$("#" + rowId + "_grade" + grade + "_range").focus();
		bSaveGrade = false;
	}
}

// 품목 조회
function btn_Select_Sub_onclick() {
	$('#allPrdGrid').trigger('reloadGrid');
}

function btn_Copy_onclick(){
	if (!confirm('선택된 품목의 프로토콜 항목을 불러오시겠습니까?')) {
		return;
	}
	
	var grid = 'allPrdGrid';
	var rowId = $('#'+grid).jqGrid('getGridParam', 'selrow');
	var data = 'prdlst_cd='+rowId;
	var json = fnAjaxAction('master/copyGradeItem.lims', data);

	if (json == null) {
		$.showAlert("갸저오기 실패하였습니다.");
	} else {
		$.showAlert("", {
			type : 'insert'
		});
		btn_Search_onclick();
	}
}

//시험방법 선택 팝업 콜백
function fnpop_methodCallback(rowId){
 	fnBasicEndLoading();
	var grid = 'testPrdStdRevGrid';
	fnEditRelease(grid);
	testPrdStdRevGridEdit(grid, rowId); 
}

//계산식 콜백
function fnpop_formula_callback(grid, gridRowId, formula_no, formula_disp, average){

	$("#"+grid).setCell(gridRowId, "formula_no", formula_no);
	$("#"+grid).setCell(gridRowId, "formula_nm", formula_disp);

	var grid = 'testPrdStdRevGrid';
	fnEditRelease(grid);
	testPrdStdRevGridEdit(grid, gridRowId); 

}

</script>
<div class="sub_purple_01 w35p">
<form id="allPrdForm" name="allPrdForm" onsubmit="return false;">
	<table width="100%" border="0" class="select_table" >
		<tr>
			<td width="20%" class="table_title">
				<span>■</span>
				품목 목록
			</td>
			<td class="table_button" style="text-align: right; padding-right: 30px;">
				<span class="button white mlargeb auth_select" id="btn_Select" onclick="btn_Select_Sub_onclick();">
					<button type="button">조회</button>
				</span>
			</td>
		</tr>
	</table>
	<!-- 조회 테이블 -->
	<table  class="list_table" >
		<tr>
			<th>품목명</th>
			<td>
				<input type="text" name="kor_nm"/>
			</td>
		</tr>
	</table>
	<input type="hidden" id="prdlst_yn" name="prdlst_yn" value='Y'>
	<input type="hidden" id="use_yn" name="use_yn" value='Y'>
	<div id="view_grid_prd">
		<table id="allPrdGrid"></table>
		<div id="allPrdGridPager"></div>
	</div>
</form>
</div>

<div class="w5p"></div>

<div class="sub_blue_01 w60p" style="margin-top:0px;">
	<div class="sub_blue_01">
		<form id="testPrdStdRevGridForm" name="testPrdStdRevGridForm" onsubmit="return false;">
		<table  class="select_table" >
			<tr>
				<td width="20%" class="table_title">
					<span>■</span>
					항목 목록
				</td>
				<td class="table_button" style="text-align: right;">
					<select id="max_grade" name="max_grade" class="w100px" onchange="maxGradeOnchange();">
						<option value="">==선택==</option>
						<option value="1">1등급</option>
						<option value="2">2등급</option>
						<option value="3">3등급</option>
						<option value="4">4등급</option>
					</select>
					
					<span class="button white mlargeg auth_save" id="btn_Copy" onclick="btn_Copy_onclick();">
						<button type="button">프로토콜항목불러오기</button>
					</span>
					<span class="button white mlargep auth_save" id="btn_Add" onclick="btn_Add_onclick('testPrdStdRevGridForm');">
						<button type="button">항목추가</button>
					</span>
					<span class="button white mlargep auth_save" id="btn_Del" onclick="btn_Del_onclick('testPrdStdRevGridForm');">
						<button type="button">항목삭제</button>
					</span>
					<span class="button white mlargep auth_save" id="btn_Edit" onclick="btn_Update_onclick('testPrdStdRevGrid');">
						<button type="button">저장</button>
					</span>
				</td>
			</tr>
		</table>
	
		<div id="view_grid_rev">
			<table id="testPrdStdRevGrid"></table>
		</div>
		<input type="hidden" id="prdlst_cd" name="prdlst_cd">
		<input type="hidden" id="prdlst_nm" name="prdlst_nm">
		<input type="hidden" id="indv_spec_seq" name="indv_spec_seq">
		<input type="hidden" id="sortName" name="sortName">
		<input type="hidden" id="sortType" name="sortType">
		</form>
	</div>
</div>
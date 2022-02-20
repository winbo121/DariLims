
<%
	/***************************************************************************************
	 * 시스템명 	: 통합장비관제시스템
	 * 업무명 		: 검사기준관리
	 * 파일명 		: testStdRevL01.jsp
	 * 작성자 		: 석은주
	 * 작성일 		: 2015.01.22
	 * 설  명		: 검사기준관리 목록 조회 화면
	 *---------------------------------------------------------------------------------------
	 * 변경일		 변경자		변경내역 
	 *---------------------------------------------------------------------------------------
	 * 2015.01.22    석은주		최초 프로그램 작성         
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

#testStdRevDiv {
	background-color: white;
	border: 2px;
	border-radius: 8px;
	border-style: solid;
	border-color: #b27ce0;
	width: 300px;
	position: absolute;
	padding-bottom: 15px;
}
/* 한글우선입력 */
.imeon input {
	ime-mode: active;
}
</style>
<script type="text/javascript">
	var unit_cd_sel;
	var result_type;
	var mxmm_val_dvs_cd;
	var mimm_val_dvs_cd;
	var choic_fit;
	var choic_impropt;
	$(function() {
		/* 세부권한검사 */
		fn_auth_check();
		
		// ID가 testStdRevDiv인 요소를 hide(); 
		$('#testStdRevDiv').hide();

		ajaxComboStdNo('test_std_no');
// 		$("#test_std_no").val("001");
// 		$("#test_std_no option").not(":selected").attr("disabled", "disabled"); //  외의 disabled
		
		ajaxComboStdNo('rev_no');	
		ajaxCombo('result_type', 'C31', 'ALL', '');
		ajaxCombo('unit_cd', 'C08', 'ALL', '');
		ajaxComboForm("dept_cd", "", "${session.dept_cd}", null, 'form');
		
		unit_cd_sel = fnGridCommonCombo('C08', null);
		result_type = fnGridCommonCombo('C31', null);
		mxmm_val_dvs_cd = fnGridCommonCombo('C36', null);
		mimm_val_dvs_cd = fnGridCommonCombo('C35', null);
		choic_fit = fnGridCommonCombo('C34', null);
		choic_impropt = fnGridCommonCombo('C34', null);
		
		
		grid('master/selectStdTestItemList.lims', 'form', 'testStdRevGrid');
		//$('#testStdRevGrid').clearGridData(); // 최초 조회시 데이터 안나옴

		//그리드 사이즈 
		$(window).bind('resize', function() {
			$("#testStdRevGrid").setGridWidth($('#view_grid_rev').width(), false);
		}).trigger('resize');

		fnDatePicker('rev_date');

		// 엔터키 눌렀을 경우
		fn_Enter_Search('form', 'testStdRevGrid');
	});

	function grid(url, form, grid) {
		var lastRowId = 0;
		$('#' + grid).jqGrid({
			datatype : function(json) {
				fn_GridData(url, form, grid);
			},
// 			height : '362px',
// 			// 			width : 'auto',
// 			autowidth : true,
// 			loadonce : true,
// 			mtype : "POST",
// 			gridview : true,
// 			shrinkToFit : false,
// 			rowNum : -1,
// 			rownumbers : true,
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
				},
				frozen : true
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
				name : 'prdlst_nm',
				hidden : true,
				width : '250'
			}, {
				label : 'test_item_cd',
				name : 'test_item_cd',
				hidden : true,
				width : '250'
			}, {
				label : '항목명',
				name : 'test_item_nm',
				width : '250'
			}, {
				label : '결과값형태<span class="indispensableGrid"></span>',
				name : 'jdgmnt_fom_cd',
				editable : true,
				edittype : "select",
				width : '80',
				align : 'center',
				formatter : 'select',
				editoptions : {
					value : result_type,
					dataEvents : [ {
						type : 'change',
						fn : function(e) {
							editable(e);
						}
					} ]
				}
			}, {
				label : '기준값',
				name : 'spec_val',
				classes : 'imeon'
			}, {
				label : '단위',
				name : 'unit_cd',
				width : '100',
				editable : true,
				formatter : 'select',
				edittype : "select",
				editoptions : {
					value : unit_cd_sel
				}
			}, {
				label : '표기자리수',
				name : 'vald_manli',
				width : '70',
				align : 'right'
			}, {
				label : '기준하한값',
				name : 'mimm_val',
				width : '70',
				align : 'right'
			}, {
				label : '하한값구분',
				name : 'mimm_val_dvs_cd',
				width : '70',
				align : 'center',
				formatter : 'select',
				edittype : "select",
				editoptions : {
					value : mimm_val_dvs_cd
				}
			}, {
				label : '기준상한값',
				name : 'mxmm_val',
				width : '70',
				align : 'right'
			}, {
				label : '상한값구분',
				name : 'mxmm_val_dvs_cd',
				width : '70',
				align : 'center',
				formatter : 'select',
				edittype : "select",
				editoptions : {
					value : mxmm_val_dvs_cd
				}
			}, {
				label : '기준적합값',
				name : 'choic_fit', 
				width : '100',
				edittype : "select",
				formatter : 'select',
				editoptions : {
					value : choic_fit
				}
			}, {
				label : '기준부적합값',
				name : 'choic_impropt',
				width : '100',
				edittype : "select",
				formatter : 'select',
				editoptions : {
					value : choic_impropt
				}
			}, {
				label : '정량하한값',
				name : 'loq_lval',
				width : '100'
			}, {
				label : '정량상한값',
				name : 'loq_hval',
				width : '100'
			}, {
				label : '수수료',
				name : 'fee',
				width : '80',
				align : 'right',
				formatter : 'integer',
				formatoptions : {
					thousandsSeparator : ","
				},
				hidden : true
			}, {
				label : '수수료그룹코드',
				name : 'fee_group_no',
				hidden : true
			}, {
				type : 'not',
				label : '수수료그룹',
				name : 'fee_group_nm',
				width : '120',
				editoptions : {
					readonly : "readonly"
				},
				hidden : true
			}, {
				label : '시험항목코드',
				name : 'test_item_cd',
				hidden : true,
				editable : true
			}, {
				label : 'indv_spec_seq',
				name : 'indv_spec_seq',
				key : true,
				hidden : true
			}],
			height : '362',
			rowNum : -1,
			rownumbers : true,
			autowidth : false,
			gridview : false,
			shrinkToFit : false,
			pager : "#"+grid+"Pager",
			viewrecords : true,
			scroll : true,
			rowList : [50,100,200],
			prmNames : {
				id : 'KEY',
				page : 'pageNum',
				rows : 'pageSize',
				sort : 'sortTarget',
				order : 'sortValue'
			},
				jsonReader : {        
				root : 'rows',        
				page : 'pageNum',        
				rowNum : 'pageSize',        
				records : 'total',        
				total : 'totalPage',        
				id : 'row_num',     
				repeatitems : true        
			},
			//emptyrecords : '데이터가 존재하지 않습니다.',
			gridComplete : function(data) {
				// 				$('#btn_Delete').hide();
				gridPrdLstPopComplete();
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
				//  				$('#' + grid).jqGrid("setSelection", rowId, true);				
			},
			onCellSelect : function(rowId, iCol, cellcontent, e) {
				var colArr = $('#' + grid).jqGrid('getGridParam', 'colModel');
				var col = colArr[iCol].name;
				if (col == 'fee_group_pop') {
					var ret = popFeeGroup();
					if (ret != null && ret != '') {
						var arr = ret.split('◆★◆');
						$('#' + grid).jqGrid('setCell', rowId, 'fee', arr[2]);
						$('#' + grid).jqGrid('setCell', rowId, 'fee_group_nm', arr[1]);
						$('#' + grid).jqGrid('setCell', rowId, 'fee_group_no', arr[0]);
						testStdRevGridEditCell(grid, rowId);
					}
				} else if (col == 'fee_group_del') {
					$('#' + grid).jqGrid('setCell', rowId, 'fee_group_nm', null);
					$('#' + grid).jqGrid('setCell', rowId, 'fee_group_no', null);
					$('#' + grid).jqGrid('setCell', rowId, 'fee', null);
					testStdRevGridEditCell(grid, rowId);
				}
			},
			onSelectRow : function(rowId, status, e) {
				if (rowId && rowId != lastRowId) {
					fnEditRelease(grid);
					lastRowId = rowId;
				}
				// 				$('#btn_Delete').show();
			},
			ondblClickRow : function(rowId, iRow, iCol, e) {
				fnEditRelease(grid);
				testStdRevGridEdit(grid, rowId);
				var colArr = $('#' + grid).jqGrid('getGridParam', 'colModel');
				$('#' + rowId + '_' + colArr[iCol].name).focus();
			},
		});

		$('#' + grid).jqGrid('setGroupHeaders', {
			useColSpanStyle : true,
			groupHeaders : [ {
				startColumnName : 'unit_cd',
				numberOfColumns : 6,
				titleText : '수치형기준'
			}, {
				startColumnName : 'choic_fit',
				numberOfColumns : 2,
				titleText : '선택형기준'
			} ]
		});
	}
	
	function gridPrdLstPopComplete(){	
		$(window).bind('resize', function() {
			$("#testStdRevGrid").setGridWidth($('#view_grid_rev').width(), false);
		}).trigger('resize');
	}
	
	// 시험기준별시험항목에 수정, 삭제, 업데이트 된 항목이 있는지 확인
	function editCount() {
		var grid = 'testStdRevGrid';
		var check = false;
		var ids = $('#' + grid).jqGrid("getDataIDs");
		for ( var i in ids) {
			var row = $('#reqGrid').getRowData(ids[i]);
			if (row.crud == 'n' || row.crud == 'd' || row.crud == 'u')
				check = true;
		}
		return check;
	}
	
	// 에디트모드
	function testStdRevGridEdit(grid, rowId) {
		var row = $('#' + grid).getRowData(rowId);
		if (row.crud != 'n') {
			$('#' + grid).setCell(rowId, 'icon', gridU);
			$('#' + grid).setCell(rowId, 'crud', 'u');
		}
		editable('');
	}
	
	// 업데이트 아이콘 생성
	function testStdRevGridEditCell(grid, rowId) {
		var row = $('#' + grid).getRowData(rowId);
		if (row.crud != 'n') {
			$('#' + grid).setCell(rowId, 'icon', gridU);
			$('#' + grid).setCell(rowId, 'crud', 'u');
		}
	}
	
	// 수수료그룹
	function popFeeGroup() {
		var obj = new Object();
		obj.msg1 = 'master/feeGroup.lims';
		return fnShowModalWindow("popMain.lims", obj, 700, 370);
	}
	
	// 셀 수정 여부
	function editable(e) {
		var grid = 'testStdRevGrid';
		var rowId = $('#' + grid).jqGrid('getGridParam', 'selrow');
		var arr = new Array();
		arr.push('jdgmnt_fom_cd');
		// 결과값형태
		var row = $("#" + grid).jqGrid('getRowData', rowId);
		var row_jdgmnt_fom_cd = '';
		if (e != '') {
			row_jdgmnt_fom_cd = $(e.target).val();
			fnEditRelease(grid);
		} else
			row_jdgmnt_fom_cd = row.jdgmnt_fom_cd;
		
		switch (row_jdgmnt_fom_cd) {
		// 선택형
		case 'C31001':
			arr.push('spec_val');
			arr.push('choic_fit');
			arr.push('choic_impropt');
			arr.push('loq_lval');
			arr.push('loq_hval');
			arr.push('unit_cd');
			// arr.push('fee');
			break;
		// 수치형
		case 'C31002':
			// arr.push('spec_val');
			arr.push('vald_manli');
			arr.push('mxmm_val');
			arr.push('mxmm_val_dvs_cd');
			arr.push('mimm_val');
			arr.push('unit_cd');
			arr.push('mimm_val_dvs_cd');
			arr.push('loq_lval');
			arr.push('loq_hval');
			// arr.push('fee');
			break;
		// 서술형
		case 'C31003':
			arr.push('spec_val');
			arr.push('loq_lval');
			arr.push('loq_hval');
			arr.push('unit_cd');
			arr.push('vald_manli');
			// arr.push('fee');
			break;
		// 결과값없음
		case 'C31004':
			//$('#' + rowId + '_spec_val').val('결과값없음');			
			//arr.push('spec_val');
			break;
		// 문서
		case 'C31005':
			//$('#' + rowId + '_spec_val').text("문서참조");
			break;
		// 2군법
		case 'C31006':
			arr.push('spec_val');
			break;
		// 3군법
		case 'C31007':
			arr.push('spec_val');
			break;
		default:
			break;
		}
		for ( var column in row) {
			if ($.inArray(column, arr) !== -1) {
				$("#" + grid).jqGrid('setColProp', column, {
					editable : true
				});
			} else {
				$("#" + grid).jqGrid('setColProp', column, {
					editable : false
				});
			}
		}
		if (e != '') {
			for ( var column in row)
				if (column != 'prdlst_cd' && column != 'prdlst_nm' && column != 'jdgmnt_fom_cd' && column != 'test_item_nm' 
						&& column != 'test_item_cd' && column != 'crud' && column != 'icon' && column != 'indv_spec_seq')
					$("#" + grid).jqGrid('setCell', rowId, column, null);
		}
		$("#" + grid).jqGrid('editRow', rowId);
		// selectbox 막음
		$("#testStdDiv select").attr("disabled", "disabled");

		if (row_jdgmnt_fom_cd == 'C31001' || row_jdgmnt_fom_cd == 'C31002') {
			fnStdTotal(rowId);
		}
	}
	
	// spec_val에 합계 값 입력
	function fnStdTotal(rowId) {
		$('#' + rowId + '_vald_manli').keyup(function() {
			if (!fnIsNumeric($('#' + rowId + '_vald_manli').val()) && $('#' + rowId + '_vald_manli').val() != '') {
				$.showAlert("숫자만 입력가능합니다.", {
					callback : function() {
						$('#' + rowId + '_vald_manli').val("");
						$('#' + rowId + '_vald_manli').focus();
					}
				});
			}
		});
		// 기준적합값 selectbox선택
		$('#' + rowId + '_choic_fit').change(function() {
			addStdTotal_fit(rowId, 'choic_fit');
		});
		$('#' + rowId + '_mimm_val,' + '#' + rowId + '_mxmm_val').keyup(function() {
			addStdTotal(rowId);
		});
		$('#' + rowId + '_mimm_val_dvs_cd,' + '#' + rowId + '_mxmm_val_dvs_cd').change(function() {
			addStdTotal(rowId);
		});
	}
	
	// 기준적합값 selectbox선택 값 기준에 붙임
	function addStdTotal_fit(rowId, column) {
		var stdFitVal = '';
		if ($('#' + rowId + '_' + column).val() == '')
			stdFitVal = '';
		else
			stdFitVal = $('#' + rowId + '_' + column + ' option:selected').text();
		if (stdFitVal != null && stdFitVal != '') {
			$('#' + rowId + '_spec_val').val(stdFitVal);
		}
	}
	
	// 수치형 합산값 기준에 붙임
	function addStdTotal(rowId) {
		var total = '';
		var stdLval = '';
		var lvalType = '';
		var stdHval = '';
		var hvalType = '';
		var row = $('#testStdRevGrid').getRowData(rowId);
		for ( var column in row) {
			switch (column) {
			case 'mxmm_val':
				stdHval = $('#' + rowId + '_' + column).val();
				if (!fnIsNumeric(stdHval) && stdHval != '') {
					$.showAlert("숫자만 입력가능합니다.", {
						callback : function() {
							$('#' + rowId + '_mxmm_val').val(null);
							$('#' + rowId + '_mxmm_val').focus();
						}
					});
					stdHval = '';
				}
				break;
			case 'mxmm_val_dvs_cd':
				if ($('#' + rowId + '_' + column).val() == '')
					hvalType = '';
				else
					hvalType = ' ' + $('#' + rowId + '_' + column + ' option:selected').text();
				break;
			case 'mimm_val':
				stdLval = $('#' + rowId + '_' + column).val();
				if (!fnIsNumeric(stdLval) && stdLval != '') {
					$.showAlert("숫자만 입력가능합니다.", {
						callback : function() {
							$('#' + rowId + '_mimm_val').val(null);
							$('#' + rowId + '_mimm_val').focus();
						}
					});
					stdLval = '';
				}
				break;
			case 'mimm_val_dvs_cd':
				if ($('#' + rowId + '_' + column).val() == '')
					lvalType = '';
				else
					lvalType = ' ' + $('#' + rowId + '_' + column + ' option:selected').text();
				break;
			}
		}
		if (lvalType != null && lvalType != '' && hvalType != null && hvalType != '')
			lvalType += ' ';
		total = stdLval + lvalType + stdHval + hvalType;

		var row_jdgmnt_fom_cd = $("#" + rowId + "_jdgmnt_fom_cd").val();
		switch (row_jdgmnt_fom_cd) {
		//수치형
		case 'C31002':
			$('#testStdRevGrid').jqGrid('setCell', rowId, 'spec_val', total);
			break;
		default:
			$('#' + rowId + '_spec_val').val(total);
			break;
		}
	}

	// 조회버튼 클릭 이벤트
	function btn_Search_onclick(type) {
		if (type == 1) {
			if (editCount()) {
				if (!confirm("수정중인 기준시험항목 목록은 사라집니다."))
					return 'stop';
			}
			//selectbox풀기
			$("#testStdDiv select").attr("disabled", false);
		}
		
// 		if ( $('#form').find('#test_std_no option:selected').val() == '001' ) {
		fnEditRelease('testStdRevGrid');
		$('#testStdRevGrid').trigger('reloadGrid');
// 		} else {
// 			fnEditRelease('testStdRevGrid');
// 			$('#testStdRevGrid').trigger('reloadGrid');
// 		}
	}

	// 기준별 시험항목 목록에 수정, 삭제, 업데이트 된 항목이 있는지 확인
	function editCount() {
		var grid = 'testStdRevGrid';
		var check = false;
		var ids = $('#' + grid).jqGrid("getDataIDs");
		for ( var i in ids) {
			var row = $('#testStdRevGrid').getRowData(ids[i]);
			if (row.crud == 'n' || row.crud == 'd' || row.crud == 'u')
				check = true;
		}
		return check;
	}

	// 저장버튼 클릭이벤트
	function btn_Insert_onclick(mode) {
		var grid = 'testStdRevGrid';
		var rowId = $('#' + grid).jqGrid('getGridParam', "selrow");
		if (!valiCheck(rowId))
			return;
		fnEditRelease(grid);
		
		var ids = $('#' + grid).jqGrid("getDataIDs");		
		for ( var i in ids ) {
			var row = $('#' + grid).getRowData(ids[i]);
			//fn_editable(grid, ids[i]);
			if ($.trim(row.spec_val) == '' || $.trim(row.spec_val) == '-') {
				alert(row.test_item_nm + ' 기준값을 입력해주세요.');
				fnGridEdit(grid, ids[i], null);
				//alert(ids[i]);
				$("#" + ids[i] + "_spec_val").focus();
				return false;
			}
		}
		
		if (ids.length < 1) {
			$.showAlert("시험항목 목록이 존재하지 않습니다.");
			return;
		}
		
		// 		alert(data)
		if (mode == 'item') {
			if (!editCount()) {
				alert("변경된 시험항목 목록이 없습니다.");
				return;
			}
			var data = fnGetGridAllData(grid);
			//alert(data);
			if ($("#form").find("#rev_no").val() == null || $("#form").find("#rev_no").val() == '') {
				$.showAlert("개정이력이 존재하지 않습니다. 개정추가를 해주세요.");
				return;
			}
			data += '&pageType=TESTSTD';
			data += '&test_std_no=' + $("#form").find("#test_std_no").val() + '&rev_no=' + $("#form").find("#rev_no").val();
			var json = fnAjaxAction('master/insertStdTestItem.lims', data);
			if (json == null) {
				$.showAlert("저장 실패하였습니다.");
			} else {
				$.showAlert("", {
					type : 'insert'
				});
				//selectbox풀기
				$("#testStdDiv select").attr("disabled", false);
				btn_Search_onclick(2);
			}
		} else
			data += '&test_std_no=' + $("#form").find("#test_std_no").val() + '&rev_no=';
		return data;
	}
	
	// 검사기준등록팝업
	function btn_Test_Std_Insert_onclick() {
		if (editCount()) {
			if (!confirm("수정중인 기준시험항목 목록은 사라집니다."))
				return 'stop';
		}
		fnEditRelease('testStdRevGrid');
		
		fnpop_testStdManagePop("form", "750", "395", '');
		fnBasicStartLoading();
	}
	
	// 시험항목추가 팝업
	function btn_Add_Test_Item_onclick() {
		fnEditRelease('testStdRevGrid');
		
		var ids = $('#testStdRevGrid').jqGrid("getDataIDs");
		var param = "";
		var arr = new Array();
		for ( var i in ids) {
			var row_ids = $('#testStdRevGrid').getRowData(ids[i]);
			arr[i] = row_ids.test_item_cd;
		}
		param =  $('#form').find('#test_std_no').val() + "◆★◆" + removeArrayDuplicate(arr) 
				+ "◆★◆" + '' + "◆★◆" + "TESTSTD"
				+ "◆★◆" + $('#form').find('#rev_no').val() + "◆★◆" + ""
				+ "◆★◆" + "";
		
		fnpop_prdItemChoicePop("form", "1000", "867", param);
		fnBasicStartLoading();
	}
	
	// 자식 -> 부모창 함수 호출
	function fnpop_callback(returnParam){
		$('#testStdRevGrid').trigger('reloadGrid');
		fnBasicEndLoading();
	}
	
	// 시험 항목 삭제 버튼 클릭
	function btn_Delete_onclick() {
		var b = false;
		var ids = $('#testStdRevGrid').jqGrid("getDataIDs");
		if (ids.length > 0) {
			for ( var i in ids) {
				var row = $('#testStdRevGrid').getRowData(ids[i]);
				if (row.chk == 'Yes') {
					b = true;
				}
			}
			if (b) {
				testStdGridDeleteMultiLine('testStdRevGrid');
			} else {
				$.showAlert('선택된 행이 없습니다. 체크박스를 선택해주세요');
			}
		}
	}
	
	// 삭제실행
	function testStdGridDeleteMultiLine(grid) {		
		var ids = $('#' + grid).jqGrid("getDataIDs");
		if (ids.length > 0) {
			for ( var i in ids) {
				var row = $('#' + grid).getRowData(ids[i]);
				if (row.chk == 'Yes') {
					if (row.crud != 'n') {
						$('#' + grid).setCell(ids[i], 'icon', gridD);
						$('#' + grid).setCell(ids[i], 'crud', 'd');
						$('#' + grid).setCell(ids[i], 'chk', 'No');
						//selectbox막기
						$("#testStdDiv select").attr("disabled", "disabled");
					} else {
						$('#' + grid).jqGrid('delRowData', ids[i]);
					}
				}
			}
		}
	}
	
	// 검사기준 개정추가 div
	function btn_Std_Rev_Insert_onclick(param) {
		if (param == 1) {
			$('#testStdRevDiv').css("top", ($(window).height() / 2.5) - ($('#testStdRevDiv').outerHeight() / 2));
			$('#testStdRevDiv').css("left", ($(window).width() / 2) - ($('#testStdRevDiv').outerWidth() / 2));
			// ID가 testStdRevDiv인 요소를 show(); 
			$('#testStdRevDiv').show();
			$('#rev_date').focus();
		} else {
			$('#testStdRevDiv').hide();
			var data = btn_Insert_onclick('tsRev');
			data += '&pageType=stdTestItemSave';
			data += '&rev_date=' + $('#form').find('#rev_date').val() + '&rev_reason=' + $('#form').find('#rev_reason').val();
			// 			alert(data)
			var json = fnAjaxAction('master/insertTestStdRev.lims', data);
			if (json == null) {
				$.showAlert("저장 실패하였습니다.");
			} else {
				alert("저장이 완료되었습니다.");
				//selectbox풀기
				$("#testStdDiv select").attr("disabled", false);
				rev_Search();
			}
		}
	}
	
	// 리비젼 완료 후 이벤트
	function rev_Search() {
		ajaxComboStdNo('rev_no');
	}
	
	// 검사기준 개정추가 div 닫기버튼 이벤트
	function btn_Std_Rev_Close_onclick() {
		$('#testStdRevDiv').hide();
	}
	
	// 검사기준콤보박스리로드
	function comboReload(key) {
		if (key == 'revDate') {
			ajaxComboStdNo(key, $('#form').find('#rev_no').val());
			btn_Search_onclick(2);
		} else {
			ajaxComboStdNo(key, '');
		}
	}
	
	// 콤보박스
	function ajaxComboStdNo(obj, val) {
		var masterUrl = '';
		var v = '';
		var t = '';
		var data = '';
		if (obj == 'test_std_no') { // 기준 정보
			masterUrl = 'master/selectTestStdList.lims';
			v = "test_std_no";
			t = "test_std_nm";
		} else {
			if (obj == 'rev_no') { // 개정 번호
			//masterUrl = 'master/selectTestStdRevList.lims';
			masterUrl = 'master/selectTestStdRevList.lims';
				v = "rev_no";
				t = "rev_no";
			} else { // 개정 날짜
			masterUrl = 'master/selectTestStdRevList.lims';
				v = "rev_no";
				t = "rev_date";
			}
			data = 'test_std_no=' + $('#form').find('#test_std_no').val();
		}
		$.ajax({
			url : masterUrl,
			type : 'POST',
			async : false,
			dataType : 'json',
			data : data,
			timeout : 5000,
			error : function() {
				alert('Error loading XML document');
			},
			success : function(json) {
				$("#" + obj).empty();
				$(json).each(function(index, entry) {
					if (obj == 'revDate') {
						if (val != null && val != '') {
							if (val == entry[v] || val == entry[t])
								$("#" + obj).append("<input class='noinput' value=" + entry[t] + " style='text-align: center;' readonly='readonly'></input>");
						}
					} else {
						if (val == entry[v] || val == entry[t])
							$("#" + obj).append("<option selected value='" + entry[v] + "'>" + entry[t] + "</option>");
						else
							$("#" + obj).append("<option value='" + entry[v] + "'>" + entry[t] + "</option>");
					}
				});
				$("#" + obj).trigger('change');// 강제로 이벤트 시키기
			}
		});
	}
	
	// 기준값 validation체크
	function valiCheck(rowId) {
		var result_id = $('#' + rowId + '_jdgmnt_fom_cd ').val();
		var check = true;
		if (result_id == 'C31002') {
			var stdHval = $('#' + rowId + '_mxmm_val');
			var stdLval = $('#' + rowId + '_mimm_val');
			var lvalType = $('#' + rowId + '_mimm_val_dvs_cd');
			var hvalType = $('#' + rowId + '_mxmm_val_dvs_cd');
			if (stdHval.val() != '' && stdLval.val() != '') {
				if (parseFloat(stdLval.val()) >= parseFloat(stdHval.val())) {
					alert("기준상한값보다 큰 값을 입력하셔야 합니다.");
					stdHval.val(null);
					stdHval.focus();
					check = false;
				}
			}
			if (check) {
				if (stdLval.val() == '') {
					if (lvalType.val() != '') {
						$.showAlert("기준하한값을 입력하세요.", {
							callback : function() {
								stdLval.focus();
							}
						});
						check = false;
					}
				} else {
					if (lvalType.val() == '') {
						$.showAlert("하한값구분을 선택하세요.", {
							callback : function() {
								lvalType.focus();
							}
						});
						check = false;
					}
				}
			}
			if (check) {
				if (stdHval.val() == '') {
					if (hvalType.val() != '') {
						$.showAlert("기준상한값을 입력하세요.", {
							callback : function() {
								stdHval.focus();
							}
						});
						check = false;
					}
				} else {
					if (hvalType.val() == '') {
						$.showAlert("상한값구분을 선택하세요.", {
							callback : function() {
								hvalType.focus();
							}
						});
						check = false;
					}
				}
			}
			if (check) {
				if ($('#' + rowId + '_unit_cd').val() == '') {
					$.showAlert("단위를 선택하세요.", {
						callback : function() {
							$('#' + rowId + '_unit_cd').focus();
						}
					});
					check = false;
				}
			}
		}
		return check;
	}
	
	// 엑셀 다운로드
	function btn_Excel_onclick() {
		var data = fn_Excel_Data_Make('testStdRevGrid');
		fn_Excel_Download(data);
	}	
</script>
<form id="form" name="form" onsubmit="return false;">
	<div class="sub_purple_01">
		<table  class="select_table" >
			<tr>
				<td width="20%" class="table_title">
					<span>■</span>
					검사기준관리(작업중)
				</td>
				<td class="table_button" style="text-align: right;">
					<span class="button white mlargep auth_select" id="btn_Select" onclick="btn_Search_onclick(1);">
						<button type="button">조회</button>
					</span>
					<span class="button white mlargep auth_save" id="btn_Test_Std_Insert" onclick="btn_Test_Std_Insert_onclick();">
						<button type="button">검사기준등록</button>
					</span>
					<span class="button white mlargep auth_save" id="btn_AddLine" onclick="btn_Add_Test_Item_onclick();">
						<button type="button">시험항목추가</button>
					</span>
					<span class="button white mlarger auth_save" id="btn_Delete" onclick="btn_Delete_onclick();">
						<button type="button">시험항목삭제</button>
					</span>
					<span class="button white mlargeg auth_save" id="btn_Insert" onclick="btn_Insert_onclick('item');">
						<button type="button">저장</button>
					</span>
					<span class="button white mlargep auth_save" id="btn_Test_Std_Insert" onclick="btn_Std_Rev_Insert_onclick(1);" >
						<button type="button">개정</button>
					</span>
					<span class="button white mlargeb auth_select" onclick="btn_Excel_onclick();" style="margin-right: 20px;">
						<button type="button">EXCEL</button>
					</span>
				</td>
			</tr>
		</table>
		<div id="testStdDiv">
			<table  class="list_table" >
				<tr>
					<th>기준</th>
					<td width="30%">
<!-- 						<select id='dept_cd' name="dept_cd"></select> -->
<!-- 						<input type="hidden" id="test_std_no" name="test_std_no" value="001"> -->
						<select id='test_std_no' name="test_std_no" onchange="comboReload('rev_no')"></select>
					</td>
					<th>개정이력</th>
					<td width="15%">
						<select id='rev_no' name="rev_no" onchange="comboReload('revDate')"></select>
					</td>
					<th>개정날짜</th>
					<td width="40%" id='revDate'></td>
				</tr>
			</table>
		</div>
		<input type="hidden" id="sortName" name="sortName">
		<input type="hidden" id="sortType" name="sortType">
		<input type='hidden' id='pageNum' name='pageNum'/>
		<input type='hidden' id='pageSize' name='pageSize'/>
		<input type='hidden' id='sortTarget' name='sortTarget'/>
		<input type='hidden' id='sortValue' name='sortValue'/>
		<div id="view_grid_rev">
			<table id="testStdRevGrid"></table>
			<div id="gridPrdLstPopPager"></div>
		</div>
	</div>

	<div id='testStdRevDiv'>
		<div class="sub_purple_01" style="width: 90%">
			<table  class="select_table" >
				<tr>
					<td width="40%" class="table_title">
						<span>■</span>
						개정추가
					</td>
					<td class="table_button" style="text-align: right;">
						<span class="button white mlargep auth_save" id="btn_Test_Std_Insert" onclick="btn_Std_Rev_Insert_onclick(2);">
							<button type="button">개정추가</button>
						</span>
						<span class="button white mlargep" id="btn_Test_Std_Insert" onclick="btn_Std_Rev_Close_onclick();">
							<button type="button">닫기</button>
						</span>
					</td>
				</tr>
			</table>
			<table  class="list_table" >
				<tr>
					<th>개정날짜</th>
					<td width="30%">
						<input type="text" name="rev_date" id="rev_date" />
					</td>
				</tr>
				<tr>
					<th>개정사유</th>
					<td width="30%">
						<input type="text" name="rev_reason" id="rev_reason" />
					</td>
				</tr>
			</table>
		</div>
	</div>
</form>

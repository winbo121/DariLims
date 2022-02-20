
<%
	/***************************************************************************************
	 * 시스템명 	: 통합장비관제시스템
	 * 업무명 		: 양식관리 리스트
	 * 파일명 		: documentL01.jsp
	 * 작성자 		: 최은향
	 * 작성일 		: 2015.10.01
	 * 설  명		: 양식관리 조회 화면
	 *---------------------------------------------------------------------------------------
	 * 변경일		 변경자		변경내역 
	 *---------------------------------------------------------------------------------------
	 * 2015.10.01    최은향		최초 프로그램 작성         
	 * 
	 *---------------------------------------------------------------------------------------
	 ****************************************************************************************/
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" media="screen" type="text/css" href="<c:url value='/css/common/sub.css'/>" />
<!DOCTYPE html>
<script type="text/javascript">
	var form_type;
	
	$(function() {
		/* 세부권한검사 */
		fn_auth_check();
		
		// 양식종류 select 박스		
		form_type = fnGridCombo('form_type', null);
		ajaxComboForm("form_type", "C60", "ALL", "", "formForm");
		
		fnDatePickerImg('revisionDate');
		
		formGrid('master/selectFormList.lims', 'formForm', 'formGrid');
		$('#formGrid').clearGridData(); // 최초 조회시 데이터 안나옴
		
		documentGrid('master/selectDocumentList.lims', 'documentForm', 'documentGrid');
		
		/* fnViewPage('master/documentDetail.lims', 'documentDetail', ''); */
		/* $("#btn_Insert").hide(); */
		
		$(window).bind('resize', function() {
			$("#formGrid").setGridWidth($('#view_grid_main').width(), true);
		}).trigger('resize');
		
		$(window).bind('resize', function() {
			$("#documentGrid").setGridWidth($('#view_grid_sub').width(), true);
		}).trigger('resize');

		fn_Enter_Search('formForm', 'formGrid');
		fn_Enter_Search('documentForm', 'documentGrid');
	});

	// 양식 그리드
	function formGrid(url, form, grid) {
		var lastRowId;
		$('#' + grid).jqGrid({
			datatype : function(json) {
				fnGridData(url, form, grid);
			},
			height : '245px',
			autowidth : true,
			loadonce : true,
			mtype : "POST",
			gridview : true,
			shrinkToFit : true,
			rowNum : -1,
			rownumbers : true,
			colModel : [{
				type : 'not',
				label : '양식번호',
				name : 'form_seq',
				width : '100',
				align : 'center',
				key : true
			}, {
				label : '양식제목',
				name : 'form_title',
				width : '150',
				editable : true,
				editrules : {
					required : true
				}
			}, {
				label : '양식이름',
				name : 'form_name',
				width : '150',
				editable : true,
				editrules : {
					required : true
				}
			}, {
				label : '양식종류',
				name : 'form_type',
				width : '100',
				editable : true,
				align : 'center',
				edittype : "select",
				editrules : {
					required : true
				},
				editoptions : {
					value : form_type
				},
				formatter : 'select'
			}, {
				label : '생성자',
				name : 'creater_id',
				width : '100',
				align : 'center',
				hidden : true
			}, {
				label : '작성일',
				name : 'create_date',
				width : '100',
				hidden : true
			}, {
				label : '표시 순서',
				name : 'etc',
				width : '200',
				editable : true
			}],
			gridComplete : function() {
				$("#btn_AddLine").show();
				$("#btn_Save").hide();
			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
			},
			onSelectRow : function(rowId, status, e) {
					$('#' + grid).jqGrid('restoreRow', lastRowId);
					$('#' + grid).jqGrid("setSelection", rowId, false);
					lastRowId = rowId;					
					$('#documentForm').find('#form_seq').val($('#formGrid').getRowData(rowId).form_seq);
					$('#documentGrid').trigger('reloadGrid');
					/* fnViewPage('master/documentDetail.lims', 'documentDetail', ''); */					
					/* $("#btn_Insert").show(); */
			}, 			
			ondblClickRow : function(rowId, iRow, iCol, e) {
				fnEditRelease(grid);
				$('#' + grid).jqGrid('editRow', rowId);
				$("#btn_AddLine").hide();
				$("#btn_Save").show();
			}
		});
	}
	
	// 문서관리 그리드
	function documentGrid(url, form, grid) {
		var lastRowId;
		$('#' + grid).jqGrid({
			datatype : function(json) {
				fnGridData(url, form, grid);
			},
			height : '245px',
			autowidth : true,
			loadonce : true,
			mtype : "POST",
			gridview : true,
			shrinkToFit : true,
			rowNum : -1,
			rownumbers : true,
			colModel : [{
				type : 'not',
				label : '문서번호',
				name : 'doc_seq',
				width : '100',
				align : 'center',
				key : true
			}, {
				label : '개정번호',
				name : 'doc_revision_seq',
				width : '70',
				align : 'center'
			}, {
				label : '개정일',
				name : 'doc_revision_date',
				align : 'center',
				width : '100'
			}, {
				label : '생성자',
				name : 'creater_id',
				width : '100',
				align : 'center',
				hidden : true
			}, {
				label : '작성일',
				name : 'create_date',
				width : '100',
				hidden : true
			} ],
			gridComplete : function() {
			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
			},
			onCellSelect : function(rowId, iCol, cellcontent, e) {
			},
			onSelectRow : function(rowId, status, e) {
				var param = 'key=' + rowId;
				$('#documentDetail').find('#form_seq').val($('#formGrid').getRowData(rowId).form_seq);
				$('#documentDetail').find('#doc_seq').val($('#documentGrid').getRowData(rowId).doc_seq);
				/* fnViewPage('master/documentDetail.lims', 'documentDetail', param); */
			}
		});
	}

	// 조회 이벤트
	function btn_Select_onclick() {
		$('#documentForm').find('#form_seq').val('');
		$('#formGrid').trigger('reloadGrid');
		$('#documentGrid').trigger('reloadGrid');
		/* fnViewPage('master/documentDetail.lims', 'documentDetail', ''); */
	}
	
	// 양식 저장 이벤트(일괄저장)
	function btn_Save_onclick(grid) {
		var rowId = $('#' + grid).getGridParam('selrow');
		var url = '';
		if (rowId == '0') {
			url = 'master/insertForm.lims';
		} else {
			url = 'master/updateForm.lims';
		}
		$('#' + grid).jqGrid('saveRow', rowId, successfunc, url, null, fn_Success_insertGroup);	
	}
	
	// 저장 후 콜백 이벤트
	function fn_Success_insertGroup(json) {
		if (json == null) {
			$.showAlert("저장 실패하였습니다.");
		} else {
			$.showAlert("", {
				type : 'insert'
			});
			btn_Select_onclick();
		}
	}

	// 양식추가
	function btn_AddLine_onclick() {			
		var json = fnAjaxAction('master/selectFormNo.lims', null);
		
		var grid = 'formGrid';
		$('#' + grid).jqGrid('addRow', {
			rowID : 0,
			position : 'last',
			initdata : {
				form_seq : json
			}
		});
		$("#btn_AddLine").hide();
		$("#btn_Save").show();
	}
	
	// 문서개정
	function btn_Revision_onclick() {
		if(!confirm("개정하시겠습니까?")){
			return;
		}
		var grid = 'formGrid';
		var rowId = $('#' + grid).getGridParam('selrow');
		
		if(rowId == null){
			alert('양식을 선택하여 주세요.');
		}else{
			var json = fnAjaxAction('master/insertDocument.lims?form_seq='+rowId, null);
			
			if (json == null) {
				$.showAlert("저장 실패하였습니다.");
			} else {
				$.showAlert("", {
					type : 'insert'
				});
				$('#documentGrid').trigger('reloadGrid');
			}
		}
	}
	
	// 저장(신규, 수정)버튼 클릭 이벤트
	function btn_Insert_onclick() {
		// 필수 체크
		if(formValidationCheck("documentDetail"))
			return;
		if ($('#documentDetail').find('#mul_file_att').val() == '' &&  $('#documentDetail').find('#file_nm').val() == '' ) {
				$.showAlert('문서를 선택해주세요.');
				$('#documentDetail').find('#mul_file_att').focus();
				return false;			 
		}else {
			// 신규(문서번호 없으면)
			var id = $('#documentDetail').find('#doc_seq').val();
			if (id == '') {
				if ($('#documentDetail').find('#mul_file_att').val() != '') {
					var json = fnAjaxFileAction('master/insertDocument.lims?form_seq='+$('#documentForm').find('#form_seq').val(), 'documentDetail', fn_suc);
				} else {
					var param = $('#documentDetail').serialize();
					var json = fnAjaxAction('master/insertDocument.lims?form_seq='+$('#documentForm').find('#form_seq').val(), param);
					if (json == null) {
						$.showAlert("저장 실패하였습니다.");
					} else {
						$.showAlert("", {
							type : 'insert'
						});
					}
				}
			// 수정
			} else {
				if ($('#documentDetail').find('#mul_file_att').val() != '') {
					var json = fnAjaxFileAction('master/updateDocument.lims', 'documentDetail', fn_suc);
				} else {
					var param = $('#documentDetail').serialize();
					var json = fnAjaxAction('master/updateDocument.lims', param);
					if (json == null) {
						$.showAlert("저장 실패하였습니다.");
					} else {
						$.showAlert("", {
							type : 'insert'
						});
					}
				}
			}
		}		
	}
	
	// 저장 후 콜백 이벤트
	function fn_suc(json) {
		if (json == null) {
			$.showAlert("저장 실패하였습니다.");
		} else {
			$.showAlert("", {
				type : 'insert'
			});
		}
	}
	
	// 삭제 버튼 클릭 이벤트
	function btn_Del_onclick() {	
		var rowId = $('#documentGrid').getGridParam('selrow');
		var param;
		var json;
		
		if (rowId == null) {
			alert('삭제 할 문저를 선택해주세요.');
		} else {
			if(confirm("선택하신 문서를 삭제하시겠습니까?")){			
				var row = $('#documentGrid').getRowData(rowId);
				param = 'doc_seq=' + row.doc_seq;
				json = fnAjaxAction('master/deleteDocument.lims', param);
				if (json == 0) {
					alert('양식의 문서가 등록되 있어 삭제가 불가능 합니다.');
					return false;
				} else {
					alert('삭제되었습니다.');
					btn_Select_onclick();
				}
			}
		}
	}
</script>

<div id="sampleDiv">
	<form id="formForm" name="formForm" onsubmit="return false;">
		<div class="sub_purple_01">
			<table class="select_table">
				<tr>
					<td width="20%" class="table_title">
						<span>■</span>
						양식정보
					</td>
					<td class="table_button" style="text-align: right; padding-right: 30px;">
						<span class="button white mlargep auth_select" id="btn_Select" onclick="btn_Select_onclick();">
							<button type="button">조회</button>
						</span>
						<span class="button white mlargeb auth_save" id="btn_AddLine" onclick="btn_AddLine_onclick();">
							<button type="button">추가</button>
						</span>
						<span class="button white mlargeg auth_save" id="btn_Save" onclick="btn_Save_onclick('formGrid');">
							<button type="button">저장</button>
						</span>
					</td>
				</tr>
			</table>
		</div>
		<div>
			<table class="list_table" >
				<tr>
					<th>양식번호</th>
					<td class="w100px">
						<input name="form_seq" type="text" class="w100px" />
					</td>
					<th>양식제목</th>
					<td class="w200px">
						<input name="form_title" type="text" class="w200px" />
					</td>
					<th>양식종류</th>
					<td>
						<select name="form_type" id="form_type" class="w100px"></select>
					</td>
				</tr>			
			</table>
		</div>
		<input type="hidden" id="sortName" name="sortName">
		<input type="hidden" id="sortType" name="sortType">
		<div id="view_grid_main">
			<table id="formGrid"></table>
		</div>
	</form>
</div>

<div>
	<form id="documentForm" name="documentForm" onsubmit="return false;">
		<div class="sub_purple_01">
			<table class="select_table">
				<tr>
					<td width="20%" class="table_title">
						<span>■</span>
						문서정보
					</td>
					<td class="table_button" style="text-align: right; padding-right: 30px;">
						<span class="button white mlargep auth_save" id="btn_Revision" onclick="btn_Revision_onclick();">
							<button type="button">개정</button>
						</span>
						<span class="button white mlarger auth_save" id="btn_Del" onclick="btn_Del_onclick();">
							<button type="button">삭제</button>
						</span>
					</td>
				</tr>
			</table>
		</div>
		<input type="hidden" id="sortName" name="sortName">
		<input type="hidden" id="sortType" name="sortType">
		<input type="hidden" id="form_seq" name="form_seq">
		<div id="view_grid_sub">
			<table id="documentGrid"></table>
		</div>
	</form>
</div>

<!-- <div class="sub_blue_01"> -->
<!-- 	<form id="documentDetail" name="documentDetail" onsubmit="return false;" class="w35p" style="float:right;"></form> -->
<!-- </div> -->
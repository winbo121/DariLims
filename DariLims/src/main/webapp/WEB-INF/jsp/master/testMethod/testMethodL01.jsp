
<%
	/***************************************************************************************
	 * 시스템명 	: 통합장비관제시스템
	 * 업무명 		: 메뉴관리
	 * 파일명 		: testMethodL01.jsp
	 * 작성자 		: 석은주
	 * 작성일 		: 2015.01.23
	 * 설  명		: 메뉴관리 리스트 조회 화면
	 *---------------------------------------------------------------------------------------
	 * 변경일		 변경자		변경내역 
	 *---------------------------------------------------------------------------------------
	 * 2015.01.23    석은주		최초 프로그램 작성         
	 * 
	 *---------------------------------------------------------------------------------------
	 ****************************************************************************************/
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html >
<link rel="stylesheet" media="screen" type="text/css" href="<c:url value='/css/common/sub.css'/>" />
<style>
</style>
<script type="text/javascript">
	$(function() {
		/* 세부권한검사 */
		fn_auth_check();
		
		// 		ajaxCombo("useFlag", "C29", "ALL",""); 

		grid('master/selectTestMethodList.lims', 'form', 'grid');
		$('#grid').clearGridData(); // 최초 조회시 데이터 안나옴

		fn_Enter_Search('form', 'grid');

		//그리드 사이즈 
		$(window).bind('resize', function() {
			$("#grid").setGridWidth($('#view_grid_main').width(), true);
		}).trigger('resize');

	});

	function grid(url, form, grid) {
		//var lastRowId;
		$('#' + grid).jqGrid({
			datatype : function(json) {
				fnGridData(url, form, grid);
			},
			height : '230',
			autowidth : true,
			loadonce : true,
			mtype : "POST",
			gridview : true,
			rowNum : -1,
			rownumbers : true,
			shrinkToFit : false,
			colModel : [ {
				label : 'test_method_no',
				name : 'test_method_no',
				key : true,
				hidden : true
			}, {
				label : '시험방법명',
				name : 'test_method_nm',
				width : '400'
			}, {
				label : '인용규격',
				name : 'quot_std'
			}, {
				label : '장비및조건',
				name : 'condition'
			}, {
				label : '시험지침서명',
				name : 'guide_nm'
			}, {
				label : '문서명',
				name : 'doc_nm'
			}, {
				label : '파일명',
				name : 'file_nm'
			}, {
				label : '첨부파일',
				name : 'att_file',
				hidden : true
			}, {
				label : '사용여부',
				name : 'use_flag',
				width : '80',
				align : 'center',
				formatter : 'select',
				editoptions : {
					value : 'Y:사용;N:사용안함'
				}
			} ],
			emptyrecords : '데이터가 존재하지 않습니다.',
			gridComplete : function() {
				$('#btn_AddLine').show();
				$('#btn_Insert').hide();
			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
			},
			onSelectRow : function(rowId, status, e) {
				$('#btn_AddLine').show();
				$('#btn_Insert').hide();
				fn_ViewPage('detail');
			}
		});
	}

	//상세보기, 신규 Detail 페이지 열기
	function fn_ViewPage(pageType) {
		var param = 'pageType=' + pageType;
		param += '&key=' + $('#grid').getGridParam('selrow');

		fnViewPage('master/selectTestMethodDetail.lims', 'detail', param);

		$('#btn_AddLine').show();
		$('#btn_Insert').show();
	}

	//저장(신규, 수정)버튼 클릭 이벤트
	function btn_Insert_onclick() {
		// 		Validation 체크
		if (!fn_saveValidation())
			return;
		var id = $('#detail').find('#test_method_no').val();
		if (id == '') {
			if ($('#detail').find('#m_file').val() != '') {				
				var json = fnAjaxFileAction('master/insertTestMethod.lims', 'detail', fn_suc);
			} else {
				var param = $('#detail').serialize();
				var json = fnAjaxAction('master/insertTestMethod.lims', param);
				if (json == null) {
					$.showAlert("저장 실패하였습니다.");
				} else {
					btn_Search_onclick();
					$.showAlert("", {
						type : 'insert'
					});
				}
			}
		} else {
			if ($('#detail').find('#m_file').val() != '') {
				var json = fnAjaxFileAction('master/updateTestMethod.lims', 'detail', fn_suc);
			} else {
				var param = $('#detail').serialize();
				var json = fnAjaxAction('master/updateTestMethod.lims', param);
				if (json == null) {
					$.showAlert("저장 실패하였습니다.");
				} else {
					btn_Search_onclick();
					$.showAlert("", {
						type : 'insert'
					});
				}
			}
		}
	}

	function fn_suc(json) {
		if (json == null) {
			alert('error');
		} else {
			btn_Search_onclick();
			$.showAlert("", {
				type : 'insert'
			});
		}
	}
	//조회
	function btn_Search_onclick() {
		$('#detail').empty();
		$('#grid').trigger('reloadGrid');
	}
	//첨부파일
	function setFile() {
		$('#m_file').trigger('click');

		var name = $('#m_file').val();
		if (name != '') {
			name = name.substring(name.lastIndexOf('\\') + 1);
			$('#file_name').html(name);
		}
	}
	//	Validation 체크	
	function fn_saveValidation() {
		if (fnIsEmpty($('#detail').find('#test_method_nm').val())) {
			$.showAlert("시험방법을 입력하십시오.", {
				callback : function() {
					$('#detail').find('#test_method_nm').focus();
					return false;
				}
			});
		} else {
			return true;
		}
	}
	
	// 엑셀 다운로드
	function btn_Excel_onclick() {
		var data = fn_Excel_Data_Make('grid');
		fn_Excel_Download(data);
	}
	
</script>
<form id="form" name="form" onsubmit="return false;">
	<div class="sub_purple_01">
		<table  class="select_table" >
			<tr>
				<td width="20%" class="table_title">
					<span>■</span>
					시험방법목록
				</td>
				<td class="table_button" style="text-align: right; padding-right: 30px;">
					<span class="button white mlargep auth_select" id="btn_Select" onclick="btn_Search_onclick();">
						<button type="button">조회</button>
					</span>
					<span class="button white mlargeg auth_save" id="btn_AddLine" onclick="fn_ViewPage('insert');">
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
				<th>시험방법명</th>
				<td>
					<input name="test_method_nm" type="text" class="inputhan" />
				
				</td>
				<th>인용규격</th>
				<td>
					<input name="quot_std" type="text" class="inputhan" />
				</td>
				<!-- <th>장비및조건</th>
				<td>
					<input name="condition" type="text" class="inputhan" />
				</td> -->
				<th>사용여부</th>
				<td>
					<label><input type='radio' name='use_flag' value='' style="width: 20px" checked="checked" />전체</label> <label><input type='radio' name='use_flag' value='Y' style="width: 20px" />사용</label> <label><input type='radio' name='use_flag' value='N' style="width: 20px" />사용안함</label>
				</td>
			</tr>
		</table>
	</div>

	<input type="hidden" id="sortName" name="sortName">
	<input type="hidden" id="sortType" name="sortType">
	<div id="view_grid_main">
		<table id="grid"></table>
	</div>
</form>
<form id="detail" name="detail" enctype="multipart/form-data" onsubmit="return false;"></form>

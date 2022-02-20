
<%
	/***************************************************************************************
	 * 시스템명 	: 통합장비관제시스템
	 * 업무명 		: 문서등록
	 * 파일명 		: kolasDocL01.jsp
	 * 작성자 		: 석은주
	 * 작성일 		: 2015.02.02
	 * 설  명		: 문서등록 리스트 조회 화면
	 *---------------------------------------------------------------------------------------
	 * 변경일		 변경자		변경내역 
	 *---------------------------------------------------------------------------------------
	 * 2015.02.02    석은주		최초 프로그램 작성         
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
		
		ajaxCombo("docType", "C01", "ALL", "");
		kolasDocGrid('kolas/selectKolasDocList.lims', 'form', 'kolasDocGrid');
		$('#kolasDocGrid').clearGridData(); // 최초 조회시 데이터 안나옴

		fnDatePickerImg('startDate');
		fnDatePickerImg('endDate');

		ajaxComboForm("dept_cd", "", "ALL", null, 'form');

		//그리드 사이즈 
		$(window).bind('resize', function() {
			$("#kolasDocGrid").setGridWidth($('#view_grid_main').width(), false);
		}).trigger('resize');

		// 엔터키 눌렀을 경우
		fn_Enter_Search('form', 'kolasDocGrid');
	});

	function kolasDocGrid(url, form, grid) {
		//var lastRowId;
		$('#' + grid).jqGrid({
			datatype : function(json) {
				fnGridData(url, form, grid);
			},
			height : '250',
			autowidth : true,
			loadonce : true,
			mtype : "POST",
			gridview : true,
			shrinkToFit : false,
			rowNum : -1,
			rownumbers : true,
			colModel : [ {
				label : 'kolas_doc_no',
				name : 'kolas_doc_no',
				key : true,
				hidden : true
			}, {
				label : '문서구분',
				name : 'doc_type',
				align : 'center',
				width : '100'
			}, {
				label : '제목',
				name : 'doc_title',
				width : '550'
			}, {
				label : 'file_no',
				name : 'file_no',
				hidden : true
			}, {
				label : '문서명',
				name : 'file_nm',
				width : '400'
			}, {
				label : '첨부파일',
				//name : 'add_file_nm',
				width : '400',
				formatter : kolasDocDown
			}, {
				label : '부서',
				name : 'create_dept',
				width : '150',
				align : 'center'
			}, {
				label : '등록자',
				name : 'creater_id',
				width : '100',
				align : 'center'
			}, {
				label : '비고',
				name : 'ect'
			}, {
				label : '등록일',
				name : 'create_date',
				width : '100',
				align : 'center',
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
				// 				alert(status.reg_user);
				$('#btn_AddLine').show();
				$('#btn_Insert').hide();
				fn_ViewPage('detail');
			}
		});
	}

	//상세보기, 신규 Detail 페이지 열기
	function fn_ViewPage(pageType) {
		var param = 'pageType=' + pageType;
		param += '&kolas_doc_no=' + $('#kolasDocGrid').getGridParam('selrow');

		fnViewPage('kolas/selectKolasDocDetail.lims', 'detail', param);

		ajaxComboForm("doc_type", "C01", $('#detail').find('#doc_type_val').val(), "", "detail");

		fnDatePickerImg('create_date');

		if (pageType == 'insert')
			$('#detail').find('#create_date').val(fnGetToday(0,0));

		$('#btn_AddLine').show();
		$('#btn_Insert').show();
	}

	//저장(신규, 수정)버튼 클릭 이벤트
	function btn_Insert_onclick() {
		//Validation 체크
		if (!fn_saveValidation())
			return;
		var nm = $('#detail').find('#doc_title');
		if (nm.val() == '') {
			alert("필수등록항목입니다.");
			nm.focus();
			return;
		}
		var id = $('#detail').find('#kolas_doc_no').val();
		if (id == '') {
			if ($('#detail').find('#kolas_file').val() != '') {
				var json = fnAjaxFileAction('kolas/insertKolasDoc.lims', 'detail', fn_suc);
			} else {
				var param = $('#detail').serialize();
				var json = fnAjaxAction('kolas/insertKolasDoc.lims', param);
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
			if ($('#detail').find('#kolas_file').val() != '') {
				var json = fnAjaxFileAction('kolas/updateKolasDoc.lims', 'detail', fn_suc);
			} else {
				var param = $('#detail').serialize();
				var json = fnAjaxAction('kolas/updateKolasDoc.lims', param);
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
			$.showAlert("저장 실패하였습니다.");
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
		$('#kolasDocGrid').trigger('reloadGrid');
	}
	//첨부파일
	function setFile() {
		$('#kolas_file').trigger('click');

		var name = $('#kolas_file').val();
		if (name != '') {
			name = name.substring(name.lastIndexOf('\\') + 1);
			$('#file_name').html(name);
		}
	}
	
	//각각 ROW에 첨부파일 다운로드 링크 걸기(코라스-문서등록)
	/**
	 * 명칭 
	 * 설명
	 * @param  
	 * @return 
	 */
	function kolasDocDown(cellvalue, options, rowObject) {
		var edit;
		if (rowObject.add_file_nm == undefined)
			edit = '<label></label>';
		else
			edit = "<label><a href='kolas/kolasDocDown.lims?file_no=" + rowObject.file_no + "'>" + rowObject.add_file_nm + "</a></label>";
		return edit;
	}

	//	Validation 체크	
	function fn_saveValidation() {
		if (fnIsEmpty($('#detail').find('#doc_type').val())) {
			$.showAlert("문서구분을 선택하십시오.", {
				callback : function() {
					$('#detail').find('#doc_type').focus();
					return false;
				}
			});
		} else if (fnIsEmpty($('#detail').find('#doc_title').val())) {
			$.showAlert("제목을 입력하십시오.", {
				callback : function() {
					$('#detail').find('#doc_title').focus();
					return false;
				}
			});
		} else {
			return true;
		}
	}
</script>
<form id="form" name="form" onsubmit="return false;">
	<div class="sub_purple_01">
		<table  class="select_table" >
			<tr>
				<td width="20%" class="table_title">
					<span>■</span>
					KOLAS문서목록
				</td>
				<td class="table_button" style="text-align: right; padding-right: 30px;">
					<span class="button white mlargep auth_select" id="btn_Select" onclick="btn_Search_onclick();">
						<button type="button">조회</button>
					</span>
					<span class="button white mlargep auth_save" id="btn_AddLine" onclick="fn_ViewPage('insert');">
						<button type="button">추가</button>
					</span>
				</td>
			</tr>
		</table>
		<table  class="list_table" >
			<tr>
				<th>문서구분</th>
				<td>
					<select id="docType" name="doc_type"></select>
				</td>
				<th>제목</th>
				<td>
					<input name="doc_title" type="text" class="inputhan" />
				</td>
				<th>문서명</th>
				<td>
					<input name="add_file_nm" type="text" class="inputhan" />
				</td>
			</tr>
			<tr>
				<th>부서</th>
				<td>
					<select id="dept_cd" name="dept_cd"></select>
				</td>
				<th>등록일</th>
				<td>
					<input name="startDate" id="startDate" type="text" class="w80px" readonly="readonly" />
					<img src="<c:url value='/images/common/calendar_del.png'/>" id="startDateStop" style="cursor: pointer;" onClick='fn_TextClear("startDate")' /> ~
					<input name="endDate" id="endDate" type="text" class="w80px" readonly="readonly" />
					<img src="<c:url value='/images/common/calendar_del.png'/>" id="endDateStop" style="cursor: pointer;" onClick='fn_TextClear("endDate")' />
				</td>
				<th>사용여부</th>
				<td>
					<label><input type='radio' name='use_flag' value='' style="width: 20px" checked="checked" />전체</label> <label><input type='radio' name='use_flag' value='Y' style="width: 20px" />사용</label> <label><input type='radio' name='use_flag' value='N' style="width: 20px" />사용안함</label>
				</td>
				<!-- 	<td>
					<input name="startDate" id="startDate" type="text" class="inputhan" style="width: 70px;"/>~
					<input name="endDate" id="endDate" type="text" class="inputhan" style="width: 70px;"/>
				</td> -->
				<!-- <th>등록자</th>
				<td>
					<input name="user_nm" type="text" class="inputhan"/>
				</td>	 -->
				<!-- <th>비고</th>
				<td>
					<input name="etc" type="text" class="inputhan"/>
				</td> -->
			</tr>
		</table>
	</div>

	<input type="hidden" id="sortName" name="sortName">
	<input type="hidden" id="sortType" name="sortType">
	<div id="view_grid_main">
		<table id="kolasDocGrid"></table>
	</div>
</form>
<form id="detail" name="detail" enctype="multipart/form-data" onsubmit="return false;"></form>


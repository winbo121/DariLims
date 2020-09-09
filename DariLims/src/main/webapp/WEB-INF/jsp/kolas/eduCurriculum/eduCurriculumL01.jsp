
<%
	/***************************************************************************************
	 * 시스템명 	: 통합장비관제시스템
	 * 업무명 		: 교육과정목록
	 * 파일명 		: eduCurriculumL01.jsp
	 * 작성자 		: 석은주
	 * 작성일 		: 2015.01.26
	 * 설  명		: 교육과정 리스트 조회 화면
	 *---------------------------------------------------------------------------------------
	 * 변경일		 변경자		변경내역 
	 *---------------------------------------------------------------------------------------
	 * 2015.01.26    석은주		최초 프로그램 작성         
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
		
		fnDatePickerImg('startDate');
		fnDatePickerImg('endDate');

		grid('kolas/selectEduCurrList.lims', 'form', 'grid');
		$('#grid').clearGridData(); // 최초 조회시 데이터 안나옴

		ajaxComboForm("dept_cd", "", "ALL", null, 'form');
		ajaxCombo("edu_kind", "C07", "ALL", "");

		//그리드 사이즈 
		$(window).bind('resize', function() {
			$("#grid").setGridWidth($('#view_grid_main').width(), true);
		}).trigger('resize');

		// 엔터키
		fn_Enter_Search('form', 'grid');
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
			shrinkToFit : false,
			rowNum : -1,
			rownumbers : true,
			colModel : [ {
				label : '교육결과번호',
				name : 'edu_result_no',
				key : true,
				hidden : true
			}, {
				label : '교육종류',
				name : 'edu_kind',
				width : '100'
			}, {
				label : '관리부서',
				name : 'mgr_dept'
			}, {
				label : '교육기관',
				name : 'edu_org'
			}, {
				label : '교육장소',
				name : 'edu_place'
			}, {
				label : '교육시작일',
				name : 'edu_sdate',
				align : 'center',
				width : '100'
			}, {
				label : '교육종료일',
				name : 'edu_edate',
				align : 'center',
				width : '100'
			}, {
				label : '사내외구분',
				name : 'edu_type',
				width : '70',
				align : 'center'
			}, {
				label : '교육내용',
				name : 'edu_content'
			}, {
				label : '비고사항',
				name : 'edu_desc'
			} ],
			emptyrecords : '데이터가 존재하지 않습니다.',
			gridComplete : function() {
				$('#btn_AddLine').show();
				$('#btn_Insert').hide();
				$('#btn_Delete').hide();
			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
			},
			onSelectRow : function(rowId, status, e) {
				$('#btn_AddLine').show();
				$('#btn_Insert').hide();
				$('#btn_Delete').hide();
				fn_ViewPage('detail');
			}
		});
	}

	// 상세보기, 신규 Detail 페이지 열기
	function fn_ViewPage(pageType) {
		var param = 'pageType=' + pageType;
		param += '&key=' + $('#grid').getGridParam('selrow');

		fnViewPage('kolas/selectEduCurriculumDetail.lims', 'detail', param);

		if (pageType == 'detail')
			$('#btn_Delete').show();
		else
			$('#btn_Delete').hide();

		$('#btn_AddLine').show();
		$('#btn_Insert').show();

		fnDatePickerImg('edu_sdate');
		fnDatePickerImg('edu_edate');

		ajaxComboForm("dept_cd", "", $('#detail').find("#dept_cd_val").val(), null, 'detail');
		ajaxComboForm("edu_kind", "C07", $('#detail').find('#edu_kind_val').val(), "", "detail");
	}

	// 저장(신규, 수정)버튼 클릭 이벤트
	function btn_Insert_onclick() {
		// 		Validation 체크
		if (!fn_saveValidation())
			return;
		var id = $('#detail').find('#edu_result_no').val();
		if (id == '') {
			if ($('#detail').find('#edu_file').val() != '') {
				fnAjaxFileAction('kolas/insertEduCurriculum.lims', 'detail', fn_suc);
			} else {
				var param = $('#detail').serialize();
				var json = fnAjaxAction('kolas/insertEduCurriculum.lims', param);
				if (json == null) {
					$.showAlert("저장 실패하였습니다.");
				} else {
					$.showAlert("", {
						type : 'insert'
					});
					btn_Search_onclick();
				}
			}
		} else {
			if ($('#detail').find('#edu_file').val() != '') {
				fnAjaxFileAction('kolas/updateEduCurriculum.lims', 'detail', fn_suc);
			} else {
				var param = $('#detail').serialize();
				var json = fnAjaxAction('kolas/updateEduCurriculum.lims', param);
				if (json == null) {
					$.showAlert("저장 실패하였습니다.");
				} else {
					$.showAlert("", {
						type : 'insert'
					});
					btn_Search_onclick();
				}
			}
		}
	}
	
	function fn_suc(json) {
		if (json == null) {
			$.showAlert("저장 실패하였습니다.");
		} else {
			$.showAlert("", {
				type : 'insert'
			});
			btn_Search_onclick();
		}
	}
	
	// 삭제버튼 클릭 이벤트
	function btn_Delete_onclick() {
		if (!confirm('삭제하시겠습니까?')) {
			return false;
		}
		var param = $('#detail').serialize();
		var json = fnAjaxAction('kolas/deleteEduCurriculum.lims', param);
		if (json == null) {
			$.showAlert("삭제 실패하였습니다.");
		} else if(json == -1){
			$.showAlert("교육이 완료되었습니다.");
		} else if (json == 0){
			$.showAlert("해당 교육에는 참석자가 있습니다.");		
		} else {
			$.showAlert("", {
				type : 'delete'
			});
			btn_Search_onclick();
		}
	}

	// 조회버튼클릭이벤트
	function btn_Search_onclick() {
		$('#detail').empty();
		$('#grid').trigger('reloadGrid');
	}
	
	// 참석자 명단 팝업
	function btn_Edu_Attend_onclick(key) {
		/* var obj = new Object();
		obj.msg1 = 'kolas/popEduAttendInfo.lims?key=' + key;
		var popup = fnShowModalWindow("popMain.lims", obj, 700, 380);
		return popup; */
		
		fnpop_eduAttendInfoPop('form' ,700, 500, key);
	}
	
	// 파일첨부
	function setFile() {
		$('#edu_file').trigger('click');

		var name = $('#edu_file').val();
		if (name != '') {
			name = name.substring(name.lastIndexOf('\\') + 1);
			$('#file_name').html(name);
		}
	}
	
	//	Validation 체크	
	function fn_saveValidation() {
		if (fnIsEmpty($('#detail').find('#edu_kind').val())) {
			$.showAlert("교육종류를 입력하십시오.", {
				callback : function() {
					$('#detail').find('#edu_kind').focus();
					return false;
				}
			});
		} else if (fnIsEmpty($('#detail').find('#edu_org').val())) {
			$.showAlert("교육기관를 입력하십시오.", {
				callback : function() {
					$('#detail').find('#edu_org').focus();
					return false;
				}
			});
		} else if (fnIsEmpty($('#detail').find('#edu_place').val())) {
			$.showAlert("교육장소를 입력하십시오.", {
				callback : function() {
					$('#detail').find('#edu_place').focus();
					return false;
				}
			});
		} else if (fnIsEmpty($('#detail').find('#edu_sdate').val())) {
			$.showAlert("교육시작일을 입력하십시오.", {
				callback : function() {
					$('#detail').find('#edu_sdate').focus();
					return false;
				}
			});
		} else if (fnIsEmpty($('#detail').find('#edu_edate').val())) {
			$.showAlert("교육종료일을 입력하십시오.", {
				callback : function() {
					$('#detail').find('#edu_edate').focus();
					return false;
				}
			});
		}else {
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
	<div class="sub_purple_01 w100p">
		<table class="select_table" >
			<tr>
				<td class="table_title">
					<span>■</span>
					교육과정목록
				</td>
				<td class="table_button">
					<span class="button white mlargep auth_select" id="btn_Select" onclick="btn_Search_onclick();">
						<button type="button">조회</button>
					</span>
					<span class="button white mlargep auth_save" id="btn_AddLine" onclick="fn_ViewPage('insert');">
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
				<th>교육종류</th>
				<td>
					<select name="edu_kind" id="edu_kind" class="w120px"></select>
				</td>
				<th>교육기관</th>
				<td>
					<input name="edu_org" type="text" class="inputhan" />
				</td>
				<th>사내외구분</th>
				<td>
					<label><input type='radio' name='edu_type' value='' style="width: 20px" checked="checked" />전체</label> <label><input type='radio' name='edu_type' value='사내' style="width: 20px" />사내</label> <label><input type='radio' name='edu_type' value='사외' style="width: 20px" />사외</label>
				</td>
			</tr>
			<tr>
				<th>관리부서</th>
				<td>
					<select id="dept_cd" name="mgr_dept" class="w120px"></select>
				</td>
				<th>교육일</th>
				<td colspan="3">
					<input name="startDate" id="startDate" type="text" class="inputhan w80px" />
					<img src="<c:url value='/images/common/calendar_del.png'/>" id="startDateStop" style="cursor: pointer;" onClick='fn_TextClear("startDate")' /> ~
					<input name="endDate" id="endDate" type="text" class="inputhan w80px" />
					<img src="<c:url value='/images/common/calendar_del.png'/>" id="startDateStop" style="cursor: pointer;" onClick='fn_TextClear("endDate")' />
				</td>
				<%-- <th>교육종료일</th>
				<td>
					<input name="startDate2" id="startDate2" type="text" class="inputhan w80px"/>
					<img src="<c:url value='/images/common/calendar_del.png'/>" id="startDateStop" style="cursor: pointer;" onClick='fn_TextClear("startDate2")' />
					~
					<input name="endDate2" id="endDate2" type="text" class="inputhan w80px"/>
					<img src="<c:url value='/images/common/calendar_del.png'/>" id="startDateStop" style="cursor: pointer;" onClick='fn_TextClear("endDate2")' />
				</td> --%>
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



<%
	/***************************************************************************************
	 * 시스템명 	: 통합장비관제시스템
	 * 업무명 		: 교육결과등록
	 * 파일명 		: eduAttendL02.jsp
	 * 작성자 		: 석은주
	 * 작성일 		: 2015.01.28
	 * 설  명		: 교육결과등록 리스트 조회 화면
	 *---------------------------------------------------------------------------------------
	 * 변경일		 변경자		변경내역 
	 *---------------------------------------------------------------------------------------
	 * 2015.01.28    석은주		최초 프로그램 작성         
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
	var editChange;
	var addFileMode = false;
	var allselect = false;
	$(function() {
		allUserGrid('kolas/selectEduAttendList.lims', 'allUserForm', 'allUserGrid');
		//$('#allUserGrid').clearGridData(); // 최초 조회시 데이터 안나옴
		
		eduAttendGrid('kolas/selectEduAttendList.lims', 'eduAttendForm', 'eduAttendGrid');
		//$('#eduAttendGrid').clearGridData(); // 최초 조회시 데이터 안나옴

		$(window).bind('resize', function() {
			$("#allUserGrid").setGridWidth($('#view_grid_sub_l').width(), true);
		}).trigger('resize');

		$(window).bind('resize', function() {
			$("#eduAttendGrid").setGridWidth($('#view_grid_sub_r').width(), true);
		}).trigger('resize');

		// 엔터키
		fn_Enter_Search('allUserForm', 'allUserGrid');

	});

	// 전체 회원
	function allUserGrid(url, form, grid) {
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
			multiselect : true,
			colModel : [ {
				label : '아이디',
				name : 'user_no',
				key : true,
				hidden : true
			}, {
				label : '이름',
				name : 'user_nm',
				align: 'center',
				width : '100'
			}, {
				label : '부서',
				align: 'center',
				name : 'dept_nm'
			}, {
				label : '부서',
				name : 'dept_no',
				hidden : true
			}, {
				label : 'use_flag',
				name : 'use_flag',
				formatter : 'checkbox',
				hidden : true
			} ],
			emptyrecords : '데이터가 존재하지 않습니다.',
			gridComplete : function() {
				editChange = false;
			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
			},
			onSelectRow : function(rowId, status, e) {
				var ids = $('#eduAttendGrid').jqGrid("getDataIDs");
				for ( var i in ids) {
					if (rowId == ids[i]) {
						alert('이미 존재합니다.');
						$('#' + grid).jqGrid('setSelection', rowId, false);
					}
				}
			},
			onSelectAll : function(selar, status) {
				if (!allselect) {
					var i = 0;
					for ( var row in selar) {
						var sel_ids = $('#eduAttendGrid').jqGrid("getDataIDs");
						for ( var j in sel_ids) {
							if (sel_ids[j] == selar[row]) {
								$('#' + grid).jqGrid('setSelection', selar[row], false);
								i++;
							}
						}
					}
					if (i > 0) {
						if (selar.length == 0) {
							$.showAlert("모든 사원들이 추가되었습니다.");
							allselect = false;
							return 'stop';
						} else
							$.showAlert("이미 추가된 사원들이 있습니다.");
					}
				} else {
					$("#" + grid).jqGrid('resetSelection');
				}
				allselect = !allselect;
			}
		});
	}
	
	// 선택된 사원
	function eduAttendGrid(url, form, grid) {
		$('#' + grid).jqGrid({
			datatype : function(json) {
				fnGridData(url, form, grid);
			},
			height : '258',
			autowidth : true,
			loadonce : true,
			mtype : "POST",
			gridview : true,
			shrinkToFit : false,
			multiselect : true,
			colModel : [ {
				type : 'not',
				name : '첨부파일',
				index : 'action',
				formatter : displayButtons,
				hidden : true,
				width : '80'
			}, {
				label : '아이디',
				name : 'user_no',
				key : true,
				hidden : true
			}, {
				label : '참석자NO',
				name : 'attend_no',
				hidden : true
			}, {
				label : '이름',
				name : 'user_nm',
				align : 'center',
				width : '80'
			}, {
				label : '부서',
				name : 'dept_nm',
				align : 'center',
				width : '100'
			}, {
				label : '부서',
				name : 'dept_no',
				hidden : true
			}, {
				label : 'use_flag',
				name : 'use_flag',
				formatter : 'checkbox',
				hidden : true
			}, {
				label : '문서이름',
				name : 'doc_nm'
			}, {
				label : '파일이름',
				name : 'file_nm',
				hidden : true
			}, {
				label : '파일이름',
				formatter : displayAlink
				
			} ],
			emptyrecords : '데이터가 존재하지 않습니다.',
			gridComplete : function() {
				/* $('#btn_Cancle').hide();
				$('#btn_Cancle_Sub').hide();  */
			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
				if (!confirm('저장하지 않은 정보는 사라집니다. 정렬하시겠습니까?')) {
					return 'stop';
				}
			}
		});
	}
	
	// 참석자목록 수정중 시험항목목록 잠금
	function fn_Div_Block(id, msg, doc) {
		fnStartLoading(id, msg);
		$('.blockUI').click(function() {
			$.showConfirm("저장되지 않은 목록은 삭제됩니다.", {
				yesCallback : function() {
					if (doc == 'addDoc')
						btn_Cancle_onclick();
					else
						btn_Sub_onclick();
				}
			});
		});
	}
	
	// 시험항목잠금모드 취소
	function btn_Sub_onclick() {
		$('#eduAttendGrid').trigger('reloadGrid');
		$('#allUserGrid').trigger('reloadGrid');
	}
	
	// 이동
	function btn_Move(m) {
		if (addFileMode) {
			alert("첨부파일모드를 종료하세요.");
			return false;
		}
		/* $.showAlert("첨부파일모드를 종료해주세요.", {callback:function() {
			return false;
		}}); */
		var left = 'allUserGrid';
		var right = 'eduAttendGrid';
		switch (m) {
		case 1:
			var rowArr = $('#' + left).getGridParam('selarrrow');
			if (rowArr.length > 0) {
				editChange = true;
				for ( var i in rowArr) {
					var row = $('#' + left).getRowData(rowArr[i]);
					$('#' + right).jqGrid('addRowData', rowArr[i], row, 'last');
				}
				for (var i = rowArr.length - 1; i >= 0; i--) {
					$('#' + left).jqGrid('setSelection', rowArr[i], false);
				}
			} else {
				alert('선택된 행이 없습니다.');
			}
			allselect = false;
			break;
		case 3:
			var rowArr = $('#' + right).getGridParam('selarrrow');
			if (rowArr.length > 0) {
				editChange = true;
				for (var i = rowArr.length - 1; i >= 0; i--) {
					$('#' + right).jqGrid('delRowData', rowArr[i]);
				}
			} else {
				alert('선택된 행이 없습니다.');
			}
			break;
		}
	}

	// 저장버튼 클릭 이벤트
	function btn_Insert_onclick() {
		var grid = 'eduAttendGrid';
		var data = '';
		var row = $('#' + grid).jqGrid("getRowData");
		if (row.length > 0) {
			data = fnGetGridAllData(grid);
		} else {
			data = 'gridData=☆★☆★';
		}
		data += '&edu_result_no=' + $('#eduAttendForm').find('#edu_result_no').val();
		var json = fnAjaxAction('kolas/insertEduAttend.lims', data);
		if (json == null) {
			alert('error');
		} else {
			$.showAlert("", {
				type : 'insert'
			});
			btn_Sub_onclick();
		}
	}
	
	function btn_Search_Sub1_onclick() {
		$('#allUserGrid').trigger('reloadGrid');
	}
	
	function popSearchSub() {
		$('#eduAttendGrid').trigger('reloadGrid');
		$('#btn_Cancle').show();
		$('#btn_Cancle_Sub').show();
	}
	///////////////////////test입니다./////////////////////////////////////////////

	// 첨부파일 버튼 클릭이벤트
	function btn_Insert_Sub1_onclick() {
		if (editChange) {
			if (!confirm('수정중인 교육참석자 목록은 사라집니다. 이동하시겠습니까?'))
				return;
		}
		editChange = false;
		$('#eduAttendGrid').trigger('reloadGrid');

		var row = $('#eduAttendGrid').jqGrid("getRowData");
		if (row.length < 1) {
			$.showAlert("선택된 참석자목록이 존재하지 않습니다.");
			return;
		}
		//Set button disabled
		// 		$("#moveBtn button").attr("disabled", "disabled");
		addFileMode = true;
 		$("#eduAttendGrid").jqGrid('showCol', [ "첨부파일" ]);
		$('#btn_Insert_Sub1').hide();
		$('#btn_Insert').hide();
		$('#btn_Cancle').show();
	 	$('#btn_Cancle_Sub').show();  
	}
	
	// 첨부파일 저장모드 취소
	function btn_Cancle_onclick() {
		// 		$("#moveBtn button").attr("disabled", false);
		addFileMode = false;
		$("#eduAttendGrid").jqGrid('hideCol', [ "첨부파일" ]);
		$('#btn_Insert_Sub1').show();
		$('#btn_Insert').show();
		$('#btn_Cancle').hide();
		$('#btn_Cancle_Sub').hide();
	}
	
	// 첨부파일 버튼 각각 ROW에 추가
	function displayButtons(cellvalue, options, rowObject) {
		var edit = "<span class='button white mlargeg auth_select' id='' onclick='popEduAttendFileUpload(\"" + rowObject.attend_no + "\");'><button type='button'>첨부파일</button></span>";
		return edit;
	}
	
	// 각각 ROW에 첨부파일 다운로드 링크 걸기
	function displayAlink(cellvalue, options, rowObject) {
		var edit;

		if (rowObject.file_nm == undefined)
			edit = '<label></label>';
		else
			edit = "<label><a href='kolas/eduAttendFileDown.lims?attend_no=" + rowObject.attend_no + "'>" + rowObject.file_nm + "</a></label>";
		return edit;
	}
	
	// 첨부파일등록팝업
	function popEduAttendFileUpload(attend_no) {
		fnpop_eduAttendPop('eduAttendGrid', 630, 200, attend_no);
		fnBasicStartLoading();
	}
	
	function fnpop_callback(){
		fnBasicEndLoading();
		$('#eduAttendGrid').trigger('reloadGrid');
	}
	
</script>
<div class="sub_blue_01 w45p">
	<form id="allUserForm" name="allUserForm" onsubmit="return false;">
		<table  class="select_table" >
			<tr>
				<td width="100%" class="table_title">
					<span>■</span>
					전체사원
				</td>
				<td class="table_button" style="text-align: right; padding-right: 30px;">
					<span class="button white mlargeb auth_select" id="btn_Select" onclick="btn_Search_Sub1_onclick();">
						<button type="button">조회</button>
					</span>
				</td>
			</tr>
		</table>
		<table  class="list_table" >
			<tr>
				<th width="20%">이름</th>
				<td>
					<input name="user_nm" type="text" class="inputhan" />
				</td>

				<th width="20%">부서</th>
				<td>
					<input name="dept_nm" type="text" class="inputhan" />
				</td>
			</tr>
		</table>
		<input type="hidden" id="pageType" name="pageType" value="all">
		<input type="hidden" id="edu_result_no" name="edu_result_no" value="${detail.edu_result_no }" />
		<input type="hidden" id="sortName" name="sortName">
		<input type="hidden" id="sortType" name="sortType">
		<div id="view_grid_sub_l">
			<table id="allUserGrid"></table>
		</div>
	</form>
</div>
<div class="w10p" id="moveBtn">
	<span>
		<button type="button" id="btn_Right" onclick="btn_Move(1)" class="btnRight"></button>
	</span>
	<br>
	<br>
	<span>
		<button type="button" id="btn_Left" onclick="btn_Move(3);" class="btnLeft"></button>
	</span>
</div>
<div class="sub_blue_01 w45p">
	<form id="eduAttendForm" name="eduAttendForm" onsubmit="return false;">
		<table  class="select_table" >
			<tr>
				<td width="40%" class="table_title">
					<span style="font-size: 11px; margin-left: 15px; color: #27aeea;">■</span>
					교육참석자
				</td>
				<td class="table_button" style="text-align: right; padding-right: 30px;" width="60%">
					<span class="button white mlargeg auth_save" id="btn_Insert" onclick="btn_Insert_onclick();">
						<button type="button">저장</button>
					</span>
					<span class="button white mlargeg auth_save" id="btn_Insert_Sub1" onclick="btn_Insert_Sub1_onclick();">
						<button type="button">첨부파일저장</button>
					</span>
					<span class="button white mlargeg auth_save" id="btn_Cancle" onclick="btn_Cancle_onclick();">
						<button type="button">첨부파일저장완료</button>
					</span>
					<span class="button white mlargeg" id="btn_Cancle_Sub" onclick="btn_Cancle_onclick();">
						<button type="button">취소</button>
					</span>
				</td>
			</tr>
		</table>
		<input type="hidden" id="edu_result_no" name="edu_result_no" value="${detail.edu_result_no }" />
		<input type="hidden" id="sortName" name="sortName">
		<input type="hidden" id="sortType" name="sortType">
		<div id="view_grid_sub_r">
			<table id="eduAttendGrid"></table>
		</div>
	</form>
</div>

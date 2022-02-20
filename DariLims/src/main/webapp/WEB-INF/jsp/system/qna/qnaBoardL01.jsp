
<%
	/***************************************************************************************
	 * 시스템명 	: 통합장비관제시스템
	 * 업무명 		: 질문과답변게시판
	 * 파일명 		: qnaBoardL01.jsp
	 * 작성자 		: 최은향
	 * 작성일 		: 2015.03.23
	 * 설  명		: 질문과답변 게시판 리스트 조회 화면
	 *---------------------------------------------------------------------------------------
	 * 변경일		 변경자		변경내역 
	 *---------------------------------------------------------------------------------------
	 * 2015.03.23    최은향		최초 프로그램 작성         
	 * 
	 *---------------------------------------------------------------------------------------
	 ****************************************************************************************/
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html >
<link rel="stylesheet" media="screen" type="text/css" href="<c:url value='/css/common/sub.css'/>" />
<style type="text/css">
.rNum {
	background: #dfeffc url("./css/images/ui-bg_glass_85_dfeffc_1x400.png") 50% 50% repeat-x;
	color: #2e6e9e !important;
}
</style>
<script type="text/javascript">
	var pre_board_no_flag;
	var gridArrow = '<img style="width: 16px;" src="images/common/icon_arrow.png" >';

	$(function() {
		/* 세부권한검사 */
		fn_auth_check();
		
		// 등록일자
		fnDatePickerImg('startDate');
		fnDatePickerImg('endDate');

		$('#startDate').val(fnGetToday(1,0));
		$('#endDate').val(fnGetToday(0,0));

		// url명명 규칙(p.21) 
		grid('system/board.lims?board_type=Q', 'qnaBoardForm', 'qnaBoardGrid');
		$('#qnaBoardGrid').clearGridData(); // 최초 조회시 데이터 안나옴

		fnViewPage('system/boardPaging.lims?board_type=Q', 'paging', $('#qnaBoardForm').serialize());

		// 엔터키 눌렀을 경우(그리드 조회)
		fn_Enter_Search('qnaBoardForm', 'qnaBoardGrid');

		// 그리드 width조절하기
		$(window).bind('resize', function() {
			$("#qnaBoardGrid").setGridWidth($('#view_grid_main').width(), false);
			$("#paging").width($("#view_grid_main").width() + 2); // 하단 페이징
		}).trigger('resize');
	});

	function grid(url, form, grid) {
		$('#' + grid).jqGrid({
			datatype : function(json) {
				fnGridData(url, form, grid);
			},
			height : '230',
			autowidth : true,
			loadonce : true,
			mtype : "POST",
			gridview : true,
			shrinkToFit : true,
			rowNum : -1,
			rownumbers : false,
			colModel : [ {
				label : '번호',
				name : 'rNum',
				width : '30',
				align : 'center',
				classes : 'rNum',
				sortable : false
			}, {
				label : '게시판 번호',
				name : 'board_no',
				key : true,
				hidden : true
			}, {
				label : '제목',
				width : '500',
				classes : 'test',
				name : 'title'
			}, {
				label : '내용',
				width : '80',
				name : 'contents',
				hidden : true
			}, {
				label : '작성일',
				width : '80',
				align : 'center',
				name : 'create_date'
			}, {
				label : '작성자',
				width : '80',
				align : 'center',
				name : 'user_nm'
			}, {
				label : '파일명',
				width : '200',
				name : 'file_nm'
			}, {
				label : 'add_file',
				width : '250',
				name : 'add_file',
				hidden : true
			}, {
				label : 'PRE_BOARD_NO',
				width : '250',
				name : 'pre_board_no',
				hidden : true
			}, {
				label : '작성자 ID',
				align : 'center',
				name : 'creater_id',
				hidden : true
			}, {
				label : '접속자 ID',
				align : 'center',
				name : 'user_id',
				hidden : true
			}, {
				label : 'BOARD_TYPE',
				width : '250',
				name : 'board_type',
				hidden : true
			} ],
			emptyrecords : '데이터가 존재하지 않습니다.',
			gridComplete : function() {
				$('#btn_Add').show();
				$('#btn_Insert').hide();
				$('#btn_Sub_Add').hide();
				$('#btn_Delete_Sub1').hide();

				var ids = $('#qnaBoardGrid').jqGrid("getDataIDs");
				var row;
				var pre_no;

				// 				if (ids.length > 0) {
				for ( var i in ids) {
					row = $('#qnaBoardGrid').getRowData(ids[i]).board_no;
					pre_no = $('#qnaBoardGrid').getRowData(ids[i]).pre_board_no;
					//alert(row);
					if (pre_no != '00000000') {
						var title = $('#qnaBoardGrid').getRowData(ids[i]).title;
						title = title.replace(/ㄶ/g, '<img style="width: 16px;" src="images/common/icon_arrow.png" >');
						$('#qnaBoardGrid').setCell(row, 'title', title);
						//$('#qnaBoardGrid').setCell(row, 'title', gridArrow + title);						
					}
				}
				// 				}
			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
			},
			onSelectRow : function(rowId, status, e) {
				$('#btn_Add').show();
				$('#btn_Insert').hide();
				$('#btn_Delete_Sub1').hide();

				var left = $('#qnaBoardGrid').getRowData(rowId);
				// 상위글 이면
				if (left.pre_board_no == '00000000') {
					btn_Row_onclick();
					$('#btn_Sub_Add').show();
				} else {
					btn_Sub_Row_onclick(left.pre_board_no);
					//$('#btn_Sub_Add').hide();
				}

				// 본인이 쓴 글만 수정가능
				if (left.creater_id == left.user_id) {
					$('#btn_Insert').show();
					$('#btn_Delete_Sub1').show();
				} else {
					$('#btn_Insert').hide();
					$('#btn_Delete_Sub1').hide();
				}
			}
		});
	}

	// 상위 저장버튼(저장 & 수정) 클릭 이벤트
	function btn_Insert_onclick(state) {
		var grid = 'qnaBoardGrid';
		var rowId = $('#' + grid).getGridParam('selrow');
		var pageType = '';

		//var id = $('#qnaBoardDetail').find('#board_no').val();
		var param = $('#qnaBoardDetail').serialize();

		// 상위 등록 여부(상위 글인지.. 덧글인지..)
		// 상위글일때
		if (state == 'main') {
			pre_board_no_flag = false;

			//alert(rowId);

			// 게시판 seq_no 가 있으면 insert
			if (rowId == '' || rowId == null || rowId == '0' || rowId.substring(0, 3) == 'jqg') {
				pageType = 'insert';
			} else {
				pageType = 'update';
			}

			if ($('#qnaBoardDetail').find('#m_file').val() != '') {
				//alert(pre_board_no_flag);
				var json = fnAjaxFileAction('system/insertBoard.lims?board_type=Q&pageType=' + pageType + '&pre_board_no_flag=' + pre_board_no_flag, 'qnaBoardDetail', fn_suc);
			} else {
				var json = fnAjaxAction('system/insertBoard.lims?board_type=Q&pageType=' + pageType + '&pre_board_no_flag=' + pre_board_no_flag, param);
				if (json == null) {
					$.showAlert("저장 실패하였습니다.");
				} else {
					$.showAlert("", {
						type : 'insert'
					});
					$('#qnaBoardDetail').empty();
					$('#qnaBoardGrid').trigger('reloadGrid');
					fnStopLoading('qnaBoardDiv');
					fnViewPage('system/boardPaging.lims?board_type=Q', 'paging', $('#qnaBoardForm').serialize()); // 페이징 처리
				}
			}
		// 덧글 일때
		} else {
			pre_board_no_flag = true;
			var SubId = $('#qnaBoardDetail').find('#board_no').val();
			var pre_board_no = $('#qnaBoardDetail').find('#pre_board_no').val();
			
			// 게시판 seq_no 가 있으면 insert
			if (SubId == '' || SubId == null || SubId == '0' || SubId.substring(0, 3) == 'jqg') {
				pageType = 'insert';
			} else {
				pageType = 'update';
			}
			var json = fnAjaxFileAction('system/insertBoard.lims?board_type=Q&pageType=' + pageType + '&pre_board_no_flag=' + pre_board_no_flag, 'qnaBoardDetail', fn_suc);
		}
	}
	
	function fn_suc(json) {
		if (json == null) {
			$.showAlert("저장 실패하였습니다.");
		} else {
			$.showAlert("", {
				type : 'insert'
			});
			$('#qnaBoardDetail').empty();
			$('#qnaBoardGrid').trigger('reloadGrid');
			fnStopLoading('qnaBoardDiv');
			fnViewPage('system/boardPaging.lims?board_type=Q', 'paging', $('#qnaBoardForm').serialize()); // 페이징 처리
		}
	}
	
	// 해당줄 클릭 이벤트(상세페이지 보기)	
	function btn_Row_onclick() {
		var param = 'key=' + $('#qnaBoardGrid').getGridParam('selrow');
		fnViewPage('system/qnaBoardD01.lims?pageType=detail', 'qnaBoardDetail', param);
		$('#btn_Add').show();
		$('#btn_Insert').show();
		$('#btn_Delete_Sub1').show();
		return false;
	}

	// 해당줄 클릭 이벤트(상세페이지 보기)	
	function btn_Sub_Row_onclick(pre_board_no) {
		//alert(pre_board_no);
		var param = 'board_no=' + $('#qnaBoardGrid').getGridParam('selrow');
		fnViewPage('system/qnaBoardD02.lims?pageType=detail&key=' + pre_board_no, 'qnaBoardDetail', param);
		$('#btn_Add2').show();
		$('#btn_Insert2').show();
		$('#btn_Sub_Add').show();
		return false;
	}

	// 	// 삭제버튼 클릭 이벤트
	// 	function btn_Delete_onclick(){
	// 		if (!confirm('삭제 하시겠습니까?')) {
	// 			return false;
	// 		}else{
	// 			var param = $('#reagentsGlassInfoDetail').serialize();
	// 			fnAjaxAction('reagents/deleteReagentsGlassInfo.lims', param);
	// 		}
	// 	}	

	// 리스트 조회 이벤트
	function btn_Select_onclick() {
		$('#pageNo').val(1);
		$('#qnaBoardDetail').empty();
		$('#qnaBoardGrid').trigger('reloadGrid');
		fnViewPage('system/boardPaging.lims?board_type=Q', 'paging', $('#qnaBoardForm').serialize());
	}

	// 추가버튼 클릭 이벤트
	function fn_ViewPage(pageType) {
		$('#qnaBoardDetail').find('#board_no').val(''); // 해당 seq 삭제
		//$('#qnaBoardGrid').trigger('reloadGrid'); // 셀클릭 해제
		$('#qnaBoardGrid').jqGrid('resetSelection');
		fnViewPage('system/qnaBoardD01.lims?pageType=' + pageType, 'qnaBoardDetail', null);
		$('#btn_Add').show();
		$('#btn_Insert').show();
		$('#btn_Delete_Sub1').hide();
		$('#btn_Sub_Add').hide(); // 덧글쓰기 버튼
	}

	// 답변쓰기버튼 클릭 이벤트
	function fn_Sub_ViewPage(pageType) {
		var board_no = $('#qnaBoardDetail').find('#board_no').val(); // 해당 seq
		$('#qnaBoardGrid').jqGrid('resetSelection');
		fnViewPage('system/qnaBoardD02.lims?board_type=Q&pageType=' + pageType + '&key=' + board_no, 'qnaBoardDetail', null);
		
		$('#btn_Add2').show();
		$('#btn_Sub_Insert').show();
		$('#btn_Delete_Sub1').hide();

		// 덧글일때 '>' 추가
		$('#qnaBoardDetail').find('#pre_board_no').val(board_no); // 해당 seq
		var contents = '>' + $('#qnaBoardDetail').find('#contents_detail').val();
		var rst;
		rst = contents.replace(/\n/g, '\n>');
		$('#qnaBoardDetail').find('#contents_detail').val(rst + '\n\n');
	}

	// 첨부파일
	function setFile() {
		$('#m_file').trigger('click');

		var name = $('#m_file').val();
		if (name != '') {
			name = name.substring(name.lastIndexOf('\\') + 1);
			$('#file_name').html(name);
		}
	}

	// 	function sFunc(json) {
	// 		if (json == null) {
	// 			alert('error');
	// 		} else {
	// 			fnViewPage('system/boardPaging.lims?board_type=Q', 'paging', $('#qnaBoardForm').serialize());
	// 			func(0);
	// 		}
	// 	}

	// 페이징 이벤트(하단 >, >> 버튼이벤트)
	function linkPage(pageNo) {
		$('#pageNo').val(pageNo);
		$('#qnaBoardGrid').trigger('reloadGrid');
		fnViewPage('system/boardPaging.lims?board_type=Q', 'paging', $('#qnaBoardForm').serialize());
		$('#qnaBoardDetail').empty();
		$('#qnaBoardDetail02').empty();
	}

	// 삭제버튼 클릭 이벤트
	function btn_Delete_onclick() {
		if (!confirm("삭제하시겠습니까?")) {
			return false;
		}
		var param = $('#qnaBoardDetail').serialize();
		var json = fnAjaxAction('system/deleteBoard.lims', param);
		if (json == null) {
			$.showAlert("삭제 실패하였습니다.");
		} else {
			$.showAlert("", {
				type : 'delete'
			});
			$('#qnaBoardDetail').empty();
			$('#qnaBoardGrid').trigger('reloadGrid');
			fnStopLoading('qnaBoardDiv');
			fnViewPage('system/boardPaging.lims?board_type=Q', 'paging', $('#qnaBoardForm').serialize());
		}
	}
</script>
<div id="qnaBoardDiv">
	<form id="qnaBoardForm" name="qnaBoardForm" onsubmit="return false;">
		<div class="sub_purple_01">
			<table  class="select_table" >
				<tr>
					<td width="30%" class="table_title">
						<span>■</span>
						질문과답변 게시판
					</td>
					<td class="table_button">
						<span class="button white mlargep auth_select" id="btn_Select" onclick="btn_Select_onclick();">
							<button type="button">조회</button>
						</span>
						<span class="button white mlargep auth_save" id="btn_Add" onclick="fn_ViewPage('insert');">
							<button type="button">추가</button>
						</span>
					</td>
				</tr>
			</table>
			<table  class="list_table" >
				<tr>
					<th>제목</th>
					<td>
						<input name="title" type="text" style="width: 300px" />
					</td>
					<th>작성자</th>
					<td>
						<input name="creater_id" type="text" style="width: 120px" />
					</td>
					<th>작성일</th>
					<td>
						<input name="startDate" id="startDate" type="text" class="w80px" style="text-align: center;" readonly="readonly" />
						<img src="<c:url value='/images/common/calendar_del.png'/>" id="startDateStop" style="cursor: pointer;" onClick='fn_TextClear("startDate")' /> ~
						<input name="endDate" id="endDate" type="text" class="w80px" style="text-align: center;" readonly="readonly" />
						<img src="<c:url value='/images/common/calendar_del.png'/>" id="endDateStop" style="cursor: pointer;" onClick='fn_TextClear("endDate")' />
					</td>
				</tr>
			</table>
		</div>
		<input type="hidden" id="pageNo" name="pageNo" value="1">
		<input type="hidden" id="totalCount" name="totalCount" value="0">
		<input type="hidden" id="sortName" name="sortName">
		<input type="hidden" id="sortType" name="sortType">
		<div id="view_grid_main">
			<table id="qnaBoardGrid"></table>
			<div id="paging"></div>
		</div>
	</form>
</div>
<div class="sub_blue_01">
	<form id="qnaBoardDetail" name="qnaBoardDetail" onsubmit="return false;"></form>
</div>
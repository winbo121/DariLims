
<%
	/***************************************************************************************
	 * 시스템명 	: 통합장비관제시스템
	 * 업무명 		: 자유공유 게시판 등록
	 * 파일명 		: freeBoardL01.jsp
	 * 작성자 		: 최은향
	 * 작성일 		: 2015.03.19
	 * 설  명		: 자유공유 게시판 리스트 조회 화면
	 *---------------------------------------------------------------------------------------
	 * 변경일		 변경자		변경내역 
	 *---------------------------------------------------------------------------------------
	 * 2015.03.19    최은향		최초 프로그램 작성         
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
	var name;
	var path;
	var size;
	
	$(function() {
		/* 세부권한검사 */
		fn_auth_check();
		
		// 등록일자
		fnDatePickerImg('startDate');
		fnDatePickerImg('endDate');

		$('#startDate').val(fnGetToday(1,0));
		$('#endDate').val(fnGetToday(0,0));

		// url명명 규칙(p.21) 
		grid('system/board.lims?board_type=F', 'freeBoardForm', 'freeBoardGrid');
		$('#freeBoardGrid').clearGridData(); // 최초 조회시 데이터 안나옴

		fnViewPage('system/boardPaging.lims?board_type=F', 'paging', $('#freeBoardForm').serialize());

		// 엔터키 눌렀을 경우(그리드 조회)
		fn_Enter_Search('freeBoardForm', 'freeBoardGrid');

		// 그리드 width조절하기
		$(window).bind('resize', function() {
			$("#freeBoardGrid").setGridWidth($('#view_grid_main').width(), false);
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
			}
			// 			, {
			// 				type : 'not',
			// 				label : ' ',
			// 				name : 'icon',
			// 				width : '10',
			// 				align : 'center',
			// 				classes : 'test',
			// 				frozen : true
			// 			}
			, {
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
				width : '50',
				align : 'center',
				name : 'user_nm'
			}, {
				label : '파일명',
				width : '200',
				name : 'file_nm'
			}, {
				label : 'PRE_BOARD_NO',
				width : '250',
				name : 'pre_board_no',
				hidden : true
			}, {
				label : 'PRE_FILE_NM',
				width : '250',
				name : 'pre_file_nm',
				hidden : true
			}, {
				label : '작성자 ID ',
				width : '50',
				name : 'creater_id',
				hidden : true
			}, {
				label : '접속자 ID',
				width : '250',
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
				$('#btn_Sub_Delete').hide();
				$('#btn_Sub_Add').hide();

				var ids = $('#freeBoardGrid').jqGrid("getDataIDs");
				var row;
				var pre_no;

				// 				if (ids.length > 0) {
				for ( var i in ids) {
					row = $('#freeBoardGrid').getRowData(ids[i]).board_no;
					pre_no = $('#freeBoardGrid').getRowData(ids[i]).pre_board_no;
					//alert(row);
					if (pre_no != '00000000') {
						var title = $('#freeBoardGrid').getRowData(ids[i]).title;
						title = title.replace(/ㄶ/g, '<img style="width: 16px;" src="images/common/icon_arrow.png" >');
						$('#freeBoardGrid').setCell(row, 'title', title);
						//$('#freeBoardGrid').setCell(row, 'title', gridArrow + title);						
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
				$('#btn_Sub_Delete').hide();

				var left = $('#freeBoardGrid').getRowData(rowId);
				// 상위글 이면
				if (left.pre_board_no == '00000000') {
					path = left.board_no;
					name = left.file_nm;
					btn_Row_onclick();
					$('#btn_Sub_Add').show();
				} else {
					path = left.pre_board_no;
					name = left.pre_file_nm;
					btn_Sub_Row_onclick(left.pre_board_no);
					//$('#btn_Sub_Add').hide();
				}
				// 본인이 쓴 글만 수정가능
				if (left.creater_id == left.user_id) {
					$('#btn_Insert').show();
					$('#btn_Sub_Delete').show();
				} else {
					$('#btn_Insert').hide();
					$('#btn_Sub_Delete').hide();
				}				
			}
		});
	}

	// 상위 저장버튼(저장 & 수정) 클릭 이벤트
	function btn_Insert_onclick(state) {
		var grid = 'freeBoardGrid';
		var rowId = $('#' + grid).getGridParam('selrow');
		var pageType = '';

		//var id = $('#freeBoardDetail').find('#board_no').val();
		var param = $('#freeBoardDetail').serialize();

		// 상위 등록 여부(상위 글인지.. 덧글인지..)
		// 상위글일때
		if (state == 'main') {
			pre_board_no_flag = false;

			// 게시판 seq_no 가 있으면 insert
			if (rowId == '' || rowId == null || rowId == '0' || rowId.substring(0, 3) == 'jqg') {
				pageType = 'insert';
			} else {
				pageType = 'update';
			}

			if ($('#freeBoardDetail').find('#m_file').val() != '') {
				var json = fnAjaxFileAction('system/insertBoard.lims?board_type=F&pageType=' + pageType + '&pre_board_no_flag=' + pre_board_no_flag, 'freeBoardDetail', fn_suc);
			} else {
				var json = fnAjaxAction('system/insertBoard.lims?board_type=F&pageType=' + pageType + '&pre_board_no_flag=' + pre_board_no_flag, param);
				if (json == null) {
					$.showAlert("저장 실패하였습니다.");
				} else {
					$.showAlert("", {
						type : 'insert'
					});
					$('#freeBoardDetail').empty();
					$('#freeBoardGrid').trigger('reloadGrid');
					fnStopLoading('freeBoardDiv');
					fnViewPage('system/boardPaging.lims?board_type=F', 'paging', $('#freeBoardForm').serialize()); // 페이징 처리
				}
			}
			// 덧글 일때
		} else {
			pre_board_no_flag = true;
			var SubId = $('#freeBoardDetail').find('#board_no').val();
			
			// 게시판 seq_no 가 있으면 insert
			if (SubId == '' || SubId == null || SubId == '0' || SubId.substring(0, 3) == 'jqg') {
				pageType = 'insert';
			} else {
				pageType = 'update';
			}
			var json = fnAjaxFileAction('system/insertBoard.lims?board_type=F&pageType=' + pageType + '&pre_board_no_flag=' + pre_board_no_flag, 'freeBoardDetail', fn_suc);
		}
	}

	// 저장 여부 함수
	function fn_suc(json) {
		if (json == null) {
			$.showAlert("저장 실패하였습니다.");
		} else {
			$.showAlert("", {
				type : 'insert'
			});
			$('#freeBoardDetail').empty();
			$('#freeBoardGrid').trigger('reloadGrid');
			fnStopLoading('freeBoardDiv');
			fnViewPage('system/boardPaging.lims?board_type=F', 'paging', $('#freeBoardForm').serialize()); // 페이징 처리
		}
	}

	// 해당줄 클릭 이벤트(상세페이지 보기)	
	function btn_Row_onclick() {
		var param = 'key=' + $('#freeBoardGrid').getGridParam('selrow');
		fnViewPage('system/freeBoardD01.lims?pageType=detail', 'freeBoardDetail', param);
		$('#btn_Add').show();
		$('#btn_Insert').show();
		$('#btn_Sub_Delete').show();
		return false;
	}

	// 해당줄 클릭 이벤트(상세페이지 보기)	
	function btn_Sub_Row_onclick(pre_board_no) {
		//alert(pre_board_no);
		var param = 'board_no=' + $('#freeBoardGrid').getGridParam('selrow');
		fnViewPage('system/freeBoardD02.lims?pageType=detail&key=' + pre_board_no, 'freeBoardDetail', param);
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
		$('#freeBoardDetail').empty();
		$('#freeBoardGrid').trigger('reloadGrid');
		fnViewPage('system/boardPaging.lims?board_type=F', 'paging', $('#freeBoardForm').serialize());
	}

	// 추가버튼 클릭 이벤트
	function fn_ViewPage(pageType) {
		$('#freeBoardDetail').find('#board_no').val(''); // 해당 seq 삭제
		//$('#freeBoardGrid').trigger('reloadGrid'); // 셀클릭 해제
		$('#freeBoardGrid').jqGrid('resetSelection');
		fnViewPage('system/freeBoardD01.lims?pageType=' + pageType, 'freeBoardDetail', null);
		$('#btn_Add').show();
		$('#btn_Insert').show();
		$('#btn_Sub_Delete').hide();
		$('#btn_Sub_Add').hide(); // 덧글쓰기 버튼
	}

	// [덧글쓰기] 버튼 클릭 이벤트
	function fn_Sub_ViewPage(pageType) {
		var board_no = $('#freeBoardDetail').find('#board_no').val(); // 해당 seq
		//$('#freeBoardGrid').trigger('reloadGrid'); // 셀클릭 해제
		fnViewPage('system/freeBoardD02.lims?board_type=F&pageType=' + pageType + '&key=' + board_no, 'freeBoardDetail', null);
		
		$('#btn_Sub_Add').hide();
		$('#btn_Add2').show();
		$('#btn_Insert2').show();
		$('#btn_Sub_Delete').hide();

		// 덧글일때 '>' 추가
		$('#freeBoardDetail').find('#pre_board_no').val(board_no); // 해당 seq
		var contents = '>' + $('#freeBoardDetail').find('#contents_detail').val();
		var rst;
		rst = contents.replace(/\n/g, '\n>');
		//alert(rst);
		$('#freeBoardDetail').find('#contents_detail').val(rst + '\n\n');
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
	// 			fnViewPage('system/freeBoardPaging.lims', 'paging', $('#freeBoardForm').serialize());
	// 			func(0);
	// 		}
	// 	}

	// 페이징 이벤트(하단 버튼이벤트)
	function linkPage(pageNo) {
		$('#pageNo').val(pageNo);
		$('#freeBoardGrid').trigger('reloadGrid');
		fnViewPage('system/boardPaging.lims?board_type=F', 'paging', $('#freeBoardForm').serialize());
		$('#freeBoardDetail').empty();
		$('#freeBoardDetail02').empty();
	}

	// 삭제버튼 클릭 이벤트
	function btn_Delete_onclick() {
		if (!confirm("삭제하시겠습니까?")) {
			return false;
		}
		var param = $('#freeBoardDetail').serialize();
		var json = fnAjaxAction('system/deleteBoard.lims', param);
		if (json == null) {
			$.showAlert("삭제 실패하였습니다.");
		} else {
			$.showAlert("", {
				type : 'delete'
			});
			$('#freeBoardDetail').empty();
			$('#freeBoardGrid').trigger('reloadGrid');
			fnStopLoading('freeBoardDiv');
			fnViewPage('system/boardPaging.lims?board_type=F', 'paging', $('#freeBoardForm').serialize());
		}
	}
</script>
<div id="freeBoardDiv">
	<form id="freeBoardForm" name="freeBoardForm" onsubmit="return false;">
		<div class="sub_purple_01">
			<table  class="select_table" >
				<tr>
					<td width="30%" class="table_title">
						<span>■</span>
						자유공유 게시판
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
			<table id="freeBoardGrid"></table>
			<div id="paging"></div>
		</div>
	</form>
</div>
<div class="sub_blue_01">
	<form id="freeBoardDetail" name="freeBoardDetail"></form>
</div>
<div class="sub_blue_01">
	<form id="freeBoardDetail02" name="freeBoardDetail02"></form>
</div>
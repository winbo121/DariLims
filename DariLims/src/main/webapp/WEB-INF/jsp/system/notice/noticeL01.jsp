
<%
	/***************************************************************************************
	 * 시스템명 	: 통합장비관제시스템
	 * 업무명 		: 공지사항
	 * 파일명 		: noticeL01.jsp
	 * 작성자 		: 최은향
	 * 작성일 		: 2015.03.19
	 * 설  명		: 공지사항 리스트 화면
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
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html >
<link rel="stylesheet" media="screen" type="text/css" href="<c:url value='/css/common/sub.css'/>" />
<style type="text/css">
.rNum {
	background: #dfeffc url("./css/images/ui-bg_glass_85_dfeffc_1x400.png") 50% 50% repeat-x;
	color: #2e6e9e !important;
}
</style>
<script type="text/javascript">
	$(function() {
		/* 세부권한검사 */
		fn_auth_check();
		
		fnDatePickerImg('startDate');
		fnDatePickerImg('endDate');

		$('#startDate').val(fnGetToday(1,0));
		$('#endDate').val(fnGetToday(0,0));

		noticeGrid('system/selectNoticeList.lims', 'mainForm', 'noticeGrid');
		$('#noticeGrid').clearGridData(); // 최초 조회시 데이터 안나옴

		fnViewPage('system/noticePaging.lims', 'paging', $('#mainForm').serialize());

		// 엔터키 눌렀을 경우
		fn_Enter_Search('mainForm', 'noticeGrid');

		$(window).bind('resize', function() {
			$("#noticeGrid").setGridWidth($('#view_grid_main').width(), true);
			$("#paging").width($("#view_grid_main").width() + 2); // 하단 페이징
		}).trigger('resize');
	});

	function noticeGrid(url, form, grid) {
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
			sortname : 'notice_no',
			sortorder : 'asc',
			colModel : [ {
				label : '번호',
				name : 'rNum',
				width : '30',
				align : 'center',
				classes : 'rNum',
				sortable : false
			}, {
				label : '제목',
				name : 'notice_title',
				width : '500'
			}, {
				label : 'notice_no',
				name : 'notice_no',
				key : true,
				hidden : true
			}, {
				label : '공지기간',
				name : 'notice_start',
				align : 'center',
				width : '200'
			}, {
				label : '작성일',
				name : 'write_date',
				align : 'center'
			}, {
				label : '작성자',
				name : 'writer',
				align : 'center'
			}, {
				label : '접속자',
				name : 'role_no',
				align : 'center',
				hidden : true
			} ],
			gridComplete : function() {
				$('#addBtn').show();
// 				var ids = $('#'+grid).jqGrid("getDataIDs");
// 				var roleNo;

// 				for ( var i in ids) {
// 					roleNo = $('#'+grid).getRowData(ids[i]).role_no;
// 					if (roleNo != '001') {
// 						$('#addBtn').hide();
// 					}
// 				}
			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
			},
			onSelectRow : function(rowId, status, e) {
				func(5);

				//var left = $('#'+grid).getRowData(rowId);
				// 관리자면 (001)
				//if (left.role_no == '001') {
					$('#addBtn').show();
					$('#udtBtn').show();
					$('#delBtn').show();
				//} else {
				//	$('#addBtn').hide();
				//	$('#udtBtn').hide();
				//	$('#delBtn').hide();
				//}
			}
		});
	}

	function func(m) {
		var param = 'mode=' + m;
		switch (m) {
		case 0:
			$('#pageNo').val(1);
			$('#noticeGrid').trigger('reloadGrid');
			fnViewPage('system/noticePaging.lims', 'paging', $('#mainForm').serialize());
			$('#detail').empty();

// 			var ids = $('#noticeGrid').jqGrid("getDataIDs");
// 			var roleNo;

// 			for ( var i in ids) {
// 				roleNo = $('#noticeGrid').getRowData(ids[i]).role_no;
// 				if (roleNo != '001') {
// 					$('#addBtn').hide();
// 				}
// 			}

			return false;
		case 3:
			if (!confirm('삭제하시겠습니까?')) {
				return false;
			}
			break;
		case 4:
			fnViewPage('system/noticeDetail.lims', 'detail', param);
			$('#addBtn').hide();
			$('#istBtn').show();
			$('#udtBtn').hide();
			$('#delBtn').hide();

			$('#notice_title').focus();

			return false;
		case 5:
			param += '&key=' + $('#noticeGrid').getGridParam('selrow');
			fnViewPage('system/noticeDetail.lims', 'detail', param);
			$('#addBtn').show();
			$('#istBtn').hide();
			$('#udtBtn').show();
			$('#delBtn').show();
			return false;
		}
		param += '&' + $('#detail').serialize();
		var json = fnAjaxAction('system/saveNotice.lims', param);
		if (json == null) {
			alert('error');
		} else {
			fnViewPage('system/noticePaging.lims', 'paging', $('#mainForm').serialize());
			func(0);
		}
	}

	function linkPage(pageNo) {
		$('#pageNo').val(pageNo);
		$('#noticeGrid').trigger('reloadGrid');
		fnViewPage('system/noticePaging.lims', 'paging', $('#mainForm').serialize());
		$('#detail').empty();
	}

	function changeRowSize() {
		$("#noticeGrid").trigger("reloadGrid");
		//fnGridPager('fnGridPager.lims', 'form');
		$('#detail').empty();
	}
</script>
<div class="sub_purple_01 w100p">
	<form id="mainForm" name="mainForm" onsubmit="return false;">
		<table  class="select_table" >
			<tr>
				<td class="table_title">
					<span>■</span>
					공지사항
				</td>
				<td class="table_button">
					<span class="button white mlargep auth_select" id="btn_Select" onclick="func(0);">
						<button type="button">조회</button>
					</span>
					<span class="button white mlargeb auth_save" id="addBtn" onclick="func(4);">
						<button type="button">추가</button>
					</span>
				</td>
			</tr>
		</table>
		<table  class="list_table" >
			<tr>
				<th>제목</th>
				<td>
					<input name="notice_title" type="text" class="inputhan" />
				</td>
				<th>작성일</th>
				<td>
					<input style="width: 80px; text-align: center;" name="startDate" id="startDate" type="text" class="inputhan" readonly />
					<img src="<c:url value='/images/common/calendar_del.png'/>" id="startDateStop" style="cursor: pointer;" onClick='fn_TextClear("startDate")' /> ~
					<input style="width: 80px; text-align: center;" name="endDate" id="endDate" type="text" class="inputhan" readonly />
					<img src="<c:url value='/images/common/calendar_del.png'/>" id="endDateStop" style="cursor: pointer;" onClick='fn_TextClear("endDate")' />
				</td>
			</tr>
		</table>

		<input type="hidden" id="pageNo" name="pageNo" value="1">
		<input type="hidden" id="totalCount" name="totalCount" value="0">
		<input type="hidden" id="sortName" name="sortName">
		<input type="hidden" id="sortType" name="sortType">
		<div id="view_grid_main">
			<table id="noticeGrid"></table>
			<div id="paging"></div>
		</div>
	</form>
</div>

<div class="sub_blue_01 w100p">
	<form id="detail" name="detail" onsubmit="return false;"></form>
</div>
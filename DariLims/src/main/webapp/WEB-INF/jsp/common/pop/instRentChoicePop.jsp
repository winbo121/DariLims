
<%
	/***************************************************************************************
	 * 시스템명 	: 통합장비관제시스템
	 * 업무명 		: 의뢰처조회(팝업)
	 * 파일명 		: acceptP03.jsp
	 * 작성자 		: 진영민
	 * 작성일 		: 2015.01.22
	 * 설  명		: 
	 *---------------------------------------------------------------------------------------
	 * 변경일		 변경자		변경내역 
	 *---------------------------------------------------------------------------------------
	 * 2015.01.22    진영민		최초 프로그램 작성         
	 * 
	 *---------------------------------------------------------------------------------------
	 ****************************************************************************************/
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html id="popHtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<link rel="stylesheet" media="screen" type="text/css" href="<c:url value='/css/jquery-ui.css'/>" />
<link rel="stylesheet" media="screen" type="text/css" href="<c:url value='/css/jqgrid/ui.jqgrid.css'/>" />
<link rel="stylesheet" media="screen" type="text/css" href="<c:url value='/css/tree/ui.fancytree.css'/>" />
<link rel="stylesheet" media="screen" type="text/css" href="<c:url value='/css/common/common.css'/>" />
<link rel="stylesheet" media="screen" type="text/css" href="<c:url value='/css/common/main.css'/>" />
<link rel="stylesheet" media="screen" type="text/css" href="<c:url value='/css/common/sub.css'/>" />
<script type="text/javascript" src="<c:url value='/script/jquery-1.11.0.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/script/jquery-ui.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/script/jquery.blockUI.js'/>"></script>
<script type="text/javascript" src="<c:url value='/script/jquery.form.js'/>"></script>
<script type="text/javascript" src="<c:url value='/script/jquery.message.js'/>"></script>
<script type="text/javascript" src="<c:url value='/script/jqgrid/grid.locale-kr.js'/>"></script>
<script type="text/javascript" src="<c:url value='/script/jqgrid/jquery.jqGrid.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/script/tree/jquery.fancytree-all.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/script/lims.com.js'/>"></script>
<script type="text/javascript" src="<c:url value='/script/lims.pop.js'/>"></script>
<script type="text/javascript" src="<c:url value='/script/lims.com.grid.js'/>"></script>
<title>LIMS</title>
<script type="text/javascript">
	var popupName = window.name; // 팝업창 이름 가져오기
	var arr = new Array;
	$(function() {
		arr = popupName.split("★●★");	
		
		ajaxComboForm("dept_cd", "", "", null, 'instRentChoicePopForm'); // 관리부서

		//url명명 규칙
		grid(fn_getConTextPath()+'/instrument/machine.lims', 'instRentChoicePopForm', 'instRentChoiceGrid');

		// 엔터키 눌렀을 경우(그리드 조회)
		fn_Enter_Search('instRentChoicePopForm', 'instRentChoiceGrid');

		//그리드 width조절하기
		$(window).bind('resize', function() {
			$("#instRentChoiceGrid").setGridWidth($('#view_grid_main').width(), false);
		}).trigger('resize');

	});

	function grid(url, form, grid) {
		$('#' + grid).jqGrid({
			datatype : function(json) {
				fnGridData(url, form, grid);
			},
			height : '330',
			autowidth : true,
			loadonce : true,
			mtype : "POST",
			gridview : true,
			shrinkToFit : false,
			rowNum : -1,
			rownumbers : true,
			colModel : [ {
				label : '시험장비번호',
				name : 'inst_no',
				key : true,
				hidden : true
			}, {
				label : '장비관리번호',
				width : '80',
				align : 'center',
				name : 'inst_mng_no'
			}, {
				label : '장비명',
				width : '150',
				name : 'inst_kor_nm'
			}, {
				label : '장비영문명',
				width : '150',
				name : 'inst_eng_nm'
			}, {
				label : '관리부서',
				width : '100',
				name : 'dept_nm'
			}, {
				label : '관리부서코드',
				name : 'dept_cd',
				hidden : true
			}, {
				label : '관리자',
				align : 'center',
				width : '80',
				name : 'admin_user'
			}, {
				label : '설치장소',
				width : '150',
				name : 'instl_plc'
			}, {
				label : '사용여부',
				width : '60',
				name : 'use_flag',
				align : 'center',
				formatter : function(value) {
					if (value == "Y") {
						return '사용함';
					} else {
						return '사용안함';
					}
				}
			} ],
			emptyrecords : '데이터가 존재하지 않습니다.',
			gridComplete : function() {
				$('#btn_Add').show();
				$('#btn_Insert').hide();
				//fnSelectFirst(grid);
			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
				//if (!confirm('저장하지 않은 정보는 사라집니다. 정렬하시겠습니까?')) {
				//	return 'stop';
				//}
			},
			onSelectRow : function(rowId, status, e) {
			},
			ondblClickRow : function(rowId, iRow, iCol, e) {
				btn_Choice_Onclick(grid);
			}
		});
	}

	// 리스트 조회 이벤트
	function btn_Select_onclick() {
		$('#detail').empty();
		$('#instRentChoiceGrid').trigger('reloadGrid');
	}
	
	// 해당 row 선택시 이벤트
	function btn_Choice_Onclick(grid) {
		var rowId = $('#' + grid).getGridParam('selrow');
		
		if (rowId != null) {
			var row = $('#' + grid).getRowData(rowId);	
			// 부모창에 던져주기
			$(opener.document).find("#"+arr[0]+" #"+arr[1]+" .inst_no").text(row.inst_no);
			$(opener.document).find("#"+arr[0]+" #"+arr[1]+" .inst_mng_no").text(row.inst_mng_no);			
			$(opener.document).find("#"+arr[0]+" #"+arr[1]+" .inst_kor_nm").text(row.inst_kor_nm); 
			$(opener.document).find("#"+arr[0]+" #"+arr[1]+" .inst_eng_nm").text(row.inst_eng_nm); 
			$(opener.document).find("#"+arr[0]+" #"+arr[1]+" .instl_plc").text(row.instl_plc);
			$(opener.document).find("#"+arr[0]+" #"+arr[1]+" .admin_user").text(row.admin_user);
			$(opener.document).find("#"+arr[0]+" #"+arr[1]+" .dept_nm").text(row.dept_nm);
			opener.instRent_fnpop_callback();
			window.close();
		} else {
			$.showAlert('선택된 행이 없습니다.');
		}
	}
	
</script>
</head>
<body id="popBody" onunload="opener.fnBasicEndLoading();">
<div class="popUp">
	<div class="pop_area pop_intro">
		<form id="instRentChoicePopForm" name="instRentChoicePopForm" onsubmit="return false;">
	<div class="sub_purple_01">
		<table  class="select_table" >
			<tr>
				<td width="20%" class="table_title">
					<span>■</span>
					장비 목록
				</td>
				<td class="table_button" style="text-align: right; padding-right: 30px;" width="60%">
					<span class="button white mlargeg auth_save" id="btn_Choice" onclick="btn_Choice_Onclick('instRentChoiceGrid');">
						<button type="button">선택</button>
					</span>
					<span class="button white mlargep auth_select" id="btn_Select" onclick="btn_Select_onclick();">
						<button type="button">조회</button>
					</span>
				</td>
			</tr>
		</table>

		<!-- 조회 테이블 -->
		<table  class="list_table" >
			<tr>
				<th>장비관리번호</th>
				<td>
					<input name="inst_mng_no" type="text" style="width: 150px;" />
				</td>
				<th>장비명/영문명</th>
				<td>
					<input name="inst_kor_nm" type="text" style="width: 160px;" />
				</td>
			</tr>
			<tr>
				<th>관리부서</th>
				<td>
					<select name="dept_cd" id="dept_cd" style="width: 173px"></select>
				</td>
				<th>관리자</th>
				<td>
					<input name="admin_user" type="text" style="width: 160px;" />
				</td>
			</tr>
			<tr>
				<th>사용여부</th>
				<td colspan="4">
					<label><input type='radio' name='use_flag' value='' style="width: 20px" />전체</label> <label><input type='radio' name='use_flag' value='Y' style="width: 20px" checked="checked" />사용함</label> <label><input type='radio' name='use_flag' value='N' style="width: 20px" />사용안함</label>
				</td>
			</tr>
		</table>
	</div>
	<input type="hidden" id="sortName" name="sortName">
	<input type="hidden" id="sortType" name="sortType">
	<div id="view_grid_main">
		<table id="instRentChoiceGrid"></table>
	</div>
	</form>
	</div>
</div>
</body>
</html>
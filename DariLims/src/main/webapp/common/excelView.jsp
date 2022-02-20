
<%
	/***************************************************************************************
	 * 시스템명 	: 통합장비관제시스템
	 * 업무명 		: 사용자관리
	 * 파일명 		: userInfo.jsp
	 * 작성자 		: 최은향
	 * 작성일 		: 2015.02.02
	 * 설  명		: 사용자관리 팝업 화면
	 *---------------------------------------------------------------------------------------
	 * 변경일		 변경자		변경내역 
	 *---------------------------------------------------------------------------------------
	 * 2015.02.02    최은향		최초 프로그램 작성         
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
<script type="text/javascript" src="<c:url value='/script/lims.com.grid.js'/>"></script>

<title>LIMS</title>
<script type="text/javascript">
	var popupName = window.name; // 팝업창 이름 가져오기
	
	$(function() {
		var deptCd = '${session.dept_cd}';
		
		ajaxComboForm("dept_cd", "", "${session.dept_cd}", null, 'form'); // 관리부서
// 		ajaxComboForm("office_cd", "", "${session.dept_cd}", null, 'form'); // 사업소별
		
		grid('../system/selectUserLimsList.lims', 'form', 'grid');

		$(window).bind('resize', function() {
			$("#grid").setGridWidth($('#view_grid_main').width(), false);
		}).trigger('resize');

		// 엔터키 눌렀을 경우(그리드 조회)
		fn_Enter_Search('form', 'grid');
		
		
// 		if(deptCd.substring(0,4) == 'LIMS'){
// 			fn_show_type('o');
// 	 	}else{
// 			fn_show_type('d');
// 		}
	});

	function grid(url, form, grid) {
		$('#' + grid).jqGrid({
			datatype : function(json) {
				fnGridData(url, form, grid);
			},
			height : '270',
			autowidth : true,
			loadonce : true,
			mtype : "POST",
			gridview : true,
			rowNum : -1,
			rownumbers : true,
			sortname : 'user_nm',
			sortorder : 'asc',
			colModel : [ {
				label : '성명',
				align : 'center',
				width : '80',
				name : 'user_nm'
			}, {
				label : '아이디',
				name : 'user_id',
				key : true
			}, {
				label : '부서명',
				name : 'dept_nm'
			}, {
				label : '부서코드',
				align : 'center',
				width : '90',
				hidden : true,
				name : 'dept_cd'
			}, {
				label : '직급',
				name : 'rank_nm'
			}, {
				label : '전화번호',
				name : 'tel_num'
			} ],
			gridComplete : function() {
			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
			},
			onSelectRow : function(rowId, status, e) {
			},
			ondblClickRow : function(rowId, iRow, iCol, e) {
				btn_Save_onclick(grid);
			}
		});
	}

	function btn_Select_onclick() {
		$('#grid').trigger('reloadGrid');
	}

	// 사용자 선택
	function btn_Save_onclick(grid) {
		var rowId = $('#' + grid).getGridParam('selrow');
		if (rowId != null) {
			var data = '';
			var row = $('#' + grid).getRowData(rowId);
			
// 			for ( var column in row) {
// 				var val = row[column];
// 				data += column + '●★●' + val + '■★■';
// 			}
// 			data = data.substring(0, data.length - 3);
// 			window.returnValue = data;
			alert(popupName);
			alert("아이디:" + row.user_id);
			alert("이름:" + row.user_nm);
			alert("부서명:" + row.dept_nm);
			 
			$(opener.document).find("#"+popupName+" .user_id").text(row.user_id); // 아이디
			$(opener.document).find("#"+popupName+" .user_nm").text(row.user_nm); // 이름
			$(opener.document).find("#"+popupName+" .dept_nm").text(row.dept_nm); // 부서 명
			
			window.close();
		} else {
			$.showAlert('선택된 행이 없습니다.');
		}
	}
	
// 	// 부서 & 사업소 선택
// 	function fn_show_type(req_dept_office) {
// 		var th = 'typeThSearch';
// 		var form = 'form';
		
// 		//alert(req_dept_office);
		
// 		if(req_dept_office == 'd'){
// 			//$('#' + th).text('요청부서명');
// 			$('#' + form).find("#dept_cd").show();
// 			$('#' + form).find("#office_cd").hide();
// 			$('#' + form).find("#office_cd").val('');
// 			$('#' + form).find("#req_dept_office").prop('checked',true);
// 			$('#' + form).find("#req_dept_office2").removeAttr('checekd');
// 		}else{
// 			//$('#' + th).text('요청사업소명');
// 			$('#' + form).find("#dept_cd").hide();
// 			$('#' + form).find("#office_cd").show();
// 			$('#' + form).find("#dept_cd").val('');
// 			$('#' + form).find("#req_dept_office2").prop('checked',true);
// 			$('#' + form).find("#req_dept_office").removeAttr('checekd');
// 		}
// 	}
</script>
</head>
<body id="popBody" onunload="opener.fnBasicEndLoading();">
<div class="popUp">
<div class="pop_area pop_intro">
	<h2>사용자 목록</h2>
		<form id="form" name="form" onsubmit="return false;">
			<div class="sub_purple_01 w100p" style="margin-top: 0px;">
		<table width="100%" border="0" class="select_table" cellpadding="0" cellspacing="0">
			<tr>
				<td width="20%" class="table_title">
					<span style="font-size: 11px; margin-left: 15px; color: #b27ce0;">■</span>
					사용자 목록
				</td>
				<td class="table_button" style="text-align: right; padding-right: 30px;">
					<span class="button white mlargeb" id="btn_Select" onclick="btn_Select_onclick();">
						<button type="button">조회</button>
					</span>
					<span class="button white mlargeg" id="btn_Save" onclick="btn_Save_onclick('grid');">
						<button type="button">선택</button>
					</span>
					<span class="button white mlargep" id="btn_Cancel" onclick="window.close();">
						<button type="button">취소</button>
					</span>
				</td>
			</tr>
		</table>
		<table width="100%" border="0" class="list_table" cellpadding="0" cellspacing="0">
			<tr>
				<th>아이디</th>
				<td>
					<input name="user_id" type="text" class="inputhan" />
				</td>
				<th>성명</th>
				<td>
					<input name="user_nm" type="text" class="inputhan" />
				</td>
				<th id="typeThSearch">
					<label for="req_dept_office">부서명</label>
				</th>
				<td>
					<select name="dept_cd" id="dept_cd" class="w120px"></select>
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
</div>
</div>

</body>
</html>

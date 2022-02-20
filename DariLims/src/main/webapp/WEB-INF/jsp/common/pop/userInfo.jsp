
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
	var arr = new Array;
	$(function() {
		var deptCd = '${session.dept_cd}';
		$('#form').find('#team_cd').val('${team_cd}');
		arr = popupName.split("★●★");
		ajaxComboForm("dept_cd", "", "${session.dept_cd}", null, 'form'); // 관리부서
		
		grid('../system/selectUserLimsList.lims', 'form', 'grid');

		$(window).bind('resize', function() {
			$("#grid").setGridWidth($('#view_grid_main').width(), false);
		}).trigger('resize');

		// 엔터키 눌렀을 경우(그리드 조회)
		fn_Enter_Search('form', 'grid');
	});

	// 사용자 조회
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
				/* name : 'potal_id', */
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
			var row = $('#' + grid).getRowData(rowId);			
			arr[0];
		
			if(arr[0] == "S"){
				//alert("S");
				$(opener.document).find("#"+arr[1]+ " #sender_id").text(row.user_id); // 아이디
				$(opener.document).find("#"+arr[1]+ " #sender_nm").text(row.user_nm); // 이름
				$(opener.document).find("#"+arr[1]+ " #sender_id").val(row.user_id); // 아이디
				$(opener.document).find("#"+arr[1]+ " #sender_nm").val(row.user_nm); // 이름
				opener.fnpop_usercallback();
				window.close();
			}  else if (arr[0] == "K") {
				//alert("R");
				$(opener.document).find("#"+arr[1]+ " #sender_id").text(row.user_id); // 아이디
				$(opener.document).find("#"+arr[1]+ " #sender_nm").text(row.user_nm); // 이름
				$(opener.document).find("#"+arr[1]+ " #sender_id").val(row.user_id); // 아이디
				$(opener.document).find("#"+arr[1]+ " #sender_nm").val(row.user_nm); // 이름
				opener.fnpop_usercallback1(arr[2],row.user_id,row.user_nm);
				window.close();
			} else if (arr[0] == "R") {
				//alert("R");
				$(opener.document).find("#"+arr[1]+ " #recipient_id").text(row.user_id); // 아이디
				$(opener.document).find("#"+arr[1]+ " #recipient_nm").text(row.user_nm); // 이름
				$(opener.document).find("#"+arr[1]+ " #recipient_id").val(row.user_id); // 아이디
				$(opener.document).find("#"+arr[1]+ " #recipient_nm").val(row.user_nm); // 이름
				opener.fnpop_usercallback();
				window.close();
				
			} else if (arr[0] == "buyingConfirm"){
				$(opener.document).find("#"+arr[1]+ " #creater_id").val(row.user_id); // 아이디
				$(opener.document).find("#"+arr[1]+ " #user_nm").val(row.user_nm); // 이름				
				opener.fnpop_buyingConfirmcallback();
				window.close();
			} else if (arr[0] == "userLog"){
				$(opener.document).find("#"+arr[1]+ " .his_user").text(row.user_id); // 아이디
				$(opener.document).find("#"+arr[1]+ " .his_user_nm").text(row.user_nm); // 이름				
				opener.fnpop_userLogcallback();
				window.close();
			} else if (arr[0] == "user"){
				$(opener.document).find("#"+arr[1]+ " #user_id").val(row.user_id); // 아이디
				$(opener.document).find("#"+arr[1]+ " #user_nm").val(row.user_nm); // 이름				
				opener.fnpop_callback();
				window.close();
			} else if (arr[0] == "machine"){ // 관리자(정)
				$(opener.document).find("#"+arr[1]+ " #mng_id").val(row.user_id); // 아이디
				$(opener.document).find("#"+arr[1]+ " #mng_nm").val(row.user_nm); // 이름
				$(opener.document).find("#"+arr[1]+ " #dept_cd").val(row.dept_cd); // 부서
				opener.fnpop_callback();
				window.close();
			} else if (arr[0] == "machineSub"){ // 관리자 (부)
				$(opener.document).find("#"+arr[1]+ " #mng_sub_id").val(row.user_id); // 아이디
				$(opener.document).find("#"+arr[1]+ " #mng_sub_nm").val(row.user_nm); // 이름
				$(opener.document).find("#"+arr[1]+ " #mng_sub_dept_cd").val(row.dept_cd); // 부서
				opener.fnpop_callback();
				window.close();
			} else if (arr[0] == "repair"){
				$(opener.document).find("#"+arr[1]+ " #rpr_user_id").val(row.user_id); // 아이디
				$(opener.document).find("#"+arr[1]+ " #rpr_user_nm").val(row.user_nm); // 이름
				opener.fnpop_callback();
				window.close();
			} else if (arr[0] == "correction"){ //장비 교정등록
				$(opener.document).find("#"+arr[1]+ " #crt_user_id").val(row.user_id); // 아이디
				$(opener.document).find("#"+arr[1]+ " #crt_user_nm").val(row.user_nm); // 이름
				opener.fnpop_callback();
				window.close();
			} else if (arr[0] == "correction2"){ //장비 중간점검
				$(opener.document).find("#"+arr[1]+ " #intchk_user_id").val(row.user_id); // 아이디
				$(opener.document).find("#"+arr[1]+ " #intchk_user_nm").val(row.user_nm); // 이름
				opener.fnpop_callback();
				window.close();
			} else if (arr[0] == "accessIp" || arr[0] == "counsel" || arr[0] == "estimate" ){
				$(opener.document).find("#"+arr[1]+ " #creater_id").val(row.user_id); // 아이디
				$(opener.document).find("#"+arr[1]+ " #user_nm").val(row.user_nm); // 이름				
				opener.fnpop_callback();
				window.close();	
			} else if (arr[0] == "itemUserFind" ){
				$(opener.document).find("#"+arr[1]+ " #tester_user_id").val(row.user_id); // 아이디
				$(opener.document).find("#"+arr[1]+ " #tester_user_nm").val(row.user_nm); // 이름				
				opener.fnpop_callback();
				window.close();	
			} else if (arr[0] == "assignmentALL"){ // 배정자 선택
				opener.fnpop_testerCallback(row.user_id, row.user_nm, arr[0]);
				window.close();
			} else if (arr[0] == "assignmentChoice"){ // 배정자 선택
				opener.fnpop_testerCallback(row.user_id, row.user_nm, arr[0], arr[2]);
				window.close();
			} else if (arr[0] == "deptTeamInfo"){  //부서관리-사용자선택
				$('#form').find('#user_id').val(rowId);
				//채원 : ajax 주소 잘못되어 있어서 수정함
				//-----------------------
				var param = $('#form').serialize();
				var json = fnAjaxAction(fn_getConTextPath()+'/insertDeptTeamUser.lims', param);
				if (json == null) {
					$('#form').find('#user_id').val('');  
					alert('사용자 추가가 실패 되었습니다.');				
				}else if (json == -1) {
					$('#form').find('#user_id').val('');
					alert('이미 추가된 사용자입니다.');				
				}else{
					$('#form').find('#user_id').val('');
					alert('사용자가 추가 되었습니다.');				
					opener.fnpop_callback_teamUser();
					window.close();
				}
			} else if (arr[0] == "testItemUser"){  //항목별담당자-사용자선택
				opener.fnpop_callback_testItemUser(row.dept_cd, row.user_id);
				window.close();
			} else if (arr[0] == "acceptNreceit"){  //의뢰/접수-사용자선택
				opener.fnpop_callback_testItemUser(row.dept_cd, row.dept_nm, row.user_id, row.user_nm, arr[2]);
				window.close();
			} else if (arr[0] == "acceptNreceit1"){ 
				opener.fnpop_callback_testItemUser1(row.dept_cd, row.dept_nm, row.user_id, row.user_nm, arr[2]);
				window.close();
			}
			
		}else {
			alert('선택된 행이 없습니다.');
		}		
	}
</script>
</head>
<body id="popBody" onunload="opener.fnBasicEndLoading();">
<div class="popUp">
	<div class="pop_area pop_intro">
		<h2>사용자 목록</h2>
		<div>
			<form id="form" name="form" onsubmit="return false;">
				<div class="sub_purple_01" style="margin-top: 0px;">
					<table width="100%" border="0" class="select_table">
						<tr>
							<td width="20%" class="table_title">
								<span style="font-size: 11px; margin-left: 15px; color: #b27ce0;">■</span>
								사용자 목록
							</td>
							<td class="table_button" style="text-align: right; padding-right: 30px;">
								<span class="button white mlargeb auth_select" id="btn_Select" onclick="btn_Select_onclick();">
									<button type="button">조회</button>
								</span>
								<span class="button white mlargeg auth_save" id="btn_Save" onclick="btn_Save_onclick('grid');">
									<button type="button">선택</button>
								</span>
								<span class="button white mlargep" id="btn_Cancel" onclick="window.close();">
									<button type="button">취소</button>
								</span>
							</td>
						</tr>
					</table>
					<table width="100%" border="0" class="list_table">
						<tr>
							<th>아이디</th>
							<td>
								<input name="user_id" id="user_id" type="text" class="inputhan" />
							</td>
							<th>성명</th>
							<td>
								<input name="user_nm" id="user_nm" type="text" class="inputhan" />
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
				<input type="hidden" id="team_cd" name="team_cd">	
				<div id="view_grid_main">
					<table id="grid"></table>
				</div>
			</form>
		</div>
	</div>
</div>
</body>
</html>
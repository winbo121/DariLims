
<%
	/***************************************************************************************
	 * 시스템명 	: 통합장비관제시스템
	 * 업무명 		: 검사결과입력-계산식
	 * 파일명 		: accountPop.jsp
	 * 작성자 		: 진영민
	 * 작성일 		: 2015.02.26
	 * 설  명		: 
	 *---------------------------------------------------------------------------------------
	 * 변경일		 변경자		변경내역 
	 *---------------------------------------------------------------------------------------
	 * 2015.02.11    진영민		최초 프로그램 작성         
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
		
		arr = popupName.split("★●★");
		
		/* alert(arr[0]); // 그리드명
		alert(arr[1]); // 그리드로우
		alert(arr[2]); // 시험방법
		alert(arr[3]); // 항목 
		alert(arr[4]); // 시료번호
		alert(arr[5]); // 계산식번호 
		*/
		$("#test_method_no").val(arr[2]);
		
		
		gridPopMain('master/selectAccountList.lims', 'mainForm', 'gridPopMain');
		//accountPopGrid('master/selectAccountPopList.lims', 'accountPopForm', 'accountPopGrid');
		
		//엔터키 눌렀을 경우(그리드 조회)
		fn_Enter_Search('mainForm', 'gridPopMain');

		//그리드 width조절하기
		$(window).bind('resize', function() {
			$("#gridPopMain").setGridWidth($('#view_grid_main').width(), false);
		}).trigger('resize');
	});
	
	// 계산식조회목록
	function gridPopMain(url, form, grid) {
		$('#' + grid).jqGrid({
			datatype : function(json) {
					fnGridData(url, form, grid);
			},
			height : '100',
			autowidth : true,
			loadonce : true,
			mtype : "POST",
			gridview : true,
			shrinkToFit : true,
			rowNum : -1,
			rownumbers : true,
			colModel : [ {
				label : '계산식번호',
				name : 'account_no',
				key : true,
				hidden : true
			}, {
				label : '시험방법관리구분',
				width : '80',
				align : 'center',
				name : 'inst_no',
				hidden : true
			}, {
				label : '시험방법번호',
				width : '50',
				name : 'test_method_no',
				hidden : true
			}, {
				label : '시험방법명',
				width : '150',
				name : 'test_method_nm'
			}, {
				label : '계산식명',
				width : '110',
				name : 'account_nm'
			}, {
				label : '계산식결과',
				width : '350',
				name : 'account_tot_disp'
			}, {
				label : '결과단위',
				width : '80',
				align : 'center',
				name : 'unit'
			}, {
				label : '사용여부',
				width : '80',
				name : 'use_flag',
				align : 'center'
			} ],
			emptyrecords : '데이터가 존재하지 않습니다.',
			gridComplete : function() {
				if(!fnIsEmpty(arr[5])){
					fnSelectRowId(grid, arr[5]);
				}else{
					fnSelectFirst(grid);
				}
			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
			},
			onSelectRow : function(rowId, status, e) {
				fnViewPage('master/selectAccountApply.lims', 'detailDiv', 'pageType=detail&account_no=' + rowId);
				
			}
		});
	}
	
	// 닫기
	function fn_close(){
		opener.fnpop_callback();
		window.close();
	}
	
</script>
</head>
<body id="popBody" onunload="opener.fnBasicEndLoading();">
<div class="popUp">
	<div class="pop_area">
		<h2>검사결과입력-계산식</h2>
		<div class="pop_intro">
		
		<form id="mainForm" name="mainForm" onsubmit="return false;">
			<div class="sub_purple_01">
				<table  class="select_table" >
					<tr>
						<td class="table_title">
							<span>■</span>
							계산식목록
						</td>
						<!-- <td class="table_button">
							<span class="button white mlargep" id="btn_Select" onclick="btn_Search_onclick();">
								<button type="button">조회</button>
							</span>
							<span class="button white mlargep" id="btn_New" onclick="btn_New_onclick();">
								<button type="button">추가</button>
							</span>
						</td> -->
					</tr>
				</table>
				<!-- 조회 테이블 -->
<!-- 				<table  class="list_table" >
					<tr>
						<th>시험방법 관리구분</th>
						<td>
							<select name="kolas_yn"></select>
						</td>
						<th>시험방법명</th>
						<td>
							<input type="text" name="test_method_nm" />
						</td>
						<th>사용여부</th>
						<td>
							<label><input type='radio' name='use_flag' value='Y' style="width: 20px" checked="checked"/>사용</label> 
							<label><input type='radio' name='use_flag' value='N' style="width: 20px" />미사용</label>
						</td>
					</tr>
				</table> -->
			</div>
			<input type="hidden" id="test_method_no" name="test_method_no">
			<input type="hidden" id="sortName" name="sortName">
			<input type="hidden" id="sortType" name="sortType">
			<div id="view_grid_main">
				<table id="gridPopMain"></table>
			</div>
		</form>
		<div id="detailDiv"></div>
			

				
		</div>
	</div>
</div>
</body>
</html>
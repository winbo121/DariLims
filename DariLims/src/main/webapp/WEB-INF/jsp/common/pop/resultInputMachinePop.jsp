
<%
	/***************************************************************************************
	 * 시스템명 	: 통합장비관제시스템
	 * 업무명 		: 시험장비 조회(팝업)
	 * 파일명 		: resultInputMachinePop.jsp
	 * 작성자 		: 조재환
	 * 작성일 		: 2015.02.12
	 * 설  명		: 
	 *---------------------------------------------------------------------------------------
	 * 변경일		 변경자		변경내역 
	 *---------------------------------------------------------------------------------------
	 * 2015.02.12    조재환		최초 프로그램 작성         
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
<script type="text/javascript" src="<c:url value='/script/lims.pop.js'/>"></script>

<title>LIMS</title>
<script type="text/javascript">
	//var obj;
	var popupName = window.name; // 팝업창 이름 가져오기
	var arr = new Array;
	//grid + "★●★" + test_item_cd + "★●★" + test_std_cd + "★●★" + rowId
	
	$(function() {
		arr = popupName.split("★●★");
		//obj = window.dialogArguments;
		$('#form').find('#test_item_cd').val(arr[1]);
		$('#form').find('#test_std_no').val(arr[2]);
		grid('selectTestMachineList.lims', 'form', 'grid');

		ajaxComboForm("dept_cd", "", "ALL", null, 'form');
		
		$(window).bind('resize', function() {
			$("#grid").setGridWidth($('#view_grid_main').width(), false);
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
				label : 'inst_no',
				name : 'inst_no',
				key : true,
				hidden : true
			}, {
				label : '장비관리번호',
				name : 'inst_mng_no',
				width : '100'
			}, {
				label : '장비한글명',
				name : 'inst_kor_nm',
				width : '110'
			}, {
				label : '장비영문명',
				name : 'inst_eng_nm',
				width : '110'
			}, {
				label : '모델',
				name : 'model_nm',
				width : '110'
			}, {
				label : '분야 및 용도',
				name : 'fld_use',
				width : '100'
			}, {
				label : '관리부서',
				name : 'dept_nm',
				width : '100'
			}, {
				label : '관리자',
				name : 'admin_user',
				width : '100'
			}, {
				label : 'LAS',
				name : 'las_yn',
				width : '100'
			}, {
				label : 'KOLAS',
				name : 'kolas_yn',
				width : '100'
			}, {
				label : '특이사항',
				name : 'cmt',
				width : '100'
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
	// 선택 이벤트
	function btn_Save_onclick() {
		var rowId = $('#grid').getGridParam('selrow');
		if (rowId != null) {
			var row = $('#grid').getRowData(rowId);	
			// 부모창에 던져주기			
			if(arr[0] == "resultGrid"){
				// 결과 입력용
				$(opener.document).find("#"+arr[0]+ " #"+arr[3]+" .inst_no").val(row.inst_no); // 
				$(opener.document).find("#"+arr[0]+ " #"+arr[3]+" .inst_kor_nm").val(row.inst_kor_nm); // 
				$(opener.document).find("#"+arr[0]+ " #"+arr[3]+" .inst_no").text(row.inst_no); // 
				$(opener.document).find("#"+arr[0]+ " #"+arr[3]+" .inst_kor_nm").text(row.inst_kor_nm); // 
			} else {
				// 시험 일지용 
				$(opener.document).find("#"+arr[3]+" #inst_no").val(row.inst_no); // 
				$(opener.document).find("#"+arr[3]+" #inst_kor_nm").val(row.inst_kor_nm); // 
				$(opener.document).find("#"+arr[3]+" #inst_eng_nm").val(row.inst_eng_nm); // 
			}
			window.close();
			fnBasicEndLoading();
		} else {
			alert('선택된 행이 없습니다.');
		}
	}
</script>
</head>
<body id="popBody" onunload="opener.fnBasicEndLoading();">
	<div class="popUp">
		<div class="pop_area pop_intro">
			<h2>시험장비</h2>
			<div class="sub_purple_01" style="margin-top: 0px;">
				<form id="form" name="form" onsubmit="return false;">
					<table width="100%" border="0" class="select_table" >
						<tr>
							<td width="20%" class="table_title">
								<span>■</span>
								시험장비 목록
							</td>
							<td class="table_button" style="text-align: right; padding-right: 30px;">
								<span class="button white mlargeb auth_select" id="btn_Select" onclick="btn_Select_onclick();">
									<button type="button">조회</button>
								</span>
								<span class="button white mlargeb auth_save" id="btn_Save" onclick="btn_Save_onclick();">
									<button type="button">선택</button>
								</span>
								<span class="button white mlargeb" id="btn_Cancel" onclick="window.close();">
									<button type="button">닫기</button>
								</span>
							</td>
						</tr>
					</table>
					<table width="100%" border="0" class="list_table" >
						<tr>
							<th>장비명</th>
							<td>
								<input name="inst_kor_nm" type="text" class="inputhan w100px" />
							</td>
							<th>공급업체명</th>
							<td>
								<input name="inst_vnd_nm" type="text" class="inputhan w100px" />
							</td>
							<th>관리부서</th>
							<td>
								<select name="dept_cd" id="dept_cd" class="w200px"></select>
							</td>
						</tr>
					</table>
					<input type="hidden" id="test_item_cd" name="test_item_cd">
					<input type="hidden" id="test_std_no" name="test_std_no">
					<input type="hidden" id="sortName" name="sortName">
					<input type="hidden" id="sortType" name="sortType">
					<div id="view_grid_main">
						<table id="grid"></table>
					</div>
				</form>
			</div>
		</div>
	</div>
</body>
</html>

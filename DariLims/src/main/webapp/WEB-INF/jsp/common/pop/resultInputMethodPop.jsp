<%
	/***************************************************************************************
	 * 시스템명 	: 통합장비관제시스템
	 * 업무명 		: 시험방법 조회(팝업)
	 * 파일명 		: resultInputMethodPop.jsp
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
	var obj;
	var popupName = window.name; // 팝업창 이름 가져오기
	var arr = new Array;
	//grid + "★●★" + test_item_cd + "★●★" + test_std_cd + "★●★" + rowId

	$(function() {
		//id 엔터키 검색
		$("input").keyup(function(e){
			if(e.keyCode == 13){
				$('#grid').trigger('reloadGrid');
			}
		});
		
		arr = popupName.split("★●★");
		obj = window.dialogArguments;
		//$('#form').find('#test_item_cd').val(arr[1]);
		//$('#form').find('#test_std_no').val(arr[2]);

		grid('selectTestMethodList.lims', 'form', 'grid');
		
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
				label : 'test_method_no',
				name : 'test_method_no',
				key : true,
				hidden : true
			}, {
				label : '시험방법명',
				name : 'test_method_nm'
			}, {
				label : '인용규격',
				name : 'quot_std'
			}, {
				label : '장비및조건',
				name : 'condition'
			}, {
				label : '시험지침서',
				name : 'guide_nm'
			}, {
				label : '문서명',
				name : 'doc_nm'
			}, {
				label : '파일명',
				name : 'file_nm'
			}, {
				label : '전처리',
				name : 'test_method_preclean',
				hidden : true
			}, {
				label : '시험방법',
				name : 'test_method_content',
				hidden : true
			}],
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
			// 결과입력용		
			if(arr[0] == "resultGrid"){
				$(opener.document).find("#"+arr[0]+ " #"+arr[3]+" .test_method_no").text(row.test_method_no); //
				$(opener.document).find("#"+arr[0]+ " #"+arr[3]+" .test_method_nm").text(row.test_method_nm); //
				opener.fnpop_methodCallback(arr[3],row.test_method_nm,row.test_method_no);
				window.close();
				
			}
			// 프로토콜
			else if(arr[0] == "testPrdStdRevGrid"){
				$(opener.document).find("#"+arr[0]+ " #"+arr[1]+" .test_method_no").val(row.test_method_no); //
				$(opener.document).find("#"+arr[0]+ " #"+arr[1]+" .test_method_no").text(row.test_method_no); //
				
				$(opener.document).find("#"+arr[0]+ " #"+arr[1]+" .test_method_nm").val(row.test_method_nm); //
				$(opener.document).find("#"+arr[0]+ " #"+arr[1]+" .test_method_nm").text(row.test_method_nm); //
				
				opener.fnpop_methodCallback(arr[1]);
				window.close();
			}//프로토콜 일괄입력
			else if(arr[1] == "resultDetailForm"){
				var parent = opener.window.document;
				parent.resultDetailForm.test_method_no.value = row.test_method_no;
				parent.resultDetailForm.test_method_nm.value = row.test_method_nm;
				opener.fnpop_methodCallback(arr[1]);
				window.close();
			}
			else {
				// 시험일지용
				$(opener.document).find("#"+arr[3]+" #test_method_no").val(row.test_method_no); //
				$(opener.document).find("#"+arr[3]+" #test_method_nm").val(row.test_method_nm); //
				$(opener.document).find("#"+arr[3]+" #test_method_preclean").val(row.test_method_preclean); //
				$(opener.document).find("#"+arr[3]+" #test_method_content").val(row.test_method_content); //
				
				opener.fnpop_methodCallback(arr[3]);
				window.close();
			}
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
			<h2>시험방법</h2>
			<div class="sub_purple_01" style="margin-top: 0px;">
				<form id="form" name="form" onsubmit="return false;">
	
					<table width="100%" border="0" class="select_table" >
						<tr>
							<td width="20%" class="table_title">
								<span>■</span>
								시험방법 목록
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
							<th>시험방법</th>
							<td>
								<input id="test_method_nm" name="test_method_nm" type="text" class="inputhan w100px" />
							</td>
							<th>인용규격</th>
							<td>
								<input name="quot_std" type="text" class="inputhan w100px" />
							</td>
							<th>장비및조건</th>
							<td>
								<input name="condition" type="text" class="inputhan w100px" />
							</td>
							<th>시험지침서</th>
							<td>
								<input name="guide_nm" type="text" class="inputhan w100px" />
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

<%
	/***************************************************************************************
	 * 시스템명 	: 통합장비관제시스템
	 * 업무명 		: 수수료
	 * 파일명 		: testItemP01.jsp
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
<script type="text/javascript" src="<c:url value='/script/lims.com.grid.js'/>"></script>

<title>LIMS</title>
<script type="text/javascript">
	var popupName = window.name; // 팝업창 이름 가져오기
	var arr = new Array;
	$(function() {
	arr = popupName.split("★●★");	
		if (arr[1] == 1) {
			$('#btn_Send').hide();			
		}else{
			$('#btn_AddLine').hide();
		}		
		grid(fn_getConTextPath()+'/selectFeeGroupList.lims', 'form', 'grid');

		$(window).bind('resize', function() {
			$("#grid").setGridWidth($('#view_grid_main').width(), true);
		}).trigger('resize');
	});

	function grid(url, form, grid) {
		var lastRowId;
		$('#' + grid).jqGrid({
			datatype : function(json) {
				fnGridData(url, form, grid);
			},
			height : '330',
			autowidth : true,
			//width : '360',
			loadonce : true,
			mtype : "POST",
			gridview : true,
			shrinkToFit : false,
			rowNum : -1,
			rownumbers : true,
			colModel : [ {
				label : '수수료그룹',
				name : 'fee_group_nm',
				editable : true
			}, {
				label : '수수료',
				name : 'fee',
				width : '50',
				align : 'right',
				editable : true
			}, {
				label : 'fee_group_no',
				name : 'fee_group_no',
				key : true,
				hidden : true
			} ],
			gridComplete : function() {
				$('#btn_Save').hide();
			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
				if (!confirm('저장하지 않은 정보는 사라집니다. 정렬하시겠습니까?')) {
					return 'stop';
				}
			},
			onSelectRow : function(rowId, status, e) {
				if (rowId && rowId != lastRowId) {
					$('#' + grid).jqGrid('restoreRow', lastRowId);
					lastRowId = rowId;
					$('#btn_Save').hide();
				}
			},
			ondblClickRow : function(rowId, iRow, iCol, e) {
				$('#' + grid).jqGrid('editRow', rowId, true);
				$('#btn_New').show();
				$('#btn_Save').show();
			}
		});
		/* $('#' + grid).bind("jqGridToolbarBeforeSearch", function(e, rowId, orgClickEvent) {
			$('#' + grid).jqGrid('restoreRow', lastRowId);
		}); */
	}

	function btn_Select_onclick() {
		var rowId = $('#grid').getGridParam('selrow');
		$('#grid').jqGrid('restoreRow', rowId);
		$('#grid').trigger('reloadGrid');
		$('#btn_New').show();
		$('#btn_Save').hide();
	}
	
	//엔터이벤트
	function enterEvent(keyCode){
		if(keyCode == 13){
			btn_Select_onclick();
		}
	}
	
	function btn_AddLine_onclick() {
		var rowId = $('#grid').getGridParam('selrow');
		$('#grid').jqGrid('restoreRow', rowId);
		$('#grid').jqGrid('addRow', {
			rowID : 0,
			position : 'last'
		});
		$('#btn_New').hide();
		$('#btn_Save').show();
	}
	function btn_Save_onclick() {
		var rowId = $('#grid').getGridParam('selrow');
		var url;
		var detail_Test_Item_Yn;
		if (rowId == '0') {
			url = fn_getConTextPath()+'/insertFeeGroup.lims';
			detail_Test_Item_Yn = 'N';
		} else {
			url = fn_getConTextPath()+'/updateFeeGroup.lims';
			detail_Test_Item_Yn = 'Y';
		}
		$('#grid').jqGrid('saveRow', rowId, successfunc, url, {
			detail_Test_Item_Yn : detail_Test_Item_Yn
		}, fn_Success);
	}
	function fn_Success(json) {
		if (json == null) {
			$.showAlert('저장 실패되었습니다.');
		} else {
			$('#grid').trigger('reloadGrid');
			$('#btn_Save').hide();
			$.showAlert('저장이 완료되었습니다.');
		}
	}
	function btn_Send_onclick() {
		/* var rowId = $('#grid').getGridParam('selrow');
		if (rowId != null) {
			$('#grid').jqGrid('restoreRow', rowId);
			var row = $('#grid').getRowData(rowId);
			window.returnValue = rowId + '◆★◆' + row.fee_group_nm + '◆★◆' + row.fee;
			opener.fnpop_callback();
			window.close();
		} else {
			$.showAlert('선택된 행이 없습니다.');
		} */
		
		var rowId = $('#grid').getGridParam('selrow');
		if (rowId != null) {
			var row = $('#grid').getRowData(rowId);			
			if(arr[0] == 'commissionGrid'){
				$(opener.document).find("#"+arr[0]+ " #" + arr[1] + " .fee").text(row.fee); //수수료
				$(opener.document).find("#"+arr[0]+ " #" + arr[1] + " .fee_group_nm").text(': ' + row.fee_group_nm); //수수료그룹
				$(opener.document).find("#"+arr[0]+ " #" + arr[1] + " .fee_group_no").text(row.fee_group_no); //수수료번호
			}else{
				// 부모창에 던져주기
				$(opener.document).find("#"+arr[0]+" #fee").val(row.fee); //수수료
				$(opener.document).find("#"+arr[0]+" #fee_group_nm").text(': ' + row.fee_group_nm); //수수료그룹
				$(opener.document).find("#"+arr[0]+" #fee_group_no").val(row.fee_group_no); //수수료번호	
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
		<h2>수수료</h2>
		<div class="sub_purple_01">
			<form id="form" name="form" onsubmit="return false;">
				<table width="100%" border="0" class="select_table">
					<tr>
						<td width="20%" class="table_title">
							<span style="font-size: 11px; margin-left: 15px; color: #b27ce0;">■</span>
							수수료
						</td>
						<td class="table_button" style="text-align: right; padding-right: 30px;">
							<span class="button white mlargep auth_select" id="btn_Select" onclick="btn_Select_onclick();">
								<button type="button">조회</button>
							</span>
							<span class="button white mlargep auth_save" id="btn_Send" onclick="btn_Send_onclick();">
								<button type="button">선택</button>
							</span>
							<span class="button white mlargep auth_save" id="btn_AddLine" onclick="btn_AddLine_onclick();">
								<button type="button">행추가</button>
							</span>
							<span class="button white mlargep auth_save" id="btn_Save" onclick="btn_Save_onclick();">
								<button type="button">저장</button>
							</span>
							<span class="button white mlargeb" id="btn_Cancel" onclick="window.close();">
								<button type="button">닫기</button>
							</span>
						</td>
					</tr>
				</table>
				<table width="100%" border="0" class="list_table" style="border-top: solid 1px #82bbce;">
					<tr>
						<th>그룹</th>
						<td>
							<input name="fee_group_nm" type="text" class="inputhan w100px" onkeypress="enterEvent(event.keyCode);"/>
						</td>
						<th>수수료</th>
						<td>
							<input name="fee" type="text" class="w100px" onkeypress="enterEvent(event.keyCode);"/>
						</td>
					</tr>
				</table>

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
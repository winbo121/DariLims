
<%
	/***************************************************************************************
	 * 시스템명 	: 통합장비관제시스템
	 * 업무명 		: 메일그룹 조회(팝업)
	 * 파일명 		: mailGroupPop.jsp
	 * 작성자 		: 한지연
	 * 작성일 		: 2020.05.22
	 * 설  명		: 
	 *---------------------------------------------------------------------------------------
	 * 변경일			 변경자		변경내역 
	 *---------------------------------------------------------------------------------------
	 * 2015.09.09    최은향		최초 프로그램 작성         
	 *
	 *---------------------------------------------------------------------------------------
	 ****************************************************************************************/
%>
<%@ page language="java" contentType="text/html; charsfet=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<jsp:useBean id="currentDate" class="java.util.Date" />
<fmt:formatDate var="now" value="${currentDate}" pattern="YYYY-MM-dd" />

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
<script type="text/javascript" src="<c:url value='/script/jquery-1.11.0.min.js?time=${now}'/>"></script>
<script type="text/javascript" src="<c:url value='/script/jquery-ui.min.js?time=${now}'/>"></script>
<script type="text/javascript" src="<c:url value='/script/jquery.blockUI.js?time=${now}'/>"></script>
<script type="text/javascript" src="<c:url value='/script/jquery.form.js?time=${now}'/>"></script>
<script type="text/javascript" src="<c:url value='/script/jquery.message.js?time=${now}'/>"></script>
<script type="text/javascript" src="<c:url value='/script/jqgrid/grid.locale-kr.js?time=${now}'/>"></script>
<script type="text/javascript" src="<c:url value='/script/jqgrid/jquery.jqGrid.min.js?time=${now}'/>"></script>
<script type="text/javascript" src="<c:url value='/script/tree/jquery.fancytree-all.min.js?time=${now}'/>"></script>
<script type="text/javascript" src="<c:url value='/script/lims.com.js?time=${now}'/>"></script>
<script type="text/javascript" src="<c:url value='/script/lims.com.grid.js?time=${now}'/>"></script>
<script type="text/javascript" src="<c:url value='/script/lims.pop.js?time=${now}'/>"></script>

<title>LIMS</title>

<script type="text/javascript">
	var obj;
	var popupName = window.name; // 팝업창 이름 가져오기
	var fnGridInit = false;
	
	$(function() {
		obj = window.dialogArguments;
		grid('../master/selectListMailAddress.lims', 'mailGroupForm', 'mailGroupGrid');
		
		
		$(window).bind('resize', function() {
			$("#orgGrid").setGridWidth($('#view_grid_main').width(), false);
		}).trigger('resize');

		
		fn_Enter_Search('mailGroupForm', 'mailGroupGrid');
	});


	// 의뢰처 그리드
	function grid(url, form, grid) {
		$('#' + grid).jqGrid({
			datatype : function(json) {
				fnGridInit ? fn_GridData(url, form, grid) : fnGridInit = true;
			},
			height : '290',
			autowidth : true,
			gridview : true,
			shrinkToFit : false,
			rowNum : -1,
			rownumbers : true,
			pager : "#"+grid+"Pager",
			viewrecords : true,
			scroll : true,
			rowList:[50,100,200],
			prmNames : {
				id : 'KEY',
				page : 'pageNum',
				rows : 'pageSize',
				sort : 'sortTarget',
				order : 'sortValue'
			},
				jsonReader : {        
				root : 'rows',        
				page : 'pageNum',        
				rowNum : 'pageSize',        
				records : 'total',        
				total : 'totalPage',        
				id : 'row_num',     
				repeatitems : true        
			},
			colModel : [{
				type : 'not',
				label : '<input type="checkbox" id="chk" onclick="fn_chk(\'' + grid + '\' , \'' + form + '\');" />',
				name : 'chk',
				width : '40',
				sortable : false,
				align : 'center',
				formatter : "checkbox",
				formatoptions : {
					disabled : false
				    }
		 	}, {
				label : '순번',
				name : 'checkNum',
				width : '60',
				key : true,
				hidden : true
		 	}, {
				label : '그룹순번',
				name : 'mailGroupSn',
				width : '60'
			}, {
				label : '메일그룹명',
				name : 'mailGroupNm',
				width : '120'
			}, {
				label : '상세순번',
				name : 'mailGroupDetailSn',
				width : '60',
				align : 'center'
			}, {
				label : '성명',
				name : 'mailNm',
				width : '120',
				align : 'center'
			}, {
				label : '메일주소',
				name : 'mailAddress',
				width : '200',
				align : 'center'
			}, {
				label : '사용여부',
				name : 'useYn',
				width : '100',
				align : 'center'/* ,
				hidden : true */
			}],
			gridComplete : function() {
			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
			},
			onSelectRow : function(rowId, status, e) {
			},
			ondblClickRow : function(rowId, iRow, iCol, e) {
				$('#' + grid).setCell(rowId, 'chk', 'Yes');
				//btn_Choice_Onclick(grid);
			}
		});
	}

	// 조회시 이벤트
	function btn_Select_onclick() {
		$('#mailGroupGrid').setGridParam({page: 1});
		$('#mailGroupGrid').trigger('reloadGrid');
	}
		 
	// 해당 row 선택시 이벤트
	function btn_Choice_Onclick(grid) {
		var parent = opener.window.document;
		var closeORnot="";
		var ids = $('#' + grid).jqGrid("getDataIDs");
		if (ids.length > 0) {
			for ( var i in ids) {
				var row = $('#' + grid).getRowData(ids[i]);
				if (row.chk == 'Yes') {
					if(popupName == '참조메일'){
						
						for(var i=0; i<parent.mailForm.mailToCc.value.split(',').length; i++){
							if(parent.mailForm.mailToCc.value.split(',')[i].substring((parent.mailForm.mailToCc.value.split(',')[i].indexOf('<'))+1,parent.mailForm.mailToCc.value.split(',')[i].indexOf('>'))==row.mailAddress){
								closeORnot="1"
							}						
						}
					  if(closeORnot==""){
						if(parent.mailForm.mailToCc.value  == null || parent.mailForm.mailToCc.value == ''){
							parent.mailForm.mailToCc.value =  '"' + row.mailNm+ '" <' + row.mailAddress  + '>'; // 메일 팝업창 참조메일이 빈공간일때 
						} else {
							parent.mailForm.mailToCc.value = parent.mailForm.mailToCc.value +", "+ "\n" +'"' + row.mailNm + '" <' + row.mailAddress + '>';// 메일 팝업창 참조메일이 빈공간아닐때
						}
					   }
					} else if (popupName == '숨은참조메일'){
						for(var i=0; i<parent.mailForm.mailToBcc.value.split(',').length; i++){
							if(parent.mailForm.mailToBcc.value.split(',')[i].substring((parent.mailForm.mailToBcc.value.split(',')[i].indexOf('<'))+1,parent.mailForm.mailToBcc.value.split(',')[i].indexOf('>'))==row.mailAddress){
								closeORnot="1"
							}				
						}
					if(closeORnot==""){
						if(parent.mailForm.mailToBcc.value  == null || parent.mailForm.mailToBcc.value == ''){
							parent.mailForm.mailToBcc.value =  '"' + row.mailNm+ '" <' + row.mailAddress + '>'; // 메일 팝업창 참조메일이 빈공간일때 
						} else {
							parent.mailForm.mailToBcc.value = parent.mailForm.mailToBcc.value +", "+ "\n" +'"' + row.mailNm + '" <' + row.mailAddress + '>';// 메일 팝업창 참조메일이 빈공간아닐때
						}
					}
						
					} 
				}
			}
			if(closeORnot==""){
				window.close();
			}
			else if(closeORnot=="1"){
				$.showAlert('중복된 이메일 입니다.');
			}
			
		} else {
			$.showAlert('선택된 행이 없습니다.');
		}

	}
		 

</script>
</head>
<body id="popBody" onunload="opener.fnBasicEndLoading();">
<div class="popUp">
	<div class="pop_area pop_intro">
		<h2>메일그룹</h2>
		<div id="tabs">
			<div id="tabDiv1">
				<form id="mailGroupForm" name="mailGroupForm" onsubmit="return false;">
					<div class="sub_purple_01 w100p">
						<table width="100%" border="0" class="select_table">
							<tr>
								<td width="20%" class="table_title">
									<span>■</span>
									메일그룹 목록
								</td>
								<td class="table_button" style="text-align: right; padding-right: 30px;">
									<span class="button white mlargeb auth_select" id="btn_Select" onclick="btn_Select_onclick();">
										<button type="button">조회</button>
									</span>
									<span class="button white mlargeg auth_save" id="btn_Choice" onclick="btn_Choice_Onclick('mailGroupGrid');">
										<button type="button">선택</button>
									</span>
									<span class="button white mlargep" id="btn_Cancel" onclick="window.close();">
										<button type="button">닫기</button>
									</span>
								</td>
							</tr>
						</table>
						<table width="100%" border="0" class="list_table">
							<tr>
								<th>메일그룹명</th>
								<td>
									<input name="mailGroupNm" type="text" class="inputhan w120px" />
								</td>
								<th>상세사용여부</th>
								<td>
									<label><input type='radio' name='useYn' value='Y' style="width: 20px"  checked="checked" />사용</label> 
									<label><input type='radio' name='useYn' value='N' style="width: 20px" />미사용</label>
								</td>
							</tr>
							<tr>
								<th>성명</th>
								<td>
									<input name="mailNm" type="text" class="inputhan w120px" />
								</td>
								<th>이메일</th>
								<td>
									<input name="mailAddress" id="mailAddress" class="inputhan w200px" />
								</td>
	
							</tr>
						</table>
					</div>
					<input type="hidden" id="sortName" name="sortName">
					<input type="hidden" id="sortType" name="sortType">
					<input type='hidden' id='pageNum' name='pageNum'/>
					<input type='hidden' id='pageSize' name='pageSize'/>
					<input type='hidden' id='sortTarget' name='sortTarget'/>
					<input type='hidden' id='sortValue' name='sortValue'/>
					<input type='hidden' id='groupUseYn' name='groupUseYn' value = "Y"/>
					<div id="view_grid_main">
						<table id="mailGroupGrid"></table>
						<div id="mailGroupGridPager"></div>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>
</body>
</html>
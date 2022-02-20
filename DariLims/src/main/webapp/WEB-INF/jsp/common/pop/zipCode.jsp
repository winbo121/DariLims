
<%
	/***************************************************************************************
	 * 시스템명 	: 통합장비관제시스템
	 * 업무명 		: 우편번호검색(팝업)
	 * 파일명 		: zipCode.jsp
	 * 작성자 		: 최은향
	 * 작성일 		: 2015.12.09
	 * 설  명		: 사용자관리 팝업 화면
	 *---------------------------------------------------------------------------------------
	 * 변경일		 변경자		변경내역 
	 *---------------------------------------------------------------------------------------
	 * 2015.12.09	 최은향         
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

<style type="text/css">
.rNum {
	background: #dfeffc url("./css/images/ui-bg_glass_85_dfeffc_1x400.png") 50% 50% repeat-x;
	color: #2e6e9e !important;
}
</style>

<script type="text/javascript">
	var popupName = window.name; // 팝업창 이름 가져오기
	var arr = new Array;
	
	var pre_board_no_flag;
	var gridArrow = '<img style="width: 16px;" src="images/common/icon_arrow.png" >';
    var load = 0;
    
	$(function() {
		zipGrid('zipCode.lims', 'zipForm', 'zipGrid');
		//fnViewPage('zipPaging.lims', 'paging', $('#zipForm').serialize());
		
		arr = popupName.split("★●★");
		
		// 그리드 width조절하기
		$(window).bind('resize', function() {
			$("#zipGrid").setGridWidth($('#view_grid_main').width(), false);
			$("#paging").width($("#view_grid_main").width() + 2); // 하단 페이징
		}).trigger('resize');		
		
		// 엔터키 눌렀을 경우(그리드 조회)
		$("form[name=zipForm] input, form[name=zipForm] select").keypress(function(e) {
			if ((e.which && e.which == 13) || (e.keyCode && e.keyCOde == 13)) {
				btn_Select_onclick();
			}
		});
		//fn_Enter_Search('zipForm', 'zipGrid');
		select_change();
		
		// 번지
		$('#zipForm').find("#addr_bunji").keyup(function() {
			var val = $(this).val();
			if (val != '' && !fnIsNumeric(val)) {
				alert("숫자만 입력가능합니다.");
				$(this).val(val.substring(0, val.length - 1));
			}
			if (val.length == 3) {
				$(this).val(val + '-');
			}
		});
		
		// 부번지
		$('#zipForm').find("#addr_bubunji").keyup(function() {
			var val = $(this).val();
			if (val != '' && !fnIsNumeric(val)) {
				alert("숫자만 입력가능합니다.");
				$(this).val(val.substring(0, val.length - 1));
			}
			if (val.length == 3) {
				$(this).val(val + '-');
			}
		});
	});
	
	function zipGrid(url, form, grid) {
		var lastRowId;
		$('#' + grid).jqGrid({
			datatype : function(json) {
				if(load != 0){
					fnGridData(url, form, grid);
				}	
				load ++;
			},
			height : '230',
			autowidth : true,
			loadonce : true,
			mtype : "POST",
			gridview : true,
			shrinkToFit : false,
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
				label : '도로명주소',
				name : 'doro_addr',
				width : '280'
			}, {
				label : '지번주소',
				name : 'jibun_addr',
				width : '210'
			}, {
				label : '건물명',
				name : 'gun_nm',
				width : '120'
			}, {
				label : '우편번호',
				name : 'zip_code',
				width : '60',
				align : 'center'
			} ],
			emptyrecords : '데이터가 존재하지 않습니다.',
			gridComplete : function() {
				
			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
			},
			onSelectRow : function(rowId, status, e) {
				if (rowId && rowId != lastRowId) {
					$('#' + grid).jqGrid('restoreRow', lastRowId);
					lastRowId = rowId;
					var row = $('#' + grid).getRowData(lastRowId);
					//$("#menuForm").find("#key").val(row.auth_Code);
					//$("#authMenuForm").find("#key").val(row.auth_Code);
					//$('#menuGrid').trigger('reloadGrid');
					//$('#authMenuGrid').trigger('reloadGrid');
				}
			},
			ondblClickRow : function(rowId, iRow, iCol, e) {
				var colArr = $('#' + grid).jqGrid('getGridParam', 'colModel');
				var col = colArr[iCol].name;				
				btn_Select_row(col);
			}
		});
	}
	
	// 조회
	function btn_Select_onclick() {
		if (!saveValidation())
			return;
		$('#pageNo').val(1);
		$('#zipGrid').trigger('reloadGrid');
		fnViewPage('zipPaging.lims', 'paging', $('#zipForm').serialize()); // 하단 게시글 번호
	}
	
	// 선택 이벤트
	function btn_Select_row(col) {
		var rowId = $('#zipGrid').getGridParam('selrow');
		if (rowId != null) {
			var row = $('#zipGrid').getRowData(rowId);
			if(arr[0] == "pacForm") {
				if(col == 'doro_addr'){	
					$(opener.document).find("#"+arr[0]+" #pac_addr1").val(row.doro_addr); // 아이디
					$(opener.document).find("#"+arr[0]+" #pac_zip_code").val(row.zip_code); // 이름
				}else{
					$(opener.document).find("#"+arr[0]+" #pac_addr1").val(row.jibun_addr); // 아이디
					$(opener.document).find("#"+arr[0]+" #pac_zip_code").val(row.zip_code); // 이름
				}
				fnBasicEndLoading();
				window.close();
			} else {
				if(col == 'doro_addr'){
					$(opener.document).find("#"+arr[0]+" #addr1").val(row.doro_addr); // 아이디
					$(opener.document).find("#"+arr[0]+" #zip_code").val(row.zip_code); // 이름
				}else{
					$(opener.document).find("#"+arr[0]+" #addr1").val(row.jibun_addr); // 아이디
					$(opener.document).find("#"+arr[0]+" #zip_code").val(row.zip_code); // 이름
				}
				fnBasicEndLoading();
				window.close();
			}
		} else {
			alert('선택된 행이 없습니다.');
		}
	}
	
	// 지번 & 도로 선택 이벤트
	function select_change() {		
		$('#all').hide();
		$('#allText').hide();
		$('#noAll').hide();
		$('#dong').hide();
		$('#dongTd').hide();
		if($("#select_bun").val() == "jibun"){
			//$('#all').attr('colspan', 5);
			$('#noAll').show();
			$('#dong').show();
			$('#dongTd').show();
			$('#dong').text("동명");
			$('#bunji').text("번지본번");
			$('#bunji_bu').text("번지부번");
		} else if ($("#select_bun").val() == "doro"){
			//$('#all').attr('colspan', 5);
			$('#noAll').show();
			$('#dong').show();
			$('#dongTd').show();
			$('#dong').text("도로명");
			$('#bunji').text("도로본번");
			$('#bunji_bu').text("도로부번");
		} else {
			$('#all').show();
			$('#allText').show();
			//$('#all2').attr('colspan', 4);
			//$('#all2').attr('width', 600);
		} 
	}
	
	// validation 체크
	function saveValidation() {
		if($("#select_bun").val() == "all"){
			if ($('#addr').val() == "" || $('#addr').val() == null) {
				alert("검색 내용을 입력하십시오.");
				$('#addr').focus();
				return false;		
			} else {
				return true;
			}
		} else {
			if ($('#addr_nm').val() == "" || $('#addr_nm').val() == null) {
				alert("동명이나 도로명을 입력하십시오.");
				$('#addr_nm').focus();
				return false;		
			} else {
				return true;
			}
		}
	}
	
	// 페이징 이벤트(하단 >, >> 버튼이벤트)
	function linkPage(pageNo) {
		$('#pageNo').val(pageNo);
		$('#zipGrid').trigger('reloadGrid');
		fnViewPage('zipPaging.lims', 'paging', $('#zipForm').serialize()); // 하단 게시글 번호
	}
</script>
</head>
<body id="popBody" onunload="opener.fnBasicEndLoading();">
<div class="popUp">
	<div class="pop_area pop_intro">
		<h2>우편번호 검색</h2>
		<div>
			<form id="zipForm" name="zipForm" onsubmit="return false;">
				<div class="sub_blue_01 w100p">
					<table width="100%" border="0" class="select_table">
						<tr>
							<td width="20%" class="table_title">
								<span>■</span> 주소 조회 목록
							</td>
							<td class="table_button" style="text-align: right; padding-right: 30px;">
								<span class="button white mlargeg auth_save" id="btn_Choice" onclick="btn_Select_row();">
									<button type="button">지번 선택</button>
								</span>
								<span class="button white mlargeg auth_save" id="btn_Choice" onclick="btn_Select_row('doro_addr');">
									<button type="button">도로명 선택</button>
								</span>
								<span class="button white mlargeb auth_select" id="btn_Select" onclick="btn_Select_onclick();">
									<button type="button">조회</button>
								</span>
								<span class="button white mlargep" id="btn_Cancel" onclick="window.close();">
									<button type="button">닫기</button>
								</span>
							</td>					
						</tr>
					</table>
					<table width="100%" border="0" class="list_table">					
						<tr style="height:30px; border-right:none;" id="allText">
					    	<td><label>* 도로명, 건물명, 지번에 대해 통합검색이 가능합니다. (예: 반포대로 58, 국립중앙박물관, 삼성동 25)</label></td>
					    </tr>
						<tr style="height:30px; border-right:none;">
					    	<td><label>* 지번으로 검색시 해당 동명을 입력해 주십시오. 동명은 필수 입력입니다. 예) 동명 : 구의동</label></td>
					    </tr>
					</table>
					<table width="100%" border="0" class="list_table">
						<tr>
							<th>선택</th>
							<td style="border-left:none; border-right:none; width:100px;">
								<select name="select_bun" id="select_bun" style="width:100px" onchange="select_change();">
									<option value="all">통합</option>
									<option value="jibun">지번검색</option>
									<option value="doro">도로명검색</option>
								</select>
							</td>
							<th>시도</th>
							<td style="border-left:none;border-right:none;width:150px">
								<select name="sido" id="sido" style="width:150px;">
									<option value="서울특별시">서울특별시</option>
									<option value="경기도">경기도</option>
									<option value="인천광역시">인천광역시</option>
									<option value="대전광역시">대전광역시</option>
									<option value="대구광역시">대구광역시</option>
									<option value="광주광역시">광주광역시</option>
									<option value="부산광역시">부산광역시</option>
									<option value="울산광역시">울산광역시</option>
									<option value="강원도">강원도</option>
									<option value="충청남도">충청남도</option>
									<option value="충청북도">충청북도</option>
									<option value="경상남도">경상남도</option>
									<option value="경상북도">경상북도</option>
									<option value="전라남도">전라남도</option>
									<option value="전라북도">전라북도</option>
									<option value="제주특별자치도">제주특별자치도</option>
									<option value="세종특별자치시">세종특별자치시</option>
								</select>
							</td>
							<td id="all"><input name="addr" id="addr" type="text" class="inputhan" width="98%"/></td>
							<th id="dong" class="indispensable">동 명</th>
							<td id="dongTd" style="border-left:none;border-right:none;width:150px">
								<input name="addr_nm" id="addr_nm" type="text" class="inputhan" style="width:150px;"/>
							</td>
						</tr>
						<tr id="noAll" style="height: 30px;border-right:none;">
							<th>건물명</th>
							<td style="border-left:none;border-right:none;width:150px">
								<input name="gun_nm" id="gun_nm" type="text" class="inputhan" style="width:150px;"/>
							</td>
							<th id="bunji">번지본번</th>
							<td style="border-left:none;border-right:none;width:100px">
								<input name="addr_bunji" id="addr_bunji" type="text" class="inputhan" style="width:120px;"/>
							</td>
							<th id="bunji_bu">번지부번</th>
							<td style="border-left:none;border-right:none;width:100px">
								<input name="addr_bubunji" id="addr_bubunji" type="text" class="inputhan" style="width:120px;"/>
							</td>
						</tr>
					</table>
				</div>
				<input type="hidden" id="pageNo" name="pageNo" value="1">
				<input type="hidden" id="totalCount" name="totalCount" value="0">
				<input type="hidden" id="sortName" name="sortName">
				<input type="hidden" id="sortType" name="sortType">
				<div id="view_grid_main">
					<table id="zipGrid"></table>
					<div id="paging"></div>
				</div>
			</form>
		</div>
	</div>
</div>
</body>
</html>

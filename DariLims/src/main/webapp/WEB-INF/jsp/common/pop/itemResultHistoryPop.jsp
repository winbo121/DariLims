
<%
	/***************************************************************************************
	 * 시스템명 	: 통합장비관제시스템
	 * 업무명 		: 항목별결과기록
	 * 파일명 		: itemResultHistoryPop.jsp
	 * 작성자 		: 최은향
	 * 작성일 		: 2015.11.13
	 * 설  명		: 항목별결과기록 팝업 화면
	 *---------------------------------------------------------------------------------------
	 * 변경일		 변경자		변경내역 
	 *---------------------------------------------------------------------------------------
	 * 2015.11.13    최은향		최초 프로그램 작성         
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
		itemResultHistoryGrid('selectItemResultHistory.lims?test_sample_seq='+arr[1], 'itemResultHistoryForm', 'itemResultHistoryGrid');

		$(window).bind('resize', function() {
			$("#itemResultHistoryGrid").setGridWidth($('#view_grid_main').width(), false);
		}).trigger('resize');

		// 엔터키 눌렀을 경우(그리드 조회)
		fn_Enter_Search('itemResultHistoryForm', 'itemResultHistoryGrid');
	});

	// 항목별 기록 조회
	function itemResultHistoryGrid(url, form, grid) {
		$('#' + grid).jqGrid({
			datatype : function(json) {
				fnGridData(url, form, grid);
			},
			height : '460',
			autowidth : true,
			loadonce : true,
			mtype : "POST",
			gridview : true,
			shrinkToFit : false,
			rowNum : -1,
			rownumbers : true,
			sortname : 'item_his_seq',
			sortorder : 'asc',
			colModel : [{
				label : 'item_his_seq',
				name : 'item_his_seq',
				hidden : true,
				key : true
			}, {
				label : '시료번호',
				align : 'center',
				width : '80',
				name : 'test_sample_seq'
			}, {
				label : '시료명',
				width : '120',
				name : 'sample_reg_nm'
			}, {
				label : '항목명',
				width : '200',
				name : 'test_item_cd'
			}, {
				label : '기준',
				align : 'center',
				width : '50',
				name : 'std_type'
			}, {
				label : '결과유형',
				align : 'center',
				width : '80',
				name : 'result_type'
			}, {
				label : '결과값',
				width : '100',
				name : 'result_val'
			}, {
				label : '결과코드',
				name : 'result_cd'
			}, {
				label : '기준상한값',
				align : 'center',
				width : '80',
				name : 'std_hval'
			}, {
				label : '기준하한값',
				align : 'center',
				width : '80',
				name : 'std_lval'
			}, {
				label : '상한값구분',
				align : 'center',
				width : '80',
				name : 'hval_type'
			}, {
				label : '하한값구분',
				align : 'center',
				width : '80',
				name : 'lval_type'
			}, {
				label : '판정값',
				align : 'center',
				width : '80',
				name : 'jdg_type'
			}, {
				label : '단위',
				align : 'center',
				width : '50',
				name : 'unit'
			}, {
				label : '유효자릿수',
				align : 'center',
				width : '80',
				name : 'valid_position'
			}, {
				label : '기준적합값',
				align : 'center',
				name : 'std_fit'
			}, {
				label : '기준부적합값',
				align : 'center',
				name : 'std_unfit'
			}, {
				label : '기준값',
				align : 'center',
				width : '100',
				name : 'std_val'
			}, {
				label : '성적서표기값',
				align : 'center',
				width : '80',
				name : 'report_disp_val'
			}, {
				label : '첨부문서명',
				name : 'file_nm'
			}, {
				label : '첨부문서번호',
				hidden : true,
				name : 'att_seq'
			}, {
				label : '시험기기',
				align : 'center',
				name : 'test_inst'
			}, {
				label : '시험방법',
				align : 'center',
				name : 'test_method'
			}, {
				label : '시험부서',
				align : 'center',
				name : 'test_dept_cd'
			}, {
				label : '정량상한값',
				align : 'center',
				name : 'loq_hval'
			}, {
				label : '계산식번호',
				align : 'center',
				name : 'account_no',
				hidden : true
			}, {
				label : '적용계산식',
				name : 'account_tot_cal_disp'
			}, {
				label : '변수대입값',
				name : 'account_val_desc_tot'
			}, {
				label : '결과값입력자',
				align : 'center',
				width : '100',
				name : 'creater_id'
			}, {
				label : '입력일',
				align : 'center',
				name : 'create_date'
			}, {
				label : '시험자',
				align : 'center',
				width : '80',
				name : 'tester_id'
			}, {
				label : '시험팀',
				align : 'center',
				width : '100',
				name : 'team_cd'
			}],
			gridComplete : function() {
			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
			},
			onSelectRow : function(rowId, status, e) {
			},
			ondblClickRow : function(rowId, iRow, iCol, e) {
			}
		});
	}

	// 조회 이벤트
	function btn_Select_onclick() {
		$('#itemResultHistoryGrid').trigger('reloadGrid');
	}
	
	//fnpop_callback
</script>
</head>
<body id="popBody" onunload="opener.fnBasicEndLoading();">
	<div class="popUp">
		<div class="pop_area pop_intro">
			<h2>사용자 목록</h2>
			<div>
				<form id="itemResultHistoryForm" name="itemResultHistoryForm" onsubmit="return false;">
					<div class="sub_purple_01" style="margin-top: 0px;">
						<table width="100%" border="0" class="select_table">
							<tr>
								<td width="20%" class="table_title">
									<span style="font-size: 11px; margin-left: 15px; color: #b27ce0;">■</span>
									항목별 결과 기록 목록
								</td>
								<td class="table_button" style="text-align: right; padding-right: 30px;">
									<!-- 
									<span class="button white mlargeb auth_select" id="btn_Select" onclick="btn_Select_onclick();">
										<button type="button">조회</button>
									</span>
									 -->
									<span class="button white mlargep" id="btn_Cancel" onclick="window.close();">
										<button type="button">닫기</button>
									</span>
								</td>
							</tr>
						</table>
						<!-- 
						<table width="100%" border="0" class="list_table">
							<tr>
								<th>시험자</th>
								<td>
									<input name="tester_id" id="tester_id" type="text" class="inputhan" />
									<input name="user_nm" id="user_nm" type="text" class="inputhan" />
								</td>
							</tr>
						</table>
						 -->
					</div>
					<input type="hidden" id="sortName" name="sortName">
					<input type="hidden" id="sortType" name="sortType">
					<div id="view_grid_main">
						<table id="itemResultHistoryGrid"></table>
					</div>
				</form>
			</div>
		</div>
	</div>
</body>
</html>
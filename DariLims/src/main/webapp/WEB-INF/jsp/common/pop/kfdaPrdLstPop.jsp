
<%
	/***************************************************************************************
	 * 시스템명 	: 통합장비관제시스템
	 * 업무명 		: 품목리스트
	 * 파일명 		: prdLstPop.jsp
	 * 작성자 		: 윤상준
	 * 작성일 		: 2015.12.17
	 * 설  명		: 
	 *---------------------------------------------------------------------------------------
	 * 변경일		 변경자		변경내역 
	 *---------------------------------------------------------------------------------------
	 * 2015.12.17    윤상준		최초 프로그램 작성         
	 * 
	 *---------------------------------------------------------------------------------------
	 ****************************************************************************************/
%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


<!DOCTYPE html>
<html id="popHtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<link rel="stylesheet" media="screen" type="text/css" href="<c:url value='/css/jquery-ui.css'/>" />
<link rel="stylesheet" media="screen" type="text/css" href="<c:url value='/css/common/common.css'/>" />
<link rel="stylesheet" media="screen" type="text/css" href="<c:url value='/css/common/sub.css'/>" />
<link rel="stylesheet" media="screen" type="text/css" href="<c:url value='/css/jqgrid/ui.jqgrid.css'/>" />
<script type="text/javascript" src="<c:url value='/script/jquery-1.11.0.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/script/jquery-ui.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/script/jquery.blockUI.js'/>"></script>
<script type="text/javascript" src="<c:url value='/script/jquery.form.js'/>"></script>
<script type="text/javascript" src="<c:url value='/script/jquery.message.js'/>"></script>
<script type="text/javascript" src="<c:url value='/script/jqgrid/grid.locale-kr.js'/>"></script>
<script type="text/javascript" src="<c:url value='/script/jqgrid/jquery.jqGrid.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/script/lims.com.js'/>"></script>
<script type="text/javascript" src="<c:url value='/script/lims.com.grid.js'/>"></script>

<title>LIMS</title>
<script type="text/javascript">
	var fnGridInit = false;
	
	$(function() {
		/* 세부권한검사 */
		//fn_auth_check();
		
		//ajaxComboForm("htrk_prdlst_cd", "", "NON", "", "prdLstForm");
		ajaxComboForm("prdlst_kind1_cd", "CP1", "CHOICE", "", "prdLstForm");
		ajaxComboForm("prdlst_kind2_cd", "CP2", "CHOICE", "", "prdLstForm");
		
		gridPrdLstPop('selectPrdLstList.lims', 'prdLstForm', 'gridPrdLstPop');
		
		// 엔터키 눌렀을 경우(그리드 조회) 페이징사용시 수정필요
		fn_Enter_Search('prdLstForm', 'gridPrdLstPop');
		$(window).bind('resize', function() {
			$("#gridPrdLstPop").setGridWidth($('#view_grid_pop').width(), false);
		}).trigger('resize'); 
	});
	
	
	// 
	function gridPrdLstPop(url, form, grid) {
		$('#' + grid).jqGrid({
			datatype : function(jsonData) {
				//fn_GridData(url, form, grid);
				fnGridInit ? fn_GridData(url, form, grid) : fnGridInit = true;
			}, 
			//scroll: true,
			/* 그리드페이징 */
			/*  트리그리드 
			treeGrid: true,
			rownumbers : false,
			treeGridModel: 'adjacency',
            ExpandColClick: true,
            tree_root_level: 2,
			ExpandColumn : 'kor_nm',
			treeReader:{
				//leaf_field : 'ISLF',
				level_field : 'lv', 
				parent_id_field : 'hrnk_prdlst_cd',
				leaf_field:            "lf",
	            expanded_field:        "ex"
			}, */
			colModel : [ 
				{label : '품목코드',name : 'prdlst_cd', width : '100',align : 'center'//,key : true,hidden : true
				}, {label : '최상위코드',width : '80',align : 'center',name : 'htrk_prdlst_cd',hidden : true
				}, {label : '최상위품목명',width : '100',align : 'center',name : 'htrk_prdlst_nm',hidden : true
				}, {label : '상위코드',width : '50',name : 'hrnk_prdlst_cd',hidden : true
				}, {label : '품목명',width : '300',hidden : true,name : 'prdlst_nm'
				}, {label : '품목한글명',width : '300',name : 'kor_nm'
				}, {label : '품목영문명',width : '200',name : 'eng_nm'
				}, {label : '레벨',width : '60',align : 'center',hidden : true,name : 'lv'
				}, {label : '품목여부',width : '100',name : 'prdlst_yn',align : 'center'
				}, {label : '속성한글명',width : '100',name : 'piam_kor_nm',align : 'center'
				}, {label : '정의',width : '100',name : 'dfn',align : 'center'
				}, {label : '조합품목여부',width : '100',name : 'mxtr_prdlst_yn',align : 'center'	
				}, {label : '사용여부',width : '100',name : 'use_yn',align : 'center'
				}, {label : '유효개시일자',width : '100',name : 'vald_begn_dt',align : 'center'	
				}, {label : '유효종료일자',width : '100',name : 'vald_end_dt',align : 'center'	
				}, {label : '비고',width : '200',name : 'rm',align : 'center'	
				}, {label : '최종수정일',width : '100',name : 'last_updt_dtm',align : 'center'
				} ],
			height : '480',
			rowNum : -1,
			rownumbers : true,
			autowidth : false,
			gridview : false,
			shrinkToFit : false,
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
			gridComplete : function(data) {
				gridPrdLstPopComplete();
			},
			onSortCol : function(index, iCol, sortorder) {
			},
			onSelectRow : function(rowId, status, e) {
			}
		});
		$("#gridPrdLstPop").setGridWidth($('#view_grid_pop').width(), false);
	}
	
	
	function btn_Excel_onclick() {
		var data = fn_Excel_Data_Make('gridPrdLstPop');
		fn_Excel_Download(data);
	}

	
	function btn_Search_onclick(){
		$('#gridPrdLstPop').setGridParam({page: 1});
		$('#gridPrdLstPop').trigger('reloadGrid');
	}
	
	function gridPrdLstPopComplete(){	
	}
	
	

</script>
</head>
<body id="popBody" onunload="opener.fnBasicEndLoading();">
<div class="popUp">
	<div class="pop_area pop_intro">
		<h2>식약처 품목조회</h2>
		<div>
		<form id="prdLstForm" name="prdLstForm" onsubmit="return false;">
		<input type="hidden" id="kfda_yn" name="kfda_yn" value="Y">
			<div class="sub_purple_01">
				<table  class="select_table" >
					<tr>
						<td class="table_title">
							<span>■</span>
							품목조회
						</td>
						<td class="table_button">
							<span class="button white mlargep auth_select" id="btn_Select" onclick="btn_Search_onclick();">
								<button type="button">조회</button>
							</span>
							<!-- <span class="button white mlargep auth_save" id="btn_New" onclick="btn_New_onclick();">
								<button type="button">추가</button>
							</span> -->
						</td>
					</tr>
				</table>
				<!-- 조회 테이블 -->
				<table  class="list_table" >
					<tr>
						<th>품목구분</th>
						<td>
							<select name="prdlst_kind1_cd" id="prdlst_kind1_cd" style="width: 45%"></select>
							<select name="prdlst_kind2_cd" id="prdlst_kind2_cd" style="width: 45%"></select>
						</td>
						<th>품목명</th>
						<td>
							<input type="text" name="kor_nm" />
						</td>
				   </tr>
				   <tr>
						<th>품목여부</th>
						<td>
							<label><input type='radio' name='prdlst_yn' value='' style="width: 20px" checked="checked"/>전체</label> 
							<label><input type='radio' name='prdlst_yn' value='Y' style="width: 20px" />예</label>
							<label><input type='radio' name='prdlst_yn' value='N' style="width: 20px" />아니오</label>
						</td>
						<th>사용여부</th>
						<td>
							<label><input type='radio' name='use_yn' value='' style="width: 20px" checked="checked"/>전체</label> 
							<label><input type='radio' name='use_yn' value='Y' style="width: 20px" />사용</label>
							<label><input type='radio' name='use_yn' value='N' style="width: 20px" />미사용</label>
						</td>
					</tr>
				</table>
				<input type="hidden" id="sortName" name="sortName">
				<input type="hidden" id="sortType" name="sortType">
				<input type='hidden' id='pageNum' name='pageNum'/>
				<input type='hidden' id='pageSize' name='pageSize'/>
				<input type='hidden' id='sortTarget' name='sortTarget'/>
				<input type='hidden' id='sortValue' name='sortValue'/>
				<div id="view_grid_pop">
					<table id="gridPrdLstPop"></table>
					<div id="gridPrdLstPopPager"></div>
				</div>
			</div>
		</form>
		</div>
	</div>
</div>
</body>
</html>
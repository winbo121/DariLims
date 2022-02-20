<%
	/***************************************************************************************
	 * 시스템명 	: 실험실정보관리시스템
	 * 업무명 		: 품목관리
	 * 파일명 		: prdLstL01.jsp
	 * 작성자 		: 윤상준
	 * 작성일 		: 2015.12.16
	 * 설  명		: 
	 *---------------------------------------------------------------------------------------
	 * 변경일		변경자		변경내역 
	 *---------------------------------------------------------------------------------------
	 * 2015.12.16    윤상준		최초 프로그램 작성  
	 *---------------------------------------------------------------------------------------
	 ****************************************************************************************/
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html >
<link rel="stylesheet" media="screen" type="text/css" href="<c:url value='/css/common/sub.css'/>" />
<script type="text/javascript">
	var fnGridInit = false;
	
	$(function() {
		/* 세부권한검사 */
		fn_auth_check();
		ajaxComboForm("htrk_prdlst_cd", "CP1", "CHOICE", "", "mainForm");
		
		
		gridMain('master/selectPrdLstList.lims', 'mainForm', 'gridMain');
		
		// 엔터키 눌렀을 경우(그리드 조회)
		fn_Enter_Search('mainForm', 'gridMain');

		//그리드 width조절하기
		$(window).bind('resize', function() {
			$("#gridMain").setGridWidth($('#view_grid_main').width(), true);
		}).trigger('resize');
	});
	
	
	// 
	function gridMain(url, form, grid) {
		$('#' + grid).jqGrid({
			datatype : function(json) {
				fnGridInit ? fn_GridData(url, form, grid) : fnGridInit = true;
			},
			height : '250',
			rowNum : -1,
			rownumbers : true,
			autowidth : true,
			gridview : false,
			shrinkToFit : true,
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
			colModel : [ {
				label : '품목코드',
				name : 'prdlst_cd',
				key : true,
				hidden : true
			}, {
				label : '품목분류',
				width : '100',
				align : 'center',
				name : 'htrk_prdlst_nm'
			}, {
				label : '품목명',
				width : '300',
				hidden : true,
				name : 'prdlst_nm'
			}, {
				label : '품목한글명',
				width : '300',
				name : 'kor_nm'
			}, {
				label : '품목영문명',
				width : '200',
				name : 'eng_nm'
			}, {
				label : '레벨',
				width : '60',
				align : 'center',
				name : 'lv',
				hidden : true
			}, {
				label : '품목여부',
				width : '100',
				name : 'prdlst_yn',
				align : 'center'
			}, {
				label : '속성한글명',
				width : '100',
				name : 'piam_kor_nm',
				align : 'center',
				hidden : true
			},/*  {
				label : '시험항목담당자',
				width : '100',
				name : 'charger_user_nm',
				align : 'center'
			}, */ {
				label : '조합품목여부',
				width : '100',
				name : 'mxtr_prdlst_yn',
				align : 'center'
			}, {
				label : '유효개시일자',
				width : '100',
				name : 'vald_begn_dt',
				align : 'center',
				hidden : true
			}, {
				label : '유효종료일자',
				width : '100',
				name : 'vald_end_dt',
				align : 'center',
				hidden : true
			}, {
				label : '사용여부',
				width : '100',
				name : 'use_yn',
				align : 'center'
			}, {
				label : '최종수정일',
				width : '100',
				name : 'last_updt_dtm',
				align : 'center'
			}, {
				label : '정의',
				width : '100',
				name : 'dfn',
				align : 'center'
			}, {
				label : '비고',
				width : '200',
				name : 'rm',
				align : 'center'	
			}, {
				label : 'kfda_yn',
				hidden : true,
				name : 'kfda_yn'
			} ],
			emptyrecords : '데이터가 존재하지 않습니다.',
			gridComplete : function() {
			},
			onSortCol : function(index, iCol, sortorder) {
				//if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
			},
			onSelectRow : function(rowId, status, e) {
				fnViewPage('master/selectPrdLstDetail.lims', 'detailDiv', 'pageType=detail&prdlst_cd=' + rowId);
			}
		});
	}
	
	
	function btn_New_onclick() {
		$("#detailDiv").empty();
		fnViewPage('master/selectPrdLstDetail.lims', 'detailDiv', 'pageType=insert');
	}
	

	
	function btn_Select_onclick(){
		$('#gridMain').setGridParam({page: 1});
		$('#gridMain').trigger('reloadGrid');
	}
	

</script>

<form id="mainForm" name="mainForm" onsubmit="return false;">
	<div class="sub_purple_01">
		<table  class="select_table" >
			<tr>
				<td class="table_title">
					<span>■</span>
					품목조회
				</td>
				<td class="table_button">
					<span class="button white mlargep auth_select" id="btn_Select" onclick="btn_Select_onclick();">
						<button type="button">조회</button>
					</span>
					<span class="button white mlargep auth_save" id="btn_New" onclick="btn_New_onclick();">
						<button type="button">추가</button>
					</span>
				</td>
			</tr>
		</table>
		<!-- 조회 테이블 -->
		<table  class="list_table" >
			<tr>
				<th>품목구분</th>
				<td>
					<select name="htrk_prdlst_cd" id="htrk_prdlst_cd" style="width: 45%"></select>
				</td>
				<th>품목명</th>
				<td colspan="3">
					<input type="text" name="kor_nm" />
				</td>
			</tr>
			<tr>
				<th>품목여부</th>
				<td>
					<label><input type='radio' name='prdlst_yn' value='' style="width: 20px"/>전체</label> 
					<label><input type='radio' name='prdlst_yn' value='Y' style="width: 20px" checked="checked"/>예</label>
					<label><input type='radio' name='prdlst_yn' value='N' style="width: 20px" />아니오</label>
				</td>
				<th>사용여부</th>
				<td>
					<label><input type='radio' name='use_yn' value='' style="width: 20px"/>전체</label> 
					<label><input type='radio' name='use_yn' value='Y' style="width: 20px" checked="checked"/>사용</label>
					<label><input type='radio' name='use_yn' value='N' style="width: 20px" />미사용</label>
				</td>
				<th style='display:none;'>식약처기준 여부</th>
				<td style='display:none;'> 
					<label><input type='radio' name='kfda_yn' value='Y' style="width: 20px"/>예</label>
					<label><input type='radio' name='kfda_yn' value='N' style="width: 20px" checked="checked"/>아니오</label>
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
	<div id="view_grid_main">
		<table id="gridMain"></table>
		<div id="gridMainPager"></div>
	</div>
	<table id="search"></table>
</form> 
<div id="detailDiv"></div>
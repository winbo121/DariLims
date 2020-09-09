
<%
	/***************************************************************************************
	 * 시스템명 	: 통합장비관제시스템
	 * 업무명 		: 교육참석자(팝업)
	 * 파일명 		: eduAttendInfoP01.jsp
	 * 작성자 		: 석은주
	 * 작성일 		: 2015.01.29
	 * 설  명		: 교육참석자 화면
	 *---------------------------------------------------------------------------------------
	 * 변경일		 변경자		변경내역 
	 *---------------------------------------------------------------------------------------
	 * 2015.01.29    석은주		최초 프로그램 작성         
	 * 
	 *---------------------------------------------------------------------------------------
	 ****************************************************************************************/
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html >
<link rel="stylesheet" media="screen" type="text/css" href="<c:url value='/css/common/sub.css'/>" />
<style>
</style>
<script type="text/javascript">
	$(function() {
		eduAttendGrid('kolas/selectEduAttendInfoList.lims', 'form', 'eduAttendGrid');
		
		//그리드 사이즈 
		$(window).bind('resize', function() { 
		    $("#eduAttendGrid").setGridWidth($('#view_grid_main').width(), true); 
		}).trigger('resize');
		
	});
	
	function eduAttendGrid(url, form, grid) {
		var lastRowId;
		$('#' + grid).jqGrid({
			datatype : function(json) {
				fnGridData(url, form, grid);
			},
			height : '250',
			autowidth : true,
			loadonce : true,
			mtype : "POST",
			gridview : true,	
			shrinkToFit : false,
			viewrecords : true,
			colModel : [ {
				label : '교육참석번호',
				name : 'attend_no',
				hidden : true,
				key : true
			}, {
				label : '교육결과번호',
				name : 'edu_result_no',
				hidden : true
			}, {
				label : '부서번호',
				name : 'dept_no',
				hidden : true
			}, {
				label : '부서',
				name : 'dept_nm'
			}, {
				label : '참석자아이디',
				name : 'user_no',
				hidden : true
			}, {
				label : '참석자',
				name : 'user_nm'
			}, {
				label : '문서이름',
				name : 'doc_nm'
			}, {
				label : '파일이름',
				name : 'file_nm',
				hidden : true
			}, {
				label : '파일이름',
				formatter: displayAlink 
			} ],
			emptyrecords: '데이터가 존재하지 않습니다.',
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
	
	function pressKey(e) {
		if (e.keyCode == 13) {
			getUser();
		} else {
			e.keyCode == 0;
			return;
		}
	}
	
	// 첨부파일 다운로드
	function displayAlink(cellvalue, options, rowObject)
    {
		var edit;
		if(rowObject.file_nm == undefined)
			edit = '<label></label>';
		else
 			edit = "<label><a href='kolas/eduAttendFileDown.lims?attend_no=" + rowObject.attend_no + "'>"+ rowObject.file_nm +"</a></label>";
        return edit;
    }
	
	// 닫기클릭이벤트
	function btn_Close_onclick() {
		window.close();
	}
</script>
<div class="popUp">
	<div class="pop_area pop_intro">
	<h2>교육참석자 </h2>
		<div class="sub_purple_01 w100p" style="margin-top: 0px;">
			<table  class="select_table" >
				<tr>
					<td width="40%" class="table_title">
						<span>■</span>
						교육참석자목록
					</td>
					<td class="table_button" style="text-align: right; padding-right: 30px;">					
						<span class="button white mlargep" id="btn_Close" onclick="btn_Close_onclick();">
							<button type="button">닫기</button>
						</span>
					</td>
				</tr>
			</table>
			<form id="form" name="form" onsubmit="return false;">
				<input type="hidden" id="sortName" name="sortName">
				<input type="hidden" id="sortType" name="sortType">
				<input type="hidden" id="edu_result_no" name="edu_result_no" value="${key }">
				<div id="view_grid_main">
					<table id="eduAttendGrid"></table>
				</div>
			</form>
		</div>
	</div>
</div>
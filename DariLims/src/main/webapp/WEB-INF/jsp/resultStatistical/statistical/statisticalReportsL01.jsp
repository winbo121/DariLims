
<%
	/***************************************************************************************
	 * 시스템명 	: 통합장비관제시스템
	 * 업무명 		: 통계보고서
	 * 파일명 		: statisticalReportsL01.jsp
	 * 작성자 		: 최은향
	 * 작성일 		: 2015.03.13
	 * 설  명		: 통계보고서 리스트 조회 화면
	 *---------------------------------------------------------------------------------------
	 * 변경일		 변경자		변경내역 
	 *---------------------------------------------------------------------------------------
	 * 2015.03.13    최은향		최초 프로그램 작성         
	 * 
	 *---------------------------------------------------------------------------------------
	 ****************************************************************************************/
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html >
<link rel="stylesheet" media="screen" type="text/css" href="<c:url value='/css/common/sub.css'/>" />
<style>
.round {
	border-top-left-radius: 5px; 
	border-top-right-radius: 5px;
	border-bottom-left-radius: 5px; 
	border-bottom-right-radius: 5px;
	border:solid 1px #82bbce;
	position: relative;
	margin: 0;
	padding: 0;
	overflow: auto;
	}
.jqgrid { width: 2000px !important; }
.jqgrid th { background:#dfeffc url("./css/images/ui-bg_glass_85_dfeffc_1x400.png") 50% 50% repeat-x !important; font-weight:bold; color: #474747;  border-left: solid 1px #82bbce; border-top: solid 0px #82bbce; }
.jqgrid .year { font-weight:bold; color: #2e6e9e; }
.jqgrid_tit th { width:50px !important; padding: 6px 0 3px 0; }
.jqgrid_num td { text-align:right; height:22px; }
</style>

<script type="text/javascript">
	$(function() {
		/* 세부권한검사 */
		fn_auth_check();
		
		fnDatePickerImg('startDate');
		fnDatePickerImg('endDate');
		$('#startDate').val(fnGetToday(1,0));
		$('#endDate').val(fnGetToday(0,0));
		ajaxComboForm("unit_work_cd", "", "ALL", null, 'statisticalReportsForm');
		
		// 실적 및 통계
// 		grid('resultStatistical/statisticalReports.lims', 'statisticalReportsForm', 'statisticalReportsGrid');
		
		// 그리드 사이즈 
		$(window).bind('resize', function() { 
		    $("#statisticalReportsGrid").setGridWidth($('#view_grid_main').width(), false);		    
		}).trigger('resize');
		
// 		//엔터키 눌렀을 경우(구매목록 그리드 조회)
// 		$("form[name=statisticalReportsForm] input, form[name=statisticalReportsForm] select").keypress(function(e) {
// 			if ((e.which && e.which == 13) || (e.keyCode && e.keyCOde == 13)) {
// 				$('#statisticalReportsGrid').trigger('reloadGrid');
// 			}
// 		});
	});
</script>
<!-- 실적 및 통계 그리드 -->
<div class="sub_purple_01 w100p" id="view_grid_main">
	<form id="statisticalReportsForm" name="statisticalReportsForm" onsubmit="return false;">			
		<table  class="select_table" >
			<tr>
				<td class="table_title">
					<span>■</span>
					실적 및 통계
				</td>
				<td class="table_button">
					<span class="button white mlargep auth_select" id="btn_Select" onclick="btn_Select_onclick();">
						<button type="button">조회</button>
					</span>
				</td>
			</tr>
		</table>
		<table  class="list_table" >
			<tr>
				<th>구분</th>
				<td>
					<label><input type='radio' name='select' value='year' style="width:20px" checked="checked"/>년간</label>
					<label><input type='radio' name='select' value='month' style="width:20px"/>월간</label>
				</td>
				<th>시험부서</th>
				<td>
					<input id="dept_cd" name="dept_cd" type="text" style="width: 120px;"/>
				</td>
				<th>단위업무</th>
				<td>
					<select id="unit_work_cd" name="unit_work_cd" style="width: 180px;"></select>
				</td>
				<th>시료명</th>
				<td>
					<input name="" id="" type="text" class="inputhan"/>
				</td>
				<th>접수일자</th>
				<td>
					<input name="startDate" id="startDate" type="text" class="inputhan w80px"/>
					<img src="<c:url value='/images/common/calendar_del.png'/>" id="startDateStop" style="cursor: pointer;" onClick='fn_TextClear("startDate")' />
					~
					<input name="endDate" id="endDate" type="text" class="inputhan w80px"/>	
					<img src="<c:url value='/images/common/calendar_del.png'/>" id="startDateStop" style="cursor: pointer;" onClick='fn_TextClear("endDate")' />
				</td>
			</tr>
		</table>		
		<input type="hidden" id="sortName" name="sortName">
		<input type="hidden" id="sortType" name="sortType">
		
		<!--  통계 테이블 -->
		<div class="round" id="statisticalReportsGrid">
			<table class="list_table jqgrid" >
				<tr>
					<th rowspan="2" style="min-width:200px; border-left:none;">시험항목</th>
					
					<!-- (for) 년도 & 월별 수 만큼 증가 -->
					<th colspan="3" class="year">2009년</th>
					<th colspan="3" class="year">2010년</th>
					<th colspan="3" class="year">2011년</th>
					<th colspan="3" class="year">2012년</th>
					<th colspan="3" class="year">2013년</th>
					<th colspan="3" class="year">2014년</th>
					<th colspan="3" class="year">2015년</th>
							
					<th rowspan="2" style="min-width:100px;">총계</th>
				</tr>
				<tr class="jqgrid_tit">
					<!-- (for) 년도 & 월별 수 만큼 증가 -->
					<th>적합</th>
					<th>부적합</th>
					<th>소계</th>
					
					<th>적합</th>
					<th>부적합</th>
					<th>소계</th>
					
					<th>적합</th>
					<th>부적합</th>
					<th>소계</th>
					
					<th>적합</th>
					<th>부적합</th>
					<th>소계</th>
					
					<th>적합</th>
					<th>부적합</th>
					<th>소계</th>
					
					<th>적합</th>
					<th>부적합</th>
					<th>소계</th>
					
					<th>적합</th>
					<th>부적합</th>
					<th>소계</th>
				</tr>
				<!-- 시험 항목 갯수 만큼(for) -->
				<tr class="jqgrid_num">
					<td style="text-align:left; border-left:none;">지오스민</td>
					
					<!-- (for) 년도 & 월별 수 만큼 증가 -->
					<td>100</td>
					<td>50</td>
					<td>150</td>
					
					<td>100</td>
					<td>50</td>
					<td>150</td>
					
					<td>100</td>
					<td>50</td>
					<td>150</td>
					
					<td>100</td>
					<td>50</td>
					<td>150</td>
					
					<td>100</td>
					<td>50</td>
					<td>150</td>
					
					<td>100</td>
					<td>50</td>
					<td>150</td>
					
					<td>100</td>
					<td>50</td>
					<td>150</td>
					
					<td>900</td>
				</tr>
				
				<tr class="jqgrid_num">
					<td style="text-align:left; border-left:none;">지오스민</td>
					
					<!-- (for) 년도 & 월별 수 만큼 증가 -->
					<td>100</td>
					<td>50</td>
					<td>150</td>
					
					<td>100</td>
					<td>50</td>
					<td>150</td>
					
					<td>100</td>
					<td>50</td>
					<td>150</td>
					
					<td>100</td>
					<td>50</td>
					<td>150</td>
					
					<td>100</td>
					<td>50</td>
					<td>150</td>
					
					<td>100</td>
					<td>50</td>
					<td>150</td>
					
					<td>100</td>
					<td>50</td>
					<td>150</td>
					
					<td>900</td>
				</tr>
				
				<tr class="jqgrid_num">
					<td style="text-align:left; border-left:none;">지오스민</td>
					
					<!-- (for) 년도 & 월별 수 만큼 증가 -->
					<td>100</td>
					<td>50</td>
					<td>150</td>
					
					<td>100</td>
					<td>50</td>
					<td>150</td>
					
					<td>100</td>
					<td>50</td>
					<td>150</td>
					
					<td>100</td>
					<td>50</td>
					<td>150</td>
					
					<td>100</td>
					<td>50</td>
					<td>150</td>
					
					<td>100</td>
					<td>50</td>
					<td>150</td>
					
					<td>100</td>
					<td>50</td>
					<td>150</td>
					
					<td>900</td>
				</tr>
			</table>
		</div>
	</form>
</div>
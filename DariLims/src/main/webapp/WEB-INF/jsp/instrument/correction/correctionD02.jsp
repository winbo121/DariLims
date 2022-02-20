
<%
	/***************************************************************************************
	 * 시스템명 	: 통합장비관제시스템
	 * 업무명 		: 교정등록
	 * 파일명 		: correctionD01.jsp
	 * 작성자 		: 최은향
	 * 작성일 		: 2015.01.29
	 * 설  명		: 교정등록 상세 조회 화면
	 *---------------------------------------------------------------------------------------
	 * 변경일		변경자		변경내역 
	 *---------------------------------------------------------------------------------------
	 * 2015.01.29    최은향		최초 프로그램 작성         
	 * 
	 *---------------------------------------------------------------------------------------
	 ****************************************************************************************/
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html >
<link rel="stylesheet" media="screen" type="text/css" href="<c:url value='/css/common/sub.css'/>" />
<script type="text/javascript">
	$(function() {
		fnDatePickerImg('intchk_date');
		fnDatePickerImg('nxt_intchk_date');
		
		if("${detail.intchk_date}" == ""){
			$('#intchk_date').val(fnGetToday(0,0));	
			dateSetting();
		}
		
		$("#intchk_date").change(function() {
			dateSetting();			
		});
	});
	
	function dateSetting(){
		var rowId = $('#machineGrid').getGridParam('selrow');
		var row = $('#machineGrid').getRowData(rowId);
		var addMonth;
		
		if(row.cali_period == ""){
			addMonth = 0;
		}else{
			addMonth = row.cali_period;
		}
		
		var date = $('#intchk_date').val();
		var dt = new Date(date);

		dt.setMonth(dt.getMonth() + parseInt(addMonth));
	
		var y = dt.getFullYear();
		var m = dt.getMonth()+1;
		var d = dt.getDate();

//		var ndt = new Date(y, m, d);
		
		/* var week = ['일', '월', '화', '수', '목', '금', '토'];
		var dayOfWeek = week[new Date(ndt).getDay()];
		
		if(dayOfWeek == "금"){
			ndt.setDate(ndt.getDate() + 2);
		}else{
			if(dayOfWeek == "토" || dayOfWeek == "일"){
				ndt.setDate(ndt.getDate() + 2);
			}	
		} */
				
// 		var ny = ndt.getFullYear();
// 		var nm = ndt.getMonth();
// 		var nd = ndt.getDate();

// 		if(nm < 10){
// 			nm = '0'+nm;
// 		}
// 		if(nd < 10){
// 			nd = '0'+nd;
// 		}

		if(m < 10){
			m = '0'+m;
		}
		if(d < 10){
			d = '0'+d;
		}
		
		$('#nxt_intchk_date').val(y+'-'+m+'-'+d);
	}	
</script>
<table  class="select_table" >
	<tr>
		<td width="20%" class="table_title">
			<span>■</span>
			중간점검 상세정보
		</td>
		<td class="table_button">
			<span class="button white mlargeg auth_save" id="btn_Save_Sub2" onclick="btn_Insert2_onclick();">
				<button type="button">저장</button>
			</span>
			<span class="button white mlarger auth_save" id="btn_Delete_Sub2" onclick="btn_Delete2_onclick();">
				<button type="button">삭제</button>
			</span>
		</td>
	</tr>
</table>
<table  class="list_table" >
	<!-- 리스트 width는 th는 10%  td는 15%로 적용-->
	<tr>
		<th>중감점검결과</th>
		<td>
			<input name="intchk_result" type="text" value="${detail.intchk_result}" style="width:160px;"/>
		</td>		
		<th class="indispensable">점검일자</th>
		<!--한글우선입력-->
		<td>
			<input type="hidden" id="inst_no" name="inst_no" value="${detail.inst_no}" />
			<input type="hidden" id="intchk_no" name="intchk_no" value="${detail.intchk_no}" />
			<input name="intchk_date" id="intchk_date" type="text" value="${detail.intchk_date}" style="width:80px; text-align:center;" readonly/>
			<img src="<c:url value='/images/common/calendar_del.png'/>" id="intchk_date_Del" style="cursor: pointer;" onClick='fn_TextClear("intchk_date")'/>
		</td>		
	</tr>
	<tr>
		<th>점검기관</th>
		<!--한글우선입력-->
		<td>
			<input name="intchk_org" type="text" class="inputhan" value="${detail.intchk_org}" style="width:160px;"/>
		</td>
		<th class="indispensable">차기점검일자</th>
		<td>
			<input name="nxt_intchk_date" id="nxt_intchk_date" type="text" value="${detail.nxt_intchk_date}"  style="width:80px; text-align:center;" readonly/>
			<img src="<c:url value='/images/common/calendar_del.png'/>" id="nxt_intchk_date_Del" style="cursor: pointer;" onClick='fn_TextClear("nxt_intchk_date")'/>
		</td>
	</tr>
	<tr>
		<th class="indispensable">담당자(정)</th>
		<td>
			<input name="mng_id" id="mng_id" type="hidden" value="${detail.mng_id}"/>
			<input name="mng_nm" type="text" class="inputhan" value="${detail.mng_nm}" style="width:160px; background-color: #D5D5D5;" readonly="readonly"/>
		</td class="indispensable">
		<th>담당자(부)</th>
		<td>
			<input name="mng_sub_id" id="mng_sub_id" type="hidden" value="${detail.mng_sub_id}"/>
			<input name="mng_sub_nm" type="text" class="inputhan" value="${detail.mng_sub_nm}" style="width:160px; background-color: #D5D5D5;" readonly="readonly"/>
		</td>
	</tr>
	<!--
	<tr>
		<th>점검여부</th>
		<td colspan="3">
			<input type="radio" name="intchk_yn" id="intchk_yn" style="width: 15px; margin-left: 15px; top: 1px;" value="Y" <c:if test="${detail.intchk_yn == 'Y' || detail.intchk_yn == '' || detail.intchk_yn == null}">checked="checked"</c:if> />
			점검함
			<input type="radio" name="intchk_yn" id="intchk_yn" style="width: 15px; margin-left: 15px; top: 1px;" value="N" <c:if test="${detail.intchk_yn == 'N'}">checked="checked"</c:if> />
			점검안함
		</td>
	</tr> -->
</table>
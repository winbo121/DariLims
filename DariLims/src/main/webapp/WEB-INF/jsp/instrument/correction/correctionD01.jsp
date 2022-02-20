
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
		fnDatePickerImg('crt_date');
		fnDatePickerImg('nxt_crt_date');
		
		if("${detail.crt_date}" == ""){
			$('#crt_date').val(fnGetToday(0,0));
			dateSetting();
		}
		
		$("#crt_date").change(function() {
			dateSetting();	
		});
	});
	
	function dateSetting(){
		var rowId = $('#machineGrid').getGridParam('selrow');
		var row = $('#machineGrid').getRowData(rowId);
		var addMonth;
		
		if(row.cali_io == ""){
			addMonth = 0;
		}else{
			addMonth = row.cali_io;
		}
		
		var date = $('#crt_date').val();
		var dt = new Date(date);
		
		dt.setMonth(dt.getMonth() + parseInt(addMonth));
		
		var y = dt.getFullYear();
		var m =  dt.getMonth()+1;
		var d = dt.getDate();
		
		var ndt = new Date(y, m, d);
		
		/* var week = ['일', '월', '화', '수', '목', '금', '토'];
		var dayOfWeek = week[new Date(ndt).getDay()];
		
		if(dayOfWeek == "금"){
			ndt.setDate(ndt.getDate() + 2);
		}else{
			if(dayOfWeek == "토" || dayOfWeek == "일"){
				ndt.setDate(ndt.getDate() + 2);
			}	
		} */
		/*		
		var ny = ndt.getFullYear();
		var nm = ndt.getMonth();
		var nd = ndt.getDate();
		*/
		/*
		if(nm < 10){
			nm = '0'+nm;
		}
		if(nd < 10){
			nd = '0'+nd;
		}
		*/
		if(m < 10){
			m = '0'+m;
		}
		if(d < 10){
			d = '0'+d;
		}
		$('#nxt_crt_date').val(y+'-'+m+'-'+d);
	}
</script>
<table  class="select_table" >
	<tr>
		<td width="20%" class="table_title">
			<span>■</span>
			교정 상세정보
		</td>
		<td class="table_button">
			<span class="button white mlargeg auth_save" id="btn_Save_Sub1" onclick="btn_Insert_onclick();">
				<button type="button">저장</button>
			</span>
			<span class="button white mlarger auth_save" id="btn_Delete_Sub1" onclick="btn_Delete_onclick();">
				<button type="button">삭제</button>
			</span>
		</td>
	</tr>
</table>
<table  class="list_table" >
	<!-- 리스트 width는 th는 10%  td는 15%로 적용-->
	<tr>
		<th>교정결과</th>
		<td>
			<input name="crt_result" type="text" value="${detail.crt_result}" style="width:160px;"/>
		</td>		
		<th class="indispensable">교정일자</th>
		<!--한글우선입력-->
		<td>
			<input type="hidden" id="inst_no" name="inst_no" value="${detail.inst_no}" />
			<input type="hidden" id="crt_no" name="crt_no" value="${detail.crt_no}" />
			<input name="crt_date" id="crt_date" type="text" value="${detail.crt_date}" style="width:80px; text-align:center;" readonly/>
			<img src="<c:url value='/images/common/calendar_del.png'/>" id="crt_date_Del" style="cursor: pointer;" onClick='fn_TextClear("crt_date")'/>
		</td>		
	</tr>
	<tr>
		<th>교정기관</th>
		<!--한글우선입력-->
		<td>
			<input name="crt_org" type="text" class="inputhan" value="${detail.crt_org}" style="width:160px;"/>
		</td>
		<th class="indispensable">차기교정일자</th>
		<td>
			<input name="nxt_crt_date" id="nxt_crt_date" type="text" value="${detail.nxt_crt_date}"  style="width:80px; text-align:center;" readonly/>
			<img src="<c:url value='/images/common/calendar_del.png'/>" id="nxt_crt_date_Del" style="cursor: pointer;" onClick='fn_TextClear("nxt_crt_date")'/>
		</td>
	</tr>
	<tr>
		<th class="indispensable">담당자(정)</th>
		<td>
			<input name="mng_id" id="mng_id" type="hidden" value="${detail.mng_id}"/>
			<input name="mng_nm" id="mng_nm" type="text" class="inputhan" value="${detail.mng_nm}" style="width:160px; background-color: #D5D5D5;" readonly="readonly"/>
		</td>
		<th class="indispensable">담당자(부)</th>
		<td>
			<input name="mng_sub_id" id="mng_sub_id" type="hidden" value="${detail.mng_sub_id}"/>
			<input name="mng_sub_nm" id="mng_sub_nm" type="text" class="inputhan" value="${detail.mng_sub_nm}" style="width:160px; background-color: #D5D5D5;" readonly="readonly"/>
		</td>
	</tr>
	<!--  
	<tr>
		<th>교정여부</th>
		<td colspan="3">
			<input type="radio" name="crt_yn" id="crt_yn" style="width: 15px; margin-left: 15px; top: 1px;" value="Y" <c:if test="${detail.crt_yn == 'Y' || detail.crt_yn == '' || detail.crt_yn == null}">checked="checked"</c:if> />
			교정함
			<input type="radio" name="crt_yn" id="crt_yn" style="width: 15px; margin-left: 15px; top: 1px;" value="N" <c:if test="${detail.crt_yn == 'N'}">checked="checked"</c:if> />
			교정안함
		</td>
	</tr>-->
</table>
<%
	/***************************************************************************************
	 * 시스템명 	: 통합장비관제시스템
	 * 업무명 		: 채수장소관리
	 * 파일명 		: samplingPointD01.jsp
	 * 작성자 		: 최은향
	 * 작성일 		: 2015.01.21
	 * 설  명		: 채수장소관리 상세 조회 화면
	 *---------------------------------------------------------------------------------------
	 * 변경일		 변경자		변경내역 
	 *---------------------------------------------------------------------------------------
	 * 2015.01.21    최은향		최초 프로그램 작성         
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
		ajaxCombo("sampling_point_nm", "C02", "${detail.sampling_point_nm}", "", "detail"); // 채수장소
		ajaxCombo("sampling_object", "C29", "${detail.sampling_object}", "", "detail"); 	// 채수대상
		ajaxCombo("facilities_type", "C28", "${detail.facilities_type}", "", "detail"); 	// 시설유형
		ajaxCombo("supply_type", "C33", "${detail.supply_type}", "", "detail"); 			// 급수형태
		ajaxCombo("water_system_d", "C02", "${detail.water_system}", "", "detail"); 		// 정수장수계

		//url명명 규칙(p.21) 
		grid('master/samplingPoint.lims', 'form', 'grid');
	});
</script>
	<table  class="select_table" >
		<tr>
			<td width="20%" class="table_title">
				<span>■</span>
				상세정보
			</td>
			<td class="table_button">
				<span class="button white mlargeg auth_save" id="btn_Insert" onclick="btn_Insert_onclick();">
					<button type="button">저장</button>
				</span>
				<!-- 
				<span class="button white mlarger" id="btn_Delete" onclick="btn_Delete_onclick();">
					<button type="button">삭제</button>
				</span>
				 -->
			</td>
		</tr>
	</table>
<table  class="list_table" >
	<!-- 리스트 width는 th는 10%  td는 15%로 적용-->
	<tr>
		<th>채수장소</th>
		<!--한글우선입력-->
		<td>
			<input name="code" type="hidden" class="inputhan" value="${detail.code}" />
			<input type="hidden" id="sampling_point_no" name="sampling_point_no" value="${detail.sampling_point_no}" />
			<!-- <input name="sampling_point_nm" type="text" class="inputhan" value="${detail.sampling_point_nm}" /> -->
			<input type="text" id="sampling_point_nm" name="sampling_point_nm" value="${detail.sampling_point_nm}"  style="width:160px;"/>
		</td>		
		<th>채수대상</th>
		<!--select필수입력-->
		<td>
			<select name="sampling_object" id="sampling_object" style="width:160px;"></select>
		</td>
		<th>정수장수계</th>
		<!--한글우선입력-->
		<td>
			<select name="water_system" id="water_system_d" style="width:173px;"></select>
<%-- 			<input name="water_system" id="water_system" type="text" class="inputhan" value="${detail.water_system}" style="width:150px;"/> --%>
		</td>		
	</tr>
	
	<tr>
		<th>사업소</th>
		<!--select필수입력-->
		<td>
			<input id="org_nm" name="org_nm" type="text" class="inputhan" value="${detail.org_nm}" style="width:150px;" disabled/>
			<input id="office_cd" name="office_cd" type="hidden" class="inputhan" value="${detail.office_cd}" />
<!-- 			<span class="button white mlargep" onclick="btn_Offices_Insert_onclick('insert');"> -->
				<img style="cursor: pointer; vertical-align: text-bottom;" src="images/common/icon_search.png" class="auth_select" onclick='btn_Pop_SamplingPointChoice()'/>
<!-- 			<button type="button" onclick="btn_Pop_ReqOrgChoice();">사업소 조회</button> -->
<!-- 			</span> -->
		</td>
		<th>시설유형</th>
		<!--한글우선입력-->
		<td>
			<select name="facilities_type" id="facilities_type" style="width:173px;"></select>
			<!-- <input id="facilities_type" name="facilities_type" type="text" class="inputhan" value="${detail.facilities_type}"/> -->
			<%--<input name="facilities_type" type="text" class="inputhan" value="${detail.facilities_type}" /> --%>
		</td>		
		<th>급수형태</th>
		<!--select필수입력-->
		<td>
			<select name="supply_type" id="supply_type" style="width:100px;"></select>
			<!-- <input name="supply_type" type="text" maxlength="4" value="${detail.supply_type}" /> -->
		</td>
	</tr>
	
	<tr>
		<th>코스</th>
		<!--한글우선입력-->
		<td>
			<input name="course_nm" type="text" class="inputhan" value="${detail.course_nm}" style="width:160px;"/>
		</td>
		<th>상호</th>
		<!--한글우선입력-->
		<td>
			<input name="company_nm" type="text" class="inputhan" value="${detail.company_nm}" style="width:150px;"/>
		</td>
		<th>사용여부</th>
		<!--radio 버튼-->
		<td>
			<input type="radio" name="use_flag" id="use_flag" style="width:15px; margin-left: 15px; top: 1px;" value="Y" <c:if test="${detail.use_flag == 'Y' || detail.use_flag == '' || detail.use_flag == null}">checked="checked"</c:if> />
			사용함
			<input type="radio" name="use_flag" id="use_flag" style="width:15px; margin-left: 15px; top: 1px;" value="N" <c:if test="${detail.use_flag == 'N'}">checked="checked"</c:if> />
			사용안함
		</td>		
	</tr>
	
	<tr>
		<th>주소</th>
		<td colspan="5">
			<input name="zip" id="zip_code" type="text" style="width: 80px;" value="${detail.zip}" readonly/>
			<span class="button white mlargeg auth_select" id="btn_Select" onclick="btn_zipcode_onclick();">
				<button type="button">조회</button>
			</span>
			<input style="width: 200px;" name="addr1" id="addr1" type="text" class="inputhan" value="${detail.addr1}" readonly/>
			<input style="width: 300px;" name="addr2" id="addr2" type="text" class="inputhan" value="${detail.addr2}" readonly/>
		</td>
	</tr>
</table>
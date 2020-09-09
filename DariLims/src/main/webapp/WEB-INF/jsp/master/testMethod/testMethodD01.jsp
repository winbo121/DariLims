
<%
	/***************************************************************************************
	 * 시스템명 	: 통합장비관제시스템
	 * 업무명 		: 시험항목별 시험기기
	 * 파일명 		: testMethodD01.jsp
	 * 작성자 		: 석은주
	 * 작성일 		: 2015.01.23
	 * 설  명		: 시험항목별 시험기기 목록 조회 화면
	 *---------------------------------------------------------------------------------------
	 * 변경일		 변경자		변경내역 
	 *---------------------------------------------------------------------------------------
	 * 2015.01.23    석은주		최초 프로그램 작성         
	 * 
	 *---------------------------------------------------------------------------------------
	 ****************************************************************************************/
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html >
<link rel="stylesheet" media="screen" type="text/css" href="<c:url value='/css/common/sub.css'/>" />
<div class="sub_blue_01">
	<table  class="select_table" >
		<tr>
			<td width="20%" class="table_title">
				<span>■</span>
				상세정보
			</td>
			<td class="table_button" style="text-align: right; padding-right: 30px;">
				<span class="button white mlargeg auth_save" id="btn_Insert" onclick="btn_Insert_onclick();">
					<button type="button">저장</button>
				</span>
			</td>
		</tr>
	</table>
</div>
<table class="list_table" >
	<!-- 리스트 width는 th는 10%  td는 15%로 적용-->
	<tr>
		<th class="indispensable">시험방법명</th>
		<!--한글우선입력-->
		<td>
			<input type="hidden" id="test_method_no" name="test_method_no" value="${detail.test_method_no }" />
			<textarea id="test_method_nm" name="test_method_nm" rows="1" style="width: 80%" >${detail.test_method_nm }</textarea>
<%-- 			<input name="test_method_nm" id="test_method_nm" type="text" class="inputhan" value="${detail.test_method_nm }" /><br/>
			<input type="text" style="width:90%; border:none; color:#FF0000 !important;" readonly value="※ 위첨자 : <sup>첨자</sup>, 아래첨자 : <sub>첨자</sub>" > 
			<input type="text" style="width:90%; border:none; color:#FF0000 !important;" readonly value="※ 줄바꿈 : <br>" >  --%>
		</td>
		<th>인용규격</th>
		<td>
			<input name="quot_std" id="quot_std" type="text" class="inputhan" value="${detail.quot_std }" />
		</td>
		<th>장비및조건</th>
		<!--한글우선입력-->
		<td>
			<input name="condition" id="condition" type="text" class="inputhan" value="${detail.condition }" />
		</td>
	</tr>
	<tr>
		<th>시험지침서명</th>
		<!--한글우선입력-->
		<td>
			<input name="guide_nm" type="text" class="inputhan" value="${detail.guide_nm }" />
		</td>
		<th>문서명</th>
		<!--한글우선입력-->
		<td>
			<input name="doc_nm" type="text" class="inputhan" value="${detail.doc_nm }" />
		</td>
		<th class="indispensable">사용여부</th>
		<!--input필수입력-->
		<td>
			<input type="radio" name="use_flag" id="use_flag" style="margin-left: 15px; top: 1px;" class="w15" value="Y" <c:if test="${detail.use_flag == 'Y' || detail.use_flag == null || detail.use_flag == ''}">checked="checked"</c:if> />
			사용
			<input type="radio" name="use_flag" id="use_flag" style="margin-left: 15px; top: 1px;" class="w15" value="N" <c:if test="${detail.use_flag == 'N' }">checked="checked"</c:if> />
			사용안함
		</td>
	</tr>
	<tr>
		<th>첨부파일</th> 
		<!-- 파일형식 -->
		<td colspan="5">
			<input id="file_nm" name="file_nm" type="hidden" value="${detail.file_nm }" />
			<c:if test="${detail.file_nm == null ||  detail.file_nm == ''}">
				<label id="file_name">첨부파일이 없습니다.</label>
			</c:if>
			<c:if test="${detail.file_nm != null && detail.file_nm != ''}">
				<label id="file_name"><a href="master/testMethodDown.lims?test_method_no=${detail.test_method_no }">${detail.file_nm }</a></label>
				<img src="<c:url value='/images/common/icon_stop.png'/>" id="clear_add_file" style="cursor: pointer;" onClick='fn_LabelClear("file_name"), fn_TextClear("m_file"), fn_TextClear("file_nm")' />
			</c:if>
			<input name="m_file" id="m_file" type="file" />
		</td>
	</tr>	
	<tr>
		<th>전처리</th>
		<td colspan="6" style="padding: 0px;">
			<textarea id="test_method_preclean" name="test_method_preclean" rows="5" style="width: 100%" >${detail.test_method_preclean }</textarea>
		</td>
	</tr>
	<tr>
		<th>시험방법</th>
		<td colspan="6" style="padding: 0px;">
			<textarea id="test_method_content" name="test_method_content" rows="5" style="width: 100%" >${detail.test_method_content }</textarea>
		</td>
	</tr>
</table>
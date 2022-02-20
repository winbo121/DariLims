
<%
	/***************************************************************************************
	 * 시스템명 	: 통합장비관제시스템
	 * 업무명 		: 자유공유 게시판
	 * 파일명 		: freeBoardD02.jsp
	 * 작성자 		: 최은향
	 * 작성일 		: 2015.03.19
	 * 설  명		: 자유공유 게시판 상세 조회 화면
	 *---------------------------------------------------------------------------------------
	 * 변경일		 변경자		변경내역 
	 *---------------------------------------------------------------------------------------
	 * 2015.03.19    최은향		최초 프로그램 작성         
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
		
	});
</script>

<table  class="select_table" >
	<tr>
		<td width="20%" class="table_title">
			<span>■</span>
			상위 게시글
		</td>
		<td class="table_button">
		</td>
	</tr>
</table>
<table  class="list_table" >
	<c:if test="${PreDetail.creater_id != null &&  PreDetail.creater_id != ''}">
	<tr>
		<th style="min-width:120px;">작성자</th>
		<td>
			${PreDetail.creater_id}
		</td>
		<th style="min-width:120px;">작성일</th>
		<td>
			${PreDetail.create_date}
		</td>
	</tr>
	</c:if>
	<tr>
		<th style="min-width:120px;">제목</th>
		<td colspan="3">
			${PreDetail.title}
		</td>
	</tr>	
	<tr>
		<th class="list_table_p">내용</th>
		<td colspan="3">
			<textarea rows="5" style="width: 80%;" name="" class="" readonly>${PreDetail.contents}</textarea>
		</td>
	</tr>
	<tr>
		<th>첨부파일</th>
		<!-- 파일형식 -->
		<td colspan="3">
			<c:if test="${PreDetail.file_nm == null ||  PreDetail.file_nm == ''}">
				<label id="file_name">첨부파일이 없습니다.</label>
			</c:if>
			<c:if test="${PreDetail.file_nm != null && PreDetail.file_nm != ''}">
				<label id="file_name"><a href="system/boardDown.lims?board_no=${PreDetail.board_no}">${PreDetail.file_nm}</a></label>
			</c:if>
		</td>
	</tr>
</table>


<table  class="select_table" >
	<tr>
		<td width="20%" class="table_title">
			<span>■</span>
			덧글
		</td>
		<td class="table_button">
			<!-- 
			<span class="button white mlargeg auth_save" id="btn_Sub_Add" onclick="fn_Sub_ViewPage('insert');">
					<button type="button">덧글쓰기</button>
			</span>
			 -->
			<span class="button white mlargeg auth_save" id="btn_Insert" onclick="btn_Insert_onclick('sub');">
				<button type="button">저장</button>
			</span>
			<span class="button white mlarger auth_save" id="btn_Sub_Delete" onclick="btn_Delete_onclick();">
				<button type="button">삭제</button>
			</span>
		</td>
	</tr>
</table>
<table  class="list_table" >
	<c:if test="${detail.creater_id != null &&  detail.creater_id != ''}">
	<tr>
		<th style="min-width:120px;">작성자</th>
		<td>
			${detail.creater_id}
		</td>
		<th style="min-width:120px;">작성일</th>
		<td>
			${detail.create_date}
		</td>
	</tr>
	</c:if>
	<tr>
		<th style="min-width:120px;">제목</th>
		<td colspan="3">
			<input type="hidden" id="pre_board_no" name="pre_board_no" value="${detail.pre_board_no}" class="w120px">
			<input type="hidden" id="board_no" name="board_no" value="${detail.board_no}" class="w120px">
			<input type="text" id="title" name="title" value="${detail.title}" class="w300px">
		</td>
	</tr>	
	<tr>
		<th class="list_table_p">내용</th>
		<td colspan="3">
			<textarea rows="5" style="width: 80%;" name="contents" id="contents_detail" class="inputhan">${detail.contents}</textarea>
		</td>
	</tr>
</table>
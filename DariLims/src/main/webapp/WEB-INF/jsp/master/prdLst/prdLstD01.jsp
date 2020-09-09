<%
	/***************************************************************************************
	 * 시스템명 	: 통합장비관제시스템
	 * 업무명 		: 품목관리
	 * 파일명 		: prdLstD01.jsp
	 * 작성자 		: 윤상준
	 * 작성일 		: 2015.12.30
	 * 설  명		: 품목상세 화면
	 *---------------------------------------------------------------------------------------
	 * 변경일		변경자		변경내역 
	 *---------------------------------------------------------------------------------------
	 * 2015.12.30    윤상준		최초 프로그램 작성  
	 *---------------------------------------------------------------------------------------
	 ****************************************************************************************/
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html >
<script type="text/javascript" src="<c:url value='/script/lims.com.account.js'/>"></script>
<link rel="stylesheet" media="screen" type="text/css" href="<c:url value='/css/common/sub.css'/>" />
<script type="text/javascript">
	
	$(function() {

		ajaxComboForm("charger_dept_cd", "", "${detail.charger_dept_cd}", null, 'prdlstDetailForm');

		$('#prdlstDetailForm').find("#charger_dept_cd").change(function() {
			ajaxComboForm("charger_user_id", $('#prdlstDetailForm').find("#charger_dept_cd").val(), "CHOICE", "", 'prdlstDetailForm');
		});

		ajaxComboForm("charger_user_id", $('#prdlstDetailForm').find("#charger_dept_cd").val(), "${detail.charger_user_nm}", "", 'prdlstDetailForm');		
		ajaxComboForm("htrk_prdlst_cd", "CP1", "${detail.htrk_prdlst_cd}", "", "prdlstDetailForm");
	});

	function btn_Save_Sub1(){
		var url;
		
		if(formValidationCheck("prdlstDetailForm")){
			return;
		}

		<c:choose>								
			<c:when test="${pageType eq 'detail'}">
				url = 'master/updatePrdlst.lims';
			</c:when>
			<c:otherwise>
		 		url = 'master/insertPrdlst.lims';
			</c:otherwise>
		</c:choose>
		
		if (confirm("저장하시겠습니까?")) {
			var json = fnAjaxAction(url, $('#prdlstDetailForm').serialize());
			if (json == null) {
				alert('저장 실패되었습니다.');
			} else {
				alert('저장이 완료되었습니다.');
				$('#gridMain').trigger('reloadGrid');
				$("#detailDiv").empty();
			}
		}
		
	}

</script>

<form id="prdlstDetailForm" name="prdlstDetailForm" onsubmit="return false;">
<input type="hidden" id="pageType" name="pageType" value="${pageType}">
<input name="prdlst_cd" type="hidden" value="${detail.prdlst_cd}"/>
<input name="kfda_yn" type="hidden" value="${detail.kfda_yn}"/>
	<div class="sub_purple_01">
		<table  class="select_table" >
			<tr>
				<td class="table_title">
					<span>■</span>
					품목 등록
				</td>
				<td class="table_button">
						<span class="button white mlargeb auth_save" id="btn_Save_Sub1" onclick="btn_Save_Sub1()">
							<button type="button">저장</button>
						</span>
				</td>
			</tr>
		</table>

		<table  class="list_table" >
			<tr>
				<th class="indispensable">품목분류</th>
				<td>
					<select name="htrk_prdlst_cd" id="htrk_prdlst_cd" class="inputCheck" <c:if test="${detail.kfda_yn eq 'Y'}">disabled</c:if>></select>
				</td>
				<th class="indispensable">품목한글명</th>
				<td>
					<input name="kor_nm" type="text" class="inputCheck" value="${detail.kor_nm}" <c:if test="${detail.kfda_yn eq 'Y'}">disabled</c:if>/>
				</td>
				<th class="">품목영문명</th>
				<td>
					<input name="eng_nm" type="text" class="" value="${detail.eng_nm}" <c:if test="${detail.kfda_yn eq 'Y'}">disabled</c:if>/>
				</td>				
			</tr>
			<tr>
<%-- 				<th class="">담당자</th>
				<td colspan="3">
					<select name="charger_dept_cd" id="charger_dept_cd" class="w200px" value="${detail.charger_dept_cd}"></select>
					<select name="charger_user_id" id="charger_user_id" class="w200px" value="${detail.charger_user_id}"></select>
				</td> --%>
				<th>품목여부</th>
				<td>
					${detail.prdlst_yn}
				</td>
				<th class="">조합품목여부</th>
				<td>
					${detail.mxtr_prdlst_yn}
				</td>
			</tr>
			<tr height="55">
				<th>정의</th>
				<td colspan="3">
					<textarea name="dfn" id="dfn" class="w100p" id="" rows="3" <c:if test="${detail.kfda_yn eq 'Y'}">disabled</c:if>>${detail.dfn}</textarea>
				</td>
				<th>비고</th>
				<td>
					<textarea name="rm" id="rm" class="w100p" id="" rows="3" <c:if test="${detail.kfda_yn eq 'Y'}">disabled</c:if>>${detail.rm}</textarea>
				</td>		
			</tr>
			<tr>
				<th class="">최종수정일</th>
				<td colspan="3">
					${detail.last_updt_dtm}
				</td>
				<th class="indispensable">사용여부</th>
				<td>
					<label><input type='radio' name='use_yn' value='Y' style="width: 20px" <c:if test="${detail.kfda_yn eq 'Y'}">disabled</c:if> <c:if test="${detail.use_yn != 'N'}">checked="checked"</c:if>/>사용</label> 
					<label><input type='radio' name='use_yn' value='N' style="width: 20px" <c:if test="${detail.kfda_yn eq 'Y'}">disabled</c:if> <c:if test="${detail.use_yn == 'N'}">checked="checked"</c:if>/>미사용</label>
				</td>
			</tr>
		</table>
	</div>
	
</form>

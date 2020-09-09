
<%
	/***************************************************************************************
	 * 시스템명 	: 통합장비관제시스템
	 * 업무명 		: 시험항목
	 * 파일명 		: testItemD01.jsp
	 * 작성자 		: 진영민
	 * 작성일 		: 2015.01.22
	 * 설  명		: 
	 *---------------------------------------------------------------------------------------
	 * 변경일		 변경자		변경내역 
	 *---------------------------------------------------------------------------------------
	 * 2015.01.22    진영민		최초 프로그램 작성         
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
		
		ajaxComboForm("testitm_lclas_cd", "", "${detail.testitm_lclas_cd}", "", "detail"); // 항목 대분류
		ajaxComboForm("testitm_mlsfc_cd", "${detail.testitm_lclas_cd}", "${detail.testitm_mlsfc_cd}", "", "detail"); // 항목 대분류
//		ajaxComboForm("oxide_cd", "${detail.oxide_cd}", "${detail.oxide_cd}", "", "detail" ); //산화물관리

		$('#detail').find('#selFee').click(function() {
			fnFee();
		});
	});

	function fnDetailLclasChange(obj){
		ajaxComboForm("testitm_mlsfc_cd", obj.value, "CHOICE", "", "detail"); // 항목 중분류
	}
	
	

<c:if test="${detail.kfda_yn ne 'Y'}">
	function btn_Save_Sub1_onclick() {
		var url;
		
		if(formValidationCheck("detail")){
			return;
		}
		
		if ($('#detail').find('#test_item_cd').val() == '') {
			url = 'master/insertTestItem.lims';
			var rowId = $('#testItemGrid').getGridParam('selrow');
			$('#detail').find('#repre_test_item_cd').val(rowId);
		} else {
			url = 'master/updateTestItem.lims';
		}
		
	//	var oxide_cd = $('#detail').find('#oxide_cd').val();
		var data = $('#detail').serialize() ;

		var json = fnAjaxAction(url, data);
		if (json == null) {
			$.showAlert('저장 실패되었습니다.');
		} else {
			$('#testItemGrid').trigger('reloadGrid');
			$.showAlert('저장이 완료되었습니다.');
			$("#detailDiv").empty();
		}
	}
</c:if>
	
	function fnFee() {
		if ($('#detail').find('#selFee').is(":checked")) {
			var ret = btn_Fee_onclick(2);
			if (ret != null && ret != '') {
				var arr = ret.split('◆★◆');
				$('#detail').find('#fee_group_no').val(arr[0]);
				$('#detail').find('#fee_group_nm').text(' : ' + arr[1]);
				$('#detail').find('#fee').val(arr[2]);
				$('#detail').find('#fee').attr('readonly', true);
			}
			$('#detail').find('#fee_group_nm').show();
		} else {
			$('#detail').find('#fee_group_no').val('');
			$('#detail').find('#fee_group_nm').text('');
			$('#detail').find('#fee').attr('readonly', false);
			$('#detail').find('#fee_group_nm').hide();
		}
	}
</script>

<form id="detail" name="detail" onsubmit="return false;">
<input type="hidden" id="test_item_cd" name="test_item_cd" value="${detail.test_item_cd}">
	<div class="sub_purple_01">
		<table  class="select_table" >
			<tr>
				<td width="20%" class="table_title">
					<span>■</span>
					상세정보
				</td>
				<td class="table_button" style="text-align: right; padding-right: 30px;">
					<c:if test="${detail.kfda_yn ne 'Y'}">
						<span class="button white mlargeg auth_save" id="btn_Save" onclick="btn_Save_Sub1_onclick();">
							<button type="button">저장</button>
						</span>
					</c:if>
				</td>
			</tr>
		</table>
		<table  class="list_table" >
			<!-- 리스트 width는 th는 10%  td는 15%로 적용-->
			<tr>
				<th class="indispensable">항목대분류</th>
				<td>
					<select id="testitm_lclas_cd" name="testitm_lclas_cd" class="w200px inputCheck" onchange="fnDetailLclasChange(this)" <c:if test="${detail.kfda_yn eq 'Y'}">disabled</c:if>></select>
				</td>
				<th class="indispensable">항목중분류</th>
				<td>
					<select id="testitm_mlsfc_cd" name="testitm_mlsfc_cd" class="w200px inputCheck" <c:if test="${detail.kfda_yn eq 'Y'}">disabled</c:if>></select>
				</td>
			</tr>
			<tr>
				<th class="indispensable">항목명</th>
				<td>
					<input name="test_item_nm" type="text" class="inputCheck w300px" value="${detail.test_item_nm}" <c:if test="${detail.kfda_yn eq 'Y'}">disabled</c:if>/><br/>
					<input type="text" style="width:90%; border:none; color:#FF0000 !important;" readonly value="※ 위첨자 : <sup>첨자</sup>, 아래첨자 : <sub>첨자</sub>" > <br/>
					<input type="text" style="width:90%; border:none; color:#FF0000 !important;" readonly value="※ 줄바꿈 : <br>" > 
				</td>
				<th>항목영문명</th>
				<td>
					<input name="test_item_eng_nm" type="text" class="w300px" value="${detail.test_item_eng_nm}" <c:if test="${detail.kfda_yn eq 'Y'}">disabled</c:if>/><br/>
					<input type="text" style="width:90%; border:none; color:#FF0000 !important;" readonly value="※ 위첨자 : <sup>첨자</sup>, 아래첨자 : <sub>첨자</sub>" > <br/>
					<input type="text" style="width:90%; border:none; color:#FF0000 !important;" readonly value="※ 줄바꿈 : <br>" > 
				</td>
			</tr>
			<tr>
				<th>이명</th>
				<td>
					<input name="ncknm" type="text" class="w200px" value="${detail.ncknm}" <c:if test="${detail.kfda_yn eq 'Y'}">disabled</c:if>/>
				</td>
				<th>약어</th>
				<td>
					<input name="abrv" type="text" class="w100px" value="${detail.abrv}" <c:if test="${detail.kfda_yn eq 'Y'}">disabled</c:if>/>
				</td>
			</tr>
			<tr>
				<th>원소의 파장</th>
				<td>
					<input name="testitm_wave"  type="text" class="w200px" value="${detail.testitm_wave}" <c:if test="${detail.testitm_wave eq 'Y'}">disabled</c:if>/>
				</td>
				<th class="indispensable">사용 여부</th>
				<td>
					<input type="radio" name="use_flag" id="use_flag" style="margin-left: 15px; top: 1px;" class="w15" value="Y" <c:if test="${detail.use_flag != 'N' }">checked="checked"</c:if> <c:if test="${detail.kfda_yn eq 'Y'}">disabled</c:if>/>
					사용
					<input type="radio" name="use_flag" id="use_flag" style="margin-left: 15px; top: 1px;" class="w15" value="N" <c:if test="${detail.use_flag == 'N' }">checked="checked"</c:if> <c:if test="${detail.kfda_yn eq 'Y'}">disabled</c:if>/>
					사용안함
				</td>	
			<tr>
				<th>최종수정일</th>
				<td colspan = "3">
					${detail.last_updt_dtm}
				</td>
			</tr>
		</table>
	</div>
	
</form>

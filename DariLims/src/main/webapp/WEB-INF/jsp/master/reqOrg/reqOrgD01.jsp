<%
	/***************************************************************************************
	 * 시스템명 	: 통합장비관제시스템
	 * 업무명 		: 업체관리
	 * 파일명 		: reqOrgD01.jsp
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
<script type="text/javascript">
	// 저장(신규, 수정) 버튼 클릭 이벤트
	function btn_Insert_onclick() {
		if (!saveValidation())
			return;
		
		var id = $('#regOrgForm').find('#req_org_no').val();
		var pac_zip_code = $('#pacForm').find('#pac_zip_code').val()
		var pac_addr1 = $('#pacForm').find('#pac_addr1').val()
		var pac_addr2 = $('#pacForm').find('#pac_addr2').val()
		
		
		var param = $('#regOrgForm').serialize() + '&pac_zip_code=' + pac_zip_code+ '&pac_addr1=' + pac_addr1+ '&pac_addr2=' + pac_addr2 ;
		var url = '';
		if (id == '') {
			url = 'master/insertReqOrg.lims';
		} else {
			url = 'master/updateReqOrg.lims';
		}		
		var json = fnAjaxAction(url, param);
	

		if (json == null) {
			$.showAlert("저장 실패하였습니다.");
		} else {
			btn_Search_onclick();
			$.showAlert("", {
				type : 'insert'
			});
		}
		
	}
	
	// 주소 팝업
	function fn_zipcode(grid){
		fnpop_zipCodePop(grid, '800', '500');
		fnBasicStartLoading();
	}	
</script>

<div class="sub_blue_01 w100p">
	<table class="select_table">
		<tr>
			<td class="table_title">
				<span>■</span>
				업체상세정보
			</td>
			<td class="table_button">				
				<span class="button white mlargeg auth_save" id="btn_Insert" onclick="btn_Insert_onclick();">
					<button type="button">저장</button>
				</span>
				<span class="button white mlarger" id="btn_Delete" onclick="btn_Delete_onclick();">
					<button type="button">삭제</button>
				</span>
			</td>
		</tr>
	</table>
	<form id="regOrgForm" name="regOrgForm" onsubmit="return false;">
		<table class="list_table">
			<!-- 리스트 width는 th는 10%  td는 15%로 적용-->
			<tr>
				<th style="min-width: 150px;" class="indispensable">기관/업체/의뢰인명</th>
				<td>
					<input type="hidden" id="req_org_no" name="req_org_no" value="${detail.req_org_no }">
					<input name="org_nm" id="org_nm" type="text" class="" value="${detail.org_nm }" />
				</td>
				<th class="indispensable">업체구분</th>
				<td style="min-width: 200px;">
					<input type="hidden" id="org_type_val" value="${detail.org_type }">
					<select id="org_type" name="org_type" class="w200px"></select>
				</td>
				<th rowspan="12">기타</th>
				<td rowspan="12">
					<textarea style="width: 98%;" rows="20" name="org_desc" class="inputhan">${detail.org_desc }</textarea>
				</td>
			</tr>
			<tr>
				<th>업태</th>
				<td>
					<input name="bsnsc" type="text" class="" value="${detail.bsnsc }" />
				</td>
				<th>종목</th>
				<td>
					<input name="item" type="text" class="" value="${detail.item }" />
				</td>	
			</tr>
			<tr>
				<th>법인번호</th>
				<td>
					<input name="cor_no" type="text" class="" value="${detail.cor_no }" />
				</td>
				<th>사업자번호</th>
				<td>
					<input name="biz_no1" type="text" class="w80px" maxlength="3"  value="${detail.biz_no1 }" />-
					<input name="biz_no2" type="text" class="w50px" maxlength="2"  value="${detail.biz_no2 }" />-
					<input name="biz_no3" type="text" class="w100px" maxlength="5" value="${detail.biz_no3 }" />
				</td>	
			</tr>
			<tr>		
				<th>목재생산업 종류</th>
				<td>
					<input name="wooden_type" type="text" value="${detail.wooden_type}"/>
				</td>
				<th>목재생산업 등록번호</th>
				<td>
					<input name="biz_wooden" type="text" value="${detail.biz_wooden}" />
				</td>
			</tr>
			<tr>
				<th>담당자 성명</th>
				<td>
					<input name="charger" type="text" class="inputhan" value="${detail.charger }" />
				</td>
				<th>대표자명</th>
				<td>
					<input name="pre_man" type="text" class="inputhan" maxlength="100"  value="${detail.pre_man }" />					
				</td>

			</tr>
			<tr>
				<th>담당자 전화번호</th>
				<td>
					<input name="charger_tel" type="text" class="" value="${detail.charger_tel }" />
				</td>
				<th>대표전화</th>
				<td>
					<input name="pre_tel_num" type="text" class="" value="${detail.pre_tel_num }" />
				</td>

			</tr>
			<tr>				
				<th>담당자 이메일</th>
				<td>
					<input name="email" type="text" class="" value="${detail.email }" />
				</td>
				<th>팩스번호</th>
				<td>
					<input name="pre_fax_num" type="text" class="" value="${detail.pre_fax_num }" />
				</td>
				
	<%-- 		<th>ㅤ</th>
				<td> </td>	
	 --%>
			</tr>
			<tr>
				<th>결제담당자명</th>
				<td>
					<input name="pay_nm" type="text" class="" value="${detail.pay_nm}" />
 				</td>
				<th>결제담당자 번호</th>
				<td>
					<input name="pay_tel" type="text" class="" value="${detail.pay_tel}" />
 				</td>
			</tr>
			<tr>
				<th>결제담당자 이메일</th>
				<td>
					<input name="pay_email" type="email" class="" value="${detail.pay_email}" />
 				</td>
				<th>업체영문명</th>
				<td> 
					<input name="eng_nm" type="text" class="" value="${detail.eng_nm}" />
				</td>	
			</tr>
			<tr>
				<th>본사 주소</th>
				<td colspan="3">
					<input name="zip_code" id="zip_code" type="text" style="width: 80px;" value="${detail.zip_code }" />
					<img style="vertical-align: text-bottom;" src="images/common/icon_search.png" class="auth_select" id="btn_Req_Org" onclick="fn_zipcode('regOrgForm');">
					<input style="width: 200px;" name="addr1" id="addr1" type="text" class="inputhan" value="${detail.addr1 }" />
					<input style="width: 350px;" name="addr2" id="addr2" type="text" class="inputhan" value="${detail.addr2 }" />
				</td>										
			</tr>	
		</table>
	</form>
	<form id="pacForm" name="pacForm" onsubmit="return false;">
		<table class="list_table" style="border-top:solid 0px #82bbce;">
			<tr>
				<th style="min-width: 150px;" >성적서발송 주소</th>
				<td colspan="3">
					<input name="pac_zip_code" id="pac_zip_code" type="text" style="width: 80px;" value="${detail.pac_zip_code }" />
					<img style="vertical-align: text-bottom;" src="images/common/icon_search.png" class="auth_select" id="btn_Req_Org" onclick="fn_zipcode('pacForm');">
					<input style="width: 200px;" name="pac_addr1" id="pac_addr1" type="text" class="inputhan" value="${detail.pac_addr1 }" />
					<input style="width: 350px;" name="pac_addr2" id="pac_addr2" type="text" class="inputhan" value="${detail.pac_addr2 }" />
				</td>										
			</tr>
			<input type="hidden" id="req_org_no" name="req_org_no">
		</table>
	</form> 
</div>
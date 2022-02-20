
<%
	/***************************************************************************************
	 * 시스템명 	: 통합장비관제시스템
	 * 업무명 		: 사용자관리
	 * 파일명 		: userD01.jsp
	 * 작성자 		: 윤상준	
	 * 작성일 		: 2015.08.20
	 * 설  명		: 사용자관리 상세 조회 화면
	 *---------------------------------------------------------------------------------------
	 * 변경일		 변경자		변경내역 
	 *---------------------------------------------------------------------------------------
	 * 2015.08.20    윤상준		최초 프로그램 작성         
	 * 
	 *---------------------------------------------------------------------------------------
	 ****************************************************************************************/
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" media="screen" type="text/css" href="<c:url value='/css/common/sub.css'/>" />
<style></style>
<script type="text/javascript">
	$(function() {
		ajaxComboForm("dept_cd", "", "${detail.dept_cd }", null, 'userDetailForm'); // 부서
		//채원 : pageType값이 늦게 들어와서 이렇게 해놓음
		setTimeout(function() {
			if(!fnIsEmpty($('#userDetailForm #pageType').val())){  //pageType이 false면 readonly
				$("#user_id").attr("readonly",true); 
			}else{
				$("#user_id").attr("readonly",false); 
			}   
		}, 30);
	});	
		
	// 저장 & 수정 이벤트
	function btn_save_onclick() {
		if(formValidationCheck("userDetailForm")){
			return;
		}
		if (confirm("저장하시겠습니까?")) {
			var url ;
			if (fnIsEmpty($('#userDetailForm').find('#pageType').val())){
				url = 'system/insertUserInfo.lims';
			} else {
			 	url = 'system/updateUserInfo.lims';
			}
			//alert(encodeURI($('#userDetailForm').serialize()));
 			var json = fnAjaxAction(url, $('#userDetailForm').serialize());
			if (json == null) {
				$.showAlert('저장 실패되었습니다.');
			} else {
				$('#userLimsGrid').trigger('reloadGrid');
				$('#detailDiv').empty();
				$.showAlert('저장이 완료되었습니다.');
			}
		}
	}
	
	/* 
	* 2019-09-02 정언구
	* 사인 등록 팝업
	*/
	function btn_Sign_File_onclick() {
		
		var user_id = "${detail.user_id}";
		if( !user_id ){
			alert('저장되지 않은 사용자는 사인을 등록할 수 없습니다');
			return false;
		}
		
		var url = "system/popUserSign.lims?userId=${detail.user_id}";
		var option = "toolbar=no, location=no, menubar=no, scrollbars=yes, status=no, resizable=yes, top=50%, left=50%, width=" + 500 + 'px, height=' + 170 +'px' ;
		window.open(url, "★●★" + user_id, option);
	}
	function getReport_class_codeData(data){
		
		var dataArray=data.split("|");
		
		for(var i=0; i<dataArray.length; i++){
		
			if(dataArray[i]=='E'){				
				$('#report_class_code1').attr("checked", true)
			}
			else if(dataArray[i]=='F'){
				$('#report_class_code2').attr("checked", true)
			}
			else if(dataArray[i]=='K'){
				$('#report_class_code3').attr("checked", true)
			}
			else if(dataArray[i]=='D'){
				$('#report_class_code4').attr("checked", true)
			}
		}
		
		
	}
	
</script>

<div>
<form id="userDetailForm" name="userDetailForm" onsubmit="return false;">
<input type="hidden" id="pageType" name="pageType" value="${pageType}"/>
<table class="select_table">
	<tr>
		<td class="table_title">  
			<span style="font-size: 11px; margin-left: 15px; color: #27aeea;">■</span>
			사용자 정보
		</td>
		<td class="table_button" >
			<span class="button white mlargeg auth_save" id="btn_Add" onclick="btn_save_onclick();">
				<button type="button">저장</button>
			</span>
		</td>
	</tr>
</table>
<table class="list_table" >
	<tr>
		<th class="indispensable" >사용자명</th>
		<td>
			<input id="user_nm" name="user_nm" class="w200px inputCheck inputhan" type="text" value="${detail.user_nm}" />
		</td>
		<th class="indispensable" >사용자아이디</th>
		<td>
			<input id="user_id" name="user_id" class="w200px inputCheck" type="text"  value="${detail.user_id}" />
		</td>
		<th class="indispensable" >사용자영문명</th>
		<td>
			<input id="user_eng_nm" name="user_eng_nm" class="w200px inputCheck" type="text"  value="${detail.user_eng_nm}" />
		</td>

	</tr>
	<tr>
		<th class="indispensable">부서명</th>
		<td>
			<select id="dept_cd" name="dept_cd" class="w200px inputCheck"></select>
		</td>
		<th>직급</th>
		<td>
			<input id="rank_nm" name="rank_nm" class="w200px" type="text" class="" value="${detail.rank_nm }" />
		</td>
		<th class="indispensable">비밀번호</th>
		<td>
			<input id="user_pw" name="user_pw" class="w200px inputCheck" type="password"  value="${detail.user_pw}" />
		</td>

	</tr>
	<tr>
		<th >핸드폰번호</th>
		<td>
			<input id="mobile_phone" name="mobile_phone" class="w200px" type="text" class="" value="${detail.mobile_phone }" />
		</td>
		<th>이메일주소</th>
		<td>
			<input id="email_addr" name="email_addr" type="text" class="w200px" value="${detail.email_addr}" />
		</td>
		<th>사무실번호</th>
		<td>
			<input id="office_tel_num" name="office_tel_num" class="w200px" type="text" class="" value="${detail.office_tel_num }" />
		</td>

	</tr>
	<tr>
		<th>사인</th>
		<td>
			<span class="button white mlargep auth_save" id="insertSampleBtn" onclick="btn_Sign_File_onclick();">
				<button type="button">등록</button>
			</span>
			<span id="userSignFileName"><a href='system/downloadSignFile.lims?user_id=${detail.user_id}'>${detail.file_name}</a></span>
		</td>
		<th class="indispensable">사용여부</th>
		<td colspan = "3">
			<input type="radio" name="use_flag" id="use_flag" style="margin-left: 15px; top: 1px;" class="w15 inputCheck" value="Y"  <c:if test="${detail.use_flag == 'Y'}">checked="checked"</c:if> />
			사용함
			<input type="radio" name="use_flag" id="use_flag" style="margin-left: 15px; top: 1px;" class="w15 inputCheck" value="N"  <c:if test="${detail.use_flag != 'Y'}">checked="checked"</c:if> />
			사용안함
		</td>
	</tr>
	
	<tr>
	<th>의뢰분류</th>
	<td colspan='5'>
	 <label><input type="checkbox" id="report_class_code1" name="report_class_code" value="E"> [고형연료]</label>
     <label><input type="checkbox" id="report_class_code2" name="report_class_code" value="F"> [검사]</label>
     <label><input type="checkbox" id="report_class_code3" name="report_class_code" value="K"> 코라스성적서</label>
     <label><input type="checkbox" id="report_class_code4" name="report_class_code" value="D"> 일반성적서</label>
	</td>
	</tr>
</table>
</form>
</div>

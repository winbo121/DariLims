
<%
	/***************************************************************************************
	 * 시스템명 	: 통합장비관제시스템
	 * 업무명 		: 시료폐기관리 상세
	 * 파일명 		: sampleDisuseD01.jsp
	 * 작성자 		: 최은향
	 * 작성일 		: 2015.09.30
	 * 설  명		: 시료폐기관리 상세 조회 화면
	 *---------------------------------------------------------------------------------------
	 * 변경일		 변경자		변경내역 
	 *---------------------------------------------------------------------------------------
	 * 2015.09.30    최은향		최초 프로그램 작성         
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
		fnDatePickerImg('disuse_date');	
	});
	
	// 사용자 추가 팝업
	function fnpop_UserInfo(user){		
		fnBasicStartLoading();		
		fnpop_UserInfoPop("disuseDetail", "500", "500", user, '');

	}
	
	//일괄입력
	function btn_insertDisuse_onclick() {
		var grid = 'disuseGrid';
		var ids = $('#' + grid).jqGrid("getDataIDs");
		var rowCnt = 0;
		
		


		for ( var i in ids) {
			var row = $('#' + grid).getRowData(ids[i]);
			if (row.chk == 'Yes') {
				rowCnt++;
			}
		}

		if (rowCnt == 0) {
			alert("선택된 항목이 없습니다.");
			return;
		} else {
			var disuse_date = $('#disuseDetailForm').find('#disuse_date').val();
			var recipient_id = $('#disuseDetailForm').find('#recipient_id').val();
			var sender_id = $('#disuseDetailForm').find('#sender_id').val();
			var recipient_nm = $('#disuseDetailForm').find('#recipient_nm').val();
			var sender_nm = $('#disuseDetailForm').find('#sender_nm').val();
			var etc = $('#disuseDetailForm').find('#etc').val();
			var disuse_flag = $(":input:radio[name=disuse_flag]:checked").val()  
			
			if (disuse_date == null || disuse_date == "") {
				alert("입력된 결과값이 없습니다.");
 				$('#disuseDetailForm').find('#disuse_date').focus(); 
			
			} else {
				var nids = $('#' + grid).jqGrid("getDataIDs");
				for ( var j in nids) {
					var nrow = $('#' + grid).getRowData(nids[j]);
					if (nrow.chk == 'Yes') {
						$('#' + grid).jqGrid('setCell', ids[j], 'disuse_date', disuse_date);
						$('#' + grid).jqGrid('setCell', ids[j], 'recipient_id', recipient_id);
						$('#' + grid).jqGrid('setCell', ids[j], 'sender_id', sender_id);
						$('#' + grid).jqGrid('setCell', ids[j], 'recipient_nm', recipient_nm);
						$('#' + grid).jqGrid('setCell', ids[j], 'sender_nm', sender_nm);
						$('#' + grid).jqGrid('setCell', ids[j], 'etc', etc);
 						$('#' + grid).jqGrid('setCell', ids[j], 'disuse_flag', disuse_flag);
					}
				}
			}
		}
	}
	
</script>
<form id="disuseDetailForm" name="disuseDetailForm" onsubmit="return false;">
	<table  class="select_table" >
		<tr>
			<td width="20%" class="table_title">
				<span>■</span>
				상세정보
			</td>
			<td class="table_button">
				<span class="button white mlargeg auth_save" id="btn_Insert" onclick="btn_insertDisuse_onclick();">
<!-- 				<span class="button white mlargeg auth_save" id="btn_Insert" onclick="btn_Insert_onclick();"> -->
					<button type="button">일괄입력</button>
				</span>
			</td>
		</tr>
	</table>
	<input type="hidden" id="test_sample_seq" name="test_sample_seq">
	<input type="hidden" name="test_sample_seq" id="seq" value="${detail.test_sample_seq}"/>
	<table  class="list_table">
		<tr>
			<th class="indispensable">폐기/반납</th>
			<td>
				<input name="disuse_flag" id="disuse_flag_n" type="radio" value="폐기" onClick="fn_show_type('disuseDetail', $(this).val())"/>
				<label for="disuse_flag_n">폐기</label>
				<input name="disuse_flag" id="disuse_flag_y" type="radio" value="반납" onClick="fn_show_type('disuseDetail', $(this).val())"/>
				<label for="disuse_flag_y">반납</label>
			</td>
			<th class="indispensable" id="date_d">일자</th>
			<td>
				<input name="disuse_date" id="disuse_date" type="text" class="w80px inputCheck" value="${detail.disuse_date}" />
				<img src="<c:url value='/images/common/calendar_del.png'/>" id="dateDel" style="cursor: pointer;" onClick='fn_TextClear("disuse_date")' />
			</td>
		</tr>
		<tr>
			<th id="s_d">반납자</th>
			<td id="s_d2">
				<input name="sender_id" id="sender_id" type="hidden" value="${detail.sender_id}" style="width:120px;"/>
				<input name="sender_nm" id="sender_nm" type="text" value="${detail.sender_nm}" style="width:120px;"/>
				<img style="vertical-align: text-bottom;" src="images/common/icon_search.png" class="auth_select" id="" onclick='fnpop_UserInfo("S");'/>				
				
			</td>
			<th id="r_d">수신자</th>
			<td id="r_d2">
				<input name="recipient_id" id="recipient_id" type="hidden" value="${detail.recipient_id}" style="width:120px;"/>
				<input name="recipient_nm" id="recipient_nm" type="text" value="${detail.recipient_nm}" style="width:120px;"/>
				<img style="vertical-align: text-bottom;" src="images/common/icon_search.png" class="auth_select" id="" onclick='fnpop_UserInfo("R");'/>				
			</td>
		</tr>		
		<tr>
			<th id="etc_d">내용</th>
			<td colspan="3">
				<textarea rows="3" name="etc" id="etc" class="w100p">${detail.etc}</textarea>
			</td>
		</tr>			
	</table>
</form>
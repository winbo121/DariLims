
<%
	/***************************************************************************************
	 * 시스템명 	: 통합장비관제시스템
	 * 업무명 		: 시약/실험기구정보
	 * 파일명 		: reagentsGlassInfoD01.jsp
	 * 작성자 		: 최은향
	 * 작성일 		: 2015.02.17
	 * 설  명		: 시약/실험기구정보 상세 조회 화면
	 *---------------------------------------------------------------------------------------
	 * 변경일		 변경자		변경내역 
	 *---------------------------------------------------------------------------------------
	 * 2015.02.17    최은향		최초 프로그램 작성         
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
		ajaxComboForm("unit", "C16", "${detail.unit}", "", 'reagentsGlassInfoDetail');					// 단위(수량단위-선택)
		ajaxComboForm("mtlr_flag", "C26", "${detail.mtlr_flag}", "", 'reagentsGlassInfoDetail');		// 물품(선택)
		ajaxComboForm("h_mtlr_info", m_mtlr_code, "${detail.h_mtlr_info}", "", 'reagentsGlassInfoDetail'); 	// 대분류
		
		if($("#h_mtlr_info_detail").val() == "C42"){
			ajaxComboForm("m_mtlr_info", "C42", "${detail.m_mtlr_info}", "", 'reagentsGlassInfoDetail'); 	// 중분류
		}else if ($("#h_mtlr_info_detail").val() == "C43"){
			ajaxComboForm("m_mtlr_info", "C43", "${detail.m_mtlr_info}", "", 'reagentsGlassInfoDetail'); 	// 중분류
		}else {
			ajaxComboForm("m_mtlr_info", "", "${detail.m_mtlr_info}", "", 'reagentsGlassInfoDetail'); 	// 중분류
		}
		
		// TAB
		$('#tabsMTLR').tabs({
			create : function(event, ui) {
			},
			activate : function(event, ui) {
				var TabNo = $('#tabsMTLR').tabs('option', 'active');
				TabNo ++;
// 				window["fn_tabAct"+TabNo]();
			}
		});
				
		
		$("#btnAllShow").click(function() {
			var btnText =  $(this).find('span').text();
			if (btnText == '펼쳐보기▼') {
				$(this).find('span').text("모두접기▲");
				$(".ListTit").each(function() {
					if ($(this).hasClass('FirstTit')) {
						$(this).attr('class', 'ListTit FirstTit LtOn');
					} else {
						$(this).attr('class', 'ListTit LtOn');
					}
					$(this).next().attr('class', 'ListConts');
				});
			} else {
				$(this).find('span').text("펼쳐보기▼");
				$(".ListTit").each(function() {
					if ($(this).hasClass('FirstTit')) {
						$(this).attr('class', 'ListTit FirstTit');
					} else {
						$(this).attr('class', 'ListTit');
					}
					$(this).next().attr('class', 'ListConts DispNone');
				});
			}
		});
		
		$(".ListTit").click(function() {
			if ($(this).hasClass('FirstTit')) {
				if ($(this).hasClass('LtOn')) {
					$(this).attr('class', 'ListTit FirstTit');
					$(this).next().attr('class', 'ListConts DispNone');
				} else {
					$(this).attr('class', 'ListTit FirstTit LtOn');
					$(this).next().attr('class', 'ListConts');
				}
				
			} else {
				if ($(this).hasClass('LtOn')) {
					$(this).attr('class', 'ListTit');
					$(this).next().attr('class', 'ListConts DispNone');
				} else {
					$(this).attr('class', 'ListTit LtOn');
					$(this).next().attr('class', 'ListConts');
				}
			}
			//IE8 inline-block 버그
			document.body.ondragstart = null;
		});
	});
	
	
	// 이미지 업로드 이벤트
	function setFile() {
		$('#m_img').trigger('click');

		var name = $('#m_img').val();
		if (name != '') {
			name = name.substring(name.lastIndexOf('\\') + 1);
			$('#file_name').html(name);
		}
	}
</script>

<c:set var="tabName1" value="상세정보" />
<c:set var="tabName2" value="MSDS" />
<c:set var="tabName3" value="MSDS 파일" />
<div id="tabsMTLR" class="tabsMTLR">
	<ul>
		<li id="tab1">
			<a href="#tabDiv1">${tabName1}</a>
		</li>
		<li id="tab2">
			<a href="#tabDiv2">${tabName2}</a>
		</li>
		<li id="tab3">
			<a href="#tabDiv3">${tabName3}</a>
		</li>
		<li style="float: right;">
			<span class="button white mlargeg auth_save" id="btn_Insert" style="vertical-align: middle;" onclick="btn_Insert_onclick();">
				<button type="button">저장</button>
			</span>
		</li>
	</ul>	
	<div id="tabDiv1">
		<table  class="list_table" >
			<tr>
				<th class="indispensable" style="min-width:120px; padding-left:35px;letter-spacing:2.2em;">대분류</th>
				<td>
					<select name="h_mtlr_info" id="h_mtlr_info_detail" style="width:115px"	onchange="comboReload_detail()">
						<option value="">전체</option>
						<option value="C42" <c:if test="${detail.h_mtlr_info == 'C42'}">selected</c:if>>시약류</option>
						<option value="C43" <c:if test="${detail.h_mtlr_info == 'C43'}">selected</c:if>>소모품류</option>
					</select>
				</td>
				<th class="indispensable" style="min-width:120px; padding-left:32px;letter-spacing:2.2em;">중분류</th>
				<td>
					<select name="m_mtlr_info" id="m_mtlr_info" class="" style="width:115px;" ></select>
				</td>
			</tr>
			<tr>
				<th class="indispensable" style="min-width:120px;padding-left:5px;">시약/실험기구명</th>
				<td>
					<input type="hidden" id="mtlr_no" name="mtlr_no" value="${detail.mtlr_no}">
					<input name="item_nm" type="text" class="inputhan" value="${detail.item_nm}" style="width:313px;"/>
				</td>
				<th class="list_table_p" style="letter-spacing:5.4em; padding-left:70px;">단위</th>
				<td>
					<select name="unit" id="unit" class="" style="width:115px;"></select>
				</td>
			</tr>		
			<tr>
				<th class="list_table_p" style="letter-spacing:2.4em; padding-left:38px;">제조사</th>
				<td>
					<input name="spec1" type="text" value="${detail.spec1}" style="width:313px;"/>
				</td>
				<th class="list_table_p" >Cas no.</th>
				<td>
					<input name="spec2" type="text" value="${detail.spec2}" style="width:313px;"/>
				</td>
			</tr>
			<tr>
				<th class="list_table_p" >  Cat # (제품번호)</th>
				<td>
					<input name="spec_etc" type="text" value="${detail.spec_etc}" style="width:313px;"/>
				</td>
				<th class="list_table_p" >  Lot # (로트번호)</th>
				<td>
					<input name="use" type="text" value="${detail.use}" style="width:313px;"/>
				</td>
			</tr>
			<tr>
				<th class="list_table_p" >용량</th>
				<td>
					<input name="mtlr_vol" type="text" value="${detail.mtlr_vol}" style="width:313px;"/>
				</td>
				<th class="list_table_p" style="letter-spacing:1.1em; padding-left:22px;">바코드</th>
				<td colspan="3">
					<input name="barcode" type="text" value="${detail.barcode}" style="width:313px;" readonly="readonly"/>
				</td>
			</tr>
			<tr>		
				<th class="list_table_p" style="letter-spacing:1.1em; padding-left:22px;">사용여부</th>
				<!--radio 버튼-->
				<td>
					<input type="radio" name="use_flag" id="use_flag" style="width:15px; margin-left: 15px; top: 1px;" value="Y"  <c:if test="${detail.use_flag == 'Y' || detail.use_flag == '' || detail.use_flag == null}">checked="checked"</c:if> />
					사용함
					<input type="radio" name="use_flag" id="use_flag" style="width:15px; margin-left: 15px; top: 1px;" value="N"  <c:if test="${detail.use_flag == 'N'}">checked="checked"</c:if> />
					사용안함
				</td>
				
				<th class="list_table_p" style="letter-spacing:.4em; padding-left:12px;">마스터 여부</th>
				<td>
					<input type="radio" name="master_yn" id="master_yn" style="width:15px; margin-left: 15px; top: 1px;" value="Y"  <c:if test="${detail.master_yn == 'Y' || detail.master_yn == '' || detail.master_yn == null}">checked="checked"</c:if> />
					마스터
					<input type="radio" name="master_yn" id="master_yn" style="width:15px; margin-left: 15px; top: 1px;" value="N"  <c:if test="${detail.master_yn == 'N'}">checked="checked"</c:if> />
					일반
				</td>		
			</tr>
			<tr>
				<th class="list_table_p" style="letter-spacing:5.4em; padding-left:70px;">내용</th>
				<td>
					<textarea style="width: 320px; height:100px; border:1px solid #afafaf;" name="content" class="inputhan">${detail.content}</textarea>
				</td>
				<th style="letter-spacing:5.4em; padding-left:70px;">비고</th>
				<td>
					<textarea style="width: 320px; height:100px; border:1px solid #afafaf;" name="etc" class="inputhan">${detail.etc}</textarea>
				</td>
			</tr>
		</table>
	</div>
	
	<div id="tabDiv2">
		<table  class="select_table">
			<tr>
				<td class="table_button" style="padding:0 0 3px 0; border:none;">
					<span class="button white mlargeg auth_select" id="btnAllShow" style="vertical-align: middle;" >
						<button type="button"><span>펼쳐보기▼</span></button>
					</span>
				</td>
			</tr>
		</table>
		<!-- 세부내용 -->
		<div class="ListContsStart">
			<h3 id="Title1" class="ListTit FirstTit"> 1. 화학제품과 회사에 관한 정보</h3>
			<div id="Contents1" class="ListConts DispNone">
				<textarea style="width: 100%; height:100px; border:1px solid #afafaf;" name="msds1" class="inputhan">${detail.msds1}</textarea>
			</div>
								
			<h3 id="Title2" class="ListTit"> 2. 유해성·위험성</h3>
			<div id="Contents2" class="ListConts DispNone">	
				<textarea style="width: 100%; height:100px; border:1px solid #afafaf;" name="msds2" class="inputhan">${detail.msds2}</textarea>
			</div>
			
			<h3 id="Title3" class="ListTit"> 3. 구성성분의 명칭 및 함유량</h3>
			<div id="Contents3" class="ListConts DispNone">
				<textarea style="width: 100%; height:100px; border:1px solid #afafaf;" name="msds3" class="inputhan">${detail.msds3}</textarea>
			</div>
			
			<h3 id="Title4" class="ListTit"> 4. 응급조치요령</h3>
			<div id="Contents4" class="ListConts DispNone">
				<textarea style="width: 100%; height:100px; border:1px solid #afafaf;" name="msds4" class="inputhan">${detail.msds4}</textarea>
			</div>
			
			<h3 id="Title5" class="ListTit"> 5. 폭발·화재시 대처방법</h3>
			<div id="Contents5" class="ListConts DispNone">
				<textarea style="width: 100%; height:100px; border:1px solid #afafaf;" name="msds5" class="inputhan">${detail.msds5}</textarea>
			</div>
			
			<h3 id="Title6" class="ListTit"> 6. 누출사고시 대처방법</h3>			
			<div id="Contents6" class="ListConts DispNone">
				<textarea style="width: 100%; height:100px; border:1px solid #afafaf;" name="msds6" class="inputhan">${detail.msds6}</textarea>
			</div>
		
			<h3 id="Title7" class="ListTit"> 7. 취급 및 저장방법</h3>			
			<div id="Contents7" class="ListConts DispNone">
				<textarea style="width: 100%; height:100px; border:1px solid #afafaf;" name="msds7" class="inputhan">${detail.msds7}</textarea>
			</div>
		
			<h3 id="Title8" class="ListTit"> 8. 노출방지 및 개인보호구</h3>			
			<div id="Contents8" class="ListConts DispNone">
				<textarea style="width: 100%; height:100px; border:1px solid #afafaf;" name="msds8" class="inputhan">${detail.msds8}</textarea>
			</div>
		
			<h3 id="Title9" class="ListTit"> 9. 물리화학적 특성</h3>			
			<div id="Contents9" class="ListConts DispNone">
				<textarea style="width: 100%; height:100px; border:1px solid #afafaf;" name="msds9" class="inputhan">${detail.msds9}</textarea>
			</div>
		
			<h3 id="Title10" class="ListTit"> 10. 안정성 및 반응성</h3>			
			<div id="Contents10" class="ListConts DispNone">
				<textarea style="width: 100%; height:100px; border:1px solid #afafaf;" name="msds10" class="inputhan">${detail.msds10}</textarea>
			</div>
		
			<h3 id="Title11" class="ListTit"> 11. 독성에 관한 정보</h3>			
			<div id="Contents11" class="ListConts DispNone">
				<textarea style="width: 100%; height:100px; border:1px solid #afafaf;" name="msds11" class="inputhan">${detail.msds11}</textarea>
			</div>
		
			<h3 id="Title12" class="ListTit"> 12. 환경에 미치는 영향</h3>			
			<div id="Contents12" class="ListConts DispNone">
				<textarea style="width: 100%; height:100px; border:1px solid #afafaf;" name="msds12" class="inputhan">${detail.msds12}</textarea>
			</div>
	
			<h3 id="Title13" class="ListTit"> 13. 폐기시 주의사항</h3>			
			<div id="Contents13" class="ListConts DispNone">
				<textarea style="width: 100%; height:100px; border:1px solid #afafaf;" name="msds13" class="inputhan">${detail.msds13}</textarea>
			</div>
		
			<h3 id="Title14" class="ListTit"> 14. 운송에 필요한 정보</h3>			
			<div id="Contents14" class="ListConts DispNone">
				<textarea style="width: 100%; height:100px; border:1px solid #afafaf;" name="msds14" class="inputhan">${detail.msds14}</textarea>
			</div>
		
			<h3 id="Title15" class="ListTit"> 15. 법적 규제현황</h3>			
			<div id="Contents15" class="ListConts DispNone">
				<textarea style="width: 100%; height:100px; border:1px solid #afafaf;" name="msds15" class="inputhan">${detail.msds15}</textarea>
			</div>
		
			<h3 id="Title16" class="ListTit"> 16. 그 밖의 참고사항</h3>			
			<div id="Contents16" class="ListConts DispNone">
				<textarea style="width: 100%; height:100px; border:1px solid #afafaf;" name="msds16" class="inputhan">${detail.msds16}</textarea>
			</div>
		</div>
	</div>
	
	<div id="tabDiv3">
		<!-- 파일형식 -->
		<div style="display:inline-block;">
			<!-- 
			<c:if test="${detail.img_file_nm == null ||  detail.img_file_nm == ''}">
				<label id="file_name">첨부파일이 없습니다.</label>
			</c:if>
			<c:if test="${detail.img_file_nm != null && detail.img_file_nm != ''}">
				<label id="file_name">${detail.img_file_nm}</label>
			</c:if>
			-->
			<input name="m_img" id="m_img" type="file" style="padding-bottom:15px;"/>
			<br>
			<c:if test="${detail.img_file_nm == null ||  detail.img_file_nm == ''}">
				<div style="position: relative; float: left; border: 1px solid #afafaf; background: #FFF; text-align: center; valign: middle;">
					<img style="vertical-align: text-bottom;" src="images/no_image.jpg" onclick="setFile();">
				</div>
			</c:if>
			<c:if test="${detail.img_file_nm != null && detail.img_file_nm != ''}">
				<div style="position: relative; float: left; background: #999999; text-align: center; valign: middle;">
					<a href="reagents/reagentsGlassImageDown.lims?mtlr_no=${detail.mtlr_no}">
						<label id="img"></label>
					</a>
				</div>
			</c:if>
		</div>
	</div>
</div>
	
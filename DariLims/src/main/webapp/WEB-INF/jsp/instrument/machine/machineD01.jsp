
<%
	/***************************************************************************************
	 * 시스템명 	: 통합장비관제시스템
	 * 업무명 		: 장비관리
	 * 파일명 		: machineD01.jsp
	 * 작성자 		: 최은향
	 * 작성일 		: 2015.01.21
	 * 설  명		: 장비관리 상세 조회 화면
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
		ajaxComboForm("dept_cd", "", "", "CHOICE", 'userForm'); // 관리부서(정)
		ajaxComboForm("mng_sub_dept_cd", "", "", "CHOICE", 'userForm'); // 관리부서(정)

		fnDatePickerImg('instl_date_Detail');
		fnDatePickerImg('inst_buy_date_Detail');
		fnDatePickerImg('mng_start');
		fnDatePickerImg('mng_end');

		
		intchkManagerGrid('instrument/selectMachineManager.lims', 'managerForm1', 'intchkManagerGrid');
		crtManagerGrid('instrument/selectMachineManager.lims', 'managerForm2', 'crtManagerGrid');
		
		$(window).bind('resize', function() {
			$("#intchkManagerGrid").setGridWidth($('#view_grid_sub1').width(), false);
		}).trigger('resize');
		$(window).bind('resize', function() {
			$("#crtManagerGrid").setGridWidth($('#view_grid_sub2').width(), false);
		}).trigger('resize');
	});
	
	// 중간점검 담당자 그리드
	function intchkManagerGrid(url, form, grid) {
		$('#' + grid).jqGrid({
			datatype : function(json) {
				fnGridData(url, form, grid);
			},
			height : '150',
			autowidth : true,
			loadonce : true,
			mtype : "POST",
			gridview : true,
			shrinkToFit : false,
			rowNum : -1,
			rownumbers : true,
			colModel : [ {
				label : 'inst_no',
				name : 'inst_no',
				hidden : true
			}, {
				label : 'mng_no',
				name : 'mng_no',
				hidden : true
			}, {
				label : '부서',
				name : 'dept_nm'
			}, {
				label : 'dept_cd',
				name : 'dept_cd',
				hidden : true
			}, {
				label : '관리자',
				name : 'mng_nm',
				width : '100', 
				align : 'center'
			}, {
				label : '관리자ID',
				name : 'mng_id',
				hidden : true,
				align : 'center'
			}, {
				label : '부서',
				name : 'mng_sub_dept_nm'
			}, {
				label : 'mng_sub_dept_cd',
				name : 'mng_sub_dept_cd',
				hidden : true
			}, {
				label : '관리자',
				name : 'mng_sub_nm',
				width : '100', 
				align : 'center'
			}, {
				label : '관리자ID',
				name : 'mng_sub_id',
				hidden : true,
				align : 'center'
			}, {
				label : '관리시작일',
				name : 'mng_start',
				align : 'center'
			}, {
				label : '관리종료일',
				name : 'mng_end',
				align : 'center'
			} ],
			gridComplete : function() {
			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
			},
			onSelectRow : function(rowId, status, e) {
				btn_manager_onclick('D','A');
			}
		});
		$('#' + grid).jqGrid('setGroupHeaders', {
			useColSpanStyle : true,
			groupHeaders : [ {
				startColumnName : 'dept_nm',
				numberOfColumns : 4,
				titleText : '정'
			}, {
				startColumnName : 'mng_sub_dept_nm',
				numberOfColumns : 4,
				titleText : '부'
			} ]
		});
	}
	
	// 교정 담당자 그리드
	function crtManagerGrid(url, form, grid) {
		$('#' + grid).jqGrid({
			datatype : function(json) {
				fnGridData(url, form, grid);
			},
			height : '150',
			autowidth : true,
			loadonce : true,
			mtype : "POST",
			gridview : true,
			shrinkToFit : false,
			rowNum : -1,
			rownumbers : true,
			colModel : [ {
				label : 'inst_no',
				name : 'inst_no',
				hidden : true
			}, {
				label : 'mng_no',
				name : 'mng_no',
				hidden : true
			}, {
				label : '부서',
				name : 'dept_nm'
			}, {
				label : 'dept_cd',
				name : 'dept_cd',
				hidden : true
			}, {
				label : '관리자',
				name : 'mng_nm',
				width : '100', 
				align : 'center'
			}, {
				label : '관리자ID',
				name : 'mng_id',
				hidden : true,
				align : 'center'
			}, {
				label : '부서',
				name : 'mng_sub_dept_nm'
			}, {
				label : 'mng_sub_dept_cd',
				name : 'mng_sub_dept_cd',
				hidden : true
			}, {
				label : '관리자',
				name : 'mng_sub_nm',
				width : '100', 
				align : 'center'
			}, {
				label : '관리자ID',
				name : 'mng_sub_id',
				hidden : true,
				align : 'center'
			}, {
				label : '관리시작일',
				name : 'mng_start',
				align : 'center'
			}, {
				label : '관리종료일',
				name : 'mng_end',
				align : 'center'
			} ],
			gridComplete : function() {
			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
			},
			onSelectRow : function(rowId, status, e) {
				btn_manager_onclick('D','B');
			}
		});
		$('#' + grid).jqGrid('setGroupHeaders', {
			useColSpanStyle : true,
			groupHeaders : [ {
				startColumnName : 'dept_nm',
				numberOfColumns : 4,
				titleText : '정'
			}, {
				startColumnName : 'mng_sub_dept_nm',
				numberOfColumns : 4,
				titleText : '부'
			} ]
		});
	}

	// 라디오 버튼에 따른 select 이벤트(내부)
	function caliPeriod(par) {
		if (par == "Y") {
			$("#cali_period_select").attr("disabled", false);
			$("#cali_period_select").val('');
		} else {
			$("#cali_period_select").attr("disabled", true);
			$("#cali_period_select").val('');
			$("#cali_period_select_input").removeAttr("disabled");
			$("#cali_period_select_input").val('0');
		}
	}
	
	// 라디오 버튼에 따른 select 이벤트 (외부)
	function caliIoPeriod(par) {
		if (par == "Y") {
			$("#cali_io_select").attr("disabled", false);
			$("#cali_io_select").val('');
		} else {
			$("#cali_io_select").attr("disabled", true);
			$("#cali_io_select").val('');
			$("#cali_io_select_input").removeAttr("disabled");
			$("#cali_io_select_input").val('0');
		}
	}

	//form_gbn:D(상세),N(추가),mng_gbn:A(중간점검),B(교정)
	function btn_manager_onclick(form_gbn,mng_gbn) {
		var grid = "";
		if(mng_gbn == "A"){
			grid = "intchkManagerGrid"
		}else{
			grid = "crtManagerGrid";
		}
		
		if(form_gbn == "D"){
			var rowId = $('#'+grid).getGridParam('selrow');
			var row = $('#'+grid).getRowData(rowId);
			for (c in row) {
				$('#userForm').find('#' + c).val(row[c]);
			}
		}else{
	 		$('#userForm').find('#mng_no').val('');
	 		$('#userForm').find('#mng_id').val('');
	 		$('#userForm').find('#mng_nm').val('');
	 		$('#userForm').find('#mng_sub_id').val('');
	 		$('#userForm').find('#mng_sub_nm').val('');
	 		$('#userForm').find('#dept_cd').val('');
	 		$('#userForm').find('#mng_sub_dept_cd').val('');
	 		$('#userForm').find('#mng_start').val('');
	 		$('#userForm').find('#mng_end').val('');
		}
		
		$("#dialog").dialog({
			width : 700,
			height : 280,
			resizable : false,
			title : '장비관리자',
			modal : true,
			open : function(event, ui) {
			},
			buttons : [ {
				text : "저장",
				click : function() {
					var data = $('#userForm').serialize();
					data += "&inst_no="+$('#detail').find('#inst_no').val();
					data += "&mng_gbn="+mng_gbn;
					var json = fnAjaxAction('instrument/saveManager.lims', data);
					if (json == null) {
						$.showAlert('저장 실패되었습니다.');
					} else {
						$('#userForm').find('#mng_no').val('');
						$('#userForm').find('#mng_id').val('');
						$('#userForm').find('#mng_nm').val('');
						$('#userForm').find('#mng_sub_id').val('');
						$('#userForm').find('#mng_sub_nm').val('');
						$('#userForm').find('#dept_cd').val('');
						$('#userForm').find('#mng_sub_dept_cd').val('');
						$('#userForm').find('#mng_start').val('');
						$('#userForm').find('#mng_end').val('');
						$('#'+grid).trigger('reloadGrid');
						$.showAlert('저장 완료되었습니다.');
						$(this).dialog("destroy");
					}
				}
			}, {
				text : "삭제",
				click : function() {
					var data = "mng_no="+$('#userForm').find('#mng_no').val();	
					data += "&inst_no="+$('#detail').find('#inst_no').val();
					data += "&mng_gbn="+mng_gbn;
					var json = fnAjaxAction('instrument/deleteManager.lims', data);
					if (json == null) {
						$.showAlert('삭제 실패되었습니다.');
					} else {
						$('#userForm').find('#mng_no').val('');
						$('#userForm').find('#mng_id').val('');
						$('#userForm').find('#mng_nm').val('');
						$('#userForm').find('#mng_sub_id').val('');
						$('#userForm').find('#mng_sub_nm').val('');
						$('#userForm').find('#dept_cd').val('');
						$('#userForm').find('#mng_sub_dept_cd').val('');
						$('#userForm').find('#mng_start').val('');
						$('#userForm').find('#mng_end').val('');
						$('#'+grid).trigger('reloadGrid');
						$.showAlert('삭제 완료되었습니다.');
						$(this).dialog("destroy");
					}
				}
			}, {
				text : "취소",
				click : function() {
					$(this).dialog("destroy");
				}
			} ]
		});
	}
	
	// 관리자 조회 팝업
	function fnpop_UserInfo(name) { 
		fnBasicStartLoading();		
		fnpop_UserInfoPop('userForm', 500, 500, name, '');		
	}
	
	// 콜백
	function fnpop_callback(returnParam){
		fnBasicEndLoading();
	}
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
		</td>
	</tr>
</table>
<table  class="list_table" >
	<!-- 리스트 width는 th는 10%  td는 15%로 적용-->
	<tr>
		<th>장비관리번호</th>
		<!--한글우선입력-->
		<td>
			<input type="hidden" id="inst_no" name="inst_no" value="${detail.inst_no}" />
			<input name="inst_mng_no" type="text" value="${detail.inst_mng_no}" />
		</td>
		<th>장비명</th>
		<!--한글우선입력-->
		<td>
			<input name="inst_kor_nm" type="text" class="inputhan" value="${detail.inst_kor_nm}" />
		</td>
		<th>장비영문명</th>
		<td>
			<input name="inst_eng_nm" type="text" value="${detail.inst_eng_nm}" />
		</td>
		<th>사용여부</th>
		<!--radio 버튼-->
		<td>
			<input type="radio" name="use_flag" id="use_flag" style="width: 15px; margin-left: 15px; top: 1px;" value="Y" <c:if test="${detail.use_flag == 'Y' || detail.use_flag == '' || detail.use_flag == null}">checked="checked"</c:if> />
			사용함
			<input type="radio" name="use_flag" id="use_flag" style="width: 15px; margin-left: 15px; top: 1px;" value="N" <c:if test="${detail.use_flag == 'N'}">checked="checked"</c:if> />
			사용안함
		</td>
	</tr>
	<tr>
		<th>물품규격번호(조달)</th>
		<td>
			<input name="inst_jd_no" type="text" value="${detail.inst_jd_no}" />
		</td>
		<th>물품명(조달)</th>
		<td>
			<input name="inst_jd_nm" type="text" value="${detail.inst_jd_nm}" />
		</td>
		<th>자산번호</th>
		<td>
			<input name="ast_no" type="text" value="${detail.ast_no}" />
		</td>
		<th>사용일지대상여부</th>
		<td>
			<!--radio 버튼-->
			<input type="radio" name="use_his_flag" id="use_his_flag" style="width: 15px; margin-left: 15px; top: 1px;" value="Y" <c:if test="${detail.use_his_flag == 'Y' || detail.use_his_flag == '' || detail.use_his_flag == null}">checked="checked"</c:if> />
			대상
			<input type="radio" name="use_his_flag" id="use_his_flag" style="width: 15px; margin-left: 15px; top: 1px;" value="N" <c:if test="${detail.use_his_flag == 'N'}">checked="checked"</c:if> />
			미대상
		</td>
	</tr>
	<tr>
		<th class="indispensable">장비구입일자</th>
		<td>
			<input name="inst_buy_date" id="inst_buy_date_Detail" style="width: 80px; text-align: center;" type="text" value="${detail.inst_buy_date}" readonly />
			<img src="<c:url value='/images/common/calendar_del.png'/>" id="inst_buy_date_Detail_Del" style="cursor: pointer;" onClick='fn_TextClear("inst_buy_date_Detail")' />
		</td>
		<th>구입가격</th>
		<td>
			<input name="buy_cost" type="text" value="${detail.buy_cost}" />
			원
		</td>
		<th>제조국</th>
		<!--한글우선입력-->
		<td>
			<input name="make_nation" type="text" class="inputhan" value="${detail.make_nation}" />
		</td>
		<th>KOLAS여부</th>
		<!--radio 버튼-->
		<td>
			<input type="radio" name="kolas_yn" id="kolas_yn" style="width: 15px; margin-left: 15px; top: 1px;" value="N" <c:if test="${detail.kolas_yn == 'N' || detail.kolas_yn == '' || detail.kolas_yn == null}">checked="checked"</c:if> />
			일반기기
			<input type="radio" name="kolas_yn" id="kolas_yn" style="width: 15px; margin-left: 15px; top: 1px;" value="Y" <c:if test="${detail.kolas_yn == 'Y'}">checked="checked"</c:if> />
			KOLAS기기
		</td>
	</tr>
	<tr>
		<th class="indispensable">설치일자</th>
		<td>
			<input name="instl_date" id="instl_date_Detail" style="width: 80px; text-align: center;" type="text" value="${detail.instl_date}" readonly />
			<img src="<c:url value='/images/common/calendar_del.png'/>" id="instl_date_Detail_Del" style="cursor: pointer;" onClick='fn_TextClear("instl_date_Detail")' />
		</td>
		<th>설치장소</th>
		<!--한글우선입력-->
		<td>
			<input name="instl_plc" type="text" class="inputhan" value="${detail.instl_plc}" />
		</td>
		<th>내용년수</th>
		<td>
			<input id="end_year" name="end_year" type="text" style="width: 15px;" maxlength="4" value="${detail.end_year}" />
			년
		</td>
		<th>LAS기기여부</th>
		<!--radio 버튼-->
		<td>
			<input type="radio" name="las_yn" id="las_yn" style="width: 15px; margin-left: 15px; top: 1px;" value="N" <c:if test="${detail.las_yn == 'N' || detail.las_yn == '' || detail.las_yn == null}">checked="checked"</c:if> />
			일반기기
			<input type="radio" name="las_yn" id="las_yn" style="width: 15px; margin-left: 15px; top: 1px;" value="Y" <c:if test="${detail.las_yn == 'Y'}">checked="checked"</c:if> />
			LAS기기
		</td>
	</tr>
	<tr>
		<th>공급업체명</th>
		<!--한글우선입력-->
		<td>
			<input name="inst_vnd_nm" type="text" class="inputhan" value="${detail.inst_vnd_nm}" />
		</td>
		<th>공급업체전화번호</th>
		<td>
			<input name="inst_vnd_tel" type="text" value="${detail.inst_vnd_tel}" />
		</td>
		<th>매뉴얼</th>
		<!--한글우선입력-->
		<td>
			<input name="manual" type="text" class="inputhan" value="${detail.manual}" />
		</td>
		<th>교정-내부(중간점검)</th>
		<td>
			<input type="radio" onclick="caliPeriod('Y');" name="cali_period_flag" id="cali_period_flag" style="width: 15px; margin-left: 15px; top: 1px;" value="Y" <c:if test="${detail.cali_period_flag == 'Y'}">checked="checked"</c:if> />
			필요
			<input type="radio" onclick="caliPeriod('N');" name="cali_period_flag" id="cali_period_flag" style="width: 15px; margin-left: 15px; top: 1px;" value="N" <c:if test="${detail.cali_period_flag == 'N' || detail.cali_period_flag == '' || detail.cali_period_flag == null}">checked="checked"</c:if> />
			불필요
			<input name="cali_period" id="cali_period_select" type="text" value="${detail.cali_period}" maxlength="2" style="margin-left: 25px; width: 50px;" <c:if test="${detail.cali_period_flag == 'N' || detail.cali_period_flag == '' || detail.cali_period_flag == null}">disabled</c:if> />
		</td>
	</tr>
	<tr>
		<th>주요부품</th>
		<!--한글우선입력-->
		<td>
			<input name="main_part" type="text" class="inputhan" value="${detail.main_part}" />
		</td>
		<th>보조기기</th>
		<!--한글우선입력-->
		<td>
			<input name="sub_inst" type="text" class="inputhan" value="${detail.sub_inst}" />
		</td>
		<th>소프트웨어</th>
		<!--한글우선입력-->
		<td>
			<input id="software" name="software" type="text" class="inputhan" value="${detail.software}" />
		</td>
		<th>교정-외부</th>
		<td>
			<input type="radio" onclick="caliIoPeriod('Y');" name="cali_io_flag" id="cali_io_flag" style="width: 15px; margin-left: 15px; top: 1px;" value="Y" <c:if test="${detail.cali_io_flag == 'Y'}">checked="checked"</c:if> />
			필요
			<input type="radio" onclick="caliIoPeriod('N');" name="cali_io_flag" id="cali_io_flag" style="width: 15px; margin-left: 15px; top: 1px;" value="N" <c:if test="${detail.cali_io_flag == 'N' || detail.cali_io_flag == '' || detail.cali_io_flag == null}">checked="checked"</c:if> />
			불필요
			<input name="cali_io" id="cali_io_select" type="text" value="${detail.cali_io}" maxlength="2" style="margin-left: 25px; width: 50px;" <c:if test="${detail.cali_io_flag == 'N' || detail.cali_io_flag == '' || detail.cali_io_flag == null}">disabled</c:if> />
		</td>
	</tr>
	<tr>
		<th>사용수수료</th>
		<!--한글우선입력-->
		<td>
			<input name="use_price" type="text" class="inputhan" value="${detail.use_price}" />
		</td>
		<th>NTIS등록번호</th>
		<td>
			<input name="ntis_no" type="text" value="${detail.ntis_no}" />
		</td>
		<th>E-TUBE등록번호</th>
		<td>
			<input name="etube_no" type="text" value="${detail.etube_no}" />
		</td>
		<th>운용구분</th>
		<!--radio 버튼-->
		<td>
			<input type="radio" name="manage_flag" id="manage_flag" style="width: 15px; margin-left: 15px; top: 1px;" value="Y" <c:if test="${detail.manage_flag == 'Y' || detail.manage_flag == '' || detail.manage_flag == null}">checked="checked"</c:if>/>
			상시
			<input type="radio" name="manage_flag" id="manage_flag" style="width: 15px; margin-left: 15px; top: 1px;" value="N" <c:if test="${detail.manage_flag == 'N'}">checked="checked"</c:if>/>
			활용
		</td>
	</tr>
	<tr>
		<th>모델명</th>
		<td>
			<input name="model_nm" type="text" class="inputhan" value="${detail.model_nm}" />
		</td>
		<th>Serial Number</th>
		<td>
			<input name="serial_number" type="text" value="${detail.serial_number}" />
		</td>
		<th>전원</th>
		<!--한글우선입력-->
		<td>
			<input name="pwr" type="text" class="inputhan" value="${detail.pwr}" />
		</td>
		<th>차기점검일자</th>
		<td>
			<input name="intchk_date" id="intchk_date"  class="w80px" style="width: 80px; text-align: center;" type="text" value="${detail.intchk_date}" readonly required="required" />
			<!--  <img src="" id="intchk_date_Del" style="cursor: pointer;" onClick='fn_TextClear("intchk_date")' /> -->
		</td>
	</tr>
	<tr>
		<th>분야용도</th>
		<!--한글우선입력-->
		<td colspan="5">
			<input name="fld_use" type="text" class="inputhan" value="${detail.fld_use}" />
		</td>
		<th >차기교정일자</th>
		<td>
			<input name="crt_date" id="crt_date"  class="w80px" style="width: 80px; text-align: center;" type="text" value="${detail.crt_date}" readonly required="required" />
			 <!-- <img src="" id="crt_date_Del" style="cursor: pointer;" onClick='fn_TextClear("crt_date")' /> -->
		</td>
	</tr>
	<tr>
		<th>사진</th>
		<!-- 파일형식 -->
		<td colspan="3">
			<c:if test="${detail.img_file_nm == null ||  detail.img_file_nm == ''}">
				<label id="file_name">첨부파일이 없습니다.</label>
			</c:if>
			<c:if test="${detail.img_file_nm != null && detail.img_file_nm != ''}">
				<label id="file_name">${detail.img_file_nm}</label>
			</c:if>
			<input name="m_img" id="m_img" type="file" />
			<br>
			<c:if test="${detail.img_file_nm == null ||  detail.img_file_nm == ''}">
				<div style="position: relative; float: left; border: 1px solid #afafaf; background: #FFF; text-align: center; valign: middle;">
					<img style="vertical-align: text-bottom;" src="images/no_image.jpg" onclick="setFile();">
				</div>
			</c:if>
			<c:if test="${detail.img_file_nm != null && detail.img_file_nm != ''}">
				<div style="position: relative; float: left; background: #999999; text-align: center; valign: middle;">
					<label id="img"></label>
				</div>
			</c:if>
		</td>
		<th>특기사항</th>
		<!--한글우선입력-->
		<td colspan="3">
			<textarea style="width: 100%; height: 160px; border: 1px solid #afafaf;" name="cmt" class="inputhan">${detail.cmt}</textarea>
		</td>
	</tr>
</table>

<form id="managerForm1" name="managerForm1" onsubmit="return false;">
	<input type="hidden" id="inst_no" name="inst_no" value="${detail.inst_no}" />
	<input type="hidden" id="mng_gbn" name="mng_gbn" value="A" />
	<table class="select_table" >
		<tr>
			<td width="20%" class="table_title">
				<span>■</span>
				중간점검 담당자
			</td>
			<td class="table_button" style="text-align: right; padding-right: 30px;">
				<span class="button white mlargeb auth_save" id="btn_add_intchk" onclick="btn_manager_onclick('N','A');">
					<button type="button">추가</button>
				</span>
			</td>
		</tr>
	</table>
	<div id="view_grid_sub1">
	<table id="intchkManagerGrid"></table>
	</div>	
</form>
<form id="managerForm2" name="managerForm2" onsubmit="return false;">
<input type="hidden" id="inst_no" name="inst_no" value="${detail.inst_no}" />
<input type="hidden" id="mng_gbn" name="mng_gbn" value="B" />
<table class="select_table" >
		<tr>
			<td width="20%" class="table_title">
				<span>■</span>
				교정 담당자
			</td>
			<td class="table_button" style="text-align: right; padding-right: 30px;">
				<span class="button white mlargeb auth_save" id="btn_add_crt" onclick="btn_manager_onclick('N','B');">
					<button type="button">추가</button>
				</span>
			</td>
		</tr>
	</table>		
	<div id="view_grid_sub2">
	<table id="crtManagerGrid"></table>
	</div>
</form>
<div id="dialog" style="display: none;">
	<div class="sub_blue_01 w100p">
		<form id="userForm" name="userForm" onsubmit="return false;">
			<table  class="list_table"  style="border-top:solid 1px #82bbce;">
				<tr>
					<th colspan="4" style="text-align:left; font-weight:bold; padding-left:15px; background:#fff;">정</th>					
				</tr>
				<tr>
					<th>관리자</th>
					<td>
						<input type="hidden" id="mng_no" name="mng_no">
						<input type="hidden" id="mng_id" name="mng_id">
						<input type="text" id="mng_nm" name="mng_nm">
						<img style="cursor: pointer; vertical-align: text-bottom;" src="images/common/icon_search.png" class="auth_select" onclick="fnpop_UserInfo('machine');">
					</td>
					<th>부서</th>
					<td>
						<select id="dept_cd" name="dept_cd"></select>
					</td>
				</tr>
				<tr>
					<th colspan="4" style="text-align:left; font-weight:bold; padding-left:15px; background:#fff;">부</th>					
				</tr>
				<tr>
					<th>관리자</th>
					<td>
						<input type="hidden" id="mng_sub_id" name="mng_sub_id">
						<input type="text" id="mng_sub_nm" name="mng_sub_nm">
						<img style="cursor: pointer; vertical-align: text-bottom;" src="images/common/icon_search.png" class="auth_select" onclick="fnpop_UserInfo('machineSub');">
					</td>
					<th>부서</th>
					<td>
						<select id="mng_sub_dept_cd" name="mng_sub_dept_cd"></select>
					</td>
				</tr>
				<tr>
					<th>관리시작일</th>
					<td>
						<input name="mng_start" id="mng_start" type="text" class="w80px" readonly="readonly" />
						<img src="<c:url value='/images/common/calendar_del.png'/>" id="startDateStop" style="cursor: pointer;" onClick='fn_TextClear("mng_start")' />
					</td>
					<th>관리종료일</th>
					<td>
						<input name="mng_end" id="mng_end" type="text" class="w80px" readonly="readonly" />
						<img src="<c:url value='/images/common/calendar_del.png'/>" id="endDateStop" style="cursor: pointer;" onClick='fn_TextClear("mng_end")' />
					</td>
				</tr>
			</table>
		</form>
	</div>
</div>
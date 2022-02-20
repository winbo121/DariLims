
<%
	/***************************************************************************************
	 * 시스템명 	: 통합장비관제시스템
	 * 업무명 		: 시험 시료별 통계
	 * 파일명 		: sampleStatisticsL01.jsp
	 * 작성자 		: 최은향
	 * 작성일 		: 2015.06.17
	 * 설  명		: 
	 *---------------------------------------------------------------------------------------
	 * 변경일		 변경자		변경내역 
	 *---------------------------------------------------------------------------------------
	 * 2015.06.17    최은향		최초 프로그램 작성         
	 * 
	 *---------------------------------------------------------------------------------------
	 ****************************************************************************************/
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html >
<link rel="stylesheet" media="screen" type="text/css" href="<c:url value='/css/common/sub.css'/>" />
<script type="text/javascript">
	var colModel;
	var groupHeaders;
	var type;
	var sample_cd;
	
	$(function() {
		/* 세부권한검사 */
		fn_auth_check();
		
		fnDatePickerImg('startDate');
		fnDatePickerImg('endDate');
		
		// 단위업무
		deptUnitWorkGrid('master/allDeptUnitWork.lims', 'allDeptUnitWorkForm', 'allDeptUnitWorkGrid');		
		$('#allDeptUnitWorkGrid').clearGridData(); // 최초 조회시 데이터 안나옴
		
		// 항목리스트		
		testItemGrid('master/selectTestItemAllList.lims', 'testItemForm', 'inputItemGrid');
		
		//ajaxComboForm("unit_work_cd", "", "ALL", null, 'sampleStatisticsForm'); // 시료
		ajaxComboForm("type", "C54", "CHOICE", "", "sampleStatisticsForm");
		
		type = fnGridCommonCombo('C54', null);
		
		$(window).bind('resize', function() {
			$("#sampleStatisticsGrid").setGridWidth($('#view_grid_main').width(), false);
		}).trigger('resize');

		// 시료 통계 리스트 조회
		fn_Enter_Search('sampleStatisticsForm', 'sampleStatisticsGrid');
		
		// 항목리스트 조회(팝업)
		fn_Enter_Search('testItemForm', 'inputItemGrid');
		fn_show_type('typeThSearch', 'sampleStatisticsForm', $('#sampleStatisticsForm').find("#type").val());
		
		// '구분' 값 change시 이벤트
		$('#sampleStatisticsForm').find("#type").change(function() {
			fn_show_type('typeThSearch', 'sampleStatisticsForm', $(this).val());
		});
	});
	
	// 항목 리스트
	function testItemGrid(url, form, grid) {
		$('#' + grid).jqGrid({
			datatype : function(json) {
				if ($('#' + form).find('#test_req_no').val() != '') {
					fnGridData(url, form, grid);
				}
			},
			height : '180',
			autowidth : true,
			loadonce : true,
			shrinkToFit : true,
			multiselect : true,
			mtype : "POST",
			gridview : true,
			rowNum : -1,
			rownumbers : true,
			colModel : [ {
				label : '항목명',
				name : 'test_item_nm',
				width : '200'
			}, {
				label : '항목영문명',
				name : 'test_item_eng_nm'
			}, {
				label : '항목유형',
				name : 'test_item_type',
				width : '220'
			}, {
				label : '시험항목코드',
				name : 'test_item_cd',
				key : true,
				hidden : true
			} ],
			gridComplete : function() {
			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
			},
			onSelectRow : function(rowId, status, e) {
			},
		});
	}
	
	// 단위업무 그리드
	function deptUnitWorkGrid(url, form, grid) {
		var allselect = false;
		$('#' + grid).jqGrid({
			datatype : function(json) {
				fnGridData(url, form, grid);
			},
			height : '248',
			autowidth : true,
			loadonce : true,
			mtype : "POST",
			gridview : true,
			shrinkToFit : true,
			multiselect : true,
			colModel : [ {
				label : '대분류',
				width : '30',
				name : 'h_unit_work',
				align : 'center'
			}, {
				label : '중분류',
				width : '70',
				name : 'm_unit_work'
			}, {
				label : '단위업무명',
				width : '110',
				name : 'unit_work_nm'
			}, {
				label : '단위업무설명',
				width : '140',
				name : 'unit_work_desc'
			}, {
				label : '단위업무코드',
				name : 'unit_work_cd',
				key : true,
				hidden : true
			}],
			gridComplete : function() {
			},
			onSortCol : function(index, iCol, sortorder) {			
			},
			onSelectRow : function(rowId, status, e) {
			},			
			onSelectAll : function(selar, status) {
			}
		});
	}
	
	
	// 조회 이벤트
	function btn_Select_onclick() {		
		var form = "#sampleStatisticsForm" ;
				
		// 필수값 입력 체크 시작
		var unit_work_cd = $(form).find('#unit_work_cd').val();
		var type = $(form).find('#type').val();
		sample_cd = $(form).find('#sample_cd').val();
		var sample_nm = $(form).find('#sample_nm').val();
		
		if (sample_cd == null || sample_cd == "") {
			alert('"시료유형"을 선택 하세요');
			btn_Pop_SampleChoice();
			return false;
		} else {
			if(sample_cd != "001" && sample_cd != "002" && sample_cd != "003"){
				alert('본 시료는 데이터가 존재하지 않습니다.');
				btn_Pop_SampleChoice();
				return false;
			}
		}
		if (unit_work_cd == null || unit_work_cd == "") {
			alert('"단위업무"을 선택 하세요');
			btn_Choice_onclick();
			return false; 
		}
		if (type == null || type == "") {
			alert('"구분"을 선택 하세요');
			$(form).find('#type').focus();
			return false;
		} else {
			if (type == 'C54001'){ // 연
				var s = $(form).find('#startYear').val();
				var e = $(form).find('#endYear').val();
				if (s == '' || s == null){
					alert('"시작년도"를 선택 하세요');
					$(form).find('#startYear').focus();
					return false;
				}
				if (e == '' || e == null){
					alert('"종료년도"를 선택 하세요');
					$(form).find('#endYear').focus();
					return false;
				}
			}
			if (type == 'C54002'){ // 분기
				var y = $(form).find('#year').val();
				if (y == '' || y == null){
					alert('"년도"를 선택 하세요');
					$(form).find('#year').focus();
					return false;
				}
			}
			if (type == 'C54003'){ // 월
				var y = $(form).find('#year').val();
				if (y == '' || y == null){
					alert('"년도"를 선택 하세요');
					$(form).find('#year').focus();
					return false;
				}
			}
			if (type == 'C54004'){ // 주
				var s = $(form).find('#startDate').val();
				var e = $(form).find('#endDate').val();
				if (s == '' || s == null){
					alert('"시작날짜"를 선택 하세요');
					$(form).find('#startDate').focus();
					return false;
				}
				if (e == '' || e == null){
					alert('"종료날짜"를 선택 하세요');
					$(form).find('#endDate').focus();
					return false;
				}
			}
		}
		// 필수값 입력 체크 종료
		
		colModel = new Array();
		groupHeaders = new Array();
		colModel.push({
			label : '항목',
			name : 'TEST_ITEM_NM',
			width : '120',
			align : 'left'
		});
		colModel.push({
			label : '항목코드',
			name : 'TEST_ITEM_CD',
			width : '200',
			hidden : true,
			align : 'left'
		});
// 		colModel.push({
// 			label : '의뢰일자',
// 			name : 'REQ_DATE',
// 			width : '100',
// 			align : 'center'
// 		});
		var json = fnAjaxAction('resultStatistical/selectSampleStatistics.lims', $('#sampleStatisticsForm').serialize());
		if (json == null) {
		} else {
			var num;
			var str = "";
			if(sample_cd == '001'){ // 시료: 상수원수계하천수
				num = 24;
			}else if(sample_cd == '002') { // 시료: 원수
				num = 5;
			}else if(sample_cd == '003') { // 시료: 정수
				num = 6;
			}
			$(json).each(function(index, entry) {
				$(entry['head']).each(function(idx, etr) {
					if(sample_cd == '001'){
						colModel.push({
							label : '궁촌',
							name : 'A01' + idx,
							width : '50'
						});
						colModel.push({
							label : '도심',
							name : 'A02' + idx,
							width : '50'
						});
						colModel.push({
							label : '월문',
							name : 'A03' + idx,
							width : '50'
						});
						colModel.push({
							label : '덕소',
							name : 'A04' + idx,
							width : '50'
						});
						colModel.push({
							label : '홍릉',
							name : 'A05' + idx,
							width : '50'
						});
						colModel.push({
							label : '산곡',
							name : 'A06' + idx,
							width : '50'
						});
						colModel.push({
							label : '진접',
							name : 'A07' + idx,
							width : '50'
						});
						colModel.push({
							label : '별내',
							name : 'A08' + idx,
							width : '50'
						});
						colModel.push({
							label : '진건',
							name : 'A09' + idx,
							width : '50'
						});
						colModel.push({
							label : '구리1',
							name : 'A10' + idx,
							width : '50'
						});
						colModel.push({
							label : '구리2',
							name : 'A11' + idx,
							width : '50'
						});
						colModel.push({
							label : '덕풍',
							name : 'A12' + idx,
							width : '50'
						});
						colModel.push({
							label : '신원리',
							name : 'A13' + idx,
							width : '50'
						});
						colModel.push({
							label : '양평',
							name : 'A14' + idx,
							width : '50'
						});
						colModel.push({
							label : '이포보',
							name : 'A15' + idx,
							width : '50'
						});
						colModel.push({
							label : '여주포',
							name : 'A16' + idx,
							width : '50'
						});
						colModel.push({
							label : '강천보',
							name : 'A17' + idx,
							width : '50'
						});
						colModel.push({
							label : '부론',
							name : 'A18' + idx,
							width : '50'
						});
						colModel.push({
							label : '양수리',
							name : 'A19' + idx,
							width : '50'
						});
						colModel.push({
							label : '삼봉리',
							name : 'A20' + idx,
							width : '50'
						});
						colModel.push({
							label : '청평댐',
							name : 'A21' + idx,
							width : '50'
						});
						colModel.push({
							label : '의암댐',
							name : 'A22' + idx,
							width : '50'
						});
						colModel.push({
							label : '춘천댐',
							name : 'A23' + idx,
							width : '50'
						});
						colModel.push({
							label : '소양댐',
							name : 'A24' + idx,
							width : '50'
						});
					}
					if(sample_cd == '002'){
						colModel.push({
							label : '광암',
							name : 'A01' + idx,
							width : '50'
						});
						colModel.push({
							label : '강북',
							name : 'A02' + idx,
							width : '50'
						});
						colModel.push({
							label : '암사',
							name : 'A03' + idx,
							width : '50'
						});
						colModel.push({
							label : '자양',
							name : 'A04' + idx,
							width : '50'
						});
						colModel.push({
							label : '풍납',
							name : 'A05' + idx,
							width : '50'
						});
					}
					if(sample_cd == '003'){
						colModel.push({
							label : '광암',
							name : 'A01' + idx,
							width : '50'
						});
						colModel.push({
							label : '강북',
							name : 'A02' + idx,
							width : '50'
						});
						colModel.push({
							label : '암사',
							name : 'A03' + idx,
							width : '50'
						});
						colModel.push({
							label : '구의',
							name : 'A04' + idx,
							width : '50'
						});
						colModel.push({
							label : '뚝도',
							name : 'A05' + idx,
							width : '50'
						});
						colModel.push({
							label : '영등포',
							name : 'A06' + idx,
							width : '50'
						});
					}
				});
				colModel.push({
					label : '평균',
					name : 'AVG',
					width : '50'
				});
				colModel.push({
					label : '최대',
					name : 'MAX',
					width : '50'
				});
				colModel.push({
					label : '최소',
					name : 'MIN',
					width : '50'
				});
				$(entry['head']).each(function(idx, etr) {
					groupHeaders.push({
						startColumnName : 'A01' + idx,
						numberOfColumns : num,
						titleText : etr
					});
				});
				$('#sampleStatisticsGrid').jqGrid('GridUnload');
				sampleStatisticsGrid(null, 'sampleStatisticsForm', 'sampleStatisticsGrid');
				$('#sampleStatisticsGrid').clearGridData();
				$('#sampleStatisticsGrid')[0].addJSONData(entry['body']);
			});
		}
	}	
	
	// 그리드
	function sampleStatisticsGrid(url, form, grid) {
		$('#' + grid).jqGrid({
			height : '500',
			autowidth : true,
			loadonce : true,
			mtype : "POST",
			gridview : true,
			shrinkToFit : false,
			rowNum : -1,
			rownumbers : true,
			colModel : colModel,
			sortorder: 'DESC',
			gridComplete : function() {
			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
			}
		});
		$('#' + grid).jqGrid('setGroupHeaders', {
			useColSpanStyle : true,
			groupHeaders : groupHeaders
		});
		$('#' + grid).jqGrid('setFrozenColumns');
	}
	
	// 엑셀 다운로드
	function btn_Excel_onclick() {
		var data = fn_Excel_Data_Make('sampleStatisticsGrid');
		fn_Excel_Download(data);
	}	
	
	// 기간 SELECT BOX 수정
	function fn_show_type(th, form, type) {
		$('#' + form).find("#year").hide();
		$('#' + form).find("#quart").hide();
		$('#' + form).find("#mon").hide();		
		$("#type option:eq(4)").remove(); // (C54004) 주 숨기기
		
		switch (type) {
		case 'C54001':
 			$('#' + th).text('연도 기간'); // 연
			$('#' + form).find("#yearDiv").show();
			$('#' + form).find("#year").hide();
			$('#' + form).find("#quart").hide();
			$('#' + form).find("#mon").hide();
			$('#' + form).find("#dateDiv").hide();
			$('#' + form).find("#quart").val('');
			$('#' + form).find("#mon").val('');
			$('#' + form).find("#startDate").val('');
			$('#' + form).find("#endDate").val('');
			$('#' + form).find("#text").hide();
			break;
		case 'C54002':
			$('#' + th).text('년도'); //분기
			$('#' + form).find("#yearDiv").hide();
			$('#' + form).find("#year").show();
			$('#' + form).find("#quart").hide();
			$('#' + form).find("#mon").hide();
			$('#' + form).find("#dateDiv").hide();
			$('#' + form).find("#mon").val('');
			$('#' + form).find("#startDate").val('');
			$('#' + form).find("#endDate").val('');
			$('#' + form).find("#text").hide();
			break;
		case 'C54003':
			$('#' + th).text('년도'); //월
			$('#' + form).find("#yearDiv").hide();
			$('#' + form).find("#year").show();
			$('#' + form).find("#quart").hide();
			$('#' + form).find("#mon").hide();
			$('#' + form).find("#dateDiv").hide();
			$('#' + form).find("#quart").val('');
			$('#' + form).find("#startDate").val('');
			$('#' + form).find("#endDate").val('');
			$('#' + form).find("#text").hide();
			break;
//	 		case 'C54004':
// 			$('#' + th).text('주');
// 			$('#' + form).find("#yearDiv").hide();
// 			$('#' + form).find("#year").hide();
// 			$('#' + form).find("#quart").hide();
// 			$('#' + form).find("#mon").hide();
// 			$('#' + form).find("#dateDiv").show();
// 			$('#' + form).find("#year").val('');
// 			$('#' + form).find("#quart").val('');
// 			$('#' + form).find("#mon").val('');
// 			$('#' + form).find("#text").hide();
// 			break;
		case '':
			$('#' + th).text('기간');
			$('#' + form).find("#yearDiv").hide();
			$('#' + form).find("#year").hide();
			$('#' + form).find("#quart").hide();
			$('#' + form).find("#mon").hide();
			$('#' + form).find("#dateDiv").hide();
			$('#' + form).find("#quart").val('');
			$('#' + form).find("#mon").val('');
			$('#' + form).find("#startDate").val('');
			$('#' + form).find("#endDate").val('');
			$('#' + form).find("#text").show();
			break;
		}
	}
	
	// 시료유형 검색 팝업
	function btn_Pop_SampleChoice() {
		fnpop_sampleChoicePop("720", "500", 'sampleStatisticsForm', true, 'sampleStatistics');
		fnBasicStartLoading();
	}
	
	// 콜백 함수
	function fnpop_callback(){
	}
	
	// 단위 업무 조회 팝업
	function btn_Choice_onclick(rowId) {
		$("#dialog").dialog({
			width : 700,
			height : 390,
			resizable : false,
			title : '단위업무 목록',
			modal : true,
			open : function(event, ui) {
				$(window).bind('resize', function() {
					$("#allDeptUnitWorkGrid").setGridWidth($('#view_grid_sub2').width(), true);
				}).trigger('resize');
			},
			buttons : [{
				text : "선택",
				click : function() {
					var rowNm = new Array();
					var rowCd = new Array();
					var rowId = $('#allDeptUnitWorkGrid').getGridParam('selarrrow');
					
					if (rowId != null) {
						for ( var i in rowId) {
							var row = $('#allDeptUnitWorkGrid').getRowData(rowId[i]);
							rowNm[i] = row.unit_work_nm;
							rowCd[i] = row.unit_work_cd;
						}
					}
					$('#sampleStatisticsForm').find('#unit_work_cd').val(String(rowCd));
					$('#sampleStatisticsForm').find('#unit_work_nm').val(String(rowNm));
					$(this).dialog("destroy");
				}
			}, {
				text : "취소",
				click : function() {
					$(this).dialog("destroy");
				}
			}]
		});
	}
	
	// 항목 조회 팝업
	function btn_Choice2_onclick(rowId) {
		$("#dialog2").dialog({
			width : 700,
			height : 390,
			resizable : false,
			title : '항목 목록',
			modal : true,
			open : function(event, ui) {
				$(window).bind('resize', function() {
					$("#inputItemGrid").setGridWidth($('#view_grid_sub3').width(), true);
				}).trigger('resize');
			},
			buttons : [
			   {
				text : "선택",
				click : function() {
					var rowNm = new Array();
					var rowCd = new Array();
					var rowId = $('#inputItemGrid').getGridParam('selarrrow');
					
					if (rowId != null) {
						for ( var i in rowId) {
							var row = $('#inputItemGrid').getRowData(rowId[i]);
							rowNm[i] = row.test_item_nm;
							rowCd[i] = row.test_item_cd;
						}
					}
					$('#sampleStatisticsForm').find('#test_item_cd').val(String(rowCd));
					$('#sampleStatisticsForm').find('#test_item_nm').val(String(rowNm));
					$(this).dialog("destroy");
				}
			}, {
				text : "취소",
				click : function() {
					$(this).dialog("destroy");
				}
			}]
		});
	}

	function btn_Search_onclick(){
		$('#inputItemGrid').trigger('reloadGrid');
	}
</script>
<div class="w100p">
	<form id="sampleStatisticsForm" name="sampleStatisticsForm" onsubmit="return false;">
		<table  class="sub_purple_01  select_table" >
			<tr>
				<td width="20%" class="table_title" nowrap="nowrap">
					<span>■</span>
					시험시료별통계 
					<span style="color:#666666; font-size:11px; font-weight:normal;">* 통계는 수치는 소수점 3째자리까지만 표시됩니다.</span>
				</td>
				<td class="table_button" style="text-align: right; padding-right: 30px;">
					<span class="button white mlargep auth_select" id="btn_Select" onclick="btn_Select_onclick();">
						<button type="button">조회</button>
					</span>
					<span class="button white mlargeb auth_select" onclick="btn_Excel_onclick();">
						<button type="button">EXCEL</button>
					</span>
				</td>
			</tr>
		</table>		
		<table  class="list_table" >
			<tr>
				<th style="width:100px;">시료유형</th>
				<td style="width:210px;">
					<input name="sample_cd" id="sample_cd" type="hidden" />
					<input name="sample_nm" id="sample_nm" type="text" class="inputhan" readonly="readonly" style="width: 150px;" onClick='btn_Pop_SampleChoice()' />
					<img src="<c:url value='/images/common/icon_search.png'/>" class="auth_select" id="sampleAdd" style="cursor: pointer;margin-bottom:-2px;" onClick='btn_Pop_SampleChoice()' /> <img src="<c:url value='/images/common/icon_stop.png'/>" id="sampleDel" style="cursor: pointer;margin-bottom:-2px;" onClick='fn_TextClear("sample_cd"), fn_TextClear("sample_nm")' />
				</td>
				<th style="width:100px;">구분</th>
				<td style="width:150px;">
					<select name="type" id="type" class="w100px"></select>
				</td>
				<th id="typeThSearch">기간</th>
				<td>
					<span id="text">구분값 조건을 선택해 주세요.</span>
					<div id="yearDiv">
						<select name="startYear" id="startYear" class="w80px">
							<option value="">전체</option>
							<c:forEach begin="2000" end="2030" var="va">
								<option value="${va }">${va }</option>
							</c:forEach>
						</select>
						~
						<select name="endYear" id="endYear" class="w80px">
							<option value="">전체</option>
							<c:forEach begin="2000" end="2030" var="va">
								<option value="${va }">${va }</option>
							</c:forEach>
						</select>
					</div>
					<select name="year" id="year" class="w80px">
						<option value="">전체</option>
						<c:forEach begin="2000" end="2030" var="va">
							<option value="${va }">${va }</option>
						</c:forEach>
					</select>
					<select name="quart" id="quart" class="w80px"></select>
					<select name="mon" id="mon" class="w80px">
						<option value="">전체</option>
						<c:forEach begin="1" end="12" varStatus="st">
							<option value="${st.count}">${st.count}</option>
						</c:forEach>
					</select>
					<div id="dateDiv">
						<input name="startDate" id="startDate" type="text" class="w80px" readonly="readonly" value="${detail.startDate}" />
						<img src="<c:url value='/images/common/calendar_del.png'/>" id="startDateStop" style="cursor: pointer;" onClick='fn_TextClear("startDate")' /> ~
						<input name="endDate" id="endDate" type="text" class="w80px" readonly="readonly" value="${detail.endDate}" />
						<img src="<c:url value='/images/common/calendar_del.png'/>" id="startDateStop" style="cursor: pointer;" onClick='fn_TextClear("endDate")' />
					</div>
				</td>
			</tr>
			<tr>
				<th style="width:100px;">단위업무</th>
				<td style="width:300px;">				
				    <input name="unit_work_cd" id="unit_work_cd" type="hidden" readonly="readonly"/>
					<input name="unit_work_nm" id="unit_work_nm" type="text" class="inputhan" readonly="readonly" style="width: 220px;" onClick='btn_Choice_onclick();' />
					<img src="<c:url value='/images/common/icon_search.png'/>" class="auth_select" id="unitWorkAdd" style="cursor: pointer;margin-bottom:-2px;" onClick='btn_Choice_onclick();' /> <img src="<c:url value='/images/common/icon_stop.png'/>" id="unitWorkDel" style="cursor: pointer;margin-bottom:-2px;" onClick='fn_TextClear("unit_work_cd"), fn_TextClear("unit_work_nm")' />
				</td>
				<th style="width:100px;">항목</th>
				<td style="width:300px;" colspan="3">				
				    <input name="test_item_cd" id="test_item_cd" type="hidden" readonly="readonly"/>
					<input name="test_item_nm" id="test_item_nm" type="text" class="inputhan" readonly="readonly" style="width: 150px;" onClick='btn_Choice2_onclick();' />
					<img src="<c:url value='/images/common/icon_search.png'/>" class="auth_select" id="testItemAdd" style="cursor: pointer;margin-bottom:-2px;" onClick='btn_Choice2_onclick();' /> <img src="<c:url value='/images/common/icon_stop.png'/>" id="testItemDel" style="cursor: pointer;margin-bottom:-2px;" onClick='fn_TextClear("test_item_cd"), fn_TextClear("test_item_nm")' />
				</td>
			</tr>
		</table>
		<input type="hidden" id="sortName" name="sortName">
		<input type="hidden" id="sortType" name="sortType">
		<div id="view_grid_main" class="sub_blue_01 w100p" >
			<table id="sampleStatisticsGrid"></table>
		</div>
	</form>
</div>

<div id="dialog" style="display: none;">
	<div class="sub_blue_01 w100p">
		<form id="allDeptUnitWorkForm" name="allDeptUnitWorkForm" onsubmit="return false;">
			<input type="hidden" id="sortName" name="sortName">
			<input type="hidden" id="sortType" name="sortType">
			<div id="view_grid_sub2">
				<table id="allDeptUnitWorkGrid"></table>
			</div>
		</form>
	</div>
</div>

<div id="dialog2" style="display: none;">
	<div class="sub_blue_01 w100p">
		<form id="testItemForm" name="testItemForm" onsubmit="return false;">
			<input type="hidden" id="sortName" name="sortName">
			<input type="hidden" id="sortType" name="sortType">
			<div id="view_grid_sub3">
				<table  class="sub_purple_01  select_table" >
					<tr>
						<td width="20%" class="table_title" nowrap="nowrap">
							<span>■</span>
							항목
						</td>
						<td class="table_button" style="text-align: right; padding-right: 10px;">
							<span class="button white mlargep auth_select" id="btn_Select" onclick="btn_Search_onclick();">
								<button type="button">조회</button>
							</span>
						</td>
					</tr>
				</table>
				<table  class="list_table" >
					<tr>
						<th style="width:80px;">항목명</th>
						<td>
							<input name="test_item_nm" id="test_item_nm" type="text" class="inputhan" style="width: 180px;" />
						</td>
					</tr>
				</table>
				<table id="inputItemGrid"></table>
			</div>
		</form>
	</div>
</div>
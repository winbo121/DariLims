
<%
	/***************************************************************************************
	 * 시스템명 	: 통합장비관제시스템
	 * 업무명 		: 보고서작성
	 * 파일명 		: paperWriteL01.jsp
	 * 작성자 		: 진영민
	 * 작성일 		: 2015.03.10
	 * 설  명		: 
	 *---------------------------------------------------------------------------------------
	 * 변경일		 변경자		변경내역 
	 *---------------------------------------------------------------------------------------
	 * 2015.03.10    진영민		최초 프로그램 작성         
	 * 
	 *---------------------------------------------------------------------------------------
	 ****************************************************************************************/
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html >
<link rel="stylesheet" media="screen" type="text/css" href="<c:url value='/css/common/sub.css'/>" />
<style>
</style>
<script type="text/javascript">
	var quart;
	var qreport_type;
	$(function() {
		/* 세부권한검사 */
		fn_auth_check();
		
		fnDatePickerImg('week_start');
		fnDatePickerImg('week_end');
		fnDatePickerImg('startDate');
		fnDatePickerImg('endDate');
		$('#paperForm').find('#endDate').val(fnGetToday(0,0));
		$('#paperForm').find('#startDate').val(fnGetToday(1,0));

		quart = fnGridCommonCombo('C14', null);
		qreport_type = fnGridCommonCombo('C54', null);

		ajaxComboForm("qreport_type", "C54", "ALL", "", "paperForm");
		ajaxComboForm("qreport_id", '', "ALL", null, 'paperForm');
		ajaxComboForm("unit_work_cd", '', "ALL", null, 'paperForm');
		
		ajaxComboForm("quart", "C14", "${detail.quart}", "", "paperForm");
		
		paperGrid('report/selectPaperList.lims', 'paperForm', 'paperGrid');
		$('#paperGrid').clearGridData(); // 최초 조회시 데이터 안나옴

		fn_show_type('typeThSearch', 'paperForm', $('#paperForm').find("#qreport_type").val());
		$('#paperForm').find("#qreport_type").change(function() {
			fn_show_type('typeThSearch', 'paperForm', $(this).val());
		});

		fn_Enter_Search('paperForm', 'paperGrid');

		$(window).bind('resize', function() {
			$("#paperGrid").setGridWidth($('#view_grid_main').width(), true);
		}).trigger('resize');
	});

	function paperGrid(url, form, grid) {
		$('#' + grid).jqGrid({
			datatype : function(json) {
				fnGridData(url, form, grid);
			},
			height : '240',
			autowidth : true,
			loadonce : true,
			mtype : "POST",
			gridview : true,
			shrinkToFit : false,
			rowNum : -1,
			rownumbers : true,
			colModel : [ {
				label : '보고서번호',
				name : 'qreport_no',
				align : 'center',
				width : '80',
				key : true,
				hidden : true
			}, {
				label : 'qreport_id',
				name : 'qreport_id',
				hidden : true
			}, {
				label : '보고서명',
				name : 'qreport_nm',
				width : '100'
			}, {
				label : '단위업무',
				name : 'unit_work_nm',
				width : '100'
			}, {
				label : '작성일자',
				name : 'write_date',
				width : '60',
				align : 'center'
			}, {
				label : '구분',
				name : 'qreport_type',
				width : '40',
				align : 'center',
				edittype : "select",
				editoptions : {
					value : qreport_type
				},
				formatter : 'select'
			}, {
				label : '기간',
				name : 'year',
				width : '80',
				align : 'center'
			}, {
				label : '부서',
				name : 'dept_nm',
				width : '80'
			}, {
				label : '작성자',
				name : 'user_nm',
				width : '50'
			}, {
				label : '업무관리시스템 연계상태',
				name : 'onnara_appv_state',
				width : '100',
				align : 'center',
				edittype : "select",
				editoptions : {
					value : 'Z:기안요청대기;S:기안요청;T:전송완료;U:승인중;V:승인완료;W:반려'
				},
				formatter : 'select'
			} ],
			gridComplete : function() {
			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
			},
			onSelectRow : function(rowId, status, e) {
				var data = 'pageType=detail&qreport_no=' + rowId;
				fn_ShowDialog(data);
			}
		});
	}

	function fn_ShowDialog(data) {
		var preview = false;
		var buttons = new Array();
		if (data == undefined) {
			buttons.push({
				text : "미리보기",
				click : function() {
					var data = $('#paperDetailForm').serialize();
					data += '&state=Z';
					var b = true;
					if ($('#paperDetailForm').find('#qreport_id').val() == '') {
						alert('보고서를 선택해주세요.');
						b = false;
					} else if ($('#paperDetailForm').find('#qreport_type').val() == 'C54004') {
						if ($('#paperDetailForm').find('#week_start').val() == '' || $('#paperDetailForm').find('#week_end').val() == '') {
							alert('주를 선택해주세요.');
							b = false;
						}
					}
					$('#paperDetailForm').find('input[id=onnara_link_yn]').each(function(index, entry) {
						if ($(this).is(":checked")) {
							if ($(this).val() == 'Y') {
								data += '&onnara_appv_state=Z';
								if ($('#paperDetailForm').find('#onnara_title').val() == '') {
									alert('연계제목을 입력해주세요');
									b = false;
								} else if ($('#paperDetailForm').find('#onnara_con').val() == '') {
									alert('연계내용을 입력해주세요');
									b = false;
								}
							}
						}
					});
					if (b) {
						var json = fnAjaxAction('report/savePaperDetail.lims', data);
						if (json == null) {
							alert('미리보기 실패하였습니다.');
						} else {
							preview = true;
							$('#paperDetailForm').find('#qreport_no').val(json);
							var file = $('#paperDetailForm').find('#qreport_id').val().split('$%');
							fn_RDView(file[1], $('#paperDetailForm').find('#qreport_no').val(), false, false, 800, 900);
						}
					}
				}
			});
		} else {
			buttons.push({
				text : "보고서 보기",
				click : function() {
					if ($('#paperDetailForm').find('#qreport_id').val() == '') {
						alert('보고서를 선택해주세요.');
					} else {
						var file = $('#paperDetailForm').find('#qreport_id').val().split('$%');
						fn_RDView(file[1], $('#paperDetailForm').find('#qreport_no').val(), false, false, 800, 900);
					}
				}
			});
		}
		buttons.push({
			text : "작성완료",
			click : function() {
				var b = true;
				var data = $('#paperDetailForm').serialize();
				data += '&state=X';
				if ($('#paperDetailForm').find('#qreport_id').val() == '') {
					alert('보고서를 선택해주세요.');
					b = false;
				} else if ($('#paperDetailForm').find('#qreport_type').val() == 'C54004') {
					if ($('#paperDetailForm').find('#week_start').val() == '' || $('#paperDetailForm').find('#week_end').val() == '') {
						alert('주를 선택해주세요.');
						b = false;
					}
				}
				$('#paperDetailForm').find('input[id=onnara_link_yn]').each(function(index, entry) {
					if ($(this).is(":checked")) {
						if ($(this).val() == 'Y') {
							data += '&onnara_appv_state=Z';
							if ($('#paperDetailForm').find('#onnara_title').val() == '') {
								alert('연계제목을 입력해주세요');
								b = false;
							} else if ($('#paperDetailForm').find('#onnara_con').val() == '') {
								alert('연계내용을 입력해주세요');
								b = false;
							}
						}
					}
				});
				if (b) {
					var json = fnAjaxAction('report/savePaperDetail.lims', data);
					if (json == null) {
						alert('작성 실패하였습니다.');
					} else {
						alert('작성 완료하였습니다.');
						$('#paperGrid').trigger('reloadGrid');
						$('#dialog').dialog("close");
					}
				}
			}
		});
		if (data != undefined) {
			buttons.push({
				text : "삭제",
				click : function() {
					if ($('#paperDetailForm').find('#user_id').val() != '${session.user_id}') {
						alert('본인이 작성한 보고서만 삭제할 수 있습니다.');
					} else {
						if (!confirm('보고서를 삭제하시겠습니까?')) {
							return false;
						}
						var json = fnAjaxAction('report/deletePaperDetail.lims', $('#paperDetailForm').serialize());
						if (json == null) {
							alert('삭제 실패하였습니다.');
						} else {
							alert('삭제 완료하였습니다.');
							$('#paperGrid').trigger('reloadGrid');
							$('#dialog').dialog("close");
						}
					}
				}
			});
		}
		buttons.push({
			text : "취소",
			click : function() {
				if (preview) {
					var data = 'qreport_no=' + $('#paperDetailForm').find('#qreport_no').val();
					var json = fnAjaxAction('report/deletePaperDetail.lims', data);
					if (json == null) {
						$.showAlert('error');
					}
				}
				$('#dialog').dialog("destroy");
			}
		});
		$("#dialog").dialog({
			width : 700,
			height : 350,
			resizable : false,
			title : '보고서작성 정보',
			modal : true,
			open : function(event, ui) {
				//$("#dialog").dialog().parents(".ui-dialog").find(".ui-dialog-titlebar").remove();
				$(".ui-dialog-titlebar-close").hide();
				fnViewPage('report/selectPaperDetail.lims', 'dialog', data);
			},
			buttons : buttons
		});
	}
	function btn_Select_onclick() {
		$('#paperGrid').trigger('reloadGrid');
	}
	function fn_show_type(th, form, qreport_type) {
		$('#' + form).find("#year").hide();
		$('#' + form).find("#quart").hide();
		$('#' + form).find("#mon").hide();
		
		switch (qreport_type) {
		case 'C54001':
			$('#' + th).text('연');
			$('#' + form).find("#year").show();
			$('#' + form).find("#quart").hide();
			$('#' + form).find("#mon").hide();
			$('#' + form).find("#dateDiv").hide();
			$('#' + form).find("#quart").val('');
			$('#' + form).find("#mon").val('');
			$('#' + form).find("#week_start").val('');
			$('#' + form).find("#week_end").val('');
			$('#' + form).find("#text").hide();
			break;
		case 'C54002':
			$('#' + th).text('분기');
			$('#' + form).find("#year").show();
			$('#' + form).find("#quart").show();
			$('#' + form).find("#mon").hide();
			$('#' + form).find("#dateDiv").hide();
			$('#' + form).find("#mon").val('');
			$('#' + form).find("#week_start").val('');
			$('#' + form).find("#week_end").val('');
			$('#' + form).find("#text").hide();
			break;
		case 'C54003':
			$('#' + th).text('월');
			$('#' + form).find("#year").show();
			$('#' + form).find("#quart").hide();
			$('#' + form).find("#mon").show();
			$('#' + form).find("#dateDiv").hide();
			$('#' + form).find("#quart").val('');
			$('#' + form).find("#week_start").val('');
			$('#' + form).find("#week_end").val('');
			$('#' + form).find("#text").hide();
			break;
		case 'C54004':
			$('#' + th).text('주');
			$('#' + form).find("#year").hide();
			$('#' + form).find("#quart").hide();
			$('#' + form).find("#mon").hide();
			$('#' + form).find("#dateDiv").show();
			$('#' + form).find("#year").val('');
			$('#' + form).find("#quart").val('');
			$('#' + form).find("#mon").val('');
			$('#' + form).find("#text").hide();
			break;			
		case '':
			$('#' + th).text('기간');
			$('#' + form).find("#year").hide();
			$('#' + form).find("#quart").hide();
			$('#' + form).find("#mon").hide();
			$('#' + form).find("#dateDiv").hide();
			$('#' + form).find("#quart").val('');
			$('#' + form).find("#mon").val('');
			$('#' + form).find("#week_start").val('');
			$('#' + form).find("#week_end").val('');
			$('#' + form).find("#text").show();
			break;
		}
	}
</script>
<div class="sub_purple_01 w100p">
	<form id="paperForm" name="paperForm" onsubmit="return false;">
		<table  class="select_table" >
			<tr>
				<td width="20%" class="table_title">
					<span>■</span>
					보고서 목록
				</td>
				<td class="table_button" style="text-align: right; padding-right: 30px;">
					<span class="button white mlargep auth_select" id="btn_Select" onclick="btn_Select_onclick();">
						<button type="button">조회</button>
					</span>
					<span class="button white mlargep auth_save" id="btn_New" onclick="fn_ShowDialog();">
						<button type="button">보고서 작성</button>
					</span>
				</td>
			</tr>
		</table>
		<table  class="list_table" >
			<tr>
				<th>보고서</th>
				<td>
					<select name="qreport_id" id="qreport_id" class="w200px"></select>
				</td>
				<th>단위업무</th>
				<td>
					<select name="unit_work_cd" id="unit_work_cd" class="w200px"></select>
				</td>
				<th>작성일</th>
				<td>
					<input name="startDate" id="startDate" type="text" class="w80px" readonly="readonly" />
					<img src="<c:url value='/images/common/calendar_del.png'/>" id="startDateStop" style="cursor: pointer;" onClick='fn_TextClear("startDate")' /> ~
					<input name="endDate" id="endDate" type="text" class="w80px" readonly="readonly" />
					<img src="<c:url value='/images/common/calendar_del.png'/>" id="endDateStop" style="cursor: pointer;" onClick='fn_TextClear("endDate")' />
				</td>
			</tr>
			<tr>
				<th>구분</th>
				<td>
					<select name="qreport_type" id="qreport_type"></select>
				</td>
				<th id="typeThSearch">기간</th>
				<td colspan="3">
					<span id="text">구분값 조건을 선택해 주세요.</span>
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
						<input name="week_start" id="week_start" type="text" class="w80px" readonly="readonly" value="${detail.week_start }" />
						<img src="<c:url value='/images/common/calendar_del.png'/>" id="startDateStop" style="cursor: pointer;" onClick='fn_TextClear("week_start")' /> ~
						<input name="week_end" id="week_end" type="text" class="w80px" readonly="readonly" value="${detail.week_end }" />
						<img src="<c:url value='/images/common/calendar_del.png'/>" id="startDateStop" style="cursor: pointer;" onClick='fn_TextClear("week_end")' />
					</div>
				</td>
			</tr>
		</table>
		<input type="hidden" id="sortName" name="sortName">
		<input type="hidden" id="sortType" name="sortType">
		<div id="view_grid_main">
			<table id="paperGrid"></table>
		</div>
	</form>
</div>
<div id="dialog" style="display: none;"></div>
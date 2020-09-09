
<%
/***************************************************************************************
 * 시스템명 	: 통합장비관제시스템
 * 업무명 		: 시험담당자변경
 * 파일명 		: chargerManageL01.jsp
 * 작성자 		: 허태원
 * 작성일 		: 2015.10.16
 * 설  명		: 시험담당자변경 리스트 화면
 *---------------------------------------------------------------------------------------
 * 변경일		변경자		변경내역 
 *---------------------------------------------------------------------------------------
 * 2015.10.16    허태원		최초 프로그램 작성         
 * 
 *---------------------------------------------------------------------------------------
 ****************************************************************************************/
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" media="screen" type="text/css" href="<c:url value='/css/common/sub.css'/>" />
<!DOCTYPE html>
<style>
input[type=text] {
	ime-mode: auto;
}
</style>
<script type="text/javascript">
	$(function() {
		/* 세부권한검사 */
		fn_auth_check();
		
		fnDatePickerImg('startDate');
		fnDatePickerImg('endDate');

		//일주일전 날짜
		$('#reqListForm').find('#startDate').val(caldate(7));
		//오늘날짜
		$('#reqListForm').find('#endDate').val(caldate(0));
		
		ajaxComboForm("req_type", "C23", "ALL", "", "reqListForm");
		ajaxComboForm("dept_cd", "", "", "ALLNAME", 'reqListForm');

		$('#reqListForm').find("#req_type").change(function() {
			$('#reqListForm').find('#req_org_no').val('');
			$('#reqListForm').find('#req_org_nm').val('');
		});

		reqGrid('accept/selectChargerManageReqList.lims?commission_flag='+$("#commission_flag").val(), 'reqListForm', 'reqListGrid');
		$('#reqListGrid').clearGridData(); // 최초 조회시 데이터 안나옴

		// 엔터키 눌렀을 경우 조회 이벤트
		fn_Enter_Search('reqListForm', 'reqListGrid');
		
		resultGrid('accept/selectChargerManageItemList.lims', 'resultForm', 'resultGrid');

		$('#inputSampleForm').find("#test_sample_seq").change(function() {
			var test_req_seq = $('#reqListGrid').getGridParam('selrow');
			$('#inputSampleForm').find('#test_req_seq').val(test_req_seq);
			$('#resultForm').find('#test_sample_seq').val($('#inputSampleForm').find('#test_sample_seq').val());
			$('#resultForm').find('#test_req_seq').val(test_req_seq);
			$('#resultGrid').trigger('reloadGrid');
			$.ajax({
				url : 'accept/selectChargerManageSampleDetail.lims',
				type : 'post',
				dataType : 'json',
				async : false,
				data : $('#inputSampleForm').serialize(),
				success : function(json) {
					$(json).each(function(index, entry) {
						var sampling_date = entry["sampling_date"];
						sampling_date = sampling_date == undefined ? '' : sampling_date;
						var sampling_hour = entry["sampling_hour"];
						sampling_hour = sampling_hour == undefined ? '' : sampling_hour;
						var sampling_min = entry["sampling_min"];
						sampling_min = sampling_min == undefined ? '' : sampling_min;

						$('#inputSampleForm').find('#vw_test_sample_no').text(entry["test_sample_no"]);
						$('#inputSampleForm').find('#sample_reg_nm').text(entry["sample_reg_nm"]);
						$('#inputSampleForm').find('#sampling_date').text(sampling_date + ' [ ' + sampling_hour + '시 ' + sampling_min + '분 ]');
						$('#inputSampleForm').find('#sampling_point_nm').text(entry["sampling_point_nm"]);
						$('#inputSampleForm').find('#sampling_method').text(entry["sampling_method"]);
						$('#inputSampleForm').find('#sampling_id').text(entry["sampling_id"]);
						$('#inputSampleForm').find('#sample_nm').text(entry["sample_nm"]);
						$('#inputSampleForm').find('#test_std_nm').text(entry["test_std_nm"]);
						$('#inputSampleForm').find('#test_std_no').val(entry["test_std_no"]);
						$('#inputSampleForm').find('#test_cmt').val(entry["test_cmt"]);
						$('#inputSampleForm').find('#test_sample_result').text(entry["test_sample_result"]);
						if (entry["rawdata"] == 'Y') {
							$('#inputSampleForm').find('#rawdataBtn').show();
						} else {
							$('#inputSampleForm').find('#rawdataBtn').hide();
						}

					});
				},
				error : function() {
					alert('error');
				}
			});
		});	

		$(window).bind('resize', function() {
			$("#reqListGrid").setGridWidth($('#sub_purple_01').width(), true);
		}).trigger('resize');
		
		$(window).bind('resize', function() {
			$("#resultGrid").setGridWidth($('#itemDiv').width(), true);
		}).trigger('resize');
	});

	function reqGrid(url, form, grid, multi) {
		$('#' + grid).jqGrid({
			datatype : function(json) {
				fnGridData(url, form, grid);
			},
			height : '200',
			autowidth : true,
			loadonce : true,
			mtype : "POST",
			gridview : true,
			shrinkToFit : true,
			rowNum : -1,
			rownumbers : true,
			colModel : [ {
				label : '의뢰구분',
				name : 'req_type',
				align : 'center',
				width : '80'
			}, {
				label : 'test_req_seq',
				name : 'test_req_seq',
				align : 'center',
				hidden : true,
				key : true
			}, {
				label : '접수번호',
				name : 'test_req_no',
				align : 'center',
				width : '80'
			}, {
				label : '제목',
				name : 'title',
				width : '300',
				align : 'center'
			}, {
				label : '접수일자',
				name : 'sample_arrival_date',
				width : '100',
				align : 'center'
			}, {
				label : '성적서 발행예정일',
				name : 'deadline_date',
				width : '100',
				align : 'center'
			}, {
				label : '의뢰업체명',
				name : 'req_org_nm',
				align : 'center'
			}, {
				label : '의뢰자',
				name : 'req_nm',
				width : '60',
				align : 'center'
			}, {
				label : '접수부서',
				name : 'dept_nm',
				width : '100',
				align : 'center'
			}, {
				label : 'dept_cd',
				name : 'dept_cd',
				hidden : true
			}, {
				label : 'supv_dept_cd',
				name : 'supv_dept_cd',
				hidden : true
			}, {
				label : '단위업무',
				name : 'unit_work_cd',
				align : 'center'
			}, {
				label : '검사목적',
				name : 'test_goal',
				align : 'center'
			}, {
				label : '접수자',
				name : 'user_nm',
				width : '60',
				align : 'center'
			}, {
				label : '생성자',
				name : 'creater_nm',
				width : '60',
				align : 'center'
			} ],
			gridComplete : function() {
			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
			},
			onSelectRow : function(rowId, status, e) {
				$('#resultForm').find('input').each(function(index, entry) {
					if ($(this).attr('id') != 'user_id' && $(this).attr('id') != 'dept_cd') {
						$(this).val('');
					}
				});
				$('#inputSampleForm').find('#test_sample_seq').find('option').remove();
				$('#resultGrid').clearGridData();
				fn_Get_Sample(rowId);
			}
		});
	}
	
	var lastRowId;
	function resultGrid(url, form, grid) {
		$('#' + grid).jqGrid({
			datatype : function(json) {
				if ($('#' + form).find('#test_sample_seq').val() != '') {
					fnGridData(url, form, grid);
				}
			},
			height : '230',
			autowidth : true,
			loadonce : true,
			mtype : "POST",
			gridview : false,
			shrinkToFit : true,
			rowNum : -1,
			rownumbers : true,
			colModel : [ {
				label : 'test_sample_seq',
				name : 'test_sample_seq',
				hidden : true
			}, {
				label : 'test_item_seq',
				name : 'test_item_seq',
				hidden : true,
				key : true
			}, {
				label : 'test_item_cd',
				name : 'test_item_cd',
				hidden : true
			}, {
				type : 'not',
				label : '항목',
				name : 'test_item_nm',
				width : '340',
				align : 'center'
			}, {
				type : 'not',
				label : '항목영문명',
				name : 'test_item_eng_nm',
				width : '340',
				align : 'center'
			}, {
				label : 'user_id',
				classes : 'user_id',
				name : 'user_id',
				hidden : true
			},/*  {
				type : 'not',
				label : '항목유형',
				name : 'test_item_type',
				width : '329',
				align : 'center'
			},  */{
				type : 'not',
				label : '팀',
				name : 'team_nm',
				classes : 'team_nm',
				width : '200',
				align : 'center'
			}, {
				type : 'not',
				label : '팀코드',
				name : 'team_cd',
				classes : 'team_cd',
				hidden : true,
				width : '100'
			}, {
				type : 'not',
				label : '시험자',
				name : 'user_nm',
				classes : 'user_id',
				width : '170',
				align : 'center'
			}, {
				type : 'not',
				label : ' ',
				name : 'user_pop',
				width : '20',
				align : 'center',
				classes : 'grid_cursor',
				sortable : false,
				formatter : imageFormat_sub
			}, {
				type : 'not',
				label : 'state',
				name : 'state',
				hidden : true
			},  {
				label : 'dept_cd',
				name : 'dept_cd',
				hidden : true
			}],
			gridComplete : function() {
			},
			afterInsertRow : function(rowId, rowdata, rowelem) {
				if (rowdata.state == 'Z' || rowdata.state == 'B') {
					for (key in rowdata) {
						if (key == 'test_item_nm') {
							$('#' + grid).jqGrid('setCell', rowId, key, '[수정가능]' + rowdata.test_item_nm, {
							});			
						}
					}
				}else {
					for (key in rowdata) {
						if (key == 'test_item_nm') {
							$('#' + grid).jqGrid('setCell', rowId, key, '[수정불가능]' + rowdata.test_item_nm, {
							});							
						}
					}
				}
			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
				if (!confirm('저장하지 않은 정보는 사라집니다. 정렬하시겠습니까?')) {
					return 'stop';
				}
			},
			onCellSelect : function(rowId, iCol, cellcontent, e) {
				var colArr = $('#' + grid).jqGrid('getGridParam', 'colModel');
				var col = colArr[iCol].name;
				var row = $('#' + grid).getRowData(rowId);
				if (col == 'user_pop') {
					if(row.state == 'B' || row.state == 'Z'){
						fnpop_reqTeam("reqItemForm", "750", "500" , "team", rowId, row.dept_cd, row.test_sample_seq, row.test_item_seq, row.user_id);	
					}					
					
					$('#' + grid).jqGrid('setSelection', rowId, false);
				}
			},
			onSelectRow : function(rowId, status, e) {
			},
			ondblClickRow : function(rowId, iRow, iCol, e) {
			}
		});
		$('#' + grid).sortableRows();
	}

	function btn_Select_onclick() {
		$('#reqListGrid').trigger('reloadGrid');
		$('#resultForm').find('input').each(function(index, entry) {
			if ($(this).attr('id') != 'user_id' && $(this).attr('id') != 'state') {
				$(this).val('');
			}
		});
		$('#inputSampleForm').find('label').text('');
		$('#inputSampleForm').find('#test_sample_seq').find('option').remove();
		$('#resultGrid').clearGridData();
	}
	
	//시료 콤보 선택
	function fn_Get_Sample(test_req_seq) {
		fnSelectSampleComboForm('inputSampleForm', 'test_sample_seq', test_req_seq, '');
	}
	
	// 시험 팀 선택
	function fnpop_reqTeam(formName, width, hight , type, rowId, dept_cd, test_sample_seq, test_item_seq, user_id) {
		fnBasicStartLoading();
		fnpop_reqTeamPop(formName, width, hight , type, rowId, dept_cd, test_sample_seq, test_item_seq, user_id);
	}
	
	// 자식 -> 부모창 함수 호출
	function fnpop_callback(returnParam){
		$('#resultGrid').trigger('reloadGrid');
		fnBasicEndLoading();
	}
	
	//본인조회 클릭 이벤트
	function use_flag_onclick(){
		if($('#reqListForm').find('#use_flag').is(":checked")){
			$('#reqListForm').find('#tester_id').attr("readonly", true);
			$('#reqListForm').find('#tester_id').val('${session.user_nm}');
			
		}else{
			$('#reqListForm').find('#tester_id').attr("readonly", false);
			$('#reqListForm').find('#tester_id').val('');
		}
	}

	//날짜 계산
	function caldate(day) {
		var caledmonth, caledday, caledYear;
		var loadDt = new Date();
		var v = new Date(Date.parse(loadDt) - day * 1000 * 60 * 60 * 24);

		caledYear = v.getFullYear();

		if (v.getMonth() + 1 < 10) {
			caledmonth = '0' + (v.getMonth() + 1);
		} else {
			caledmonth = v.getMonth() + 1;
		}

		if (v.getDate() < 10) {
			caledday = '0' + v.getDate();
		} else {
			caledday = v.getDate();
		}
		return caledYear + '-' + caledmonth + '-' + caledday;
	}
	
</script>
<div>
	<form id="reqListForm" name="reqListForm" onsubmit="return false;">
		<div class="sub_purple_01 w100p" style="margin-top: 0px;">
			<table width="100%" border="0" class="select_table" >
				<tr>
					<td width="20%" class="table_title">
						<span>■</span>
						접수목록
					</td>
					<td class="table_button" style="text-align: right; padding-right: 30px;">
						<span class="button white mlargep auth_select" id="btn_Select" onclick="btn_Select_onclick();">
							<button type="button">조회</button>
						</span>
					</td>
				</tr>
			</table>
			<table width="100%" border="0" class="list_table" >
				<tr>
					<th>접수번호</th>
					<td>
						<input name="test_req_no" id="test_req_no" type="text" class="w100px" />
					</td>
					<th>의뢰구분</th>
					<td>
						<select name="req_type" id="req_type" class="w100px"></select>
					</td>
					<th>제목</th>
					<td>
						<input name="title" id="title" type="text" class="w300px" />
					</td>
				</tr>
				<tr>
					<th>의뢰업체명</th>
					<td>
						<input name="req_org_nm" id="req_org_nm" type="text" class="w100px" />
						<img style="cursor: pointer; vertical-align: text-bottom;" src="images/common/icon_search.png"  class="auth_select" onclick='fnpop_reqOrgChoicePop("reqListForm", "750", "550", "결과입력")' />
					</td>
					<th>의뢰자</th>
					<td>
						<input name="req_nm" id="req_nm" type="text" class="inputhan w100px" />
					</td>
					<th>접수일자</th>
					<td>
						<input name="startDate" id="startDate" type="text" class="w80px" readonly="readonly" />
						<img src="<c:url value='/images/common/calendar_del.png'/>" id="startDateStop" style="cursor: pointer;" onClick='fn_TextClear("startDate")' /> ~
						<input name="endDate" id="endDate" type="text" class="w80px" readonly="readonly" />
						<img src="<c:url value='/images/common/calendar_del.png'/>" id="endDateStop" style="cursor: pointer;" onClick='fn_TextClear("endDate")' />
					</td>
				</tr>
				<tr>
					<th>접수부서</th>
					<td>
						<select name="dept_cd" id="dept_cd" class="w200px"></select>
					</td>
					<th>진행상태</th>
					<td>
						<select name="state" id="state" class="w200px" onchange="fn_set_state(this);">
							<option value="Z">접수대기</option>
							<option value="B">결과입력대기</option>
						</select>
					</td>
					<th>항목담당자</th>
					<td>
						<input type="text" id="tester_id" name="tester_id" class="w200px"/>
						<input type="checkbox" id="use_flag" value="Y" onclick="use_flag_onclick();"/>본인조회
					</td>					
				</tr>
			</table>
		</div>
		<input type="hidden" id="sortName" name="sortName">
		<input type="hidden" id="sortType" name="sortType">
		<input type="hidden" id="pageType" name="pageType" value="chargerManage">
		<div id="view_grid_main">
			<table id="reqListGrid"></table>
		</div>
	</form>
</div>
<div id="sampleDiv">
	<form id="inputSampleForm" name="inputSampleForm" onsubmit="return false;">
		<div class="sub_purple_01 w100p">
			<table width="100%" border="0" class="select_table" >
				<tr>
					<td width="20%" class="table_title">
						<span>■</span>
						시료정보
					</td>
				</tr>
			</table>
			<table width="100%" border="0" class="list_table" >
				<tr>
					<th>시료 선택</th>
					<td colspan="5">
						<input name="test_req_seq" id="test_req_seq" type="hidden" readonly="readonly" />
						<select id="test_sample_seq" name="test_sample_seq" class="w300px"></select>
					</td>
					<th>시료판정</th>
					<td>
						<label id="test_sample_result"></label>
					</td>
				</tr>
				<tr>
					<th>시료번호</th>
					<td style="width: 10%;">
						<label id="vw_test_sample_no"></label>
					</td>
					<th>시료명</th>
					<td style="width: 10%;">
						<label id="sample_reg_nm"></label>
					</td>
					<th>시료유형</th>
					<td style="width: 10%;">
						<label id="sample_nm"></label>
					</td>
					<th>검사기준</th>
					<td style="width: 10%;">
						<label id="test_std_nm"></label>
					</td>
				</tr>
			</table>
		</div>
	</form>
</div>
<div id="itemDiv">
	<form id="resultForm" name="resultForm" onsubmit="return false;">
		<input type="hidden" id="user_id" name="user_id" value="${session.user_id }" />
		<input type="hidden" id="test_req_seq" name="test_req_seq" />
		<input type="hidden" id="test_sample_seq" name="test_sample_seq" />
		<input type="hidden" id="state" name="state" value="B">
		<input type="hidden" id="sortName" name="sortName">
		<input type="hidden" id="sortType" name="sortType">
		<div id="view_grid_sub1">
			<table id="resultGrid"></table>
		</div>
	</form>
</div>



<%
	/***************************************************************************************
	 * 시스템명 	: 통합장비관제시스템
	 * 업무명 		: 업무별통계
	 * 파일명 		: testStatusL01.jsp
	 * 작성자 		: 최은향
	 * 작성일 		: 2015.10.21
	 * 설  명		: 
	 *---------------------------------------------------------------------------------------
	 * 변경일		 변경자		변경내역 
	 *---------------------------------------------------------------------------------------
	 * 2015.10.21    최은향		최초 프로그램 작성         
	 * 
	 *---------------------------------------------------------------------------------------
	 ****************************************************************************************/
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html >
<link rel="stylesheet" media="screen" type="text/css" href="<c:url value='/css/common/sub.css'/>" />
<style>
.ui-jqgrid .ui-jqgrid-hbox {padding-right:0px;width:100% !important;}
.ui-jqgrid-ftable {width:100% !important;}
</style>
<script type="text/javascript">
	var colModel;
	var groupHeaders;
	
	$(function() {
		/* 세부권한검사 */
		fn_auth_check();
		
		fnDatePickerImg('startDate');
		fnDatePickerImg('endDate');
		
		$('#testStatisticsForm').find('#startDate').val(fnGetToday(0,0));
		$('#testStatisticsForm').find('#endDate').val(fnGetToday(-1,0));
		
		testStatusGrid('resultStatistical/selectTestStatus.lims', 'testStatisticsForm', 'testStatisticsGrid');
		$('#testStatisticsGrid').clearGridData(); // 최초 조회시 데이터 안나옴
		
		$(window).bind('resize', function() {
			$("#testStatisticsGrid").setGridWidth($('#view_grid_main').width(), false);
		}).trigger('resize');

		fn_Enter_Search('testStatisticsForm', 'testStatisticsGrid');

		btn_type_onclick($(":input:radio[name=type]:checked").val());
		
		ajaxComboForm("statusState", "", "ALL", "", "testStatisticsForm");
	});
	
	
	// 그리드
	function testStatusGrid(url, form, grid) {
		$('#' + grid).jqGrid({
			datatype : function(json) {
				fnGridData(url, form, grid);
			},
			height : '460',
			autowidth : true,
			loadonce : true,
			mtype : "POST",
			gridview : true,
			shrinkToFit : false,
			footerrow: true,
			userDataOnFooter: true,
			rowNum : -1,
			rownumbers : true,
			colModel : [ {
				label :'건수',
				name : 'cnt1',
				hidden : true,
				align : 'center',
				width : '100'
			}, {
				label : '접수번호',
				width : '80',
				align : 'center',
				name : 'test_req_no'
			}, {
				label : '의뢰구분',
				width : '60',
				align : 'center',
				name : 'req_type'
			}, {
				label : '제목',
				width : '180',
				name : 'title'
			}, {
				label : '시료번호',
				width : '80',
				align : 'center',
				name : 'test_sample_seq'
			}, {
				label : '시료명',
				width : '100',
				name : 'sample_reg_nm'
			}, {
				label : '항목명',
				width : '200',
				name : 'test_item_cd'
			}, {
				label : '시험자',
				width : '80',
				align : 'center',
				name : 'tester_id'
			}, {
				label : '시험팀',
				width : '80',
				align : 'center',
				name : 'team_cd'
			}, {
				label : '진행상태',
				width : '80',
				align : 'center',
				name : 'state'
			}, {
				label : '결과값',
				width : '80',
				align : 'center',
				name : 'result_val'
			}, {
				label : '결과유형',
				width : '80',
				align : 'center',
				name : 'result_type'
			}, {
				label : '요청일자',
				width : '80',
				align : 'center',
				name : 'sample_arrival_date'
			}, {
				label : '성적서 발행예정일',
				width : '80',
				align : 'center',
				name : 'deadline_date'
			}, {
				label : '의뢰업체',
				width : '100',
				name : 'req_org_no'
			}
			/* , {
				label : '시험완료준수여부',
				width : '100',
				name : 'req_org_no'
			}, {
				label : '성적서발행준수여부',
				width : '100',
				name : 'req_org_no'
			}   */
			],
			emptyrecords : '데이터가 존재하지 않습니다.',
			gridComplete : function() {
				// 하단 합계 부분
				var sum = $("#" + grid).jqGrid('getCol', 'cnt1', false, 'sum');
				$("#" + grid).jqGrid('footerData', 'set', {req_org_no: '총: ' + sum + ' 건'} );
				
				// 스타일 주기 
				$('table.ui-jqgrid-ftable').css('postion', 'absolute');
				$('table.ui-jqgrid-ftable tr:first').children('td').css('background-color', '#dfeffc');	// 배경색
				$('table.ui-jqgrid-ftable tr:first').children('td').css('font-weight', 'normal'); 		// 폰트 스타일
				$('table.ui-jqgrid-ftable tr:first td:eq(16)').css('padding-top','8px');
				$('table.ui-jqgrid-ftable tr:first td:eq(16)').css('padding-bottom','8px');
				$('table.ui-jqgrid-ftable tr:first td:eq(16)').css('font-weight', 'bold'); // 총계				
				
				// td 병합
				$("table.ui-jqgrid-ftable td:eq(0)").hide();
				$("table.ui-jqgrid-ftable td:eq(1)").hide();
				$("table.ui-jqgrid-ftable td:eq(2)").hide();
				$("table.ui-jqgrid-ftable td:eq(3)").hide();
				$("table.ui-jqgrid-ftable td:eq(4)").hide();
				$("table.ui-jqgrid-ftable td:eq(5)").hide();
				$("table.ui-jqgrid-ftable td:eq(6)").hide();
				$("table.ui-jqgrid-ftable td:eq(7)").hide();
				$("table.ui-jqgrid-ftable td:eq(8)").hide();
				$("table.ui-jqgrid-ftable td:eq(9)").hide();
				$("table.ui-jqgrid-ftable td:eq(10)").hide();
				$("table.ui-jqgrid-ftable td:eq(11)").hide();
				$("table.ui-jqgrid-ftable td:eq(12)").hide();
				$("table.ui-jqgrid-ftable td:eq(13)").hide();
				$("table.ui-jqgrid-ftable td:eq(14)").hide();
				$("table.ui-jqgrid-ftable td:eq(15)").hide();
				
				// 총계 공백
				$('table.ui-jqgrid-ftable tr:first td:eq(16)').css("padding-right","50px");
				
				// 총합계 정렬
				$('table.ui-jqgrid-ftable tr:first td:eq(16)').css("text-align","right");		// 총계
				
			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
			},
			onSelectRow : function(rowId, status, e) {
			}
		});
	}
	
	// 조회 조건
	function btn_type_onclick(val) {
		var arrShow = new Array();
		var arrHide = new Array();
		var grid = 'testStatisticsGrid';
		//alert(val);
		// 시험자
		if(val == 'Y'){			
			arrShow.push('tester_id');
			arrHide.push('team_cd');
			$('#user_nm').show();
			$('#team_nm').hide();
			$('#userInfo').show();
			$('#teamInfo').hide();
			$('#team_cd').val('');
			$('#team_nm').val('');
		} else {
			arrShow.push('team_cd');
			arrHide.push('tester_id');
			$('#user_nm').hide();
			$('#team_nm').show();
			$('#userInfo').hide();
			$('#teamInfo').show();
			$('#user_id').val('');
			$('#user_nm').val('');
		}
		$('#' + grid).showCol(arrShow);
		$('#' + grid).hideCol(arrHide);
		btn_Select_onclick();
	}	
	
	// 조회
	function btn_Select_onclick(){
		$('#testStatisticsGrid').trigger('reloadGrid');
	} 
	
	// 엑셀 다운로드
	function btn_Excel_onclick() {
		var data = fn_Excel_Data_Make('testStatisticsGrid');
		fn_Excel_Download(data);
	}
	
	// 사용자 추가 팝업
	function fnpop_UserInfo(){		
		fnBasicStartLoading();
		fnpop_UserInfoPop("testStatisticsForm", "500", "500", "user", '');
	}
	
	// 팀 추가 팝업
	function fnpop_TeamInfo(){
		fnBasicStartLoading();
		fnpop_TeamInfoPop("testStatisticsForm", "500", "500", "team");
	}
	
	// 콜백
	function fnpop_callback(){
		fnBasicEndLoading();
	}
</script>
<div class="sub_purple_01 w100p">
	<form id="testStatisticsForm" name="testStatisticsForm" onsubmit="return false;">
		<table  class="select_table" >
			<tr>
				<td width="20%" class="table_title" nowrap="nowrap">
					<span>■</span>
					담당별 업무현황
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
				<th>구분</th>
				<td>
					<input name="type" id="type" type="radio" value="Y" checked="checked"  onClick="btn_type_onclick($(this).val())"/>
					시험자
					<input name="type" id="type" type="radio" value="N"  onClick="btn_type_onclick($(this).val())"/>
					시험팀
					<span style="padding-right:15px;"></span>
					<input name="user_nm" id="user_nm" type="text" class="w80px"/>
					<input name="user_id" id="user_id" type="hidden" class="w80px"/>
					<input name="team_nm" id="team_nm" type="text" class="w80px"/>
					<input name="team_cd" id="team_cd" type="hidden" class="w80px"/>
					<img style="cursor: pointer; vertical-align: text-bottom;" src="images/common/icon_search.png" class="auth_select" id="userInfo" onclick='fnpop_UserInfo();'/>
					<img style="cursor: pointer; vertical-align: text-bottom;" src="images/common/icon_search.png" class="auth_select" id="teamInfo" onclick='fnpop_TeamInfo();'/>
					<img src="images/common/icon_stop.png" id="infoDel" style="cursor: pointer; vertical-align: text-bottom;" onClick='fn_TextClear("user_id"), fn_TextClear("user_nm"), fn_TextClear("team_nm"), fn_TextClear("team_cd")' />
					
				</td>				
				<th>업무유형</th>
				<td>
					<select name="state" id="statusState" class="w100px"></select>
				</td>				
				<th>처리기한</th>
				<td>
					<input name="startDate" id="startDate" type="text" class="w80px" readonly="readonly" />
					<img src="<c:url value='/images/common/calendar_del.png'/>" id="startDateStop" style="cursor: pointer;" onClick='fn_TextClear("startDate")' /> ~
					<input name="endDate" id="endDate" type="text" class="w80px" readonly="readonly" />
					<img src="<c:url value='/images/common/calendar_del.png'/>" id="endDateStop" style="cursor: pointer;" onClick='fn_TextClear("endDate")' />
				</td>
			</tr>
		</table>
		<input type="hidden" id="sortName" name="sortName">
		<input type="hidden" id="sortType" name="sortType">
		<div id="view_grid_main">
			<table id="testStatisticsGrid"></table>
		</div>
	</form>
</div>

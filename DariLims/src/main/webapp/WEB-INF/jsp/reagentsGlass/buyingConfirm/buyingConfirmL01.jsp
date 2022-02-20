
<%
	/***************************************************************************************
	 * 시스템명 	: 통합장비관제시스템
	 * 업무명 		: 구매검수등록
	 * 파일명 		: buyingConfirmL01.jsp
	 * 작성자 		: 최은향
	 * 작성일 		: 2015.05.20
	 * 설  명		: 구매검수등록 조회 화면
	 *---------------------------------------------------------------------------------------
	 * 변경일		 변경자		변경내역 
	 *---------------------------------------------------------------------------------------
	 * 2015.05.20    최은향		최초 프로그램 작성         
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
	var buy_sts;
	var mtlr_mst_no;
	
	$(function() {
		/* 세부권한검사 */
		fn_auth_check();
		
		buy_sts = fnGridCommonCombo('C39', null);
		ajaxComboForm("buy_q", "C14", "", "", 'form');
		ajaxComboForm("buy_sts", "C39", '', '', "form");
		checkYear('ALL', new Date().getFullYear(), 'sel_buy_year');
		
		grid('reagents/selectBuyingInfoList.lims?pageType=info', 'form', 'grid');
		$('#grid').clearGridData(); // 최초 조회시 데이터 안나옴
				
		// 엔터키 눌렀을 경우
		fn_Enter_Search('form', 'grid');

		// 그리드 사이즈 
		$(window).bind('resize', function() { 
		    $("#grid").setGridWidth($('#view_grid_main').width(), true); 
		}).trigger('resize');
	});
	function grid(url, form, grid) {
		var lastRowId = 0;
		$('#' + grid).jqGrid({
			datatype : function(json) {
				fnGridData(url, form, grid);
			},
			height : '230',
			autowidth : true,
			loadonce : true,
			mtype : "POST",
			gridview : true,
			shrinkToFit : false,
			rowNum : -1,
			rownumbers : true,
			colModel : [ {
				label : 'mtlr_mst_no',
				name : 'mtlr_mst_no',
				key : true,
				hidden : true,
				search : false
			}, {
				label : '진행상태',
				name : 'buy_sts',
				align : 'center',
				width : '80',
				formatter : 'select',
				edittype : "select",
				editoptions : {
					value : buy_sts
				}
			}, {
				label : '구매명칭',
				name : 'buy_title',
				width : '200'
			}, {
				label : '구매년도',
				name : 'buy_year',
				align : 'center',
				width : '60'
			}, {				
				label : '구매분기',
				name : 'buy_q',
				align : 'center',
				width : '80'
			}, {
				label : '수요조사시작일',
				name : 'buy_date',
				align : 'center',
				width : '100'
			}, {
				label : '수요조사종료일',
				name : 'dmd_date',
				align : 'center',
				width : '100'
			}, {
				label : '구매비고',
				name : 'buy_etc'				
			/* }, {
				label : '진행상태',
				name : 'state',
				width : '100' */
			} ],
			emptyrecords: '데이터가 존재하지 않습니다.',
			gridComplete : function() {
				lastRowId = 0;
// 				fnSelectFirst(grid);
			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
			},
			beforeSelectRow : function(rowId, e) {
 				if (rowId && rowId != lastRowId) {
					if(editCount()) {
						if(!confirm("수정중인 구매요청 목록은 사라집니다."))
							return 'stop';
					}
				} 
 				return true;			
			},
			onSelectRow : function(rowId, status, e) {
				
				if (rowId && rowId != lastRowId) {	
					lastRowId = rowId;
					var param = 'mtlr_mst_no=' + rowId;
					// 구매검수 등록
					fnViewPage('reagents/buyingConfirmList.lims', 'detail', param);
				}
				var rowData = $('#' + grid).jqGrid ('getRowData', rowId);
				if(rowData.buy_sts != 'C39001') {
					$('#btn_Insert').hide();
				} else {
					$('#btn_Insert').show();
				}
			}
		});
	}
	
	// 구매요청목록에 수정, 삭제, 업데이트 된 항목이 있는지 확인
	function editCount() {
		var grid = 'reqGrid';
		var check = false;
		var ids = $('#' + grid).jqGrid("getDataIDs");
		for(var i in ids) {
			var row = $('#reqGrid').getRowData(ids[i]);
			if(row.crud == 'n' || row.crud == 'd' || row.crud == 'u') 			
				check = true;
		}		
		return check;
	}
	
	// 조회버튼 클릭 이벤트
	function btn_Search_onclick() {		
		if(editCount()) {
			if(!confirm("수정중인 구매요청 목록은 사라집니다."))
				return 'stop';
		}
		$('#detail').empty();
		$('#grid').trigger('reloadGrid');
	}
	
	// 구매년도 콤보박스
	function checkYear(type, year, id) {
		var name = id;
		if (type == 'ALL') {
			$('#' + name).append($('<option />').val('').html('전체'));
		}
		for (var i = new Date().getFullYear() + 5; i > new Date().getFullYear() - 5; i--)
		{			
			if(year == i) {
				$('#' + name).append($('<option selected />').val(i).html(i + ' 년'));
			} else
		    	$('#' + name).append($('<option />').val(i).html(i + ' 년'));
		}
	}	
	
	// 요청자 등록팝업
	function btn_Pop_AdminChoice() {
		/* var form = 'detail';
		var popup = popUserInfo();
		if (popup != null) {
			var arr = popup.split('■★■');
			for ( var r in arr) {
				var v = arr[r].split('●★●');
				var id = v[0];
				if (id == 'user_nm') {
					id = 'user_nm'; // 요청자명
				} else if (id == 'user_id') {
					id = 'creater_id';// 요청자ID
				} 
				$('#' + form).find('#' + id).val(v[1]);
			}
		} */
		
		fnBasicStartLoading();		
		fnpop_UserInfoPop("reqForm", "500", "500", 'buyingConfirm', '');
		
	}
	
	function fnpop_buyingConfirmcallback(){
		
	}
	
	
</script>

<div id="buyingDiv">
	<form id="form" name="form" onsubmit="return false;">
		<div class="sub_purple_01">
			<table  class="select_table" >
				<tr>
					<td width="20%" class="table_title">
						<span>■</span>
						구매정보목록
					</td>
					<td class="table_button" style="text-align: right; padding-right: 30px;">
						<span class="button white mlargep auth_select" id="btn_Select" onclick="btn_Search_onclick();">
							<button type="button">조회</button>
						</span>
					</td>
				</tr>
			</table>
			<table  class="list_table" >
				<tr>
					<th>진행상태</th>
					<td>
						<select name="buy_sts" id="buy_sts" ></select>
					</td>
					<th>구매명칭</th>
					<td>
						<input name="buy_title" type="text"  />
					</td>				
					<th>구매년도</th>
					<td>
						<select name="buy_year" id="sel_buy_year"></select>
					</td>
					<th>구매분기</th>
					<td>
						<select name="buy_q" id="buy_q" ></select>
					</td>
				</tr>
			</table>
		</div>	
		<input type="hidden" id="sortName" name="sortName">
		<input type="hidden" id="sortType" name="sortType">
		<div id="view_grid_main">
			<table id="grid"></table>
		</div>
	</form>
</div>
<form id="detail" onsubmit="return false;"></form>
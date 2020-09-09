
<%
	/***************************************************************************************
	 * 시스템명 	: 통합장비관제시스템
	 * 업무명 		: 채수장소조회(팝업)
	 * 파일명 		: acceptP04.jsp
	 * 작성자 		: 진영민
	 * 작성일 		: 2015.01.22
	 * 설  명		: 
	 *---------------------------------------------------------------------------------------
	 * 변경일		 변경자		변경내역 
	 *---------------------------------------------------------------------------------------
	 * 2015.01.22    진영민		최초 프로그램 작성         
	 * 
	 *---------------------------------------------------------------------------------------
	 ****************************************************************************************/
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<style type="text/css">
.rNum {
	background: #dfeffc url("./css/images/ui-bg_glass_85_dfeffc_1x400.png") 50% 50% repeat-x;
	color: #2e6e9e !important;
}
</style>
<script type="text/javascript">
	$(function() {
		grid('accept/selectSamplingPointList.lims', 'samplingForm', 'samplingGrid');

		ajaxComboForm("sampling_object", "C29", "ALL", "", "samplingForm"); // 채수대상
		
		fnViewPage('accept/selectSamplingPointListPaging.lims', 'paging', $('#samplingForm').serialize()); // 하단 게시글 번호
		
		$(window).bind('resize', function() {
			$("#samplingGrid").setGridWidth($('#view_grid_main').width(), false);
			$("#paging").width($("#view_grid_main").width() + 2); // 하단 페이징
		}).trigger('resize');

		fn_Enter_Search('samplingForm', 'samplingGrid');
	});
	
	function grid(url, form, grid) {
		var lastRowId;
		$('#' + grid).jqGrid({
			datatype : function(json) {
				fnGridData(url, form, grid);
			},
			//height : '230',
			height : '248',
			autowidth : true,
			loadonce : true,
			mtype : "POST",
			gridview : true,
			shrinkToFit : false,
			rowNum : -1,
			rownumbers : false,
			colModel : [ {
				label : '번호',
				name : 'rNum',
				width : '30',
				align : 'center',
				classes : 'rNum',
				sortable : false
			}, {
				label : 'sampling_point_no',
				name : 'sampling_point_no',
				key : true,
				hidden : true
			}, {
				label : '채수장소',
				name : 'sampling_point_nm'
			}, {
				label : '채수대상',
				name : 'sampling_object',
				width : '80',
				align : 'center'
			}, {
				label : '정수장수계',
				name : 'water_system',
				width : '80',
				align : 'center'
			}, {
				label : '사업소',
				name : 'org_nm',
				width : '80',
				align : 'center'
			}, {
				label : '시설유형',
				name : 'facilities_type',
				width : '80',
				align : 'center'
			}, {
				label : '급수형태',
				name : 'supply_type',
				width : '80',
				align : 'center'
			}, {
				label : '코스',
				name : 'course_nm',
				width : '80',
				align : 'center'
			}, {
				label : '주소',
				width : '200',
				name : 'addr'
			}, {
				label : '상호',
				name : 'company_nm'
			} ],
			gridComplete : function() {
			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
			},
			onSelectRow : function(rowId, status, e) {
			},
			ondblClickRow : function(rowId, iRow, iCol, e) {
				btn_Save_onclick(grid);
			}
		});
	}
	
	// 조회 이벤트
	function btn_Select_onclick() {
		$('#pageNo').val(1);
		$('#samplingGrid').trigger('reloadGrid');
		fnViewPage('accept/selectSamplingPointListPaging.lims', 'paging', $('#samplingForm').serialize()); // 하단 게시글 번호		
	}	
	
	function btn_Save_onclick() {
		var rowId = $('#samplingGrid').getGridParam('selrow');
		if (rowId != null) {
			var row = $('#samplingGrid').getRowData(rowId);
			window.returnValue = row.sampling_point_nm + '◆★◆' + rowId;
			window.close();
		} else {
			alert('선택된 행이 없습니다.');
		}
	}
	
	// 페이징 이벤트(하단 번호, >, >> 버튼이벤트)
	function linkPage(pageNo) {
		$('#pageNo').val(pageNo);
		$('#samplingGrid').trigger('reloadGrid');
		fnViewPage('accept/selectSamplingPointListPaging.lims', 'paging', $('#samplingForm').serialize()); // 하단 게시글 번호
	}
</script>
<div class="popUp">
	<div class="pop_area pop_intro">
		<h2>채수장소</h2>
		<form id="samplingForm" name="samplingForm" onsubmit="return false;">
			<div class="sub_purple_01" style="margin-top: 0px;">
				<table width="100%" border="0" class="select_table" cellpadding="0" cellspacing="0">
					<tr>
						<td width="20%" class="table_title">
							<span>■</span>
							채수장소 목록
						</td>
						<td class="table_button" style="text-align: right; padding-right: 30px;">
							<span class="button white mlargeb" id="btn_Select" onclick="btn_Select_onclick();">
								<button type="button">조회</button>
							</span>
							<span class="button white mlargeg" id="btn_Save" onclick="btn_Save_onclick();">
								<button type="button">선택</button>
							</span>
							<span class="button white mlargep" id="btn_Cancel" onclick="window.close();">
								<button type="button">닫기</button>
							</span>
						</td>
					</tr>
				</table>
				<table width="100%" border="0" class="list_table" cellpadding="0" cellspacing="0">
					<tr>
						<th>채수장소</th>
						<td>
							<input name="sampling_point_nm" type="text w100px" class="inputhan w100px" />
						</td>
						<th>채수대상</th>
						<td>
							<select name="sampling_object" id="sampling_object" class="w100px"></select>
						</td>
						<th>사업소</th>
						<td>
							<input name="org_nm" type="text w100px" class="inputhan" />
						</td>
					</tr>
				</table>
			</div>
			<input type="hidden" id="pageNo" name="pageNo" value="1">
			<input type="hidden" id="totalCount" name="totalCount" value="0">
			<input type="hidden" id="sortName" name="sortName">
			<input type="hidden" id="sortType" name="sortType">
			<div id="view_grid_main">
				<table id="samplingGrid"></table>
				<div id="paging"></div>				
			</div>
		</form>
	</div>
</div>
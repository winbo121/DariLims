
<%
	/***************************************************************************************
	 * 시스템명     : 통합장비관제시스템
	 * 업무명 		: 항목별 시험기기
	 * 파일명 		: testItemInstrumentL01.jsp
	 * 작성자 		: 석은주
	 * 작성일 		: 2015.01.22
	 * 설  명		: 항목별 시험기기 목록 조회 화면
	 *---------------------------------------------------------------------------------------
	 * 변경일	     변경자		변경내역 
	 *---------------------------------------------------------------------------------------
	 * 2015.01.22    석은주		최초 프로그램 작성         
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
	var editChange;
	var test_std_no;
	$(function() {
		/* 세부권한검사 */
		fn_auth_check();
		
		ajaxComboStdNo('test_std_no');
		
		ajaxComboForm("test_item_type", "C20", "ALL", "", "form");

		testItemInstLGrid('master/selectTestItemList.lims', 'form', 'testItemInstLGrid');
		$('#testItemInstLGrid').clearGridData(); // 최초 조회시 데이터 안나옴

		fn_Enter_Search('form', 'testItemInstLGrid');

		//그리드 사이즈 
		$(window).bind('resize', function() {
			$("#testItemInstLGrid").setGridWidth($('#sub_purple_01').width(), false);
		}).trigger('resize');
		
		$('#itemInstrumentGrid').hide();
		$('#allItemInstrumentGrid').hide();
	});
	
	function testItemInstLGrid(url, form, grid) {
		var lastRowId = 0;
		$('#' + grid).jqGrid({
			datatype : function(json) {
				fnGridData(url, form, grid);
			},
			height : '610',
			autowidth : false,
			loadonce : true,
			mtype : "POST",
			gridview : true,
			shrinkToFit : true,
			rowNum : -1,
			rownumbers : true,
			colModel : [ {
				label : '항목번호',
				name : 'test_item_cd',
				key : true,
				search : false,
				hidden : true
			}, {
				label : '항목대분류',
				name : 'testitm_lclas_cd',
				width : '100'
			}, {
				label : '항목중분류',
				name : 'testitm_mlsfc_cd',
				width : '100'
			}, {
				label : '항목명',
				name : 'test_item_nm',
				width : '200'
			}, {
				label : '항목영문명',
				name : 'eng_nm',
				width : '300'
			}],
			emptyrecords : '데이터가 존재하지 않습니다.',
			gridComplete : function(rowId) {
				editChange = false;
				lastRowId = 0;
				//fnSelectFirst(grid);
				
				var param = 'test_item_cd=' + rowId;
				fnViewPage('master/testItemInstrumentList.lims', 'detail', param);
					
				$('#itemInstrumentGrid').hide();
				$('#allItemInstrumentGrid').hide();
			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
			},
			beforeSelectRow : function(rowId, e) {
				if (rowId && rowId != lastRowId) {
					if (editChange) {
						if (!confirm('수정중인 시험기기 목록은 사라집니다. 이동하시겠습니까?'))
							return;
					}
				}
				editChange = false;
				return true;
			},
			onSelectRow : function(rowId, status, e) {
				$('#itemInstrumentGrid').show();
				$('#allItemInstrumentGrid').show();
				if (rowId && rowId != lastRowId) {
					lastRowId = rowId;
					var param = 'test_item_cd=' + rowId + '&test_std_no=' + test_std_no;
					fnViewPage('master/testItemInstrumentList.lims', 'detail', param);
				}
			}
		});
	}
	
	// 조회버튼 클릭 이벤트
	function btn_Search_onclick() {
		if (editChange) {
			if (!confirm('수정중인 시험기기 목록은 사라집니다. 이동하시겠습니까?'))
				return;
		}
		editChange = false;
		$('#detail').empty();
		$('#testItemInstLGrid').trigger('reloadGrid');
	}
	
	// 검사기준콤보박스리로드
	function comboReload(key) {		
		ajaxComboStdNo(key, '');
	}	
	
	// 콤보박스
	function ajaxComboStdNo(obj, val) {
		var masterUrl = '';
		var v = '';
		var t = '';
		var data = '';
		
		if (obj == 'test_std_no') {
			masterUrl = 'master/selectTestStdList.lims';
			v = "test_std_no";
			t = "test_std_nm";
		} else {
			masterUrl = 'master/selectTestStdRevList.lims';
			v = "rev_no";
			t = "rev_no";
		}
		data = 'test_std_no=' + $('#form').find('#test_std_no').val();		
		btn_Search_onclick();				
		
		$.ajax({
			url : masterUrl,
			type : 'POST',
			async : false,
			dataType : 'json',
			data : data,
			timeout : 5000,
			error : function() {
				alert('Error loading XML document');
			},
			success : function(json) {
				$("#" + obj).empty();
				$(json).each(function(index, entry) {					
					if (val == entry[v] || val == entry[t])
						$("#" + obj).append("<option selected value='" + entry[v] + "'>" + entry[t] + "</option>");
					else
						$("#" + obj).append("<option value='" + entry[v] + "'>" + entry[t] + "</option>");
				});
				//$("#" + obj).trigger('change');// 강제로 이벤트 시키기
			}
		});
		test_std_no = $('#form').find('#test_std_no').val();
	}
	
	// 조회 이벤트
	function btn_Select_onclick() {
		$('#testItemInstLGrid').trigger('reloadGrid');
		btn_Search_Sub1_onclick();
	}
</script>
<div class="sub_purple_01 w45p" style="margin-top:0px;">
	<form id="form" name="form" onsubmit="return false;">
		<div class="sub_purple_01">
			<table  class="select_table" >
				<tr>
					<td width="20%" class="table_title">
						<span>■</span>
						시험항목별 시험기기
					</td>
					<td class="table_button" style="text-align: right; padding-right: 30px;">
					<span class="button white mlargep auth_select" id="btn_Select" onclick="btn_Select_onclick();">
						<button type="button">조회</button>
					</span>
				</td>				
				</tr>
			</table>
			<table  class="list_table" >
				<tr>
					<th>항목유형</th>
					<td>
						<select name="testitm_lclas_cd" id="testitm_lclas_cd" class="w150px"></select>
						<select name="testitm_mlsfc_cd" id="testitm_mlsfc_cd" class="w150px"></select>
					</td>
				</tr>
				<tr>
					<th>항목명</th>
					<td width="30%">
						<input name="test_item_nm" id="test_item_nm" type="text" class="" value="${detail.test_item_nm }" />
					</td>
				</tr>
			</table>
		</div>
	
		<input type="hidden" id="sortName" name="sortName">
		<input type="hidden" id="sortType" name="sortType">
		<div id="view_grid_main">
			<table id="testItemInstLGrid"></table>
		</div>
	</form>
</div>

<div class="w10p"></div>

<div class="sub_blue_01 w45p" style="margin-top:0px;">
	<form id="detail" onsubmit="return false;"></form>
</div>
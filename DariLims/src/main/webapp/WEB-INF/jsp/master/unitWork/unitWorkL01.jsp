
<%
	/***************************************************************************************
	 * 시스템명 	: 통합장비관제시스템
	 * 업무명 		: 단위업무등록
	 * 파일명 		: unitWorkL01.jsp
	 * 작성자 		: 최은향
	 * 작성일 		: 2015.01.21
	 * 설  명		: 단위업무 리스트 조회 화면
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
<style>
	.inputKor input {ime-mode:active !important;}
</style>
<script type="text/javascript">
	var h_unit_work;
	var m_unit_work;
	$(function() {
		/* 세부권한검사 */
		fn_auth_check();
		
		h_unit_work = fnGridCommonCombo('C40', "SELECT");
		m_unit_work = fnGridCommonCombo('C41', "SELECT");
		
		//url명명 규칙(p.21) 
		grid('master/unitWork.lims', 'unitWorkForm', 'unitWorkGrid');
		$('#unitWorkGrid').clearGridData(); // 최초 조회시 데이터 안나옴
		
		ajaxComboForm("h_unit_work", "C40", "ALL", null, 'unitWorkForm');	// 대분류
		ajaxComboForm("m_unit_work", "C41", "ALL", null, 'unitWorkForm'); 	// 중분류
		
		
		// 엔터키 눌렀을 경우(그리드 조회)
		fn_Enter_Search('unitWorkForm', 'unitWorkGrid');
		
	 	//그리드 width조절하기
		$(window).bind('resize', function() { 
		    $("#unitWorkGrid").setGridWidth($('#view_grid_main').width(), true); 
		}).trigger('resize'); 
	 	
		fnSelectFirst('unitWorkGrid');
	});

	var lastRowId;
	function grid(url, form, grid) {
		$('#' + grid).jqGrid({
			datatype : function(json) {
				fnGridData(url, form, grid);
			},
// 			sortname : 'unit_work_cd',
// 			sortorder : 'desc',
			height : '230',
			autowidth : true,
			loadonce : true,
			mtype : "POST",
			gridview : true,	shrinkToFit : true,
			rowNum : -1,			rownumbers : true,			
			colModel : [ {
				label : 'unit_work_cd',
				name : 'unit_work_cd',
				width : '250',
				key : true,
				hidden : true
			}, {
				label : '대분류',
				editable : true,
				name : 'h_unit_work',
				width : '100',
				align: 'center',
				formatter : 'select',
				edittype : "select",
				editoptions : {
					value : h_unit_work
				}
// 				editable : true,
// 				edittype : 'select',
// 				editoptions : {
// 					value : 'C40001:정기;C40002:수시;C40003:민원'					
// 				}
			}, {
				label : '중분류',
				editable : true,
				width : '100',
				name : 'm_unit_work',
				formatter : 'select',
				edittype : "select",
				editoptions : {
					value : m_unit_work
				}
// 				edittype : 'select',
// 				editoptions : {
// 					value : 'C41001:상수원수계하천수;C41002:원수;C41003:정수;C41004:수도꼭지;C41005:사업소지원;C41006:연구지원;C41007:타지자체지원'					
// 				}
			}, {
				label : '단위업무명<span class="indispensableGrid"></span>',
				classes : 'inputKor',
				editable : true,
				editrules : {
					required : true
				},
				width : '100',
				name : 'unit_work_nm'
			}, {
				label : '단위업무설명<span class="indispensableGrid"></span>',
				classes : 'inputKor',
				width : '250',
				editable : true,
				editrules : {
					required : true
				},
				name : 'unit_work_desc'
			}, {
				label : '사용여부',
				width : '50',
				align: 'center',
// 				formatter : function(value){
// 					if(value == "Y"){
// 						return '사용함';  
// 					} else {
// 						return '사용안함';
// 					}
// 				},
				editable : true,
				edittype : 'select',
				editoptions : {
					value : 'Y:사용함;N:사용안함'
				},
				name : 'use_flag'
			}, {
				label : '등록일시',
				width : '100',
				align: 'center',
				name : 'create_date',
				hidden : true
			}, {
				label : '등록자ID',
				width : '80',
				name : 'creater_id',
				hidden : true
			}],
			emptyrecords: '데이터가 존재하지 않습니다.',
			gridComplete : function() {
				$('#btn_AddLine').show();
				$('#btn_Save').hide();				
				$('#btn_Insert').hide();
				$('#btn_Delete').hide();
				fnSelectFirst(grid);
			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
			},
			onSelectRow : function(rowId, status, e) {
				if (rowId && rowId != lastRowId) {
					$('#' + grid).jqGrid('restoreRow', lastRowId);
					lastRowId = rowId;
					$('#btn_Insert').hide();
					$('#btn_Delete').hide();
					btn_Row_onclick();
				}
			},
			ondblClickRow : function(rowId, iRow, iCol, e) {
				$('#' + grid).jqGrid('editRow', rowId, true);
				$('#btn_Save').show();
			}
		});
	}
	

	// 저장버튼(저장 & 수정) 클릭 이벤트
	function btn_Insert_onclick(){
		var grid = 'unitWorkGrid';
		var rowId = $('#' + grid).getGridParam('selrow');
		var pageType = '';
		var unit_work_cd = $('#unitWorkForm').find('#unit_work_cd').val();
		
		if(rowId == '' || rowId == null || rowId == '0' || rowId.substring(0,3) == 'jqg'){
			pageType = 'insert';
		}else{
			pageType = 'update';
		}
		$('#' + grid).jqGrid('saveRow', rowId, successfunc, 'master/insertUnitWork.lims', {
			pageType : pageType
			,unit_work_cd : unit_work_cd
		}, fn_Success_inserDetail, null, null);
	}
	
	
	// 메뉴상세 저장 후 콜백 이벤트
	function fn_Success_inserDetail(json) {
		if (json == null) {
			$.showAlert("저장 실패하였습니다.");
		} else {
			$.showAlert("", {type:'insert'});
			$('#unitWorkGrid').trigger('reloadGrid');
		}
	} 
	
	
	// 해당줄 클릭 이벤트(상세페이지 보기)
	function btn_Row_onclick(){		
		$('#btn_Add').show();
		$('#btn_Insert').show();
		$('#btn_Delete').show();
		return false;
	}
	
	
	// 리스트 조회 이벤트
	function btn_Select_onclick() {
		$('#unitWorkGrid').trigger('reloadGrid');
		var rowId = $('#unitWorkGrid').getGridParam('selrow');
		$('#unitWorkGrid').jqGrid('restoreRow', rowId);
	}
	
	
	// 행추가
	function btn_AddLine_onclick() {
		//var rowId = $('#unitWorkGrid').getGridParam('selrow');
		//$('#unitWorkGrid').jqGrid('restoreRow', rowId);
		$('#unitWorkGrid').jqGrid('addRow', {rowID : 0,	position : 'last'});		
		$('#' + 0 + '_h_unit_work').focus();
		
		$('#btn_AddLine').hide();
		$('#btn_Save').show();
		$('#btn_Delete').hide();
	}	
</script>
<form id="unitWorkForm" name="unitWorkForm" onsubmit="return false;">
	<div class="sub_purple_01">
		<table  class="select_table" >
			<tr>
				<td width="20%" class="table_title">
					<span>■</span>
					단위업무
				</td>
				<td class="table_button">
					<span class="button white mlargep auth_select" id="btn_Select" onclick="btn_Select_onclick();">
						<button type="button">조회</button>
					</span>
					<span class="button white mlargep auth_save" id="btn_AddLine" onclick="btn_AddLine_onclick();">
						<button type="button">단위업무추가</button>
					</span>
					<span class="button white mlargeg auth_save" id="btn_Save" onclick="btn_Insert_onclick();">
						<button type="button">저장</button>
					</span>
				</td>
			</tr>
		</table>
		<table  class="list_table" >
			<tr>
				<th>대분류</th>
				<td>
					<select name="h_unit_work" id="h_unit_work" style="width:115px;"></select>
				</td>
				<th>중분류</th>
				<td>
					<select name="m_unit_work" id="m_unit_work" style="width:115px;"></select>
				</td>
				<th>단위업무명</th>
				<td>
					<input name="unit_work_nm" type="text"  maxlength="15"/>
				</td>			
				<th>사용여부</th>
				<td>
					<label><input type='radio' name='use_flag' value="" style="width:20px" checked="checked"/>전체</label>
					<label><input type='radio' name='use_flag' value="Y" style="width:20px"/>사용함</label>
					<label><input type='radio' name='use_flag' value="N" style="width:20px"/>사용안함</label>
				</td>
			</tr>
		</table>
	</div>

	<input type="hidden" id="sortName" name="sortName">
	<input type="hidden" id="sortType" name="sortType">
	<div id="view_grid_main">
		<table id="unitWorkGrid"></table>
	</div>
</form>
<!-- 
<div class="sub_blue_01">
	<form id="detail" name="detail" onsubmit="return false;"></form>
</div>
-->
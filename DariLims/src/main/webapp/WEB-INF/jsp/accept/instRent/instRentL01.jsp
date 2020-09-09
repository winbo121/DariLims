<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
/***************************************************************************************
 * 시스템명 	: 통합장비관제시스템
 * 업무명 		: 장비대여접수
 * 파일명 		: instRentL01.jsp
 * 작성자 		: 허태원
 * 작성일 		: 2015.10.16
 * 설  명		: 장비대여접수 리스트 화면
 *---------------------------------------------------------------------------------------
 * 변경일		 변경자		변경내역 
 *---------------------------------------------------------------------------------------
 * 2015.10.16    허태원		최초 프로그램 작성         
 * 
 *---------------------------------------------------------------------------------------
 ****************************************************************************************/
%>
<link rel="stylesheet" media="screen" type="text/css" href="<c:url value='/css/common/sub.css'/>" />
<style>
</style>
<script type="text/javascript">

	$(function() {
		
		$('#tabs').tabs({
			create : function(event, ui) {
				$(window).bind('resize', function() {
					$("#instRentGrid").setGridWidth($('#view_grid_main').width(), false);
				}).trigger('resize');
				$(window).bind('resize', function() {
					$("#detailGrid").setGridWidth($('#view_grid_sub1').width(), false);
				}).trigger('resize');
				$(window).bind('resize', function() {
					$("#instInputGrid").setGridWidth($('#view_grid_sub2').width(), false);
				}).trigger('resize');
				$(window).bind('resize', function() {
					$("#sampleGrid").setGridWidth($('#view_grid_sub3').width(), false);
				}).trigger('resize');
				$(window).bind('resize', function() {
					$("#itemGrid").setGridWidth($('#view_grid_sub4').width(), false);
				}).trigger('resize');

			},
			activate : function(event, ui) {
				$(window).bind('resize', function() {
					$("#instRentGrid").setGridWidth($('#view_grid_main').width(), false);
				}).trigger('resize');
				$(window).bind('resize', function() {
					$("#detailGrid").setGridWidth($('#view_grid_sub1').width(), false);
				}).trigger('resize');
				$(window).bind('resize', function() {
					$("#instInputGrid").setGridWidth($('#view_grid_sub2').width(), false);
				}).trigger('resize');
				$(window).bind('resize', function() {
					$("#sampleGrid").setGridWidth($('#view_grid_sub3').width(), false);
				}).trigger('resize');
				$(window).bind('resize', function() {
					$("#itemGrid").setGridWidth($('#view_grid_sub4').width(), false);
				}).trigger('resize');

			}
		});
		
	/* 접수등록 TAB onload ==================== s*/
		
		// 장비대여일자
		fnDatePickerImg('startDate');
		fnDatePickerImg('endDate');
		
		// 장비대여일자
		fnDatePickerImg('startDt');
		fnDatePickerImg('endDt');
		
		$('#btn_Date').hide();
		$('#btn_AddRow').hide();
		$('#btn_Delete_Sub').hide();
		$('#btn_Save').hide();
		$('#btn_Excel').hide();
		
		//엔터키 눌렀을 경우
		fn_Enter_Search('instRentForm', 'instRentGrid');
		
		//장비대여 업체목록
		instRentGrid('accept/selectInstRentList.lims', 'instRentForm', 'instRentGrid');
		$('#instRentGrid').clearGridData(); // 최초 조회시 데이터 안나옴
		
		$(window).bind('resize', function() {
			$("#instRentGrid").setGridWidth($('#view_grid_main').width(), false);
		}).trigger('resize');
		
		//장비관리 목록
		detailGrid('accept/selectInstRentDetailList.lims', 'instRentDetailForm', 'detailGrid');
		
		$(window).bind('resize', function() {
			$("#detailGrid").setGridWidth($('#view_grid_sub1').width(), false);
		}).trigger('resize');
		
	/* 접수등록 TAB onload ==================== e*/
		
	/* 사용결과등록및조회 TAB onload ==================== s*/
		
		$('#btn_Sample_Save').hide();
	
		//사용결과등록 장비목록
		instInputGrid('accept/selectInstRentDetailList.lims', 'instRentInputForm', 'instInputGrid');
		$(window).bind('resize', function() {
			$("#instInputGrid").setGridWidth($('#view_grid_sub2').width(), false);
		}).trigger('resize');
		
		//시료 목록
		sampleGrid('accept/selectInstRent_sampleList.lims', 'instRentSampleForm', 'sampleGrid');
		$(window).bind('resize', function() {
			$("#sampleGrid").setGridWidth($('#view_grid_sub3').width(), false);
		}).trigger('resize');
		
		//항목 목록
		itemGrid('accept/selectInstRent_itemList.lims', 'instRentItemForm', 'itemGrid');
		$(window).bind('resize', function() {
			$("#itemGrid").setGridWidth($('#view_grid_sub4').width(), false);
		}).trigger('resize');
		
	/* 사용결과등록및조회 TAB onload ==================== e*/
		
	});

	/* 접수등록 TAB function ==================== s*/
	
	function instRentGrid(url, form, grid) {
		$('#' + grid).jqGrid({
			datatype : function(json) {
				fnGridData(url, form, grid);
			},
			height : '200',
			autowidth : true,
			loadonce : true,
			mtype : "POST",
			gridview : true,
			shrinkToFit : false,
			rowNum : -1,
			rownumbers : true,
			colModel : [ {
				label : '접수번호',
				name : 'instRent_receipt_no',
				align : 'center',
				width : '80',
				key : true
			}, {
				label : '업체명',				
				name : 'org_nm',
				align : 'left',
				width : '250'
			}, {
				label : '업체구분',				
				name : 'org_type',
				align : 'center',
				width : '80'
			}, {
				label : '대표번호',				
				name : 'pre_tel_num',
				align : 'center',
				width : '100'
			}, {
				label : '업체담당자',				
				name : 'req_nm',
				align : 'center',
				width : '100'
			}, {
				label : '업체담담자 전화번호',				
				name : 'req_tel',
				align : 'center',
				width : '130'
			}, {
				label : '사용자',
				name : 'instRent_user_nm',
				align : 'center',
				width : '100'
			}, {
				label : '사용기간',				
				name : 'instRent_rent_date',
				align : 'center',
				width : '150'
			}, {
				label : '접수담당자',
				name : 'instRent_taker_nm',
				align : 'center',				
				width : '100'
			} ],
			emptyrecords : '데이터가 존재하지 않습니다.',
			gridComplete : function() {
			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
			},
			onSelectRow : function(rowId, status, e) {
				btn_Select_onclick();
				$('#btn_Date').show();
				$('#btn_AddRow').show();
				$('#btn_Delete_Sub').show();
				$('#btn_Save').show();
				$('#btn_Excel').show();
			},
			ondblClickRow : function(rowId, iRow, iCol, e) {
				btn_UseResultInput_onclick();
			}
		});
	}
	
	var lastRowId;
	function detailGrid(url, form, grid) {
		$('#' + grid).jqGrid({
			datatype : function(json) {
				fnGridData(url, form, grid);
			},
			height : '250',
			autowidth : true,
			loadonce : true,
			mtype : "POST",
			gridview : true,
			shrinkToFit : false,
			rowNum : -1,
			rownumbers : true,
			colModel : [{
				type : 'not',
				label : '<input type="checkbox" id="chk" onclick="fn_chk(\'' + grid + '\' , \'' + form + '\');" />',
				name : 'chk',
				width : '40',
				sortable : false,
				align : 'center',
				formatter : "checkbox",
				formatoptions : {
					disabled : false
				},
				frozen : true
			}, {
				type : 'not',
				label : ' ',
				name : 'icon',
				width : '20',
				align : 'center',
				sortable : false,
				frozen : true
			}, {
				label : 'crud',
				name : 'crud',
				hidden : true
			}, {
				label : '업체접수번호',
				name : 'instRent_receipt_no',
				hidden : true
			}, {
				label : '장비대여번호',
				name : 'instRent_rent_no',
				key : true,
				hidden : true
			}, {
				label : '시험장비번호',
				name : 'inst_no',
				classes : 'inst_no',
				hidden : true
			}, {
				label : '장비관리번호',
				name : 'inst_mng_no',
				classes : 'inst_mng_no',
				align : 'center',
				width : '100'
			}, {
				type : 'not',
				label : ' ',
				name : 'inst_mng_noPop',
				width : '20',
				align : 'center',
				classes : 'grid_cursor',
				sortable : false, 
				formatter : imageFormat
			}, {
				label : '장비명(KOR)',
				name : 'inst_kor_nm',
				classes : 'inst_kor_nm',
				align : 'left',
				width : '200'
			}, {
				label : '장비명(ENG)',
				name : 'inst_eng_nm',
				classes : 'inst_eng_nm',
				align : 'left',
				width : '200'
			}, {
				label : '설치장소',
				name : 'instl_plc',
				classes : 'instl_plc',
				align : 'left',
				width : '200'
			}, {
				label : '관리자',
				name : 'admin_user',
				classes : 'admin_user',
				align : 'center',
				width : '100'
			}, {
				label : '관리자부서',
				name : 'dept_nm',
				classes : 'dept_nm',
				align : 'center',
				width : '100'
			}, {
				label : '대여시작일',
				name : 'instRent_st_date',
				width : '80',
				align : 'center',
				editable : true,
				editoptions : {
					dataInit : function(elem) {
						fnDatePicker(elem.getAttribute('id'));
					}
				}	
			}, {
				label : '대여종료일',
				name : 'instRent_end_date',
				width : '80',
				align : 'center',
				editable : true,
				editoptions : {
					dataInit : function(elem) {
						fnDatePicker(elem.getAttribute('id'));
					}
				}
			}],
			gridComplete : function() {				
			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
			},
			onSelectRow : function(rowId, status, e) {
				fnEditRelease(grid);
			},
			ondblClickRow : function(rowId, iRow, iCol, e) {
				fnGridEdit(grid, rowId, null);
				$('#' + grid).jqGrid('editRow', rowId, true);
			},
			onCellSelect : function(rowId, iCol, cellcontent, e) {
				var colArr = $('#' + grid).jqGrid('getGridParam', 'colModel');
				var col = colArr[iCol].name;
				if(col == 'inst_mng_noPop'){
					fnBasicStartLoading();
					fnpop_reqInstChoicePop('detailGrid', '850', '500', rowId);
					fnGridEdit(grid, rowId, null);
				}
			}
		});
	}

	function instRent_fnpop_callback(){
		fnBasicEndLoading();
	}
	
	// 장비대여 업체목록 조회 이벤트
	function btn_Search_onclick() {		
		$('#instRentGrid').trigger('reloadGrid');
		$('#instRentDetailForm').find('#instRent_receipt_no').val('');
		$('#detailGrid').trigger('reloadGrid');
		$('#btn_Date').hide();
		$('#btn_AddRow').hide();
		$('#btn_Delete_Sub').hide();
		$('#btn_Save').hide();
		$('#btn_Excel').hide();
	}
	
	//장비대여 업체등록
	function btn_Insert_onclick(){
		fnpop_instRentPop(580, 210, 'insert', '');
		fnBasicStartLoading();
	}
	
	//장비대여 업체수정
	function btn_Modify_onclick(){
		var rowId = $('#instRentGrid').getGridParam('selrow');
		if(rowId != null){
			fnpop_instRentPop(580, 210, 'update', rowId);
			fnBasicStartLoading();	
		}else{
			alert('업체를 선택하여 주십시오.');
		}		
	}
	
	function fnpop_callback_org(){
		btn_Search_onclick();
		fnBasicEndLoading();
	}
	
	//장비대여 업체목록 삭제처리
	function btn_Delete_onclick(){
		var rowId = $('#instRentGrid').getGridParam('selrow');
		if(rowId != '' && rowId != null){
			if (!confirm('장비대여 업체를 삭제하면 업체에서 대여한 장비목록까지 삭제됩니다.\n삭제하시겠습니까?')) {
				return false;
			}else{				
				data = '&instRent_receipt_no=' + rowId;
				var json = fnAjaxAction('accept/deleteInstRent.lims', data);			
				if(json == null) {
					alert('삭제 실패하였습니다.');
				}else{
					alert('삭제 완료되었습니다.');
					btn_Search_onclick();
				}	
		}		
		}else{
			alert('선택된 행이 없습니다.');
		}
	}
	
	//사용결과등록 버튼 이벤트
	function btn_UseResultInput_onclick(){		
		var rowId = $('#instRentGrid').getGridParam('selrow');		
		var cnt = $("#detailGrid").getGridParam("records");
		if(rowId != '' && rowId != null){
			if(cnt != 0){				
				$('#tabs').tabs({
					active : 1
				});
				$('#instRentInputForm').find('#instRent_receipt_no').val(rowId);
				$('#instInputGrid').trigger('reloadGrid');
				$('#instRentSampleForm').find('#instRent_rent_no').val('');
				$('#sampleGrid').trigger('reloadGrid');
				$('#instRentItemForm').find('#instRent_sample_no').val('');
				$('#itemGrid').trigger('reloadGrid');
			}else{
				alert('해당 업체는 등록된 장비가 없습니다.');
				return;
			}	
		}else{
			alert('업체를 선택하여 주십시오.');
			return;
		}
	}
	
	//장비관리 저장 처리
	function btn_Save_onclick(){
		var grid = 'detailGrid';
		fnEditRelease(grid);
		
		if (!editCount()) {
			alert("변경된 장비 목록이 없습니다.");
			return;
		}
		
		var ids = $('#detailGrid').jqGrid("getDataIDs");
		for ( var i in ids) {
			var row = $('#detailGrid').getRowData(ids[i]);
			if(row.inst_mng_no == ''){
				alert('장비를 선택하여 주십시오.');
				return;
			}
			if (row.instRent_st_date == ''){
				alert('대여시작일을 입력하여 주십시오.');				
				return;
			}
			if(row.instRent_end_date == ''){
				alert('대여종료일을 입력하여 주십시오.');
				return;
			}
		}
		
		var param = fnGetGridAllData(grid);
		var json = fnAjaxAction(fn_getConTextPath()+'/accept/saveInstRent_inst.lims', param);
		if (json == null) {
			alert("저장이 실패되었습니다.");			
			return false;
		} else {				
			alert("저장이 완료되었습니다.");
			$('#detailGrid').trigger('reloadGrid');
		}
	}
	
	// CRUD 체크
	function editCount() {
		var grid = 'detailGrid';
		var check = false;
		var ids = $('#' + grid).jqGrid("getDataIDs");
		for ( var i in ids) {
			var row = $('#' + grid).getRowData(ids[i]);
			if (row.crud == 'c' || row.crud == 'd' || row.crud == 'u')
				check = true;
		}
		return check;
	}
	
	//장비목록 행 추가
	function btn_AddRow_onclick() {
		var grid = 'detailGrid';	
		var rowIdTemp;
		var ids = $('#' + grid).jqGrid("getDataIDs");
		
		if(ids.length == 0){
			rowIdTemp = 0;										
		}else{
			var row = $('#' + grid).getRowData(ids[ids.length-1]);
			rowIdTemp = parseInt(row.instRent_rent_no)+1;
		}
		
		$('#' + grid).jqGrid('addRow', {
			rowID : rowIdTemp,
			position : 'last'
		});
		$('#' + grid).setCell(rowIdTemp, 'crud', 'c');
		$('#' + grid).setCell(rowIdTemp, 'icon', gridC);
		$('#' + grid).setCell(rowIdTemp, 'instRent_receipt_no', $('#instRentGrid').getGridParam('selrow'));
		
		fnEditRelease(grid);
	}
	
	//장비목록 행 삭제
	function btn_DeleteSub_onclick(){
		var b = false;
		var ids = $('#detailGrid').jqGrid("getDataIDs");
		if (ids.length > 0) {
			for ( var i in ids) {
				var row = $('#detailGrid').getRowData(ids[i]);
				if (row.chk == 'Yes') {
					b = true;
				}
			}
			if (b) {
				detailGridDeleteMultiLine('detailGrid');
			} else {
				alert('선택된 행이 없습니다. 체크박스를 선택해주세요');
			}
		}
	}
	
	// 삭제실행
	function detailGridDeleteMultiLine(grid) {
		var ids = $('#' + grid).jqGrid("getDataIDs");
		if (ids.length > 0) {
			for ( var i in ids) {
				var row = $('#' + grid).getRowData(ids[i]);
				if (row.chk == 'Yes') {
					$('#' + grid).setCell(ids[i], 'icon', gridD);
					$('#' + grid).setCell(ids[i], 'crud', 'd');
					$('#' + grid).setCell(ids[i], 'chk', 'No');
				}
			}
		}
	}
	
	//대여기간 일괄입력
	function btn_Date_onclick() {
		var ids = $('#detailGrid').jqGrid("getDataIDs");
		if (ids.length > 0) {
			for ( var i in ids) {
				var row = $('#detailGrid').getRowData(ids[i]);				
				if(row.crud != 'c' && row.crud != 'd'){
					$('#detailGrid').jqGrid('setCell', ids[i], 'crud', 'u');	
				}				
			}
		}
		
		$("#dialog").dialog({
			buttons : [ {
				text : "일괄입력",
				click : function() {
					var startDate = $('#startDt').val();
					var endDate = $('#endDt').val();					
					fnEditRelease('detailGrid');
					var ids = $('#detailGrid').jqGrid("getDataIDs");
					if (ids.length > 0) {
						for ( var i in ids) {
							$('#detailGrid').jqGrid('setCell', ids[i], 'instRent_st_date', startDate);
							$('#detailGrid').jqGrid('setCell', ids[i], 'instRent_end_date', endDate);
						}
					} else {
						alert('선택된 행이 없습니다.');
					}
					$('#dialog').dialog("destroy");
				}
			}, {
				text : "취소",
				click : function() {
					$('#dialog').dialog("destroy");
				}
			} ]
		});
	}
	
	//업체 장비 선택
	function btn_Select_onclick(){
		var rowId = $('#instRentGrid').getGridParam('selrow');
		
		if(rowId != null){
			$('#instRentDetailForm').find('#instRent_receipt_no').val(rowId);
			$('#detailGrid').trigger('reloadGrid');	
		}else{
			alert('업체를 선택하여 주십시오.');
			return;
		}
	}
	
	/* 접수등록 TAB function ==================== e*/
	
	/* 사용결과등록및조회 TAB function ==================== s*/
	
	function instInputGrid(url, form, grid) {
		$('#' + grid).jqGrid({
			datatype : function(json) {
				if($('#instRentInputForm').find('#instRent_receipt_no').val() != null && $('#instRentInputForm').find('#instRent_receipt_no').val() != ''){
					fnGridData(url, form, grid);
				}
			},
			height : '250',
			autowidth : true,
			loadonce : true,
			mtype : "POST",
			gridview : true,
			shrinkToFit : false,
			rowNum : -1,
			rownumbers : true,
			colModel : [{
				label : '장비대여번호',
				name : 'instRent_rent_no',
				key : true,
				hidden : true
			}, {
				label : '장비관리번호',
				name : 'inst_mng_no',
				classes : 'inst_mng_no',
				align : 'center',
				width : '100'
			}, {
				label : '장비명(KOR)',
				name : 'inst_kor_nm',
				classes : 'inst_kor_nm',
				align : 'left'
				
			}, {
				label : '장비명(ENG)',
				name : 'inst_eng_nm',
				classes : 'inst_eng_nm',
				align : 'left'
			}, {
				label : '설치장소',
				name : 'instl_plc',
				classes : 'instl_plc',
				align : 'left'
			}, {
				label : '담당자',
				name : 'admin_user',
				classes : 'admin_user',
				align : 'center'
			}, {
				label : '담당자부서',
				name : 'dept_nm',
				classes : 'dept_nm',
				align : 'center'
			}, {
				label : '대여시작일',
				name : 'instRent_st_date',
				width : '80',
				align : 'center',
				editoptions : {
					dataInit : function(elem) {
						fnDatePicker(elem.getAttribute('id'));
					}
				}	
			}, {
				label : '대여종료일',
				name : 'instRent_end_date',
				width : '80',
				align : 'center',
				editoptions : {
					dataInit : function(elem) {
						fnDatePicker(elem.getAttribute('id'));
					}
				}
			}],
			gridComplete : function() {				
			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
			},
			onSelectRow : function(rowId, status, e) {
				$('#instRentSampleForm').find('#instRent_rent_no').val(rowId);
				$('#sampleGrid').trigger('reloadGrid');
				$('#instRentItemForm').find('#instRent_sample_no').val('');
				$('#itemGrid').trigger('reloadGrid');
				$('#btn_Sample_Save').hide();
				$('#btn_Sample_Add').show();
				$('#btn_Sample_Delete').show();
				$('#instRent_sample_etc').val('');
			},
			ondblClickRow : function(rowId, iRow, iCol, e) {
			},
			onCellSelect : function(rowId, iCol, cellcontent, e) {
			}
		});
	}
	
	var lastRowId;
	function sampleGrid(url, form, grid) {
		$('#' + grid).jqGrid({
			datatype : function(json) {
				if($('#instRentSampleForm').find('#instRent_rent_no').val() != null){
					fnGridData(url, form, grid);	
				}				
			},
			height : '432',
			autowidth : true,
			loadonce : true,
			mtype : "POST",
			gridview : true,
			shrinkToFit : false,
			rowNum : -1,
			rownumbers : true,
			colModel : [{
				label : '시료번호',
				name : 'instRent_sample_no',
				key : true,
				hidden : true
			}, {
				label : 'crud',
				name : 'crud',
				hidden : true
			}, {
				label : '시료명',
				name : 'instRent_sample_nm',
				editable : true,
				align : 'left',
				editrules : {
					required : true
				}
			}, {
				label : '시료유형코드',
				name : 'sample_cd',
				classes : 'sample_cd',
				align : 'center',
				hidden : true
			}, {
				label : '시료유형',
				name : 'sample_nm',
				classes : 'sample_nm',
				align : 'left'
			}, {
				type : 'not',
				label : ' ',
				name : 'sample_type_pop',
				width : '20',
				align : 'center',
				classes : 'grid_cursor',
				sortable : false,
				formatter : imageFormat
			}, {
				type : 'not',
				label : ' ',
				name : 'sample_type_del',
				width : '20',
				align : 'center',
				classes : 'grid_cursor',
				sortable : false,
				formatter : deleteImageFormat
			}],
			gridComplete : function() {				
			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
			},
			onSelectRow : function(rowId, status, e) {
				if (rowId && rowId != lastRowId) {
					var row = $('#' + grid).getRowData(rowId);
					$('#' + grid).jqGrid('restoreRow', lastRowId);
					lastRowId = rowId;					
					if (row.instRent_sample_no != '') {
						fnEditRelease(grid);
					}					
				}
				$('#instRentItemForm').find('#instRent_sample_no').val(rowId);
				$('#itemGrid').trigger('reloadGrid');
				$('#instRent_sample_etc').val('');
				selectSampleEtc(rowId);
			},
			ondblClickRow : function(rowId, iRow, iCol, e) {				
				fnGridEdit(grid, rowId, null);
				$('#' + grid).jqGrid('editRow', rowId, true);
				$('#btn_Sample_Add').hide();
				$('#btn_Sample_Delete').hide();
				$('#btn_Sample_Save').show();
			},
			onCellSelect : function(rowId, iCol, cellcontent, e) {
				var row = $('#' + grid).getRowData(rowId);
				var colArr = $('#' + grid).jqGrid('getGridParam', 'colModel');
				var col = colArr[iCol].name;
			    if (col == 'sample_type_pop') {
					var ret = sampleChoicePop("720", "400", rowId, true); 					
					fnBasicStartLoading();
					if (ret != null && ret != '') {
						var arr = ret.split('◆★◆');
						$('#' + grid).jqGrid('setCell', rowId, 'sample_nm', arr[0]);
						$('#' + grid).jqGrid('setCell', rowId, 'sample_cd', arr[1]);						
					}
				
				}else if (col == 'sample_type_del') {
					$('#btn_Sample_Add').hide();
			    	$('#btn_Sample_Delete').hide();
			    	$('#btn_Sample_Save').show();
					$('#' + grid).jqGrid('setCell', rowId, 'sample_nm', null);
					$('#' + grid).jqGrid('setCell', rowId, 'sample_cd', null);
					var row = $('#sampleGrid').getRowData(rowId);
					if(row.crud != 'c'){
						$('#sampleGrid').setCell(rowId, 'crud', 'u');
					}
				}
			}
		});
	}
	
	function itemGrid(url, form, grid) {
		$('#' + grid).jqGrid({
			datatype : function(json) {
				if($('#instRentItemForm').find('#instRent_sample_no').val() != null && $('#sampleGrid').getGridParam('selrow') != '0'){
					fnGridData(url, form, grid);	
				}				
			},
			height : '250',
			autowidth : true,
			loadonce : true,
			mtype : "POST",
			gridview : true,
			shrinkToFit : false,
			rowNum : -1,
			rownumbers : true,
			multiselect : true,
			colModel : [{
				label : '시료번호',
				name : 'instRent_sample_no',
				hidden : true
			}, {
				label : '항목코드',
				name : 'test_item_cd',
				key : true,
				hidden : true
			}, {
				label : '항목명(KOR)',
				name : 'test_item_kornm',
				align : 'left'
			}, {
				label : '항목명(ENG)',
				name : 'test_item_engnm',
				align : 'left'
			}, {
				label : '항목유형',
				name : 'test_item_type',
				align : 'left'
			}],
			gridComplete : function() {				
			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
			},
			onSelectRow : function(rowId, status, e) {
				if (rowId && rowId != lastRowId) {
					lastRowId = rowId;
					var row = $('#' + grid).getRowData(rowId);
					if (row.test_item_cd != '') {
						fnEditRelease(grid);	
					}					
				}
			},
			ondblClickRow : function(rowId, iRow, iCol, e) {
				fnGridEdit(grid, rowId, null);
				$('#' + grid).jqGrid('editRow', rowId, true);
			},
			onCellSelect : function(rowId, iCol, cellcontent, e) {
			}
		});
	}

	function sampleChoicePop(width, heigh, rowid, b){
		fnpop_sampleChoicePop(width, heigh, rowid, b);
	}
	
	//시료 목록 행 추가
	function btn_Sample_Add_onclick() {
		if($('#instInputGrid').getGridParam('selrow') == '' || $('#instInputGrid').getGridParam('selrow') == null){
			alert('장비를 선택하여 주십시오.');
			return;
		}
		
		$('#btn_Sample_Add').hide();
		$('#btn_Sample_Delete').hide();
		$('#btn_Sample_Save').show();
		var grid = 'sampleGrid';
		$('#' + grid).jqGrid('addRow', {
			rowID : '0',
			position : 'last'
		});
		
		$('#sampleGrid').setCell('0', 'crud', 'c');
	}
	
	//항목 추가
	function btn_Item_Add_onclick() {
		var rowId = $('#sampleGrid').getGridParam('selrow');
		if(rowId == '' || rowId == null){
			alert('시료를 선택하여 주십시오.');
			return;
		}		
		if(rowId == 0){
			alert('해당 시료를 저장 후 추가하십시오.');
			return;
		}
		var ids = $('#itemGrid').jqGrid("getDataIDs");
		var param = "";
		var arr = new Array();
		for ( var i in ids) {
			var row_ids = $('#itemGrid').getRowData(ids[i]);			
			arr[i] = row_ids.test_item_cd;
		}
		param = rowId + "◆★◆" + removeArrayDuplicate(arr) + "◆★◆" +  " " + "◆★◆" + "INSTRENT"
				+ "◆★◆" + "" + "◆★◆" + "";
		fnpop_itemChoicePop("instRentItemForm", "1000", "867", param);
		fnBasicStartLoading();
	}
	
	//시료 목록 저장 처리
	function btn_Sample_Save_onclick(){
		param = fnGetGridAllData('sampleGrid') + '&instRent_rent_no=' + $('#instInputGrid').getGridParam('selrow'); 
		var json = fnAjaxAction('accept/saveInstRent_sample.lims', param);
		if (json == null) {
			alert("저장이 실패되었습니다.");			
			return false;
		} else {				
			alert("저장이 완료되었습니다.");
			$('#sampleGrid').trigger('reloadGrid');
			$('#btn_Sample_Save').hide();
			$('#btn_Sample_Add').show();
			$('#btn_Sample_Delete').show();
		}
	}
	
	//시료 목록 행 삭제
	function btn_Sample_Delete_onclick(){
		var rowId = $('#sampleGrid').getGridParam('selrow');
		if(rowId != '' && rowId != null){
			if (!confirm('선택된 시료를 삭제하면 해당 시료의 항목까지 삭제됩니다..\n삭제하시겠습니까?')) {
				return false;
			}else{				
				data = '&instRent_sample_no=' + rowId;
				var json = fnAjaxAction('accept/deleteInstRent_sample.lims', data);			
				if(json == null) {
					alert('삭제 실패하였습니다.');
				}else{
					alert('삭제 완료되었습니다.');
					$('#sampleGrid').trigger('reloadGrid');
					$('#instRentItemForm').find('#instRent_sample_no').val('');
					$('#itemGrid').trigger('reloadGrid');
				}	
		}		
		}else{
			alert('선택된 행이 없습니다.');
		}
		
	}
	
	//항목 삭제
	function btn_Item_Delete_onclick(){
		var data = 'instRent_sample_no=' + $('#sampleGrid').getGridParam('selrow');
		var data2 = '';
		var ids = $("#sampleGrid").jqGrid('getGridParam' ,"selrow");  
		var ids2 = $("#itemGrid").jqGrid('getGridParam' ,"selarrrow");  
		if (ids.length > 0 && ids2.length > 0) {
			if (!confirm('삭제하시겠습니까?')) {
				return false;
			}
			data2 += "test_item_cd=";
			for ( var r2 in ids2) {
				data2 += ids2[r2] + ',';
			}
			data2 = data2.substr(0, data2.length - 1);
			
			var strData = data +"&"+ data2;
			var json = fnAjaxAction('accept/deleteInstRent_item.lims', strData);			
			if (json == null) {
				alert('삭제 실패하였습니다.');
			} else {
				alert('삭제 완료되었습니다.');
				$('#itemGrid').trigger('reloadGrid');
			}
		} else {
			alert('선택된 항목이 없습니다.');
		}
	}
	
	//항목비고 저장
	function btn_SampleEtc_Save_onclick(){
		var instRent_sample_no = $('#sampleGrid').getGridParam('selrow');
		if(instRent_sample_no == '' || instRent_sample_no == null){
			alert('시료를 선택하여 주십시오.');
			return;
		}
		
		var instRent_sample_etc = $('#instRent_sample_etc').val();
		var param = 'instRent_sample_etc=' + instRent_sample_etc + '&instRent_sample_no=' + instRent_sample_no;
		var json = fnAjaxAction(fn_getConTextPath()+'/accept/saveSampleEtc.lims', param);
		if (json == null) {
			alert("저장이 실패되었습니다.");			
			return false;
		} else {				
			alert("저장이 완료되었습니다.");
		}
	}
	
	//항목 비고란 조회
	function selectSampleEtc(rowId){
		$.ajax({
			url : fn_getConTextPath()+'/accept/selectSampleEtc.lims',
			type : 'post',
			dataType : 'json',
			async : false,
			data : 'instRent_rent_no=' + $('#instInputGrid').getGridParam('selrow') + '&instRent_sample_no=' + rowId,
			success : function(json) {
				if(json == null){
					$('#instRent_sample_etc').val('');
				}
				$(json).each(function(index, entry) {
					$('#instRent_sample_etc').val(entry["instRent_sample_etc"]);					
				});				
			},
			error : function() {				
				alert('error');
			}
		});
		
	}
	
	/* 사용결과등록및조회 TAB function ==================== e*/
	
	/* 기타 함수 ==================== s */
	
	function fnpop_callback(){		
		$('#btn_Sample_Add').hide();
    	$('#btn_Sample_Delete').hide();
    	$('#btn_Sample_Save').show();
		$('#itemGrid').trigger('reloadGrid');
		var rowId = $('#sampleGrid').getGridParam('selrow');		
		var row = $('#sampleGrid').getRowData(rowId);
		if(row.crud != 'c'){
			$('#sampleGrid').setCell(rowId, 'crud', 'u');
		}		
		fnBasicEndLoading();
	}
	
	//sampleGrid edit모드 해제
	function sampleGridEditOff(){
		fnEditRelease('sampleGrid');
	}
	
	//itemGrid edit모드 해제
	function itemGridEditOff(){
		fnEditRelease('itemGrid');
	}
	
	// 엑셀 다운로드
	function btn_Excel_onclick() {
		var bigDivName = null;
		var bigDivData = null;
		var rowId = $('#instRentGrid').getGridParam('selrow');  
		var row = $('#instRentGrid').getRowData(rowId);
		bigDivName = "업체명";
		bigDivData = row.org_nm;
		var data = fn_Excel_Data_Make2('detailGrid', bigDivName, bigDivData);
		fn_Excel_Download(data);
	}
	
	/* 기타 함수 ==================== e */
	
</script>
<div id="tabs" style="display: inline-block; width: 100%;">
	<ul>
		<li id="tab1">
			<a href="#tabDiv1">접수등록</a>
		</li>
		<li id="tab2">
			<a href="#tabDiv2">사용결과등록및조회</a>
		</li>
	</ul>
	<div id="tabDiv1">
		<form id="instRentForm" name="instRentForm" onsubmit="return false;">
			<div class="sub_purple_01">
				<table  class="select_table" >
					<tr>
						<td width="20%" class="table_title">
							<span>■</span>
							장비대여 업체목록
						</td>
						<td class="table_button">							
							<span class="button white mlargep auth_select" id="btn_Select" onclick="btn_Search_onclick();">
								<button type="button">조회</button>
							</span>
							<span class="button white mlargep auth_select" id="btn_Select" onclick="btn_Select_onclick();">
								<button type="button">선택</button>
							</span>
							<span class="button white mlargep auth_save" id="btn_Insert" onclick="btn_Insert_onclick();">
								<button type="button">등록</button>
							</span>
							<span class="button white mlargep auth_save" id="btn_Modify" onclick="btn_Modify_onclick();">
								<button type="button">수정</button>
							</span>
							<span class="button white mlarger auth_save" id="btn_Delete" onclick="btn_Delete_onclick();">
								<button type="button">삭제</button>
							</span>															
							<span class="button white mlargep auth_save" id="btn_UseResultInput" onclick="btn_UseResultInput_onclick();">
								<button type="button">사용결과등록</button>
							</span>	
						</td>
					</tr>
				</table>
				<!-- 조회 테이블 -->
				<table  class="list_table" >
					<tr>
						<th>접수번호</th>
						<td>
							<input name="instRent_receipt_no" id="instRent_receipt_no" type="text" style="width: 100px;" />
						</td>
						<th>업체명</th>
						<td>
							<input name="org_nm" id="org_nm" type="text" style="width: 100px;" />
						</td>
						<th>장비명</th>
						<td>
							<input name="inst_kor_nm" id="inst_kor_nm" type="text" style="width: 100px;" />
						</td>
						<th>장비대여일자</th>
						<td>
							<input name="startDate" id="startDate" type="text" style="text-align: center; width: 80px;" readonly="readonly" />
							<img src="<c:url value='/images/common/calendar_del.png'/>" id="startDateStop" style="cursor: pointer;" onClick='fn_TextClear("startDate")' /> ~
							<input name="endDate" id="endDate" type="text" style="text-align: center; width: 80px;" readonly="readonly" />
							<img src="<c:url value='/images/common/calendar_del.png'/>" id="endDateStop" style="cursor: pointer;" onClick='fn_TextClear("endDate")' />
						</td>
					</tr>
				</table>
			</div>
			<div id="view_grid_main">
				<table id="instRentGrid"></table>
			</div>
		</form>
		<div class="sub_blue_01" id="view_grid_sub">			
			<form id="instRentDetailForm" name="instRentDetailForm" onsubmit="return false;">
				<input type="hidden" name="instRent_receipt_no" id="instRent_receipt_no"/>
				<table  class="select_table" >
					<tr>
						<td width="20%" class="table_title">
							<span>■</span>
							장비관리
						</td>
						<td class="table_button">
							<span class="button white mlargeb auth_save" id="btn_Date" onclick="btn_Date_onclick();">
								<button type="button">대여일 일괄입력</button>
							</span>
							<span class="button white mlargep auth_save" id="btn_AddRow" onclick="btn_AddRow_onclick();" >
								<button type="button">행추가</button>
							</span>
							<span class="button white mlarger auth_save" id="btn_Delete_Sub" onclick="btn_DeleteSub_onclick();">
								<button type="button">행삭제</button>
							</span>				
							<span class="button white mlargeg auth_save" id="btn_Save" onclick="btn_Save_onclick();" >
								<button type="button">저장</button>
							</span>
							<span class="button white mlargeb auth_select" id="btn_Excel" onclick="btn_Excel_onclick();">
								<button type="button">EXCEL</button>
							</span>
						</td>
					</tr>
				</table>
				<div id="view_grid_sub1">
					<table id="detailGrid"></table>
				</div>
			</form>
			<div id="dialog" style="display: none;">
				<table>
					<tr>
						<th>대여시작일</th>
						<td>
							<input name="startDt" id="startDt" type="text" class="w80px" readonly="readonly" />
							<img src="<c:url value='/images/common/calendar_del.png'/>" id="startDateStop" style="cursor: pointer;" onClick='fn_TextClear("startDt")' />
						</td>
					</tr>
					<tr>
						<th>대여종료일</th>
						<td>
							<input name="endDt" id="endDt" type="text" class="w80px" readonly="readonly" />
							<img src="<c:url value='/images/common/calendar_del.png'/>" id="startDateStop" style="cursor: pointer;" onClick='fn_TextClear("endDt")' />
						</td>
					</tr>
				</table>
			</div>
		</div>
	</div>
	<div id="tabDiv2">
		<div class="sub_purple_01">
		<form id="instRentInputForm" name="instRentInputForm" onsubmit="return false;">
		<input type="hidden" name="instRent_receipt_no" id="instRent_receipt_no" />
			<table  class="select_table" >
				<tr>
					<td width="20%" class="table_title">
						<span>■</span>
						장비 목록
					</td>
				</tr>
			</table>
			<div id="view_grid_sub2">
				<table id="instInputGrid"></table>
			</div>
		</form>
		</div>
		<div class="sub_purple_01 w45p">
			<table border="0" class="select_table">
				<tr>
					<td class="table_title">
						<span>■</span>
						시료 목록
					</td>
					<td class="table_button">
						<span class="button white mlargep auth_save" id="btn_Sample_Add" onclick="btn_Sample_Add_onclick();">
							<button type="button">시료추가</button>
						</span>
						<span class="button white mlargeg auth_save" id="btn_Sample_Save" onclick="btn_Sample_Save_onclick();" onmousedown="sampleGridEditOff();">
							<button type="button">저장</button>
						</span>						
						<span class="button white mlarger auth_save" id="btn_Sample_Delete" onclick="btn_Sample_Delete_onclick();">
							<button type="button">시료삭제</button>
						</span>						
					</td>
				</tr>
			</table>
			<form id="instRentSampleForm" name="instRentSampleForm" onsubmit="return false;">
			<input type="hidden" id="instRent_rent_no" name="instRent_rent_no">
				<div id="view_grid_sub3">
					<table id="sampleGrid"></table>
				</div>
			</form>
		</div>
		<div class="sub_purple_01 w45p" style="float: right;">
			<table width="100%" border="0" class="select_table">
				<tr>
					<td class="table_title">
						<span>■</span>
						항목 목록
					</td>
					<td class="table_button">
						<span class="button white mlargep auth_save" id="btn_Item_Add" onclick="btn_Item_Add_onclick();" >
							<button type="button">항목추가</button>
						</span>											
						<span class="button white mlarger auth_save" id="btn_Item_Delete" onclick="btn_Item_Delete_onclick();">
							<button type="button">항목삭제</button>
						</span>	
					</td>
				</tr>
			</table>
			<form id="instRentItemForm" name="instRentItemForm" onsubmit="return false;">
			<input type="hidden" id="instRent_sample_no" name="instRent_sample_no" />
				<div id="view_grid_sub4">
					<table id="itemGrid"></table>
				</div>
				<div>
					<table width="100%" border="0" class="select_table">
						<tr>
							<td class="table_title">
								<span>■</span>
								항목 비고
							</td>
							<td class="table_button">
								<span class="button white mlargeg auth_save" id="btn_SampleEtc_Save" onclick="btn_SampleEtc_Save_onclick();">
									<button type="button">저장</button>								
								</span>
							</td>													
						</tr>
						<tr>
							<td colspan="2">
								<textarea id="instRent_sample_etc" name="instRent_sample_etc" rows="10" style="width: 100%"></textarea>
							</td>
						</tr>
					</table>					
				</div>
			</form>			
		</div>
	</div>
</div>

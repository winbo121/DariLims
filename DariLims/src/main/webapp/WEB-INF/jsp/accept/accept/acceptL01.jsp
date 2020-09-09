<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<jsp:useBean id="currentDate" class="java.util.Date" />
<fmt:formatDate var="now" value="${currentDate}" pattern="YYYY-MM-dd" />

<%
	/***************************************************************************************
	 * 시스템명 	: 통합장비관제시스템
	 * 업무명 		: 접수
	 * 파일명 		: acceptL01.jsp
	 * 작성자 		: 진영민
	 * 작성일 		: 2015.01.22
	 * 설  명		: 
	 *---------------------------------------------------------------------------------------
	 * 변경일		 변경자		변경내역 
	 *---------------------------------------------------------------------------------------
	 * 2015.01.22    진영민		최초 프로그램 작성         
	 * 2016.01.14    윤상준       테이블구조변경 및 개선 
	 *---------------------------------------------------------------------------------------
	 ****************************************************************************************/
%>
<link rel="stylesheet" media="screen" type="text/css" href="<c:url value='/css/common/sub.css'/>" />
<script type="text/javascript" src="<c:url value='/script/lims.com.accept.js?time=${now}'/>"></script>
<style>
input[type=text] {
	ime-mode: active;
}
</style>
<script type="text/javascript">

var attGbnEdit;
var disuse_flag;
var bReqLoad = false;

//출력서 이미지 select기능 
	$(function() {
		/* 세부권한검사 */
		fn_auth_check();

		/*
		* 공통코드
		*/
		ajaxComboForm("req_type", "C23", "ALL", "EX1", "reqListForm");		
		ajaxComboForm("state", "", "ALL", "ALLNAME", "reqListForm");
		ajaxComboForm("unit_work_cd", "", "ALL", null, 'reqListForm');
		ajaxComboForm("sensory_test", "C65", "${detail.sensory_test}", "EX1", "reqListForm");
		ajaxComboForm("dept_cd", "", "ALL", "ALLNAME", 'reqListForm');
		
		test_std = fnGridCombo('test_std', null);
		//attGbnEdit = fnGridCommonCombo("C83", "NON");		
		disuse_flag = fnGridCommonCombo('C52', '');
		
		/*
		* 그리드
		*/
		// 검체 리스트
		reqSampleGrid('accept/selectAcceptSampleList.lims', 'reqSampleForm', 'reqSampleGrid');
		// 항목 리스트
		reqItemGrid('accept/selectAcceptItemList.lims', 'reqItemForm', 'reqItemGrid');
		// 검체별 문서 리스트
		sampleFileGrid('accept/selectSampleFileList.lims', 'sampleFileForm', 'sampleFileGrid');
		// 항목별 문서 리스트
		sampleItemFileGrid('accept/selectSampleItemFileList.lims', 'sampleItemFileForm', 'sampleItemFileGrid');
		grid('accept/selectAcceptList.lims', 'reqListForm', 'reqListGrid');
		
		$('#tabs').tabs({
			create : function(event, ui) {
				$(window).bind('resize', function() {
					$("#reqListGrid").setGridWidth($('#view_grid_main').width(), false);
				}).trigger('resize');
				$(window).bind('resize', function() {
					$("#reqSampleGrid").setGridWidth($('#view_grid_sub_1').width(), false);
				}).trigger('resize');
				$(window).bind('resize', function() {
					$("#reqItemGrid").setGridWidth($('#view_grid_sub_2').width(), false);
				}).trigger('resize');
				$(window).bind('resize', function() {
					$("#sampleFileGrid").setGridWidth($('#view_grid_sample_file').width(), true);
				}).trigger('resize');
				$(window).bind('resize', function() {
					$("#sampleItemFileGrid").setGridWidth($('#view_grid_item_file').width(), true);
				}).trigger('resize');
				fn_Btn_Visible();
				$('#btn_Accept').hide();
				$('#btn_Return').hide();
			},
			activate : function(event, ui) {
				$(window).bind('resize', function() {
					$("#reqListGrid").setGridWidth($('#view_grid_main').width(), false);
				}).trigger('resize');
				$(window).bind('resize', function() {
					$("#reqSampleGrid").setGridWidth($('#view_grid_sub_1').width(), false);
				}).trigger('resize');
				$(window).bind('resize', function() {
					$("#reqItemGrid").setGridWidth($('#view_grid_sub_2').width(), false);
				}).trigger('resize');
				$(window).bind('resize', function() {
					$("#sampleFileGrid").setGridWidth($('#view_grid_sample_file').width(), true);
				}).trigger('resize');
				$(window).bind('resize', function() {
					$("#sampleItemFileGrid").setGridWidth($('#view_grid_item_file').width(), true);
				}).trigger('resize');
				if ($('#tabs').tabs('option', 'active') == 0) {
					$('#btn_Accept').hide();
					$('#btn_Return').hide();
				} else {
					fn_Btn_Visible();
				}
			}
		});		
		
		/*
		* 초기화셋팅
		*/
		
		fnDatePickerImg('startDate');
		fnDatePickerImg('endDate');
		
		fnDatePickerImg('startTest');
		fnDatePickerImg('endTest');
		
		fnDatePickerImg('taxSdate');
		fnDatePickerImg('taxEdate');
		
		if ('${move.type}' == 'move') {
			var data = 'type=${type}' + '&pageType=detail&test_req_seq=${move.test_req_seq}';
			fnViewPage('accept/selectAcceptDetail.lims', 'acceptDiv', data);
			$('#reqSampleForm').find('#test_req_seq').val('${move.test_req_seq}');
			fnStopLoading('sampleDiv');
			fnStopLoading('itemDiv');
		} else {
			fnViewPage('accept/selectAcceptDetail.lims', 'acceptDiv', 'type=${type}');
			fn_Div_Block('itemDiv', reqMsg, true);
			fn_Div_Block('sampleDiv', reqMsg, true);
		}
		
		// '의뢰 구분' 이 바뀔때 마다
		$('#reqListForm').find("#req_type").change(function() {
			var req_type = $(this).val();
			if(req_type =='E'){
				$('#reqListForm').find("#sensory_test").attr("disabled", false);
			}else{
				$('#reqListForm').find("#sensory_test").val("");
				$('#reqListForm').find("#sensory_test").attr("disabled", "disabled");
			}
		});
		
		$('#reqListForm').find('#endDate').val(fnGetToday(0,0));
		$('#reqListForm').find('#startDate').val(fnGetToday(3,0));
		
		$('#reqListForm').find('#endTest').val(fnGetToday(0,30));
		$('#reqListForm').find('#startTest').val(fnGetToday(3,0));
		
		$('#reqListForm').find('#taxEdate').val(fnGetToday(0,0));

		// 메인에서 접근할때(접수대기)
		if ('${move.type}' == 'move2') {
			$('#reqListForm').find('#state').val('A');
			$('#tabs').tabs({
				active : 0
			});
			$('#reqListGrid').trigger('reloadGrid');
		}
		
		// 의뢰 페이지
		if ('${type}' == 'receipt') {
			$('#reqBtn').find('#req').text('접수'); // 접수하기
			$('#btn_Accept').hide(); // 접수등록
			$('#reqViewBtn').hide(); // 의뢰정보
			$('#resultViewBtn').hide(); // 결과보기

			$('#reqListForm').find('#accept').text('의뢰');

			$('#sampleDiv').css('display', 'inline-block');
			$('#itemDiv').css('display', 'inline-block');
		} else {
			$('#reqListForm').find('#state option[value=Y]').remove();
			$('#btn_Accept').show();
			
			$('#btn_Req_Retest').hide();

			$('#sampleDiv').css('display', 'inline-block');
			$('#itemDiv').css('display', 'inline-block');
			$('#taxHead').remove();
			$('#taxTd').remove();
		}
		
		// 엔터키 눌렀을 경우 조회 이벤트
		fn_Enter_Search('reqListForm', 'reqListGrid');

		$('#reqListForm').find("#state").change(function() {
			var menu_cd = $('#menu_cd').val();
			var sState = $('#reqListForm').find("#state").val();
			$('#reqBtn').attr("onclick", '').unbind('click');
			$('#btn_Req_Cancel').attr("onclick", '').unbind('click');
			
			if (sState == "A") {
				$('#reqBtn').attr("onclick", '').click(fnpop_req);
				$('#btn_Req_Cancel').attr("onclick", '').click(showAlert0305);
			} else if (sState == "B" || sState == "F"|| sState == "G"|| sState == "H") {
				$('#btn_Req_Cancel').attr("onclick", '').click(btn_Req_Cancel_onclick);
			} else {
				$('#reqBtn').attr("onclick", '').click(showAlert0304);
				$('#btn_Req_Cancel').attr("onclick", '').click(showAlert0305);
			}
			
			if (bReqLoad) 
				btn_Select_onclick();
			else
				bReqLoad = true
		});
		
		$('#reqListForm').find("#state").trigger('change');
	});

	function showAlert0303(){
		alert('조회조건의 [진행상태]가 [의뢰]인 경우 접수가 가능합니다.\n진행상태를 변경해주세요.'); 
		return false;
	}
	
	function showAlert0304(){
		alert('조회조건의 [진행상태]가 [접수대기]인 경우 접수완료가 가능합니다.\n진행상태를 변경해주세요.');
		return false;
	}
	
	function showAlert0305(){
		alert('조회조건의 [진행상태]가 [접수완료,결과승인완료,성적서작성완료,성적서발행완료]인 경우 접수취소가 가능합니다.\n진행상태를 변경해주세요.');
		return false;
	}
	
	// 접수 리스트
	function grid(url, form, grid) {
		$('#' + grid).jqGrid({
			datatype : function(json) {
				reqListGridInit ? fn_GridData(url, form, grid) : reqListGridInit = true;
			},
			height : '500',
			autowidth : false,
			loadonce : true,
			mtype : "POST",
			gridview : true,
			shrinkToFit : false,
			rowNum : -1,
			rownumbers : true,
			colModel : [ {
				type : 'not',
				label : '<input type="checkbox" id="chk" onclick="fn_chk(\'' + grid + '\' , \'' + form + '\');" />',
				name : 'chk',
				width : '40',
				sortable : false,
				align : 'center',
				formatter : "checkbox",
				formatoptions : {
					disabled : false
				}
			}, {
				label : 'process',
				name : 'process',
				hidden : true
			}, {
				label : '진행상태',
				name : 'state',
				width : '80',
				align : 'center'
			}, {
				label : '의뢰일련번호(HIDDEN)',
				name : 'test_req_seq',
				align : 'center',
				width : '150',
				hidden : true,
				key : true
			}, {
				label : '의뢰구분',
				name : 'req_type',
				align : 'center',
				width : '80'
			}, {
				label : '제목',
				name : 'title',
				align : 'center',
				width : '130'
			}, {
				label : '의뢰번호',
				name : 'test_req_no',
				align : 'center',
				width : '80',
			}, {
				label : 'Sampling NO',
				name : 'sampling_no',
				align : 'center',
				width : '150',
			}, {
				label : 'Sample Number',
				name : 'sample_num',
				align : 'center',
				width : '150',
			}, {
				label : '수수료',
				name : 'fee_tot',
				align : 'right',
				width : '120',
			}, {
				label : '접수일자',
				name : 'sample_arrival_date',
				width : '120',
				align : 'center'
			}, {
				label : '성적서발행 예정일',
				name : 'deadline_date',
				width : '100',
				align : 'center'
			},  {
				label : '결과승인완료일자',
				name : 'last_approval_date',
				width : '100',
				align : 'center'
			}, {
				label : '성적서발행일자',
				name : 'last_report_date',
				width : '100',
				align : 'center'
			}, {
				label : '의뢰업체명',
				name : 'req_org_nm',
				align : 'center'
			}, {
				label : '의뢰자',
 				name : 'req_nm',
				width : '100',
				align : 'center'
			}, {
				label : '라벨 설명',
 				name : 'barcode_desc',
				width : '130',
				align : 'center'
			}, {
				label : '주관부서',
				name : 'dept_nm',
				width : '100',
				align : 'center'
			}, {
				label : '품목명',
				name : 'sample_nms',
				align : 'center',
				width : '200'
			}, {
				label : '단위업무',
				name : 'unit_work_cd',
				width : '80',
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
			}, 
			 {
				label : '관리자 메모',
				name : 'admin_message',
				width : '140',
				align : 'center'
			}, 			
			{
				label : 'creater_id',
				name : 'creater_id',
				hidden : true
			}, {
				label : 'dept_cd',
				name : 'dept_cd',
				hidden : true
			}, {
				label : 'commission_type',
				name : 'commission_type',
				hidden : true
			}, {
				label : 'commission_amt_flag',
				name : 'commission_amt_flag',
				hidden : true
			}, {
				label : 'email',
				name : 'email',
				hidden : true
			}, {
				label : 'pick_no',
				name : 'pick_no',
				hidden : true
			} ],
			gridComplete : function() {
			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
			},
			onClickRow : function(rowId, iRow, iCol, e) {
				btn_Choice_onclick('');
			},
			ondblClickRow : function(rowId, iRow, iCol, e) {
				btn_Choice_onclick('');
			}
		});
		$('#' + grid).jqGrid('setGroupHeaders', {
			useColSpanStyle : true,
			groupHeaders : [ {
				startColumnName : 'req_type',
				numberOfColumns : 10,
				titleText : '의뢰정보'
			}, {
				startColumnName : 'dept_nm',
				numberOfColumns : 4,
				titleText : '검사정보'
			} ]
		});
	}

	var lastRowId;
	
	// 검체 리스트
	function reqSampleGrid(url, form, grid) {
		$('#' + grid).jqGrid({
			datatype : function(json) {
				if ($('#' + form).find('#test_req_seq').val() != '') {
					fnGridData(url, form, grid);
				} else {
					$('#' + grid).clearGridData();
				}
			},
			height : '230',
			autowidth : true,
			loadonce : true,
			mtype : "POST",
			gridview : true,
			shrinkToFit : false,
			rowNum : -1,
			rownumbers : true,
			//multiselect : true,
			colModel : [ {
				type : 'not',
				label : '<input type="checkbox" id="chk" onclick="fn_chk(\'' + grid + '\' , \'' + form + '\');" />',
				name : 'chk',
				width : '40',
				sortable : false,
				align : 'center',
				formatter : "checkbox",
				formatoptions : {
					disabled : false
				}
			}, {
				type : 'not',
				label : ' ',
				name : 'icon',
				width : '20',
				sortable : false,
				align : 'center'
			}, {
				label : 'crud',
				name : 'crud',
				hidden : true
			}, {
				label : 'sample_temp_cd',
				name : 'sample_temp_cd',
				hidden : true
			}, {
				label : 'test_sample_seq',
				name : 'test_sample_seq',
				hidden : true,
				key: true
			}, {
				label : 'test_req_seq',
				name : 'test_req_seq',
				hidden : true
			}, {
				label : '검체상태',
				name : 'disuse_flag',
				width : '100',
				align : 'center',
				edittype : "select",
				editoptions : {
					value : disuse_flag
				},
				formatter : 'select'
			}, {
				label : '검체접수번호',
				name : 'test_sample_no',
				width : '100',
				hidden : true,
				align : 'center'
			}, {
				label : '검체명',
				width : '150',
				name : 'sample_reg_nm',
				align : 'center'
			}, {
				label : '품목코드',
				name : 'prdlst_cd',
				classes : 'prdlst_cd',
				hidden : true
			}, {
				type : 'not',
				label : '품목명',
				name : 'prdlst_nm',
				classes : 'prdlst_nm',
				width : '150',
				editoptions : {
					readonly : "readonly"
				},
				align : 'center'
			}, {
				label : '스탠다드코드',
				width : '150',
				name : 'sm_code',
				hidden : true
			}, {
				label : '스탠다드명',
				width : '150',
				name : 'sm_name',
				editoptions : {
					readonly : "readonly"
				},
				align : 'center'
			}, {
				label : '시험기준',
				name : 'test_std_no',
				width : '180',
				edittype : "select",
				hidden : true,
				editoptions : {
					value : test_std
				},
				formatter : 'select'
			}, {
				label : 'pretreatment_cd',
				name : 'pretreatment_cd',
				hidden : true
			}, {
				label : '전처리비용',
				name : 'pre_cost',
				editable : false,
				formatter : 'integer',
				formatoptions : {
					thousandsSeparator : ','
				},
				width : '100',
				align : 'right'
			}, {
				type : 'not',
				label : ' ',
				name : 'pre_cost_pop',
				sortable : false,
				width : '20',
				align : 'center',
				formatter : imageFormat
			}, {
				type : 'not',
				label : ' ',
				name : 'pre_cost_del',
				sortable : false,
				width : '20',
				align : 'center',
				formatter : deleteImageFormat
			}, {
				label : '검체수수료',
				name : 'sample_fee',
				editable : false,
				formatter : 'integer',
				formatoptions : {
					thousandsSeparator : ','
				},
				width : '100',
				align : 'right'
			}, {
				label : '식약처_자가_구분',
				width : '100',
				name : 'kfda_yn',
				hidden : true
			}, {
				label : '생산/수입일',
				width : '100',
				name : 'produce_date',
				editable : true
			}, {
				label : '수입ㆍ제조번호',
				width : '100',
				name : 'produce_no',
				editable : true,
				align : 'center'
			},  {
				label : '제조사/생산자',
				width : '100',
				name : 'producer_nm',
				editable : true,
				align : 'center'
			}, {
				label : '제조국/생산지',
				width : '100',
				name : 'produce_place',
				editable : true,
				align : 'center'
			}, {
				label : '공급자',
				width : '100',
				name : 'supplier',
				editable : true,
				align : 'center'
			}, {
				label : '목재제품 용도',
				width : '150',
				name : 'sample_etc_nm',
				editable : true,
				align : 'center'
			}, {
				label : '유통기한',
				width : '100',
				name : 'expiry_date',
				editable : true,
				editoptions : {
					dataInit : function(elem) {
						fnDatePicker(elem.getAttribute('id'));
					},
					readonly : "readonly"
				},
				align : 'center'
			}, {
				label : '생산량/수입량',
				width : '50',
				name : 'sample_weight',
				editable : true,
				align : 'center'
			}, {
				label : '보관방법',
				width : '150',
				name : 'keep_method',
				editable : true,
				align : 'center'
			}, {
				label : '발주자',
				width : '100',
				name : 'orderer_nm',
				editable : true,
				align : 'center'
			}, {
				label : '시공자',
				width : '100',
				name : 'builder_nm',
				editable : true,
				align : 'center'
			}, {
				label : '입회자',
				width : '100',
				name : 'joiner_nm',
				editable : true,
				align : 'center'
			}, {
				label : '비고',
				width : '400',
				name : 'etc_desc',
				sortable:false,
				editable: true,
				edittype:"textarea",
				editoptions:{rows:"2",cols:"55"}
			}, {
				label : 'result_input_type',
				name : 'result_input_type',
				hidden : true
			} ],
			gridComplete : function() {
				$("#test_std_no").attr("disabled", "disabled");
			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
				if (!confirm('저장하지 않은 정보는 사라집니다. 정렬하시겠습니까?')) {
					return 'stop';
				}
			},
			onCellSelect : function(rowId, iCol, cellcontent, e) {
				var row = $('#' + grid).getRowData(rowId);
				var colArr = $('#' + grid).jqGrid('getGridParam', 'colModel');
				var col = colArr[iCol].name;
				if (col == 'pre_cost_pop') {
					var param = "";
					
					param = row.test_req_seq + "◆★◆" + rowId + "◆★◆" + row.prdlst_cd + "◆★◆" + grid;
					fnpop_pretreatmentPop("reqSampleForm", "700", "500", param);
					
					fnBasicStartLoading();
				} 
				if (col == 'pre_cost_del') {
					if (confirm('전처리비용을 삭제하시겠습니까?')) {
						var param = {
								grid : grid,
								test_sample_seq : row.test_sample_seq,
								test_req_seq : row.test_req_seq,
								pretreatment_cd : ""
							}
							fnpop_PretreatmentCallback(param);
					}
				} 
			},
			onSelectRow : function(rowId, status, e) {
				if (rowId && rowId != lastRowId) {
					lastRowId = rowId;
					var row = $('#' + grid).getRowData(rowId);
					if (row.test_sample_seq != '') {
						$('#reqItemForm').find('#test_sample_seq').val(row.test_sample_seq);
						$('#reqItemForm').find('#prdlst_cd').val(row.prdlst_cd);
						$('#reqItemForm').find('#sm_code').val(row.sm_code);
						$('#' + grid).jqGrid('editRow', rowId, true, null, null, 'clientArray');
						$('#reqItemForm').find('#test_std_no').val($('#' + grid).find('#' + rowId + '_test_std_no').val());
						fnEditRelease(grid);
						$('#reqItemGrid').trigger('reloadGrid');
						
						$('#sampleFileForm').find('#test_sample_seq').val(row.test_sample_seq);
						$('#sampleItemFileForm').find('#test_sample_seq').val(row.test_sample_seq);
						$('#sampleItemFileForm').find('#test_item_cd').val('');
						$('#sampleFileGrid').trigger('reloadGrid');
						btn_Item_Select_onclick();
					}
				}
			},
			ondblClickRow : function(rowId, iRow, iCol, e) {
				$('#' + grid).setCell(rowId, 'chk', 'Yes');
				if (editChange) {
					fn_Div_Block('itemDiv', itemMsg, false);
					fnGridEdit(grid, rowId, fn_Row_Click);
					var colArr = $('#' + grid).jqGrid('getGridParam', 'colModel');
					$('#' + rowId + '_' + colArr[iCol].name).focus();
					var p = 0;
					$('#' + rowId + '_' + colArr[iCol].name).blur(function() {
						if (p == 0) {
							$('#' + rowId + '_' + colArr[iCol].name).focus();
						}
						p++;
					});
				}
			},
			afterInsertRow : function(rowId, rowdata, rowelem) {
			}
		});
	}
	
	// 검체별 문서 리스트
	var lastRowId;
	function sampleFileGrid(url, form, grid) {
		$('#' + grid).jqGrid({
			datatype : function(json) {
				fnGridData(url, form, grid);
			},
			height : '230',
			autowidth : true,
			loadonce : true,
			mtype : "POST",
			gridview : false,
			shrinkToFit : false,
			rowNum : -1,
			rownumbers : true,
			colModel : [ {
				label : '문서 번호',
				name : 'att_seq',
				hidden : true,
				key : true
			}, {
				label : '검체 번호',
				name : 'test_sample_seq',
				align : 'center',
				hidden : true
			}, {
				label : '첨부 문서명',
 				name : 'file_nm',
				width : '150',
				formatter : displaySampleAlink,
				align : 'center'
			}/* , {
				index : 'not',
				label : '문서 구분',
				name : 'sample_att_gbn',
				sortable : false,
				align : 'center',
				editable : true,
				edittype : "select",
				editoptions : {
					value : attGbnEdit
				},
				formatter : 'select',
				width : '90',
				align : 'center'
			}  */],
			
			gridComplete : function() {
				$('#sampleFileForm').find('#insertSampleBtn').show();
				$('#sampleFileForm').find('#updateSampleBtn').hide();
				var ids = $('#'+grid).jqGrid("getDataIDs");
			},
			onSortCol : function(index, iCol, sortorder) {
			},
			onCellSelect : function(rowId, iCol, cellcontent, e) {
				
			},
			onSelectRow : function(rowId, status, e) {
				var row = $('#' + grid).getRowData(rowId);
				$('#sampleFileForm').find('#att_seq').val(row.att_seq);
				$('#sampleFileForm').find('#insertSampleBtn').hide();
				$('#sampleFileForm').find('#updateSampleBtn').show();
				if (rowId && rowId != lastRowId) {
					lastRowId = rowId;
				}
			},
			ondblClickRow : function(rowId, iRow, iCol, e) {
				fnGridEdit(grid, rowId, null);
			},
			afterInsertRow : function(rowId, rowdata, rowelem) {
			},
		});		
	}
	

	// 선택 항목 리스트
	function reqItemGrid(url, form, grid) {
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
			gridview : true,
			shrinkToFit : false,
			rowNum : -1,
			rownumbers : true,
			multiselect : false,
			colModel : [ {
				type : 'not',
				label : '<input type="checkbox" id="chk" onclick="fn_chk(\'' + grid + '\' , \'' + form + '\');" />',
				name : 'chk',
				width : '40',
				sortable : false,
				align : 'center',
				formatter : "checkbox",
				formatoptions : {
					disabled : false
				}
			}, {
				type : 'not',
				label : ' ',
				name : 'icon',
				width : '20',
				sortable : false,
				align : 'center'
			}, {
				label : 'crud',
				name : 'crud',
				hidden : true
			}, {
				label : 'test_sample_seq',
				name : 'test_sample_seq',
				hidden : true
			}, {
				label : 'test_item_seq',
				name : 'test_item_seq',
				hidden : true,
				key : true
			}, {
				label : 'prdlst_cd',
				name : 'prdlst_cd',
				hidden : true
			}, {
				label : '항목코드',
				name : 'test_item_cd',
				width : '100',
				align : 'center'
			}, {
				type : 'not',
				label : '항목대분류',
				name : 'testitm_lclas_nm',
				width : '100',
				align : 'center'
			}, {
				type : 'not',
				label : '항목 중분류',
				name : 'testitm_mlsfc_nm',
				width : '100',
				align : 'center'
			}, {
				type : 'not',
				label : '항목명',
				name : 'test_item_nm',
				width : '150',
				align : 'center'
			}, {
				type : 'not',
				label : '항목영문명',
				name : 'test_item_eng_nm',
				width : '130',
				align : 'center'
			}, {
				index : 'not',
				label : 'dept_cd',
				name : 'dept_cd',
				hidden : true,
				align : 'center'
			}, {
				index : 'not',
				label : '시험부서',
				name : 'dept_nm',
				align : 'center',
				width : '90'
			}, {
				index : 'not',
				label : 'tester_id',
				name : 'tester_id',
				hidden : true
			}, {
				index : 'not',
				label : '시험자',
				name : 'tester_nm',
				align : 'center',
				width : '90'
			}, {
				type : 'not',
				label : ' ',
				name : 'item_mng_pop',
				sortable : false,
				width : '20',
				align : 'center',
				formatter : imageFormat
			}, {
				type : 'not',
				label : ' ',
				name : 'item_mng_del',
				sortable : false,
				width : '20',
				align : 'center',
				formatter : deleteImageFormat
			}, {
				label : '최종수수료',
				name : 'fee',
				editable : true,
				formatter : 'integer',
				formatoptions : {
					thousandsSeparator : ','
				},
				width : '90',
				align : 'right'
			}, {
				label : '1.품목수수료',
				name : 'prdlst_fee',
				editable : true,
				formatter : 'integer',
				formatoptions : {
					thousandsSeparator : ','
				},
				width : '100',
				align : 'right',
				hidden : true
			}, {
				label : '부서기본수수료',
				name : 'dept_fee',
				editable : true,
				formatter : 'integer',
				formatoptions : {
					thousandsSeparator : ','
				},
				width : '100',
				align : 'right'
			}, {
				label : '성적서 표시 순서',
				name : 'report_order',
				formatter : 'integer',
				width : '100',
				align : 'center'
			}, {
				label : '성적서 표시 여부',
				name : 'report_flag',
				editable : true,
				width : '100',
				align : 'center',
				edittype : "select",
				editoptions : {
					value : 'Y:표시함;N:표시안함'
				},
				formatter : 'select'
			}, {
				label : 'sm_code',
				name : 'sm_code',
				hidden : true,
				width : '250'
			}, {
				label : '스탠다드명',
				name : 'sm_name',
				hidden : true,
				width : '200'
			},{
				label : '세부항목',
				name : 'fnprt_itm_incls_yn',
				width : '70',
				align : 'center'
			}, {
				label : 'result_type',
				name : 'result_type',
				hidden : true
			}, {
				label : '기준<span class="indispensableGrid"></span>',
				name : 'std_type_nm',
				width : '80',
				align : 'center'
			}, {
				label : '결과값형태<span class="indispensableGrid"></span>',
				name : 'result_type_nm',
				width : '80',
				align : 'center'
			}, {
				label : 'std_val',
				name : 'std_val',
				hidden : true
			}, {
				label : 'result_type',
				name : 'result_type',
				hidden : true
			}, {
				label : '기준값<span class="indispensableGrid"></span>',
				name : 'std_val',
				classes : 'imeon',
				align : 'center'
			}, {
				label : '단위코드',
				name : 'unit_cd',
				width : '100',
				hidden : true
			}, {
				label : '단위',
				name : 'unit_nm',
				width : '100',
				align : 'center'
			}, {
				label : '표기자리수',
				name : 'valid_position',
				width : '70',
				align : 'right',
				hidden : true
			}, {
				label : '기준하한값',
				name : 'std_lval',
				width : '70',
				align : 'right',
				hidden : true
			}, {
				label : '하한값구분',
				name : 'lval_type',
				width : '70',
				align : 'center',
				hidden : true
			}, {
				label : '기준상한값',
				name : 'std_hval',
				width : '70',
				align : 'right',
				hidden : true
			}, {
				label : '상한값구분',
				name : 'hval_type',
				width : '70',
				align : 'center',
				hidden : true
			}, {
				label : '기준적합값',
				name : 'std_fit', 
				width : '100',
				hidden : true,
				align : 'center'
			}, {
				label : '기준부적합값',
				name : 'std_unfit',
				width : '100',
				hidden : true,
				align : 'center'
			}, {
				label : '정량하한값',
				name : 'loq_lval',
				width : '100',
				hidden : true,
				align : 'center'
			}, {
				label : '정량하한표기',
				name : 'loq_lval_mark',
				width : '100',
				hidden : true,
				align : 'center'
			}, {
				label : '정량상한값',
				name : 'loq_hval',
				width : '100',
				hidden : true,
				align : 'center'
			}, {
				label : '정량상한표기',
				name : 'loq_hval_mark',
				width : '100',
				hidden : true,
				align : 'center'
			}, {
				label : 'BASE',
				name : 'base_cd',
				width : '150',
				hidden : true,
				align : 'center'
			}, {
				label : '시험방법',
				name : 'test_method_nm',
				width : '150',
				align : 'center'
			}, {
				label : 'formula_no',
				name : 'formula_no',
				hidden : true
			}, {
				label : '계산식',
				name : 'formula_nm',
				width : '150'
			}, {
				label : '등급1 값',
				width : '100',
				name : 'grade1',
				align : 'center',
				hidden : true
			}, {
				label : '등급1범위',
				width : '100',
				name : 'grade1_range',
				align : 'center',
				hidden : true
			}, {
				label : '등급1',
				width : '100',
				name : 'grade1_nm',
				align : 'center'
			}, {
				label : '등급2 값',
				width : '100',
				name : 'grade2',
				align : 'center',
				hidden : true
			}, {
				label : '등급2범위',
				width : '100',
				name : 'grade2_range',
				align : 'center',
				hidden : true
			}, {
				label : '등급2',
				width : '100',
				name : 'grade2_nm',
				align : 'center'
			}, {
				label : '등급3 값',
				width : '100',
				name : 'grade3',
				align : 'center',
				hidden : true
			}, {
				label : '등급3범위',
				width : '100',
				name : 'grade3_range',
				align : 'center',
				hidden : true
			}, {
				label : '등급3',
				width : '100',
				name : 'grade3_nm',
				align : 'center'
			}, {
				label : '등급4',
				width : '100',
				name : 'grade4',
				align : 'center',
				hidden : true
			}, {
				label : '등급4범위',
				width : '100',
				name : 'grade4_range',
				align : 'center',
				hidden : true
			}, {
				label : '등급4',
				width : '100',
				name : 'grade4_nm',
				align : 'center'
			}, {
				label : '산화물 표기',
				name : 'oxide_content',
				width : '300',
				align : 'center',
				hidden : true
			}, {
				label : 'oxide_cd',
				name : 'oxide_cd',
				width : '300',
				align : 'center',
				hidden : true
			}, {
				type : 'not',
				label : 'fee_group_no',
				name : 'fee_group_no',
				hidden : true
			}, {
				type : 'not',
				label : 'KOLAS',
				name : 'kolas_flag',
				width : '70',
				hidden : true,
				align : 'center'
			}, {
				type : 'not',
				label : '항목 그룹',
				hidden : true,
				name : 'test_item_group_nm'
			}, {
				label : 'test_item_group_no',
				name : 'test_item_group_no',
				hidden : true
			}, {
				type : 'not',
				label : 'state',
				name : 'state',
				hidden : true
			}, {
				label : 'kfda_yn',
				name : 'kfda_yn',
				hidden : true
			}, {
				label : 'del_st_spec',
				name : 'del_st_spec',
				hidden : true
			} ],
			gridComplete : function() {
				var ids = $('#' + grid).jqGrid("getDataIDs");
				if (ids.length > 0) {
					for ( var i in ids) {
						var row = $('#' + grid).getRowData(ids[i]);
						fn_Item_Row_Click(row.test_item_seq);
						if (row.state == 'Z' || row.state == 'A') {
						} else if (row.state == 'B') {
							for (key in row) {
								if (key == 'test_item_nm') {
									$('#' + grid).jqGrid('setCell', ids[i], key, '[시험중]' + row.test_item_nm, {
										color : 'red'
									});
								} else {
									$('#' + grid).jqGrid('setCell', ids[i], key, '', {
										color : 'red'
									});
								}
							}
						} else {
							for (key in row) {
								if (key == 'test_item_nm') {
									$('#' + grid).jqGrid('setCell', ids[i], key, '[시험완료]' + row.test_item_nm, {
										color : 'blue'
									});
								} else {
									$('#' + grid).jqGrid('setCell', ids[i], key, '', {
										color : 'blue'
									});
								}
							}
						}
					}
				}
			},
			afterInsertRow : function(rowId, rowdata, rowelem) {

			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
				if (!confirm('저장하지 않은 정보는 사라집니다. 정렬하시겠습니까?')) {
					return 'stop';
				}
			},
			onCellSelect : function(rowId, iCol, cellcontent, e) {
				if (editChange) {
					var colArr = $('#' + grid).jqGrid('getGridParam', 'colModel');
					var col = colArr[iCol].name;
					var row = $('#' + grid).getRowData(rowId);
					if (col == 'user_pop') {

						fnpop_reqTeam("reqItemForm", "750", "500" , "team", rowId, row.dept_cd, row.test_sample_seq, row.test_item_seq, row.user_id);
						
						$('#' + grid).jqGrid('setSelection', rowId, false);
					}
					if (col == 'item_mng_pop') {
						if (row.state == 'A' || row.state == 'Z') {
							if (confirm('담당자를 등록하시겠습니까?')) {
								fnpop_UserInfoPop(grid, "500", "500", 'acceptNreceit', rowId);	
							}
						}else{
							$.showAlert('시험진행중입니다.');
							return;
						}
					}
					if (col == 'item_mng_del') {
						if (row.state == 'A' || row.state == 'Z') {
							if (confirm('담당자를 삭제하시겠습니까?')) {
								$('#' + grid).jqGrid('setCell', rowId, 'dept_cd', '');
								$('#' + grid).jqGrid('setCell', rowId, 'dept_nm', '');
								$('#' + grid).jqGrid('setCell', rowId, 'tester_id', '');
								$('#' + grid).jqGrid('setCell', rowId, 'tester_nm', '');
								$('#' + grid).setCell(rowId, 'icon', gridU);
								$('#' + grid).setCell(rowId, 'crud', 'u');
							}
						}else{
							$.showAlert('시험진행중입니다.');
							return;
						}
					}
				}
			},
			onSelectRow : function(rowId, status, e) {
				if (rowId && rowId != lastRowId) {
					lastRowId = rowId;					
					fnEditRelease(grid);
					
					if($("input:checkbox[id='jqg_reqItemGrid_" + rowId + "']").is(":checked")){
						var row = $('#' + grid).getRowData(rowId);
						$('#sampleItemFileForm').find('#test_sample_seq').val(row.test_sample_seq);
						$('#sampleItemFileForm').find('#test_item_cd').val(row.test_item_cd);
					} else {
						var row = $('#' + grid).getRowData(rowId);
						$('#sampleItemFileForm').find('#test_item_cd').val(row.test_item_cd);
					}
				} else {
					// 리스트에 체크된게 하나도 없으면,
					var selID = $('#'+grid).getGridParam('selrow');
					if(selID == null || selID == ""){
						$('#sampleItemFileForm').find('#test_item_cd').val('');
					} else {
						var row = $('#' + grid).getRowData(rowId);
						$('#sampleItemFileForm').find('#test_item_cd').val(row.test_item_cd);
					}
				}				
				$('#sampleItemFileGrid').trigger('reloadGrid');
			},
			ondblClickRow : function(rowId, iRow, iCol, e) {
				
				var row = $('#' + grid).getRowData(rowId);
				if (!(row.state == 'Z' || row.state =='A')){
					$('#'+grid).setColProp('dept_cd',{editable:false});				
				}
				
				fnGridEdit(grid, rowId, fn_Item_Row_Click);
				
				var colArr = $('#' + grid).jqGrid('getGridParam', 'colModel');
				$('#' + rowId + '_' + colArr[iCol].name).focus();
				var p = 0;
				$('#' + rowId + '_' + colArr[iCol].name).blur(function() {
					if (p == 0) {
						$('#' + rowId + '_' + colArr[iCol].name).focus();
					}
					p++;
				});
			}
		});
		//jQuery("#reqItemGrid").sortableRows();   
	}

	//항목별 첨부문서
	var lastRowId;
	function sampleItemFileGrid(url, form, grid) {
		$('#' + grid).jqGrid({
			datatype : function(json) {
				fnGridData(url, form, grid);
			},
			height : '230',
			autowidth : true,
			loadonce : true,
			mtype : "POST",
			gridview : false,
			shrinkToFit : false,
			rowNum : -1,
			rownumbers : true,
			colModel : [ {
				label : '문서 번호',
				name : 'att_seq',
				hidden : true,
				key : true
			}, {
				label : '검체 번호',
				name : 'test_sample_seq',
				align : 'center',
				hidden : true
			}, {
				label : '항목 번호',
				name : 'test_item_cd',
				align : 'center',
				hidden : true,
				align : 'center'
			}, {
				label : '첨부 문서명',
// 				name : 'file_nm'
				width : '300',
				formatter : displayItemAlink,
				align : 'center'
			} ],
			gridComplete : function() {
				$('#sampleItemFileForm').find('#updateItemBtn').hide();
				$('#sampleItemFileForm').find('#insertItemBtn').show();
			},
			onSortCol : function(index, iCol, sortorder) {
			},
			onCellSelect : function(rowId, iCol, cellcontent, e) {
			},
			onSelectRow : function(rowId, status, e) {
				var row = $('#' + grid).getRowData(rowId);
				$('#sampleItemFileForm').find('#att_seq').val(row.att_seq);
				$('#sampleItemFileForm').find('#updateItemBtn').show();
				$('#sampleItemFileForm').find('#insertItemBtn').hide();		

				if (rowId && rowId != lastRowId) {
					lastRowId = rowId;
				
				}
			},
			ondblClickRow : function(rowId, iRow, iCol, e) {
			}
		});
	}
	
	

	// 의뢰/접수리스트 조회
	function btn_Select_onclick() {
		var state = $('#reqListForm').find('#state').val();
		$('#reqListGrid').trigger('reloadGrid');
	}
	
	// 의뢰/접수 추가
	function btn_New_onclick() {
		fnViewPage('accept/selectAcceptDetail.lims', 'acceptDiv', 'type=${type}');
		$('#reqSampleForm').find('#test_req_seq').val('');
		$('#reqSampleGrid').clearGridData();
		$('#reqItemForm').find('#test_sample_seq').val('');
		$('#reqItemGrid').clearGridData();
		$('#tabs').tabs({
			active : 1
		});
		fn_Div_Block('itemDiv', reqMsg, true);
		fn_Div_Block('sampleDiv', reqMsg, true);
	}
	
	// 의뢰/접수 저장
	function btn_Save_onclick(param) {
		//비고저장부분

		var sta = $('#reqDetailForm').find('#state').val();
		
		var url;
		// 필수 체크
		if(formValidationCheck("reqDetailForm")){			
			return;
		} else {		
				if ($('#reqDetailForm').find('#req_org_no').val() == '') {
					$.showAlert('의뢰업체 선택해주세요.');
					$('#reqDetailForm').find('#req_org_nm').focus();
					return false;
				} else if ($('#reqDetailForm').find('#req_org_no2').val() == '') {
					$.showAlert('소유업체 선택해주세요.');
					$('#reqDetailForm').find('#req_org_nm2').focus();
					return false;
				} else if ($('#reqDetailForm').find('#req_org_no3').val() == '') {
					$.showAlert('계산서발행업체 선택해주세요.');
					$('#reqDetailForm').find('#req_org_nm3').focus();
					return false;
				} else if ($('#reqDetailForm').find('#req_org_no4').val() == '') {
					$.showAlert('성적서발행업체 선택해주세요.');
					$('#reqDetailForm').find('#req_org_nm4').focus();
					return false;
				}
				// 난이도조정(이름미정) 적용 선택
				if($(":input:radio[name=discount_flag]:checked").val()== 'Y'){
					if ($('#reqDetailForm').find('#discount_rate').val() == '') {
						$.showAlert('난이도조정비율을 입력해주세요.');
						$('#reqDetailForm').find('#discount_rate').focus();
						return false;
					}
				} 
				// 수수료 입금 종류 선택
				var commission_type = $('#reqDetailForm').find('#commission_type').val();
				var fee_tot = $('#reqDetailForm').find('#fee_tot').val();
				if(commission_type == 'C61003' || commission_type == 'C61004' || fee_tot == '0'){
					commission_amt_flag = 'Y';
				} else {
					commission_amt_flag = 'N';
				}
	 			if ($('#reqDetailForm').find('#test_req_seq').val() == '') {
					url = 'accept/insertAccept.lims?commission_amt_flag=' + commission_amt_flag;
				} else {
					url = 'accept/updateAccept.lims?commission_amt_flag=' + commission_amt_flag;
				} 
	 			var json;
				 if ($('#reqDetailForm').find('#QR_file_upload').val() != '') {
				 	 var json = fnAjaxFileAction2(url, 'reqDetailForm', fn_suc);
				}  else { 
					 json = fnAjaxAction(url, $('#reqDetailForm').serialize());
					if (json == null) {
						$.showAlert('저장실패하였습니다.');
						return false;
					}
				}
				
				
			 	$("#vw_test_req_no2").text(json.test_req_no);
			 	$("#vw_state2").text("진행상태 : 접수대기");
	
				$('#reqDetailForm').find('#test_req_seq').val(json.test_req_seq);
				$('#reqDetailForm').find('#vw_test_req_seq').text(json.test_req_seq);
				$('#reqSampleForm').find('#test_req_seq').val(json.test_req_seq);
				$('#requestFileForm').find('#test_req_seq').val(json.test_req_seq);
				$('#reqSampleGrid').trigger('reloadGrid');
				$('#requestFileGrid').trigger('reloadGrid');
				
				fnStopLoading('sampleDiv');
				fnStopLoading('itemDiv');
				if(param == 'List'){
					$.showAlert('저장이 완료되었습니다.');
				}
				btn_Select_onclick();
	
				$('#reqDetailForm').find('#state').val('A');
	
				fn_Btn_Visible();
				
		}
		return "success";
	}

	// 의뢰/접수 선택
	function btn_Choice_onclick(reqSeq) {
		var rowId;
		if(reqSeq == ''){
			rowId = $('#reqListGrid').getGridParam('selrow');			
		}else{
			rowId = reqSeq;
		}
		
		if (rowId == null) {
			alert('선택된 의뢰가 없습니다.');
			return false;
		}

		var data = 'type=${type}' + '&pageType=detail&test_req_seq=' + rowId;
		fnViewPage('accept/selectAcceptDetail.lims', 'acceptDiv', data);
		$('#reqSampleForm').find('#test_req_seq').val(rowId);
		btn_Reset_Sub_onclick('reqSampleGrid');
		btn_Reset_Sub_onclick('reqItemGrid');
		
		fnStopLoading('sampleDiv');
		fnStopLoading('itemDiv');
		$('#tabs').tabs({
			active : 1
		});
	}
	
	// 검체삭제
	function btn_Delete_Sub_onclick(grid) {
		if (!confirm('선택하신 검체를 삭제하시겠습니까?\n삭제후 저장버튼을 누르셔야 반영됩니다.')) {
			return false;
		}
		var div = 'itemDiv';
		var msg = itemMsg;
		var b = false;
		var ids = $('#' + grid).jqGrid("getDataIDs");
		if (ids.length > 0) {
			for ( var i in ids) {
				var row = $('#' + grid).getRowData(ids[i]);
				if (row.chk == 'Yes') {
					b = true;
				}
			}
		}
		if (b) {
			fn_Div_Block(div, msg, false);
			fnGridDeleteMultiLine(grid);
		} else {
			$.showAlert('선택된 행이 없습니다.');
		}
	}
	
	// 항목 삭제 ( 삭제 시 시험일지에도 삭제 )
	function btn_Delete_Sub2_onclick() {
		if (!confirm('삭제하시겠습니까?')) {
			return false;
		}	
		var grid = 'reqItemGrid';		
		var data = 'test_sample_seq=' + $('#reqItemForm').find('#test_sample_seq').val() + '&menu_cd=' + $('#menu_cd').val();
		var data2 = "&test_item_seq=";
		data += "&test_item_cd=";
		var ids = $('#' + grid).jqGrid("getDataIDs");
		if (ids.length > 0) {
			for ( var i in ids) {
				var row = $('#' + grid).getRowData(ids[i]);
				if (row.chk == 'Yes') {
					//alert(row.test_item_cd);
					data += row.test_item_cd + ',';
					data2 += row.test_item_seq + ',';
				}
			}
			data = data.substr(0, data.length - 1);
			data2 = data2.substr(0, data2.length - 1);
			data += data2 + '&test_req_seq=' +  $('#reqSampleForm').find('#test_req_seq').val();
			var json = fnAjaxAction('accept/deleteItemGrid.lims', data);
			if (json == null) {
				$.showAlert('삭제 실패하였습니다.');
			} else {
				$('#reqItemGrid').trigger('reloadGrid');
				
				fn_show_type($(":input:radio[name=fee_auto_flag]:checked").val());
				$.showAlert('삭제 완료되었습니다.');
				$('#reqSampleGrid').trigger('reloadGrid');
			}
			
		}else {
			$.showAlert('선택된 행이 없습니다.');
		}
	}
	
	// 검체 리스트 저장
	function btn_Save_Sub_onclick(grid) {
		fnEditRelease(grid);
		
		//접수시 저장
		var sta = $('#reqDetailForm').find('#state').val();
		if(sta == null||sta == ''||sta == 'A') {	
			var url = 'accept/saveSampleGrid.lims?&state=A';
			var ids = $('#' + grid).jqGrid("getDataIDs");
			for ( var i in ids) {
				var row = $('#' + grid).getRowData(ids[i]);
				if (row.sample_reg_nm == '') {
					$.showAlert((Number(i) + 1) + '번 행의 품목명을 넣어주세요.');
					return false;
				}
	 			if (row.prdlst_cd == '') {
	 				$.showAlert((Number(i) + 1) + '번 행의 품목을 선택해주세요.');
	 				return false;
	 			}
			}
			var data = fnGetGridCheckData(grid) + '&menu_cd=' + $('#menu_cd').val();
			var json = fnAjaxAction(url, data);
			if (json == null) {
				$.showAlert('저장실패하였습니다.');
			} else {
				// 수수료 선택
				if($(":input:radio[name=fee_auto_flag]:checked").val()== 'Y'){
					$('#reqDetailForm').find("#fee_tot").val("");
				} else {
					$('#reqDetailForm').find("#fee_tot_item").val("");
				}
				btn_Reset_Sub_onclick('reqSampleGrid');			
				
				fn_show_type($(":input:radio[name=fee_auto_flag]:checked").val());
				
				$.showAlert('저장이 완료되었습니다.');
			}
			//접수 후  생산/수입일-비고 업데이트
 		} else if (sta != 'F'&&sta != 'A'&&sta != '') {
			alert("접수 완료 후에는 비고만 반영됩니다.");
			var data = fnGetGridAllData(grid) ;

			var url = 'accept/updateReqSampleMessage.lims';
			var json = fnAjaxAction(url, data);
/* 			var ids = $('#' + grid).jqGrid("getDataIDs");
			for ( var i in ids) {
				var row = $('#' + grid).getRowData(ids[i]);
				var data = 'etc_desc=' + row.etc_desc + '&test_sample_seq=' + row.test_sample_seq+ '&test_req_seq=' + row.test_req_seq;
				var url = 'accept/updateReqSampleMessage.lims';

				var json = fnAjaxAction(url, data);

			} */

			if (json == null) {
				$.showAlert('저장실패하였습니다.'); 
				return false;
			}
			$.showAlert('저장이 완료되었습니다.');
			fn_Btn_Visible();
		}  
	}

	
	// 접수완료 ( 상세페이지 )
	function btn_Accept_onclick() {
		if (!confirm('접수완료하시겠습니까?')) {
			return false;
		}	
		
		// 접수저장
		var rst = btn_Save_onclick("Detail");		
		if(rst != 'success'){
			return false;
		}
		if ($('#reqDetailForm').find('#test_req_seq').val() == '') {
			$.showAlert('의뢰정보가 없습니다.');
			return;
		} else {	
			
			var state ="";
			var sample_state ="";
			var tmp_state = $('#reqDetailForm').find('#state').val();
			if(tmp_state == "Z"){
				state = "Z";
				sample_state = 'A';
			}else if(tmp_state =="A"){
				state = "B";
				sample_state = 'B';
			}
			var data = 'type='+ '${type}' + '&test_req_seq=' + $('#reqDetailForm').find('#test_req_seq').val() + 
			'&dept_cd=' + $('#reqDetailForm').find('#dept_cd').val()  + '&menu_cd=' + $('#menu_cd').val() + '&state='+state + 
			'&sample_state='+sample_state + '&act_date=' + $('#reqDetailForm').find('#act_date').val();
			var json = fnAjaxAction('accept/updateAcceptState.lims', data);
			if (json == null) {
				$.showAlert('접수실패하였습니다.');
			} else if (json == '1') {
				var data = 'type=${type}' + '&pageType=detail&test_req_seq=' + $('#reqDetailForm').find('#test_req_seq').val();
				fnViewPage('accept/selectAcceptDetail.lims', 'acceptDiv', data);
				btn_Reset_Sub_onclick('reqSampleGrid');
				btn_Reset_Sub_onclick('reqItemGrid');
				$.showAlert('접수완료되었습니다.');
				fn_Btn_Visible();
				/* $('#tabs').tabs({
					active : 0
				}); */
				btn_Select_onclick();
			} else if (json == '2') {
				$.showAlert('검체가 존재하지 않습니다. 검체를 추가해주세요.');
			} else {
				var j = json[json.length - 1];
				var str = '';
				if (j == '3') {
					var str = '검체명:';
					for (var s = 0; s < json.length - 1; s++) {
						str += '&nbsp;' + json[s] + ' ';
					}
					str += '의 시험부서를 모두 선택해 주세요.';
				} else {
					var str = '검체명:';
					for ( var s in json) {
						str += ' ' + json[s] + ' ';
					}					
					str += '의 항목이 존재하지 않습니다.';
				}
				$('#dialog').html(str);
				$("#dialog").dialog({
					buttons : [ {
						text : "확인",
						click : function() {
							$(this).dialog("close");
						}
					} ]
				});
			}
		}
	}
	
	// 반려
	function btn_Return_onclick() {
		if (!confirm('반려하시겠습니까?')) {
			return false;
		}
		if ($('#reqDetailForm').find('#test_req_seq').val() == '') {
			$.showAlert('의뢰정보가 없습니다.');
		} else {
			var data = 'test_req_seq=' + $('#reqDetailForm').find('#test_req_seq').val() + '&state=Z' + '&menu_cd=' + $('#menu_cd').val();
			var json = fnAjaxAction('accept/returnAcceptState.lims', data);
			if (json == null) {
				$.showAlert('반려실패하였습니다.');
			} else {
				fnViewPage('accept/selectAcceptDetail.lims', 'acceptDiv', 'type=${type}');
				$('#reqListGrid').clearGridData();
				$('#reqSampleForm').find('#test_req_seq').val('');
				btn_Reset_Sub_onclick('reqSampleGrid');
				btn_Reset_Sub_onclick('reqItemGrid');
				$.showAlert('반려완료되었습니다.');
				fn_Btn_Visible();
			}
		}
	}
	
	// 리스트에서 접수 (의뢰 -> 접수대기 , 접수대기 -> 접수 완료)
	function fnpop_req() {
		var ids = $('#reqListGrid').jqGrid("getDataIDs");
		var c = 0;
		
		var state;
		var sample_state = '';
		var c = 0;
		
		var menu_cd = $('#menu_cd').val();
		if (menu_cd == "030300"){
			if (!confirm('접수 하시겠습니까?')) {
				return false;
			}
			
			state = 'Z';
			sample_state = 'A';
		}else if(menu_cd == "030400"){
			if (!confirm('접수완료 하시겠습니까?')) {
				return false;
			}
			
			state = 'B';
		}else{
			$.showAlert('잘못된 경로입니다.');
			return false;	
		}
		for ( var i in ids) {
			var row = $('#reqListGrid').getRowData(ids[i]);
			if (row.chk == 'Yes') {
				if( row.state == '의뢰' ){
					if( row.commission_type == 'C61001' && row.commission_amt_flag != 'Y' ){ // 수수료 사용 FLAG
						alert('요금이 완납되지 않은 의뢰건 입니다.');
						return false;
					}
				} else if (row.state == '접수대기'){

				} else {
					alert("접수 할 수 없습니다.");
					return false;
				}
				var data = 'type='+ '${type}' + '&test_req_seq=' + row.test_req_seq + 
							'&dept_cd=' + row.dept_cd  + '&menu_cd=' + $('#menu_cd').val() + '&state='+state + '&sample_state='+sample_state;
				var json = fnAjaxAction('accept/updateAcceptState.lims', data);
				if (json == null) {						
					$.showAlert('접수실패하였습니다.');
					return false;
				} else if (json == '1') {
					$('#reqListGrid').jqGrid('delRowData', ids[i]);
				} else if (json == '2') {						
					$.showAlert('검체가 존재하지 않습니다. 검체를 추가해주세요.');	
					return false;
				} else {
					var j = json[json.length - 1];
					var str = '';
					if (j == '3') {
						var str = '검체명:';
						for (var s = 0; s < json.length - 1; s++) {
							str += '&nbsp;' + json[s] + ' ';
						}
						str += '의 시험부서를 모두 선택해 주세요.';
					} else {
						var str = '검체명:';
						for ( var s in json) {
							str += '&nbsp;' + json[s] + ' ';
						}
						str += '의 항목이 존재하지 않습니다.';
					}
					$('#dialog').html(str);
					$("#dialog").dialog({
						buttons : [ {
							text : "확인",
							click : function() {
								$(this).dialog("close");
							}
						} ]
					});
					return false;
				}
				c++;
			}
		}
		if (c == 0) {
			alert('선택된 건이 없습니다.');
			return false;
		}
		$('#reqListGrid').trigger('reloadGrid');
		if(state == 'Z'){
			$.showAlert('의뢰가 완료되었습니다. 접수에서 확인하세요.');
		}else{
			$.showAlert('접수완료되었습니다.');
		}
	}
	
	// 접수(의뢰) 삭제
	function btn_Delete_onclick() {
		if (!confirm('의뢰삭제를 진행하면 복구가 불가능합니다.\n\r진행하시겠습니까?')) {
			return false;
		}
		var rowId = $('#reqListGrid').getGridParam('selrow');
		if (rowId == null) {
			alert('선택된 행이 없습니다.');
			return false;
		} else {
			var row = $('#reqListGrid').getRowData(rowId);
			if (row.creater_id == '${session.user_id}') {
				var json = fnAjaxAction('accept/deleteAccept.lims', 'test_req_seq=' + row.test_req_seq + '&pick_no=' + row.pick_no);
				if (json == null) {
					$.showAlert('삭제 실패하였습니다.');
				} else {
					$('#reqListGrid').trigger('reloadGrid');
					fnViewPage('accept/selectAcceptDetail.lims', 'acceptDiv', 'type=${type}');
					$.showAlert('삭제 완료하였습니다.');
				}
			} else {
				alert('본인 접수건이 아닙니다.');
			}
		}
	}
	
	
	// 항목 저장(수수료 수정)
	function btn_Save_Sub2_onclick(pageType) {
		var grid = 'reqItemGrid';
		var json = null;
		fnEditRelease(grid); // 수정모드 해제
		
		var test_sample_seq = $('#test_sample_seq').val();
		var test_req_seq = $('#test_req_seq').val();
		var ids = $('#' + grid).jqGrid("getDataIDs");
		for (var i in ids) {
			var row = $('#' + grid).getRowData(ids[i]);
			if ($.trim(row.dept_cd) == '' && $.trim(row.crud) == 'u') {
				alert('('+row.test_item_nm + ') 항목의 시험부서를 선택해주세요.');
				return false;
			}
		}	 
		
		//수정 	 
  		var data = fnGetGridAllData(grid) + '&test_sample_seq=' + test_sample_seq + "&pageType=" + pageType + "&test_req_seq=" + test_req_seq;
		json = fnAjaxAction('accept/insertItemGrid.lims', data);  
		
 		if (json == null) {
			$.showAlert('저장 실패하였습니다.');
		} else {				
			$.showAlert('저장 완료하였습니다.');
			fnpop_callback(); 
		}  
	}
	
	// 수수료마스터등록
	function btn_SaveItemFee_onclick(){
		
		var grid = "reqItemGrid";
		var tmp_test_req_seq = $('#reqDetailForm').find('#test_req_seq').val();
		var tmp_test_sample_seq = $('#reqItemForm').find('#test_sample_seq').val();
		var tmp_dept_fee ="";
		var tmp_prdlst_fee ="";
		fnEditRelease(grid); // 수정모드 해제
		var ids = $('#' + grid).jqGrid("getDataIDs");
		var tmp_test_item_cd ="";
		if (ids.length > 0){
			for ( var i in ids) {
				var row = $('#' + grid).getRowData(ids[i]);
			    var state = $('#' + grid).jqGrid('getCell', ids[i], 'crud');

			    if (row.chk == 'Yes') {
					tmp_test_item_cd += row.test_item_cd + ',';
					tmp_dept_fee += row.dept_fee+ ',';
				    tmp_prdlst_fee += row.prdlst_fee+ ',';
				}
			}
			if(fnIsEmpty(tmp_test_item_cd)){
				alert("선택된 시험항목이 없습니다.");
				return;
			}
			tmp_test_item_cd = tmp_test_item_cd.substr(0, tmp_test_item_cd.length - 1);
			tmp_dept_fee = tmp_dept_fee.substr(0, tmp_dept_fee.length - 1);
		    tmp_prdlst_fee = tmp_prdlst_fee.substr(0, tmp_prdlst_fee.length - 1);
		} else {
			alert("등록된 시험항목이 없습니다.");
			return false;
		}
		var data = 'dept_cd=' +$('#reqDetailForm').find('#dept_cd').val() +'&test_std_no=' + $('#reqDetailForm').find('#test_std_no').val()
		+'&test_req_seq=' + tmp_test_req_seq +'&test_sample_seq=' + tmp_test_sample_seq
		+ "&test_item_cd=" + tmp_test_item_cd + "&dept_fee=" + tmp_dept_fee + "&prdlst_fee=" + tmp_prdlst_fee;
	
		
		var json = fnAjaxAction('accept/saveItemMasterFee.lims', data);
		if (json == null) {
			$.showAlert('마스터등록에 실패하였습니다.');
		} else {
			$.showAlert('등록 완료하였습니다.');
		}
	}
    
	function fn_Item_Row_Click(rowId) {
		var grid = 'reqItemGrid';
		//$('#' + rowId + '_dept_cd').change(function() {
			var row = $('#' + grid).getRowData(rowId);
			var data = 
				"test_std_no=" + $('#reqDetailForm').find('#test_std_no').val() +
				"&dept_cd=" + row.dept_cd +
				"&prdlst_cd=" + row.prdlst_cd +
				"&test_item_cd=" + row.test_item_cd;
			fn_deptFee_change(rowId, data);
		//});
	}

	function fn_deptFee_change(rowId, data) {
		var grid = 'reqItemGrid';
		$.ajax({
			url : "accept/selectFeeValue.lims",
			dataType : 'json',
			type : 'POST',
			async : false,
			data : data,
			success : function(json) {
				if(json != null){
					$('#' + grid).jqGrid('setCell', rowId, 'fee', json.dept_fee);
					$('#' + grid).jqGrid('setCell', rowId, 'dept_fee', json.dept_fee);	
				}
			},
			/* error : function() {
				$.showAlert('[010]서버에 접속할 수 없습니다.');
			} */
		});
	}

	function btn_itemMngChange_onclick() {
		var ids = $('#reqItemGrid').jqGrid("getDataIDs");
		var chkCnt = 0;
		if (ids.length > 0) {
			for ( var i in ids) {
				var row = $('#reqItemGrid').getRowData(ids[i]);
				if (row.chk == 'Yes') {
					chkCnt++;
				}
			}
		}
		if (chkCnt == 0) {
			$.showAlert('선택된 행이 없습니다.');
		} else {
			if (confirm('담당자를 등록하시겠습니까?')) {
				fnpop_UserInfoPop('reqItemGrid', "500", "500", 'acceptNreceit', '');	
			}	
		}
	}

	function btn_print_onclick() {
		var rowId = $('#reqListGrid').getGridParam('selrow');
		if (rowId != null) {
			$("#dialogPrint").dialog({
				width : 555,
				height : 130,
				resizable : false,
				title : '출력물 개정 정보',
				modal : true,
				open : function(event, ui) {
					$(".ui-dialogPrint-titlebar-close").hide();
					var data = "printGbn=C60003";
					fnViewPage('/revisionPop.lims', 'dialogPrint', data);
				},
				buttons : [
				{
					text : "미리보기",
					click : function() {
						// 필수 체크
						if(formValidationCheck("revisionPopForm")){			
							return;
						} else {
							var fileNm = $("#revisionPopForm").find("#doc_seq").val() + "_V" 
									   + $("#revisionPopForm").find("#doc_seq option:checked").text() + ".mrd";
							
						 	var test_req_seq = $('#reqListGrid').getGridParam('selrow'); 
							
							html5Viewer(fileNm, "/rp ["+test_req_seq+"] " , false);
							
						}
					}
				
				},  
				{
					text : "출력",
					click : function() {
						var fileNm = $("#revisionPopForm").find("#doc_seq").val() + "_V" 
						   + $("#revisionPopForm").find("#doc_seq option:checked").text() + ".mrd";
						
					 	var test_req_seq = $('#reqListGrid').getGridParam('selrow'); 
						
						html5Viewer(fileNm, "/rp ["+test_req_seq+"] " , false);
					}
				}, 
				{
					text : "취소",
					click : function() {
						$('#dialogPrint').dialog("destroy");
					}
				}]
			});
		} else {
			$.showAlert('선택된 행이 없습니다.');
		}
	}
	
	//라벨프린트
	function btn_label_onclick(){
		var rowId = $('#reqListGrid').getGridParam('selrow');
		
		if(rowId == null){
			alert("선택된 행이 없습니다.");
			return false;
		}else{
			var gridRow = $('#reqListGrid').getRowData(rowId);

			if(gridRow.process != "B"){
				alert("접수완료 후에 출력하여 주세요.");
				return false;
			}
			
			//rsetpageinfo [2@@@] 프린트시 방향전환
			html5Viewer("barcode.mrd", "/rsetpageinfo [2@@@] /rp [TEST_REQ_NO] [BARCODE_DESC] [TEST_REQ] [TEST_REQ_SEQ] ["+rowId+"] ", true);    
		}
	}
	function copy_content() {
		
		
		var rowId = $('#reqSampleGrid').getGridParam('selrow');
		var row = $('#reqSampleGrid').getRowData(rowId);
	
		
		var ids = $('#reqSampleGrid').jqGrid("getDataIDs");
		
	
		for ( var i in ids) {
			var row1 = $('#reqSampleGrid').getRowData(ids[i]);
			
			if (row1.chk == 'Yes') {
				
				
				
				$('#reqSampleGrid').jqGrid('setCell',ids[i] , 'crud', 'u');
				$('#reqSampleGrid').jqGrid('setCell',ids[i] , 'sample_reg_nm', row.sample_reg_nm.trim());
				$('#reqSampleGrid').jqGrid('setCell',ids[i] , 'produce_date', row.produce_date.trim());
				$('#reqSampleGrid').jqGrid('setCell',ids[i] , 'produce_no', row.produce_no.trim());
				$('#reqSampleGrid').jqGrid('setCell',ids[i] , 'producer_nm', row.producer_nm.trim());
				$('#reqSampleGrid').jqGrid('setCell',ids[i] , 'produce_place', row.produce_place.trim());
				$('#reqSampleGrid').jqGrid('setCell',ids[i] , 'supplier', row.supplier.trim());
				$('#reqSampleGrid').jqGrid('setCell',ids[i] , 'sample_etc_nm', row.sample_etc_nm.trim());
				$('#reqSampleGrid').jqGrid('setCell',ids[i] , 'expiry_date', row.expiry_date.trim());
				$('#reqSampleGrid').jqGrid('setCell',ids[i] , 'sample_weight', row.sample_weight.trim());
				$('#reqSampleGrid').jqGrid('setCell',ids[i] , 'keep_method', row.keep_method.trim());
				$('#reqSampleGrid').jqGrid('setCell',ids[i] , 'orderer_nm', row.orderer_nm.trim());
				$('#reqSampleGrid').jqGrid('setCell',ids[i] , 'builder_nm', row.builder_nm.trim());
				$('#reqSampleGrid').jqGrid('setCell',ids[i] , 'joiner_nm', row.joiner_nm.trim());
				$('#reqSampleGrid').jqGrid('setCell',ids[i] , 'etc_desc', row.etc_desc.trim());
			}
		}
		
		console.log(ids)
	}
	
	//스탠다드 추가 팝업
	function btn_SelfStandChoice_onclick(grid) {
		var param = $('#reqDetailForm').find('#test_req_seq').val();
		fnpop_selfStandItemChoicePop("reqItemForm", "1000", "867", param);
		
		fnBasicStartLoading();
	}
	
	//등급설정 항목 추가 팝업
	function btn_SelfGradeChoice_onclick(grid) {
		var param = $('#reqDetailForm').find('#test_req_seq').val();
		fnpop_selfGradeChoicePop("reqItemForm", "1000", "867", param);
		
		fnBasicStartLoading();
	}
	
// 	//검체별 첨부문서 문서 구분 저장
// 	function btn_Sample_check_onclick(grid) {
// 		fnEditRelease(grid); // 수정모드 해제
// 		var grid = 'sampleFileGrid';
// 		fnEditRelease(grid); // 수정모드 해제
		
// 		var ids = $('#' + grid).jqGrid("getDataIDs");
// 		var c = 0;
		
// 		for ( var i in ids) {
// 			var row = $('#' + grid).getRowData(ids[i]);
// 			var isPng = row.file_nm.match(/.png/);
// 			var isJpg = row.file_nm.match(/.jpg/);
// 			var isBmp = row.file_nm.match(/.bmp/);
// 			var isGif = row.file_nm.match(/.gif/);
// 			var isPNG = row.file_nm.match(/.PNG/);
// 			var isJPG = row.file_nm.match(/.JPG/);
// 			var isBMP = row.file_nm.match(/.BMP/);
// 			var isGIF = row.file_nm.match(/.GIF/);
// 			if ( (row.sample_att_gbn == 'C83002') 
// 					&& (isPng == ".png" || isJpg == ".jpg" || isBmp == ".bmp" || isGif == ".gif" 
// 							|| isPNG == "..PNG" || isJPG == ".JPG" || isBMP == ".BMP" || isGIF == ".GIF" ) ) {
// 				c++;
// 			} else if (row.sample_att_gbn == 'C83001') {
				
// 			} else if (row.sample_att_gbn == null || row.sample_att_gbn == '') {
// 				alert('문서구분을 선택해 주시기 바랍니다.');
// 				$('#sampleFileGrid').trigger('reloadGrid');
// 				return false;	
// 			}else {
// 				alert('성적서 출력용 이미지는 png, jpg, bmp, gif 만 가능합니다.');
// 				$('#sampleFileGrid').trigger('reloadGrid');
// 				return false;	
// 			}
// 		}
// 		var json;
//  		//성적서 이미지 중복 선택 불가
// 		if (c > 2) {
// 			alert('성적서 출력용 이미지는 두 개만 선택하실 수 있습니다.');
// 			$('#sampleFileGrid').trigger('reloadGrid');
// 			return false;
// 		} else {
// 			for ( var i in ids) {
//  				var row = $('#' + grid).getRowData(ids[i]);
// 				// 문서 구분 저장
// 				var data = {
// 						'att_seq' : row.att_seq
// 						, 'sample_att_gbn' : row.sample_att_gbn
// 				};
// 	 			json = fnAjaxAction('accept/updateFileDivision.lims', data);
// 			}	
// 			if (json == null) {
// 				$.showAlert('저장 실패하였습니다.');
// 				$('#sampleFileGrid').trigger('reloadGrid');
// 			} else {				
// 				$.showAlert('저장 완료하였습니다.');
// 				fnpop_callback();
// 				fnEditRelease(grid); 
// 			} 	
// 		}
// 	}
	
	function fnpop_callback_testItemUser(dept_cd, dept_nm, user_id, user_nm, rowId){
		if(rowId == ''){
			var ids = $('#reqItemGrid').jqGrid("getDataIDs");
			if (ids.length > 0) {
				for ( var i in ids) {
					var row = $('#reqItemGrid').getRowData(ids[i]);
					if (row.chk == 'Yes') {
						$('#reqItemGrid').jqGrid('setCell', ids[i], 'dept_cd', dept_cd);
						$('#reqItemGrid').jqGrid('setCell', ids[i], 'dept_nm', dept_nm);
						$('#reqItemGrid').jqGrid('setCell', ids[i], 'tester_id', user_id);
						$('#reqItemGrid').jqGrid('setCell', ids[i], 'tester_nm', user_nm);
						$('#reqItemGrid').jqGrid('setCell', ids[i], 'icon', gridU);
						$('#reqItemGrid').jqGrid('setCell', ids[i], 'crud', 'u');
					}
				}
			}
		}else{
			$('#reqItemGrid').jqGrid('setCell', rowId, 'dept_cd', dept_cd);
			$('#reqItemGrid').jqGrid('setCell', rowId, 'dept_nm', dept_nm);
			$('#reqItemGrid').jqGrid('setCell', rowId, 'tester_id', user_id);
			$('#reqItemGrid').jqGrid('setCell', rowId, 'tester_nm', user_nm);
			$('#reqItemGrid').jqGrid('setCell', rowId, 'icon', gridU);
			$('#reqItemGrid').jqGrid('setCell', rowId, 'crud', 'u');
		}
	}
	
	function fn_suc(json) {
		if (json == null) {
			$.showAlert("저장 실패하였습니다.");
		}
	}
	
	function btn_Req_Cancel_onclick() {
		var c = 0;
		var sucChk = true;
		if (!confirm('접수취소하시겠습니까?')) {
			return false;
		}
		var ids = $('#reqListGrid').jqGrid("getDataIDs");
		for ( var i in ids) {
			var row = $('#reqListGrid').getRowData(ids[i]);
			if (row.chk == 'Yes') {
				if( row.state == '접수완료' || row.state == '결과승인완료' || row.state == '성적서작성완료' || row.state == '성적서발행완료' ){
					var data = 'test_req_seq=' + ids[i] + '&menu_cd=030400';
					var json = fnAjaxAction('returnToBegining.lims', data);
					if (json == null) {
						sucChk = false;
					}
				}
				c++;
			}
		}
		if (c == 0) {
			alert('선택된 건이 없습니다.');
			return false;
		}else{
			if(!sucChk){
				alert('접수취소 실패하였습니다.');
			}else{
				alert('접수취소 완료되었습니다.');
			}
			$('#reqListGrid').trigger('reloadGrid');
		}
	}
	
	//퍠기요청
	function btn_Disuse_onclick(grid,gbn){
		var chkCnt = false;
		var chkCnt2 = false;
		var ids = $('#' + grid).jqGrid("getDataIDs");
		if (ids.length > 0) {
			for ( var i in ids) {
				var row = $('#' + grid).getRowData(ids[i]);
				if (row.chk == 'Yes') {
					chkCnt = true;
				}
				if(row.chk == 'Yes' && row.disuse_flag != 'C52003') {
					chkCnt2 = true;
				}
			}
		}
		
		if(!chkCnt){
			if(gbn == "Y"){
				alert('반환되는 검체를 선택해주세요.');	
			}else{
				alert('반환요청취소되는 검체를 선택해주세요.');
			}
			return;
		}
		/*
		if(chkCnt2){
			alert('보관상태가 아닌 검체가 있습니다.');
			return;
		}
		*/
		for ( var i in ids) {
			var row = $('#' + grid).getRowData(ids[i]);
			if (row.chk == 'Yes' && (row.crud != 'c' && row.crud != 'r')) {
				if(gbn == 'Y'){
					$('#' + grid).jqGrid('setCell', ids[i], 'disuse_flag', 'C52004');
				}else{
					$('#' + grid).jqGrid('setCell', ids[i], 'disuse_flag', 'C52003');						
				}
				$('#' + grid).jqGrid('setCell', ids[i], 'icon', gridU);
				$('#' + grid).jqGrid('setCell', ids[i], 'crud', 'u');
			}
		}
	}

</script>
<c:set var="tabName1" value="접수" />
<c:set var="tabName2" value="접수조회" />
<!-- 의뢰페이지 -->
<c:if test="${type == 'receipt' }">
	<c:set var="tabName1" value="의뢰" />
	<c:set var="tabName2" value="의뢰조회" />
</c:if>
<div id="tabs">
	<ul>
		<li id="tab2">
			<a href="#tabDiv2">${tabName2 }</a>
		</li>
		<li id="tab1">
			<a href="#tabDiv1">${tabName1 }</a>
		</li>
		<li style="float: right;">
			<span class="button white mlargeg auth_save" style="vertical-align: middle;">
				<button type="button" id="btn_Send_Mail" onclick="btn_Send_Mail_onclick('reqListGrid')">메일전송</button>
				<button type="button" id="btn_Accept" onclick="btn_Accept_onclick()"><label id="accept">접수</label>완료</button>
				<input type="hidden"  id="saveType" name="saveType" value="${type}">
			</span>
		</li>
	</ul>
	<div id="tabDiv1">
		<div id="acceptDiv"></div>
		<div id="acceptDivSub">
			<div id="sampleDiv">
				<div  id="sampleList" class="w68p" style="display:inline-block;">
				<form id="reqSampleForm" name="reqSampleForm" onsubmit="return false;">
					<div class="sub_purple_01 w100p">
						<table class="select_table">
							<tr>
								<td width="20%" class="table_title">
									<span>■</span>
									검체 목록
								</td>
								<td class="table_button" style="text-align: right; " id="sampleBtn">
									<span class="button white mlargep auth_save" id="btn_Add_Self" onclick="btn_SelfitemChoice_onclick();" style="display: none;">
										<button type="button">프로토콜</button>
									</span>
									<span class="button white mlargep auth_save" id="btn_Add_Self" onclick="copy_content()">
										<button type="button">검체내용복사</button>
									</span>
									<span class="button white mlargep auth_save" id="btn_Add_Self" onclick="btn_SelfStandChoice_onclick('reqSampleGrid');">
										<button type="button">스탠다드품목</button>
									</span>
									<span class="button white mlargep auth_save" id="btn_Add_Self" onclick="btn_SelfGradeChoice_onclick('reqSampleGrid');">
										<button type="button">등급품목</button>
									</span>
									<span class="button white mlargeg auth_save" id="btn_Disuse1" onclick="btn_Disuse_onclick('reqSampleGrid','Y');">
										<button type="button">반환요청</button>
									</span>
									<span class="button white mlargeg auth_save" id="btn_Disuse2" onclick="btn_Disuse_onclick('reqSampleGrid','N');">
										<button type="button">반환요청취소</button>
									</span>
									<span >(</span>
									<input type="text" id="copyNum" style="width: 25px; height: 14px; vertical-align: middle; text-align: right;" value="1" maxlength="3">
									<span class="button white mlargeb auth_save" id="btn_CopyLine" onclick="btn_CopyLine_onclick();">
										<button type="button">검체복사</button>
									</span>
									<span >)</span>
									<span class="button white mlargeg auth_save" id="btn_Reset_Sub1" onclick="btn_Reset_Sub_onclick('reqSampleGrid');">
										<button type="button">되돌리기</button>
									</span>
									<span class="button white mlargeb auth_save" id="btn_Delete_Sub1" onclick="btn_Delete_Sub_onclick('reqSampleGrid');">
										<button type="button">삭제</button>
									</span>
								</td>
								<td class="table_button" style="text-align: right; " id="sampleSaveBtn">
									<span class="button white mlargeg auth_save" id="btn_Save_Sub1" onclick="btn_Save_Sub_onclick('reqSampleGrid');">
										<button type="button">저장</button>
									</span>
								</td>
							</tr>
						</table>
					</div>
					<input type="hidden" id="test_req_no" name="test_req_no" />
					<input type="hidden" id="test_req_seq" name="test_req_seq" />
					<input type="hidden" id="sortName" name="sortName">
					<input type="hidden" id="sortType" name="sortType">
					<div id="view_grid_sub_1">
						<table id="reqSampleGrid"></table>
					</div>
				</form>
				</div>
				
				<div id="sampleFileList" class="w30p" style="float:right;display:inline-block;">
				<form id="sampleFileForm" name="sampleFileForm" onsubmit="return false;">
					<div class="sub_purple_01">
						<table class="select_table">
							<tr>
								<td width="20%" class="table_title">
									<span>■</span>
									검체별 첨부문서
								</td>
								<td class="table_button" style="text-align: right; padding-right: 30px;" id="sampleFile">
									<span class="button white mlargep auth_select" id="btn_Select" onclick="btn_Sample_Select_onclick();">
										<button type="button">조회</button>
									</span>
									<span class="button white mlargep auth_save" id="insertSampleBtn" onclick="btn_Sample_File_onclick('insert');">
										<button type="button">등록</button>
									</span>
									<span class="button white mlargep auth_save" id="updateSampleBtn" onclick="btn_Sample_File_onclick('upate');">
										<button type="button">수정</button>
									</span>
<!-- 									<span class="button white mlargep auth_check" id="btn_check" onclick="btn_Sample_check_onclick();">
										<button type="button">저장</button>
									</span> -->
								</td>
							</tr>
						</table>
					</div>
					<input type="hidden" id="test_sample_seq" name="test_sample_seq" />
					<input type="hidden" id="att_seq" name="att_seq" />
					<input type="hidden" id="sortName" name="sortName">
					<input type="hidden" id="sortType" name="sortType">
					<div id="view_grid_sample_file">
						<table id="sampleFileGrid"></table>
					</div>
				</form>
				</div>				
			</div>		
			
			<div id="itemDiv" >
				<div id="itemList" class="w68p" style="display:inline-block;">
				<form id="reqItemForm" name="reqItemForm" onsubmit="return false;">
					<div class="sub_purple_01 w100p">
						<table class="select_table">
							<tr >
								<td width="20%" class="table_title" nowrap="nowrap">
									<span>■</span>
									선택 항목
								</td>
								<td id="itemBtnSub" class="table_button" style="text-align: right; padding-right: 5px;" >
								<span class="button white mlargep auth_select" id="btn_mngDeptChange" onclick="fn_reportOrder();">
										<button type="button">성적서표시순서일괄변경</button>
								</span>
								</td>
								<td class="table_button" style="text-align: right; padding-right: 5px; width:100px"  id="itemBtn">								
									<span class="button white mlargep auth_select" id="btn_mngDeptChange" onclick="btn_itemMngChange_onclick();">
										<button type="button">담당일괄변경</button>
									</span>
									<span class="button white mlargep auth_save" id="btn_SelectFee" onclick="btn_SelectFee_onclick();">
										<button type="button">수수료자동선택</button>
									</span>
									<span class="button white mlargep auth_save" id="btn_SaveItemFee" onclick="btn_SaveItemFee_onclick();">
										<button type="button">수수료마스터등록</button>
									</span>
									<span class="button white mlargeb auth_save" id="btn_AddItem" onclick="fn_itemChoice();">
										<button type="button">항목추가</button>
									</span>
									<span class="button white mlarger auth_save" id="btn_Delete_Sub2" onclick="btn_Delete_Sub2_onclick();">
										<button type="button">항목삭제</button>
									</span>
									<span class="button white mlargeg auth_save" id="btn_SaveItem" onclick="btn_Save_Sub2_onclick('UPDATEFEE');">
										<button type="button">항목저장</button>
									</span>
								</td>
							</tr>
						</table>
					</div>
					<input type="hidden" id="test_sample_seq" name="test_sample_seq" />
					<input type="hidden" id="sm_code" name="sm_code" />
					<input type="hidden" id="max_grade" name="max_grade" />
					<input type="hidden" id="test_std_no" name="test_std_no" />
					<input type="hidden" id="prdlst_cd" name="prdlst_cd" />
					<input type="hidden" id="sortName" name="sortName">
					<input type="hidden" id="sortType" name="sortType">
					<div id="view_grid_sub_2">
						<table id="reqItemGrid"></table>
					</div>
				</form>
				</div>
				
				<div  id="itemFileList" class="w30p" style="float:right;display:inline-block;">
				<form id="sampleItemFileForm" name="sampleItemFileForm" onsubmit="return false;">
					<div class="sub_purple_01">
						<table class="select_table">
							<tr>
								<td width="20%" class="table_title">
									<span>■</span>
									항목별 첨부문서
								</td>
								<td class="table_button" style="text-align: right; padding-right: 30px;" id="itemFile">
									<span class="button white mlargep auth_select" id="btn_Select" onclick="btn_Item_Select_onclick();">
										<button type="button">조회</button>
									</span>
									<span class="button white mlargep auth_save" id="insertItemBtn" onclick="btn_Item_File_onclick();">
										<button type="button">등록</button>
									</span>
									<span class="button white mlargep auth_save" id="updateItemBtn" onclick="btn_Item_File_onclick();">
										<button type="button">수정</button>
									</span>
								</td>
							</tr>
						</table>
					</div>
					<input type="hidden" id="test_sample_seq" name="test_sample_seq" />
					<input type="hidden" id="test_item_cd" name="test_item_cd" />
					<input type="hidden" id="att_seq" name="att_seq" />
					<input type="hidden" id="sortName" name="sortName" />
					<input type="hidden" id="sortType" name="sortType" />
					<div id="view_grid_item_file">
						<table id="sampleItemFileGrid"></table>
					</div>
				</form>
				</div>
				
				<div style=" border: solid 1px #2fa1d4; margin-top: 5px; padding: 3px; float: left; width: 99.5%; display:inline-block;">
				<ul>
					<li style="margin: 2px;">* 수수료 우선순위 : 부서별 등록한 1.품목수수료 - 2.부서기본수수료</li>
					<li style="margin: 2px;">* 수수료마스터등록 버튼 사용하면 선택된항목의 <B>1.품목수수료, 2.부서기본수수료</B>를 마스터로 등록하거나 수정할 수 있습니다.</li>
					<li style="margin: 2px;">* [수수료자동선택] : <B>최종수수료가 0원</B>인 항목을 수수료 우선순위에 따라 자동 선택하여 입력합니다. 선택후 <B>[저장]버튼</B>을 눌러주세요</li>
				</ul> 
				</div>
			</div>	
		</div>
	</div>
	<div id="tabDiv2">
		<form id="reqListForm" name="reqListForm" onsubmit="return false;">
			<div class="sub_purple_01 w100p" style="margin-top: 0px;">
				<table class="select_table">
					<tr>
						<td width="20%" class="table_title">
							<span>■</span>
							<label id="accept">접수</label>목록
						</td>
						<td class="table_button" style="text-align: right; padding-right: 30px;">
							<span class="button white mlargep auth_select" id="btn_Select" onclick="btn_Select_onclick();">
								<button type="button">조회</button>
							</span>
							<span class="button white mlargep auth_select" id="btn_Choice" onclick="btn_Choice_onclick('');">
								<button type="button">선택</button>
							</span>
							<span class="button white mlargep auth_save" id="btn_New" onclick="btn_New_onclick();">
								<button type="button">추가</button>
							</span>
							<span class="button white mlargeg auth_save" id="btn_Req_Copy" onclick="btn_Req_Copy_onclick();">
								<button type="button">복사</button>
							</span>
							<span class="button white mlargeg auth_save" id="btn_Req_Cancel" onclick="btn_Req_Cancel_onclick();">
								<button type="button">접수취소</button>
							</span>
							<span class="button white mlargeg auth_save" id="btn_Req_Retest" onclick="btn_Req_Retest_onclick();">
								<button type="button">재시험</button>
							</span>
							<span class="button white mlarger auth_save" id="btn_Delete" onclick="btn_Delete_onclick();">
								<button type="button">의뢰삭제</button>
							</span>
							<span class="button white mlargeb auth_select" id="reqViewBtn" onclick="fnpop_reqInfo('reqListGrid');">
								<button type="button">의뢰정보</button>
							</span>
							<span class="button white mlargeb auth_select" id="stateViewBtn" onclick="fnpop_stateInfo();">
								<button type="button">진행상황</button>
							</span>
							<span class="button white mlargeb auth_select" id="resultViewBtn" onclick="fnpop_reqResultInfo();">
								<button type="button">결과보기</button>
							</span>
							<span class="button white mlargeb auth_save" id="reqBtn" onclick="fnpop_req();">
								<button id="reqBtnObj" type="button"><label id="req">접수완료</label></button>
							</span>
							<span class="button white mlargeb auth_select" onclick="btn_print_onclick();">
								<button type="button">시험분석확인서</button>
							</span>
							<span class="button white mlargeb auth_select" onclick="btn_label_onclick();">
								<button type="button">라벨출력</button>
							</span>
							<span class="button white mlargeb auth_select" onclick="btn_Excel_onclick();">
								<button type="button">EXCEL</button>
							</span>
							
						</td>
					</tr>
				</table>
				<table class="list_table">
					<tr>
						<th>의뢰번호</th>
						<td>
							<input name="test_req_no" id="test_req_no" type="text" class="w100px" />
						</td>
						<th>의뢰구분</th>
						<td>
							<select name="req_type" id="req_type" class="w100px"></select>
							<select name="sensory_test" id="sensory_test" class="w80px" disabled="disabled"></select>
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
							<img style="cursor: pointer; vertical-align: text-bottom;" src="images/common/icon_search.png" class="auth_select" onclick='fnpop_reqOrgChoice("reqDetailForm", "750", "550", "조회의뢰")'/>
						</td>
						<th>의뢰자</th>
						<td>
							<input name="req_nm" id="req_nm" type="text" class="inputhan w100px" />
						</td>
						<th>영업 담당자</th>
						<td>
							<input name="sales_user_id" id="sales_user_id" type="text" class="w100px" />
						</td>
					</tr>
					<tr>
						<th><label id="accept">접수</label>부서</th>
						<td>
							<select name="dept_cd" id="dept_cd" class="w200px"></select>
						</td>
						<th>단위업무</th>
						<td>
							<select name="unit_work_cd" id="unit_work_cd" class="w200px"></select>
						</td>
						<th>진행상태</th>
						<td>
							<select name="state" id="state" class="w100px"></select>
						</td>
					</tr>
					<tr>
						<th>Sampling NO</th>
						<td> 
							<input name="sampling_no" id="sampling_no" type="text" class="w150px" />  
						</td>
						<th>Sample Number</th>
						<td colspan = "3"> 
							<input name="sample_num" id="sample_num" type="text" class="w150px" />  
						</td>
	
					</tr>
					<tr>
						<th id="taxHead">세금계산서 발행일</th>
						<td id="taxTd">
							<input name="taxSdate" id="taxSdate" type="text" class="w80px" readonly="readonly" />
							<img src="<c:url value='/images/common/calendar_del.png'/>" id="taxSdateStop" style="cursor: pointer;" onClick='fn_TextClear("taxSdate")' /> ~
							<input name="taxEdate" id="taxEdate" type="text" class="w80px" readonly="readonly" />
							<img src="<c:url value='/images/common/calendar_del.png'/>" id="taxEdateStop" style="cursor: pointer;" onClick='fn_TextClear("taxEdate")' />
						</td>
<!-- 						<th>세금계산서 발행처</th>
						<td>
							<input name="tax_req_org_nm" id="tax_req_org_nm" type="text" class="w150px" />
						</td> -->

					</tr>
					<tr>
						<th>접수일자</th>
						<td>
							<input name="startDate" id="startDate" type="text" class="w80px" readonly="readonly" />
							<img src="<c:url value='/images/common/calendar_del.png'/>" id="startDateStop" style="cursor: pointer;" onClick='fn_TextClear("startDate")' /> ~
							<input name="endDate" id="endDate" type="text" class="w80px" readonly="readonly" />
							<img src="<c:url value='/images/common/calendar_del.png'/>" id="endDateStop" style="cursor: pointer;" onClick='fn_TextClear("endDate")' />
						</td>
						<th>성적서발행 예정일</th>
						<td colspan = "3">
							<input name="startTest" id="startTest" type="text" class="w80px" readonly="readonly" />
							<img src="<c:url value='/images/common/calendar_del.png'/>" id="startTestStop" style="cursor: pointer;" onClick='fn_TextClear("startTest")' /> ~
							<input name="endTest" id="endTest" type="text" class="w80px" readonly="readonly" />
							<img src="<c:url value='/images/common/calendar_del.png'/>" id="endTestStop" style="cursor: pointer;" onClick='fn_TextClear("endTest")' />
						</td>
					</tr>

				</table>
			</div>
			<input type="hidden" id="type" name="type" value="${type}">
			<input type="hidden" id="sortName" name="sortName">
			<input type="hidden" id="sortType" name="sortType">
			<div id="view_grid_main">
				<table id="reqListGrid"></table>
			</div>
		</form>
	</div>
	<form id="excelReportForm" name="excelReportForm"></form>
</div>

<div id="dialog"></div>
<div id="dialogPrint" class="sub_blue_01 w100p" style="display: none; margin-top: 0px;"></div>
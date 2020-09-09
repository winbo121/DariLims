
<%
	/***************************************************************************************
	 * 시스템명 	: 통합장비관제시스템
	 * 업무명 		: 구매요청(승인)
	 * 파일명 		: buyingConfirmationL01.jsp
	 * 작성자 		: 최은향
	 * 작성일 		: 2015.02.24
	 * 설  명		: 구매요청(승인) 리스트 조회 화면
	 *---------------------------------------------------------------------------------------
	 * 변경일		변경자		변경내역 
	 *---------------------------------------------------------------------------------------
	 * 2015.02.24    최은향		최초 프로그램 작성         
	 * 
	 *---------------------------------------------------------------------------------------
	 ****************************************************************************************/
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html >
<link rel="stylesheet" media="screen" type="text/css" href="<c:url value='/css/common/sub.css'/>" />
<script type="text/javascript">
	var editChange;
	var confirmationMsg = '<label style="font-weight: bold; font-size: 28px;">구매확정 목록을 저장해 주세요.</label>';
	var deptcd;
	var buy_sts;
	var mtlr_mst_no;
	var appr_flag; // 구매확정 구분 (확정이면 '확정'버튼 숨기게)
	var save_flag = false;

	var m_mtlr;
	var m_mtlr_C42 = fnGridCommonCombo('C42', null);
	var m_mtlr_C43 = fnGridCommonCombo('C43', null);
	m_mtlr_C43 = m_mtlr_C43.slice(1);
	var m_mtlr_code;

	$(function() {
		/* 세부권한검사 */
		fn_auth_check();
		
		m_mtlr = m_mtlr_C42 + m_mtlr_C43;

		buy_sts = fnGridCommonCombo('C39', null);
		deptcd = fnGridCombo('dept', null);

		checkYear('ALL', new Date().getFullYear(), 'sel_buy_year'); // 구매년도
		ajaxComboForm("buy_q", "C14", "", "", 'buyingConfirmationForm'); // 구매분기
		ajaxComboForm("buy_sts", "C39", "ALL", "", 'buyingConfirmationForm'); // 진행상태

		$("#right_left_btn").hide(); // 좌우버튼 >  <

		// 구매정보 위
		grid('reagents/buyingConfirmationBuyingInfoList.lims', 'buyingConfirmationForm', 'buyingConfirmationGrid');
		$('#buyingConfirmationGrid').clearGridData(); // 최초 조회시 데이터 안나옴

		// 그리드 사이즈 
		$(window).bind('resize', function() {
			$("#buyingConfirmationGrid").setGridWidth($('#view_grid_main').width(), true);
		}).trigger('resize');

		// 엔터키 눌렀을 경우(구매목록 그리드 조회)
		fn_Enter_Search('buyingConfirmationForm', 'buyingConfirmationGrid');
	});

	// 대분류 콤보
	function comboReload() {
		if ($("#h_mtlr_info").val() == "C42") {
			ajaxComboForm("m_mtlr_info", "C42", "All", "", 'allBuyingConfirmationListForm'); // 중분류			
		} else if ($("#h_mtlr_info").val() == "C43") {
			ajaxComboForm("m_mtlr_info", "C43", "All", "", 'allBuyingConfirmationListForm'); // 중분류
		}
	}

	// 구매년도 SELECT
	function checkYear(type, year, id) {
		var name = id;
		if (type == 'ALL') {
			$('#' + name).append($('<option />').val('').html('전체'));
		}
		for (var i = new Date().getFullYear() + 5; i > new Date().getFullYear() - 5; i--) {
			if (year == i) {
				$('#' + name).append($('<option selected />').val(i).html(i + ' 년'));
			} else
				$('#' + name).append($('<option />').val(i).html(i + ' 년'));
		}
	}

	function btn_Select_onclick() {
		$('#buyingConfirmationGrid').trigger('reloadGrid');
		$('#allBuyingConfirmationListGrid').trigger('reloadGrid');
		$('#receivePayGrid').trigger('reloadGrid');
		fnStopLoading('view_grid_main');
	}

	// 상단(구매정보목록) 1
	function grid(url, form, grid) {
		var lastRowId = 0;
		$('#' + grid).jqGrid({
			datatype : function(json) {
				fnGridData(url, form, grid);
			},
			height : '115',
			autowidth : false,
			loadonce : true,
			mtype : "POST",
			gridview : true,
			shrinkToFit : true,
			rowNum : -1,
			rownumbers : true,
			colModel : [ {
				label : '구매정보번호',
				name : 'mtlr_mst_no',
				key : true,
				hidden : true,
				search : false
			}, {
				label : '진행상태',
				width : '60',
				name : 'buy_sts',
				align : 'center',
				formatter : 'select',
				edittype : "select",
				editoptions : {
					value : buy_sts
				}
			}, {
				label : '구매명칭',
				width : '250',
				name : 'buy_title'
			}, {
				label : '구매년도',
				width : '60',
				name : 'buy_year',
				align : 'center'
			}, {
				label : '구매분기',
				width : '60',
				name : 'buy_q',
				align : 'center'
			}, {
				label : '수요조사시작일',
				width : '110',
				name : 'buy_date',
				align : 'center'
			}, {
				label : '수요조사종료일',
				width : '110',
				name : 'dmd_date',
				align : 'center'
			}, {
				label : '구매비고',
				width : '350',
				name : 'buy_etc'
			}, {
				label : '진행상태',
				width : '110',
				hidden : true,
				name : 'state'
			} ],
			emptyrecords : '데이터가 존재하지 않습니다.',
			gridComplete : function() {
				lastRowId = 0;
				fnSelectFirst(grid);
			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
			},
			onSelectRow : function(rowId, status, e) {
				var left = $('#' + grid).getRowData(rowId);
				$('#receivePayForm #mtlr_mst_no').val(left.mtlr_mst_no);
				mtlr_mst_no = left.mtlr_mst_no;
				appr_flag = left.buy_sts;
				//alert(appr_flag); 	// 진행상태 코드
				//alert(mtlr_mst_no);	// 구매정보번호				
				if (rowId && rowId != lastRowId) {
					lastRowId = rowId;
					var param = 'mtlr_mst_no=' + rowId;
					fnViewPage('reagents/buyingRequestList2.lims', 'allBuyingConfirmationListForm', param);
					fnViewPage('reagents/buyingRequestList3.lims', 'receivePayForm', param);
					$("#right_left_btn").show(); // 좌우버튼 >  <
				}
			}
		});
	}

	// 왼쪽(구매요청목록) 2
	function allBuyingConfirmationListGrid(url, form, grid) {
		var allselect = false;
		$('#' + grid).jqGrid({
			datatype : function(json) {
				fnGridData(url, form, grid);
			},
			height : '350',
			autowidth : false,
			loadonce : true,
			mtype : "POST",
			gridview : true,
			shrinkToFit : true,
			multiselect : true,
			rowNum : -1,
			rownumbers : true,
			colModel : [ {
				label : '구매정보코드',
				width : '110',
				name : 'mtlr_mst_no',
				hidden : true
			}, {
				label : '구매요청코드',
				width : '140',
				name : 'mtlr_req_no',
				key : true,
				hidden : true
			}, {
				label : '마스터여부',
				width : '70',
				name : 'master_yn',
				align : 'center',
				formatter : function(value) {
					if (value == "Y") {
						return '마스터';
					} else {
						return '일반';
					}
				}
			}, {
				label : '대분류',
				width : '60',
				align : 'center',
				name : 'h_mtlr_info',
			/* formatter : 'select',
			edittype : "select",
			editoptions : {
				value : h_mtlr_info
			} */
			}, {
				label : '중분류',
				width : '100',
				align : 'center',
				name : 'm_mtlr_info',
			// 				formatter : 'select',
			// 				edittype : "select",
			// 				editoptions : {
			// 					value : m_mtlr
			// 				}
			/* formatter : 'select',
			edittype : "select",
			editoptions : {
				value : m_mtlr_info
			} */
			}, {
				label : '시약실험기구명',
				width : '250',
				name : 'item_nm'
			}, {
				label : '시약실험기구코드',
				width : '140',
				name : 'mtlr_no',
				hidden : true
			}, {
				label : '요청수량',
				width : '60',
				align : 'right',
				name : 'req_qty',
				classes : 'number_css'
			}, {
				label : '요청부서명',
				width : '120',
				name : 'create_dept',
				edittype : "select",
				editoptions : {
					value : deptcd
				},
				formatter : "select",
				hidden : false
			}, {
				label : '요청자명',
				width : '80',
				name : 'user_nm',
				align : 'center'
			}, {
				label : '요청일자',
				width : '80',
				align : 'center',
				name : 'create_date'
			}, {
				label : '제조사',
				width : '250',
				align : 'center',
				name : 'spec1'
			}, {
				label : 'Cas no.',
				width : '250',
				align : 'center',
				name : 'spec2'
			}, {
				label : 'Cat # (제품번호)',
				width : '250',
				align : 'center',
				name : 'spec_etc'
			}, {
				label : 'Lot # (로트번호)',
				width : '200',
				align : 'center',
				hidden : true,
				name : 'use'
			}, {
				label : '용량',
				width : '200',
				align : 'center',
				name : 'mtlr_vol'
			}, {
				label : '단위',
				width : '100',
				align : 'center',
				name : 'unit'
			}, {
				label : '사용여부',
				width : '60',
				name : 'use_flag',
				align : 'center',
				formatter : function(value) {
					if (value == "Y") {
						return '사용함';
					} else {
						return '사용안함';
					}
				}
			}, {
				label : '비고',
				width : '250',
				name : 'etc'
			}, {
				label : '승인구분',
				width : '140',
				name : 'appr_flag',
				hidden : true
			}, {
				label : '요청부서코드',
				width : '140',
				name : 'dept_cd',
				hidden : true
			}, {
				label : '정렬순서',
				width : '140',
				name : 'ord_no',
				hidden : true
			}, {
				label : '구매그룹코드',
				width : '140',
				name : 'buy_grp_cd',
				hidden : true
			} ],
			emptyrecords : '데이터가 존재하지 않습니다.',
			gridComplete : function() {
				fnCheckAction(grid);
				$('#btn_Modify').hide();
				allselect = false;
			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
				// 					if (!confirm('저장하지 않은 정보는 사라집니다. 정렬하시겠습니까?')) {
				// 						return 'stop';
				// 					}
			},
			onSelectRow : function(rowId, status, e) {
				fnEditRelease('receivePayGrid');
				var left = $('#' + grid).getRowData(rowId);
				var ic = left.mtlr_no;
				//var master = left.master_yn; // 마스터 여부
				var ids = $('#receivePayGrid').jqGrid("getDataIDs");

				for ( var i in ids) {
					var right = $('#receivePayGrid').getRowData(ids[i]);
					if (ic == right.mtlr_no) {
						$.showAlert('이미 존재하는 항목입니다.');
						$('#' + grid).jqGrid('setSelection', rowId, false);
					}
				}
				var selectRow = $('#' + grid).jqGrid('getGridParam', 'selarrrow');

				// 선택된게 한개 일때,
				if (selectRow.length == 1) {
					var master = $('#' + grid).getRowData(selectRow).master_yn;
					if (master == "일반") {
						// 수정버튼 보임
						$('#btn_Modify').show();
					} else {
						// 수정버튼 안보임
						$('#btn_Modify').hide();
					}
				} else {
					// 수정버튼 안보임
					$('#btn_Modify').hide();
				}
			},
			ondblClickRow : function(rowId, iRow, iCol, e) {
				$('#' + grid).jqGrid('editRow', rowId, true);
			},
			onSelectAll : function(selar, status) {
				var leftGrid = '#allBuyingConfirmationListGrid';
				var rightGrid = '#receivePayGrid';

				if (!allselect) {
					var i = 0;
					var sel_ids_left = $(leftGrid).jqGrid("getDataIDs");
					for ( var row in sel_ids_left) {
						var left = $(leftGrid).getRowData(sel_ids_left[row]).mtlr_no;
						var sel_ids = $(rightGrid).jqGrid("getDataIDs");

						for ( var j in sel_ids) {
							var right = $(rightGrid).getRowData(sel_ids[j]).mtlr_no;
							if (right == left) {
								$(leftGrid).jqGrid('setSelection', sel_ids_left[row], false);
								i++;
							}
						}
					}
					if (i > 0) {
						$.showAlert("이미 존재하는 항목들이 있습니다.");
					}
				} else {
					$("#" + grid).jqGrid('resetSelection');
				}
				allselect = !allselect;
			}
		});
	}

	// 오른쪽(구매확정목록) 3
	function buyingConfirmationGrid(url, form, grid) {
		var lastRowId = 0;
		$('#' + grid).jqGrid({
			datatype : function(json) {
				fnGridData(url, form, grid);
			},
			height : '405',
			autowidth : false,
			loadonce : true,
			mtype : "POST",
			gridview : true,
			shrinkToFit : true,
			//multiselect : true,
			rowNum : -1,
			rownumbers : true,
			//footerrow : true,
			//userDataOnFooter : true,
			colModel : [ {
				label : '구매확정코드',
				width : '110',
				name : 'mtlr_cnfr_no',
				key : true, // 원래 '시약실험기구코드'가 KEY 값이였음
				hidden : true
			}, {
				label : '구매요청코드',
				width : '140',
				name : 'mtlr_req_no',
				hidden : true
			}, {
				type : 'not',
				label : '<input type="checkbox" id="chk" onclick="fn_chk(\'' + grid + '\' , \'' + form + '\');" />',
				name : 'chk',
				width : '25',
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
				hidden : true,
				frozen : true
			}, {
				label : '마스터여부',
				width : '70',
				name : 'master_yn',
				align : 'center',
				formatter : function(value) {
					if (value == "Y" || value == "마스터") {
						return '마스터';
					} else {
						return '일반';
					}
				}
			}, {
				label : '대분류',
				width : '60',
				align : 'center',
				name : 'h_mtlr_info',
			/* formatter : 'select',
			edittype : "select",
			editoptions : {
				value : h_mtlr_info
			} */
			}, {
				label : '중분류',
				width : '100',
				align : 'center',
				name : 'm_mtlr_info'
			// 				,
			// 				formatter : 'select',
			// 				edittype : "select",
			// 				editoptions : {
			// 					value : m_mtlr
			// 				}
			}, {
				label : '시약실험기구명',
				width : '250',
				name : 'item_nm'
			}, {
				label : '시약실험기구코드',
				width : '140',
				name : 'mtlr_no',
				hidden : true
			}, {
				label : '요청부서명<span class="indispensableGrid"></span>',
				width : '120',
				name : 'create_dept',
				editable : true,
				edittype : "select",
				editoptions : {
					value : deptcd
				},
				formatter : "select"
			}, {
				label : '요청수량',
				width : '60',
				align : 'right',
				name : 'req_qty',
				editrules : {
					number : true
				},
				classes : 'number_css'
			// 				,index:'req_qty',
			// 				formatter:'integer',
			// 				formatoptions : {thousandsSeparator:"," ,
			// 					summaryType:'sum',summaryTpl:'Totals:'}
			}, {
				label : '확정수량<span class="indispensableGrid"></span>',
				width : '80',
				name : 'fix_qty',
				align : 'right',
				editable : true,
				editrules : {
					//required : true	// 필수값
					number : true
				},
				classes : 'number_css'
			}, {
				label : '단가(원)<span class="indispensableGrid"></span>',
				width : '70',
				align : 'right',
				editable : true,
				name : 'cost',
				editrules : {
					number : true
				},
				classes : 'number_css'
			},

			{
				label : '제조사',
				width : '250',
				type : 'not',
				align : 'center',
				name : 'spec1'
			}, {
				label : 'Cas no.',
				width : '250',
				type : 'not',
				align : 'center',
				name : 'spec2'
			}, {
				label : 'Cat # (제품번호)',
				width : '250',
				type : 'not',
				align : 'center',
				name : 'spec_etc'
			}, {
				label : 'Lot # (로트번호)',
				width : '200',
				align : 'center',
				hidden: true,
				name : 'use'
			}, {
				label : '용량',
				width : '200',
				align : 'center',
				name : 'mtlr_vol'
			}, {
				label : '단위',
				width : '100',
				align : 'center',
				name : 'unit'
			}, {
				label : '사용여부',
				width : '60',
				name : 'use_flag',
				align : 'center',
				formatter : function(value) {
					if (value == "Y" || value == "사용함") {
						return '사용함';
					} else {
						return '사용안함';
					}
				}
			}, {
				label : '비고',
				width : '250',
				name : 'etc'
			},

			{
				label : '구매정보번호',
				width : '140',
				name : 'mtlr_mst_no',
				hidden : true
			}, {
				label : '승인구분',
				width : '80',
				name : 'appr_flag',
				hidden : true
			}, {
				label : '검수일자',
				width : '140',
				align : 'center',
				name : 'create_date',
				hidden : true
			}, {
				label : '정렬순서',
				width : '140',
				name : 'ord_no',
				hidden : true
			}, {
				label : '구매그룹코드',
				width : '140',
				name : 'buy_grp_cd',
				hidden : true
			}, {
				label : '진행상태',
				width : '200',
				editable : true,
				hidden : true,
				name : 'state'
			} ],
			emptyrecords : '데이터가 존재하지 않습니다.',
			gridComplete : function() {
				lastRowId = 0;
				editChange = false;
				fnCheckAction(grid);
				// 				var moneySum = $("#receivePayGrid").jqGrid('getCol', 'req_qty', false, 'sum');
				// 				$("#receivePayGrid").jqGrid('footerData', 'set', {crateName:'합계', req_qty:moneySum } );
			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
				if (!confirm('저장하지 않은 정보는 사라집니다. 정렬하시겠습니까?')) {
					return 'stop';
				}
			},
			onSelectRow : function(rowId, status, e) {
				if (rowId && rowId != lastRowId) {
					lastRowId = rowId;
					fnEditRelease('receivePayGrid');
				}
			},
			ondblClickRow : function(rowId, iRow, iCol, e) {
				editChange = true;
				//buyingGridEdit(grid, rowId, buying_Row_Click);
				// 구매요청 항목
				if (appr_flag == 'C39001') {
					fnEditRelease('receivePayGrid');
					$('#btn_Save').show();
					//fn_Div_Block('view_grid_main', confirmationMsg);
					save_flag = false;
					var row = $('#' + grid).getRowData(rowId);
					if (row.crud != 'c') {
						$('#' + grid).setCell(rowId, 'icon', gridU);
						$('#' + grid).setCell(rowId, 'crud', 'u');
					}
					$('#' + grid).jqGrid('editRow', rowId, true, buying_Row_Click, null, 'clientArray');
				} else {
					$.showAlert('구매요청 항목이 아닙니다.');
				}
			}
		});
	}

	// 리스트 좌우 이동 이벤트 (btn_Move(1), btn_Move(3))
	function btn_Move(m) {
		//fnEditRelease('receivePayGrid');
		var left = 'allBuyingConfirmationListGrid'; // 모든 단위업무
		var right = 'receivePayGrid'; // 부서별 단위업무
		if (appr_flag == 'C39001') {
			$('#btn_Save').show();
			switch (m) {
			case 1:
				var rowArr = $('#' + left).getGridParam('selarrrow');
				if (rowArr.length > 0) {
					save_flag = false;
					//fn_Div_Block('view_grid_main', confirmationMsg);
					for ( var i in rowArr) {
						var row = $('#' + left).getRowData(rowArr[i]);
						rowId = rowArr[i];
						row.crud = 'c';
						row.icon = gridC;
						$('#' + right).jqGrid('addRowData', rowArr[i], row, 'last');
					}
					for (var i = rowArr.length - 1; i >= 0; i--) {
						$('#' + left).jqGrid('setSelection', rowArr[i], false);
					}
				} else {
					$.showAlert('선택된 행이 없습니다.');
				}
				break;
			case 3:
				var b = false;
				var ids = $('#' + right).jqGrid("getDataIDs");
				if (ids.length > 0) {
					for ( var i in ids) {
						var row = $('#' + right).getRowData(ids[i]);
						if (row.chk == 'Yes') {
							b = true;
						}
					}
					if (b) {
						//fn_Div_Block('view_grid_main', confirmationMsg);
						fnGridDeleteMultiLine(right);
					} else {
						$.showAlert('선택된 행이 업습니다.');
					}
				}
				break;
			}
		} else {
			$.showAlert('구매요청 항목이 아닙니다.');
		}
	}

	// 삭제 클릭 이벤트
	function btn_Del_Sub_onclick() {
		var b = false;
		var ids = $('#receivePayGrid').jqGrid("getDataIDs");
		if (ids.length > 0) {
			for ( var i in ids) {
				var row = $('#receivePayGrid').getRowData(ids[i]);
				if (row.chk == 'Yes') {
					b = true;
				}
			}
			if (b) {
				//fn_Div_Block('view_grid_main', confirmationMsg);
				fnGridDeleteMultiLine('receivePayGrid');
				if (appr_flag == 'C39001') {
					$('#btn_Save').show();
				}
			} else {
				$.showAlert('선택된 행이 업습니다.');
			}
		}
	}

	// 수정 불가
	function fn_Div_Block(id, msg) {
		fnStartLoading(id, msg);
		$('.blockUI').click(function() {
			if (!confirm("구매 확정 정보를 되돌리시겠습니까?")) {
				return false;
			}
			btn_Select_onclick();
		});
	}

	// 수정버튼 클릭 이벤트
	function btn_Modify_sub_onclick() {
		fnEditRelease('allBuyingConfirmationListGrid');
		var obj = new Object();
		obj.ids = $('#allBuyingConfirmationListGrid').jqGrid('getGridParam', 'selarrrow');
		var mtlr_no = $('#allBuyingConfirmationListGrid').getRowData(obj.ids).mtlr_no;
		var mtlr_req_no = $('#allBuyingConfirmationListGrid').getRowData(obj.ids).mtlr_req_no;
		
		obj.ids = mtlr_no;
		obj.msg1 = 'reagents/popBuyingConfirmationManage02.lims?mtlr_no=' + mtlr_no + '&mtlr_req_no=' + mtlr_req_no ;

		obj.rows = $("#allBuyingConfirmationListGrid").jqGrid('getRowData');
		obj.self = window.self; // 부모창 함수 사용하기
		var popup = fnShowModalWindow("popMain.lims", obj, 700, 360);
		return popup;
	}

	function btn_Search_sub_onclick2() {
		$('#allBuyingConfirmationListGrid').trigger('reloadGrid');
		//$('#receivePayGrid').trigger('reloadGrid');
	}

	// 저장버튼 클릭 이벤트(구매확정)
	function btn_Save_Sub_onclick() {
		fnEditRelease('receivePayGrid');
		save_flag = true;
		var rowArr = $('#receivePayGrid').jqGrid("getDataIDs");

		if (rowArr.length > 0) {
			$.showConfirm("저장 하시겠습니까?", {
				yesCallback : function() {
					var data = fnGetGridAllData('receivePayGrid');
					//alert(data);
					var json = fnAjaxAction('reagents/saveBuyingConfirmation.lims?mtlr_mst_no=' + mtlr_mst_no, data);
					if (json == null) {
						$.showAlert("저장 실패하였습니다.");
					} else {
						$.showAlert("", {
							type : 'insert'
						});
						btn_Select_onclick();
					}
				}
			});
		} else {
			$.showAlert('저장될 행이 없습니다.');
		}
	}

	// 확정버튼 클릭 이벤트(수불등록)
	function btn_Conf_Sub_onclick() {
		fnEditRelease('receivePayGrid');
		var rowArr = $('#receivePayGrid').jqGrid("getDataIDs");
		var required = true;

		// 필수입력값 체크
		if (rowArr.length > 0) {
			for ( var i in rowArr) {
				var row = $('#receivePayGrid').getRowData(rowArr[i]);
				if (row.fix_qty == '0' || row.fix_qty == '' || row.fix_qty == null || // 확정수량체크-fix_qty
				row.create_dept == '' || row.create_dept == null || // 요청부서체크-create_dept
				row.cost == '' || row.cost == null // 단가체크-cost
				) {
					required = false; // 필수값 없음
				}
			}
		}

		if (required) {
			if (rowArr.length > 0) {
				$.showConfirm("확정 하시겠습니까?", {
					yesCallback : function() {
						var data = fnGetGridAllData('receivePayGrid');
						var json = fnAjaxAction('reagents/buyingConfirmationCount.lims', data);
						fnEditRelease('receivePayGrid');
						//alert(json);
						//alert(save_flag);
						if (!save_flag || json == 1) {
							$.showAlert("현재 리스트가 저장이 되지 않았습니다.");
						} else {
							var data = fnGetGridAllData('receivePayGrid');
							var json = fnAjaxAction('reagents/saveReceivePay.lims?mtlr_mst_no=' + mtlr_mst_no, data);
							if (json == null) {
								$.showAlert("저장 실패하였습니다.");
							} else {
								$.showAlert("", {
									type : 'insert'
								});
								btn_Select_onclick();
							}
						}
					}
				});
			} else {
				$.showAlert('확정될 행이 없습니다.');
			}
		} else {
			$.showAlert('필수값을 모두 입력해 주세요.');
		}
	}

	// 구매리스트추가 등록팝업
	function btn_Reagents_Info_onclick() {
		fnEditRelease('reqGrid');
		var obj = new Object();
		obj.msg1 = 'reagents/popBuyingConfirmationManage.lims';
		obj.ids = $('#receivePayGrid').jqGrid("getDataIDs");
		var mtlr_no = $('#receivePayGrid').jqGrid("getDataIDs");

		for ( var j in mtlr_no) {
			var rowData = $('#receivePayGrid').jqGrid('getRowData', mtlr_no[j]);
			obj.ids[j] = rowData.mtlr_no;
			//alert(rowData.mtlr_no);
		}

		obj.rows = $("#receivePayGrid").jqGrid('getRowData');
		var popup = fnShowModalWindow("popMain.lims", obj, 1000, 788);
		if (popup != null) {
			for (var i = 0; i < popup.length; i++) {
				var row = popup[i];
				row.crud = 'c';
				row.icon = gridC;
				$('#receivePayGrid').jqGrid('addRowData', row.mtlr_no, row, 'last');
				if (appr_flag == 'C39001') {
					$('#btn_Save').show();
				}
			}
		}
	}

	// Validation 체크
	function buying_Row_Click(rowId) {
		var fix_qty_id = rowId + "_fix_qty";
		var cost_id = rowId + "_cost";

		// 확정수량
		$('#' + fix_qty_id).keyup(function() {
			var fixQty = $('#' + fix_qty_id).val();
			if (!fnIsNumeric(fixQty) && fixQty != '') {
				$.showAlert("숫자만 입력가능합니다.", {
					callback : function() {
						$('#' + fix_qty_id).val('');
						$('#' + fix_qty_id).focus();
					}
				});
			}
		});
		$('#' + fix_qty_id).blur(function() {
			var fixQty = $('#' + fix_qty_id).val();
			if (fixQty == '') {
				$('#' + fix_qty_id).val(0);
			}
		});

		// 단가
		$('#' + cost_id).keyup(function() {
			var cost = $('#' + cost_id).val();
			if (!fnIsNumeric(cost) && cost != '') {
				$.showAlert("숫자만 입력가능합니다.", {
					callback : function() {
						$('#' + cost_id).val('');
						$('#' + cost_id).focus();
					}
				});
			}
		});
		$('#' + cost_id).blur(function() {
			var cost = $('#' + cost_id).val();
			if (cost == '') {
				$('#' + cost_id).val(0);
			}
		});
	}
</script>

<!-- 구매정보목록 그리드 -->
<div class="sub_purple_01 w100p" id="view_grid_main">
	<form id="buyingConfirmationForm" name="buyingConfirmationForm" onsubmit="return false;">
		<table  class="select_table" >
			<tr>
				<td class="table_title">
					<span>■</span>
					구매 정보 목록
				</td>
				<td class="table_button">
					<span class="button white mlargep auth_select" id="btn_Select" onclick="btn_Select_onclick();">
						<button type="button">조회</button>
					</span>
				</td>
			</tr>
		</table>
		<table  class="list_table" >
			<tr>
				<th>진행상태</th>
				<td>
					<select id="buy_sts" name="buy_sts" class="w120px"></select>
				</td>
				<th>구매명칭</th>
				<td>
					<input id="buy_title" name="buy_title" type="text" class="w300px" />
				</td>
				<th>구매년도</th>
				<td>
					<select name="buy_year" id="sel_buy_year" class="w120px"></select>
					<!-- 					<input id="buy_year" name="buy_year" value="" type="text" style="width: 120px;" /> -->
				</td>
				<th>구매분기</th>
				<td>
					<input id="buy_q_val" type="hidden" class="inputhan" value="${detail.buy_q}" />
					<select id="buy_q" name="buy_q" style="border: 1px solid #afafaf;" class="w120px"></select>
				</td>
			</tr>
		</table>
		<input type="hidden" id="sortName" name="sortName">
		<input type="hidden" id="sortType" name="sortType">
		<table id="buyingConfirmationGrid"></table>
	</form>
</div>

<!-- 구매요청목록 그리드 -->
<div class="sub_blue_01 w45p" id="view_grid_sub">
	<form id="allBuyingConfirmationListForm" name="allBuyingConfirmationListForm" onsubmit="return false;"></form>
</div>

<!-- 하단 좌우 이동 버튼 -->
<div id="right_left_btn" class="w10p">
	<table>
		<tr>
			<td class="table_button">
				<span>
					<button type="button" onclick="btn_Move(1);" id="butten_right" class="btnRight"></button>
				</span>
				<br>
				<br>
				<span>
					<button type="button" onclick="btn_Move(3);" id="butten_left" class="btnLeft"></button>
				</span>
			</td>
		</tr>
	</table>
</div>

<!-- 구매확정 그리드 -->
<div class="sub_blue_01 w45p" id="view_grid_sub2">
	<form id="receivePayForm" name="receivePayForm" onsubmit="return false;"></form>
</div>

<%
	/***************************************************************************************
	 * 시스템명 	: 통합장비관제시스템
	 * 업무명 		: 구매정보
	 * 파일명 		: buyingInfoL01.jsp
	 * 작성자 		: 석은주
	 * 작성일 		: 2015.02.17
	 * 설  명		: 구매정보 리스트 조회 화면
	 *---------------------------------------------------------------------------------------
	 * 변경일		 변경자		변경내역 
	 *---------------------------------------------------------------------------------------
	 * 2015.02.17    석은주		최초 프로그램 작성         
	 * 
	 *---------------------------------------------------------------------------------------
	 ****************************************************************************************/
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html >
<link rel="stylesheet" media="screen" type="text/css" href="<c:url value='/css/common/sub.css'/>" />
<script type="text/javascript">
	$(function() {
		/* 세부권한검사 */
		fn_auth_check();
		
		ajaxComboForm("buy_q", "C14", "", "", 'form');
		ajaxComboBuyingForm("buy_sts", "C39", '', "form");
		checkYear('ALL', new Date().getFullYear(), 'sel_buy_year');

		//url명명 규칙(p.21) 
		grid('reagents/selectBuyingInfoList.lims', 'form', 'grid');
		$('#grid').clearGridData(); // 최초 조회시 데이터 안나옴

		// 엔터키 눌렀을 경우(그리드 조회)
		fn_Enter_Search('form', 'grid');

		//그리드 width조절하기
		$(window).bind('resize', function() {
			$("#grid").setGridWidth($('#view_grid_main').width(), true);
		}).trigger('resize');
	});

	function grid(url, form, grid) {
		$('#' + grid).jqGrid({
			datatype : function(json) {
				fnGridData(url, form, grid);
			},
			height : '230',
			autowidth : true,
			loadonce : true,
			mtype : "POST",
			gridview : true,
			shrinkToFit : true,
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
				formatter : function(value) {
					if (value == "C39001") {
						return '구매요청';
					} else if (value == "C39002") {
						return '요청승인';
					} else if (value == "C39003") {
						return '가격조사';
					} else if (value == "C39004") {
						return '구매확정';
					} else {
						return '임시저장';
					}
				}
			/* 	formatter : 'select',
			edittype : "select",
			editoptions : {
				value : buy_sts
			}  */
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
				name : 'buy_etc',
				width : '250'
			/* }, {
				label : '진행상태',
				name : 'state',
				width : '100' */
			} ],
			emptyrecords : '데이터가 존재하지 않습니다.',
			gridComplete : function() {
				$('#btn_Add').show();
				$('#btn_Insert').hide();
			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
			},
			onSelectRow : function(rowId, status, e) {
				var rowData = $('#' + grid).jqGrid('getRowData', rowId);
				fn_ViewPage('detail', rowData.buy_sts);
			}
		});
	}
	//저장버튼클릭
	function btn_Bf_Insert_onclick() {
		//validation 체크
		if (!saveValidation())
			return;
		$.showConfirm("시작일 : " + $('#detail').find('#buy_date').val() + "일, " + "종료일 : " + $('#detail').find('#dmd_date').val() + "일에 수요조사를 진행하시겠습니까?", {
			yesCallback : function() {
				btn_Insert_onclick(2);
			}
		});
	}
	//저장버튼(저장 & 수정) 클릭 이벤트
	function btn_Insert_onclick(type) {
		var param = '';
		if (type == 1) {
			//validation 체크
			if (!saveValidation())
				return;
			param = 'pageType=temp_insert&buy_sts=';
			$('#detail').find('#buy_sts').val('');
		} else {
			param = 'pageType=new_insert&buy_sts=C39001';
		}
		var url;
		var mtlr_mst_no = $('#detail').find('#mtlr_mst_no').val();
		param += '&' + $('#detail').serialize();
		if (mtlr_mst_no == '' || mtlr_mst_no == null) {
			url = 'reagents/insertBuyingInfo.lims';
		} else {
			url = 'reagents/updateBuyingInfo.lims';
		}
		var json = fnAjaxAction(url, param);
		if (json == null) {
			$.showAlert("저장 실패하였습니다.");
		} else {
			$.showAlert("", {
				type : 'insert'
			});
			btn_Search_onclick();
		}
	}

	// 삭제버튼 클릭 이벤트
	function btn_Delete_onclick() {
		if (!confirm('삭제 하시겠습니까?')) {
			return false;
		} else {
			var param = $('#detail').find('#mtlr_mst_no');
			var json = fnAjaxAction('reagents/deleteBuyingInfo.lims', param);
			if (json == null) {
				$.showAlert("삭제 실패하였습니다.");
			} else {
				$.showAlert("", {
					type : 'delete'
				});
				btn_Search_onclick();
			}
		}
	}

	// 리스트 조회 이벤트
	function btn_Search_onclick() {
		$('#detail').empty();
		$('#grid').trigger('reloadGrid');
	}

	// 추가버튼 클릭 이벤트
	function fn_ViewPage(pageType, type) {
		var param = 'pageType=' + pageType;
		param += '&mtlr_mst_no=' + $('#grid').getGridParam('selrow');
		fnViewPage('reagents/selectBuyingInfoDetail.lims', 'detail', param);

		fnDatePickerImg('dmd_date');
		fnDatePickerImg('buy_date');

		ajaxComboForm("buy_q", "C14", $('#detail').find('#buy_q_val').val(), "", "detail");
		var buySts = '';

		if (pageType == 'detail') {
			checkYear('', $('#detail').find('#buy_year_val').val(), 'buy_year');
			if (type == '임시저장') {
				$('#btn_Insert').show();
				$('#btn_Delete').show();
				$('#btn_Pre_Insert').show();
			} else if (type == '구매요청') {
				$('#btn_Insert').show();
				$('#btn_Delete').hide();
				$('#btn_Pre_Insert').hide();
				$("#detail select").attr("disabled", "disabled");
				// 				$('#detail').find('#buy_date img').attr("disabled","disabled");
			} else {
				//$('#btn_Insert').hide();
				$('#btn_Delete').hide();
				$('#btn_Pre_Insert').hide();
				//디테일에 입력불가능
				$("#detail input, #detail textarea").attr("readonly", true);
				$("#detail select, #detail img").attr("disabled", "disabled");
			}
		} else {
			//오늘날짜
			$('#detail').find('#buy_date').val(fnGetToday(0,0));
			buySts = '';
			$('#grid').resetSelection(); // 셀클릭 해제
			checkYear('', new Date().getFullYear(), 'buy_year');
			$('#btn_Pre_Insert').show();
			$('#btn_Insert').show();
			$('#btn_Delete').hide();
		}
		// 		ajaxComboBuyingForm("buy_sts", "C39", buySts, "detail");
	}

	//구매년도 콤보박스
	function checkYear(type, year, id) {
		var name = id;
		if (type == 'ALL') {
			$('#' + name).append($('<option />').val('').html('전체'));
		}
		for (var i = new Date().getFullYear() + 5; i > new Date().getFullYear() - 6; i--) {
			if (year == i) {
				$('#' + name).append($('<option selected />').val(i).html(i + ' 년'));
			} else
				$('#' + name).append($('<option />').val(i).html(i + ' 년'));
		}
	}
	//임시저장 콤보 Detail
	function ajaxComboBuyingForm(obj, thisCode, type, form) {
		var url = '/commonCode/selectCommonCodeCombo.lims';

		$.ajax({
			url : url,
			type : 'POST',
			async : false,
			dataType : 'json',
			data : "code=" + thisCode,
			timeout : 5000,
			error : function() {
				alert('Error loading XML document');
			},
			success : function(json) {
				var select = $("#" + form).find("#" + obj);
				select.empty();
				select.append("<option value=''>전체</option>");
				if (type == '') {
					select.append("<option value='tempSave'>임시저장</option>");
				}
				$(json).each(function(index, entry) {
					if (type == entry["code"] || type == entry["code_Name"]) {
						select.append("<option selected value='" + entry["code"] + "'>" + entry["code_Name"] + "</option>");
					} else {
						select.append("<option value='" + entry["code"] + "'>" + entry["code_Name"] + "</option>");
					}
				});
				select.trigger('change');// 강제로 이벤트 시키기			
			}
		});
	}
	//Validation 체크
	function saveValidation() {
		if (fnIsEmpty($('#detail').find('#buy_year').val())) {
			$.showAlert("구매년도를 선택하십시오.", {
				callback : function() {
					$('#detail').find('#buy_year').focus();
					return false;
				}
			});
		} else if (fnIsEmpty($('#detail').find('#buy_q').val())) {
			$.showAlert("구매분기를 선택하십시오.", {
				callback : function() {
					$('#detail').find('#buy_q').focus();
					return false;
				}
			});
		} else if (fnIsEmpty($('#detail').find('#buy_title').val())) {
			$.showAlert("구매명칭을 선택하십시오.", {
				callback : function() {
					$('#detail').find('#buy_title').focus();
					return false;
				}
			});
		} else
			return true;
	}
	/* 	function fnGridBuyingCommonCombo(code) {
			var ret;
			ret = ':임시저장;';
			var url = '/lims/';
			url += 'commonCode/selectCommonCodeCombo.lims';
			$.ajax({
				url : url,
				dataType : 'json',
				type : 'POST',
				async : false,
				data : 'code_group=' + code,
				success : function(json) {
					$(json).each(function(index, entry) {
						if(entry['code'] == '' || entry['code'] == null)
							ret += ':임시저장;';
						else
							ret += entry['code'] + ':' + entry["code_Name"] + ';';
					});
					ret = ret.substring(0, ret.length - 1);
				},
				error : function() {
					alert('fnGridCommonCombo error');
				}
			});
			return ret;
		} */
		
		// 엑셀 다운로드
		function btn_Excel_onclick() {
			var data = fn_Excel_Data_Make('grid');
			fn_Excel_Download(data);
		}		
		
</script>
<div id="buyingInfoDiv">
	<form id="form" name="form" onsubmit="return false;">
		<div class="sub_purple_01">
			<table  class="select_table" >
				<tr>
					<td width="20%" class="table_title">
						<span>■</span>
						구매정보목록
					</td>
					<td class="table_button">
						<span class="button white mlargep auth_select" id="btn_Select" onclick="btn_Search_onclick();">
							<button type="button">조회</button>
						</span>
						<span class="button white mlargep auth_save" id="btn_Add" onclick="fn_ViewPage('insert', '');">
							<button type="button">추가</button>
						</span>
						<span class="button white mlargeb auth_select" onclick="btn_Excel_onclick();">
							<button type="button">EXCEL</button>
						</span>
					</td>
				</tr>
			</table>
			<table  class="list_table" >
				<tr>
					<th>진행상태</th>
					<td>
						<select name="buy_sts" id="buy_sts"></select>
					</td>
					<th>구매명칭</th>
					<td>
						<input name="buy_title" type="text" />
					</td>
					<th>구매년도</th>
					<td>
						<select name="buy_year" id="sel_buy_year"></select>
					</td>
					<th>구매분기</th>
					<td>
						<select name="buy_q" id="buy_q"></select>
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
<div class="sub_blue_01">
	<form id="detail" name="detail" onsubmit="return false;"></form>
</div>
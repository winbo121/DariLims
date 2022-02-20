
<%
	/***************************************************************************************
	 * 시스템명 	: 통합장비관제시스템
	 * 업무명 		: 시험항목(팝업)
	 * 파일명 		: stdTestItemP01.jsp
	 * 작성자 		: 석은주
	 * 작성일 		: 2015.01.29
	 * 설  명		: 시험항목 상세보기 화면
	 *---------------------------------------------------------------------------------------
	 * 변경일		 변경자		변경내역 
	 *---------------------------------------------------------------------------------------
	 * 2015.01.29    석은주		최초 프로그램 작성         
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
	$(function() {
		grid('master/selectStdTestItemList.lims?pageType=all', 'form', 'grid');
		grid('', 'stdTestItemForm', 'stdTestItemGrid');

		$(window).on("beforeunload", function() {
			// 			var opener = window.dialogArguments;
			// 			opener.comboReload('test_std_no');
		});

		//그리드 사이즈 
		$(window).bind('resize', function() {
			$("#grid").setGridWidth($('#view_grid_main').width(), false);
		}).trigger('resize');
		$(window).bind('resize', function() {
			$("#stdTestItemGrid").setGridWidth($('#view_grid_sub').width(), false);
		}).trigger('resize');
		
		// 엔터키 눌렀을 경우
		fn_Enter_Search('form', 'grid');

	});

	function grid(url, form, grid) {
		var allselect = false;
		$('#' + grid).jqGrid({
			datatype : function(json) {
				if (grid == 'stdTestItemGrid') {
				} else
					fnGridData(url, form, grid);
			},
			height : '230px',
			width : 'auto',
			autowidth : true,
			loadonce : true,
			mtype : "POST",
			gridview : true,
			shrinkToFit : false,
			multiselect : true,
			rowNum : -1,
			rownumbers : true,
			colModel : [ {
				label : '항목명',
				name : 'test_item_nm',
				width : '230'
			}, {
				label : '항목영문명',
				name : 'test_item_eng_nm',
				width : '230'
			}, {
				label : '항목유형',
				name : 'test_item_type',
				width : '250'
			}, {
				label : 'KOLAS',
				name : 'kolas_flag',
				align : 'center',
				width : '100'
			}, {
				label : '시험항목코드',
				name : 'test_item_cd',
				key : true,
				hidden : true
			}, {
				label : 'use_flag',
				name : 'use_flag',
				formatter : 'checkbox',
				hidden : true
			} ],
			emptyrecords : '데이터가 존재하지 않습니다.',
			gridComplete : function() {
				allselect = false;
			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
			},
			onSelectRow : function(rowId, status, e) {
				if (grid == 'grid') {
					//선택항목에 선택되어 있는 항목들 체크
					var ids = $('#stdTestItemGrid').jqGrid("getDataIDs");
					for ( var i in ids) {
						if (rowId == ids[i]) {
							$.showAlert("선택항목에 존재하는 항목입니다.");
							//							alert("이미 존재하는 항목입니다.");
							$('#' + grid).jqGrid('setSelection', rowId, false);
							return 'stop';
						}
					}
					//부모창에서 받아온 항목들 체크
					var check = stdTestItems(rowId);
					if (check) {
						$.showAlert("이미 존재하는 항목입니다.");
						$('#' + grid).jqGrid('setSelection', rowId, false);
					}
				}
			},
			onSelectAll : function(selar, status) {
				if (!allselect) {
					var i = 0;
					for ( var row in selar) {
						var pre_ids = window.dialogArguments["ids"];
						for ( var k in pre_ids) {
							if (pre_ids[k] == selar[row]) {
								$('#' + grid).jqGrid('setSelection', selar[row], false);
								i++;
							}
						}
						var sel_ids = $('#stdTestItemGrid').jqGrid("getDataIDs");
						for ( var j in sel_ids) {
							if (sel_ids[j] == selar[row]) {
								$('#' + grid).jqGrid('setSelection', selar[row], false);
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
	//부모창에서 받아온 선택된 시험항목들
	function stdTestItems(rowId) {
		var check = false;
		var pre_ids = window.dialogArguments["ids"];
		for ( var i in pre_ids) {
			if (pre_ids[i] == rowId)
				check = true;
		}
		return check;
	}
	//조회버튼 클릭 이벤트
	function btn_Search_onclick() {
		$('#grid').trigger('reloadGrid');
	}
	function keyEventSearch(param) {
		var ieKey = event.keyCode;
		if (ieKey == 13) {
			btn_Search_onclick();
		}
	}
	//시험항목추가클릭이벤트
	function btn_Insert_onclick() {
		var returnValue = new Array();
		var selar = $("#stdTestItemGrid").jqGrid('getDataIDs');
		if (selar.length > 0) {
			var i = 0;
			for ( var row in selar) {
				var r = $('#stdTestItemGrid').jqGrid('getRowData', selar[row]);
				returnValue[i] = r;
				i++;
			}
			window.returnValue = returnValue;
			window.close();
		} else {
			$.showAlert('선택된 행이 없습니다.');
		}

	}
	//닫기클릭이벤트
	function btn_Close_onclick() {
		window.close();
	}

	//이동
	function btn_Move(m) {
		var up = 'grid';
		var down = 'stdTestItemGrid';
		switch (m) {
		case 1:
			var rowArr = $('#' + up).getGridParam('selarrrow');
			if (rowArr.length > 0) {
				for ( var i in rowArr) {
					var row = $('#' + up).getRowData(rowArr[i]);
					$('#' + down).jqGrid('addRowData', rowArr[i], row, 'last');
				}
				for (var i = rowArr.length - 1; i >= 0; i--) {
					$('#' + up).jqGrid('setSelection', rowArr[i], false);
				}
			} else {
				alert('선택된 행이 없습니다.');
			}
			break;
		case 3:
			var rowArr = $('#' + down).getGridParam('selarrrow');
			if (rowArr.length > 0) {
				for (var i = rowArr.length - 1; i >= 0; i--) {
					$('#' + down).jqGrid('delRowData', rowArr[i]);
				}
			} else {
				alert('선택된 행이 없습니다.');
			}
			break;
		}
	}
</script>
<div class="popUp">
	<div class="pop_area pop_intro">
		<h2>시료유형</h2>
		<form id="form" name="form" onsubmit="return false;">
			<div class="sub_purple_01 w100p" style="margin-top: 0px;">
				<table  class="select_table" >
					<tr>
						<td width="20%" class="table_title">
							<span>■</span>
							시험항목목록
						</td>
						<td class="table_button" style="text-align: right; padding-right: 30px;">
							<span class="button white mlargep auth_select" id="btn_Select" onclick="btn_Search_onclick();">
								<button type="button">조회</button>
							</span>
							<span class="button white mlargep" id="btn_Close" onclick="btn_Close_onclick();">
								<button type="button">닫기</button>
							</span>
						</td>
					</tr>
				</table>
				<table  class="list_table"  style="padding-left: 3px;">
					<tr>
						<th>항목명</th>
						<td>
							<input name="test_item_nm" type="text" class="inputhan" />
						</td>
						<th>KOLAS여부</th>
						<td>
							<label><input type='radio' name='kolas_flag' value='' style="width: 20px" checked="checked" />전체</label> <label><input type='radio' name='kolas_flag' value='Y' style="width: 20px" />예</label> <label><input type='radio' name='kolas_flag' value='N' style="width: 20px" />아니오</label>
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
		<div style="clear: both; margin-top: 15px; text-align: center;">
			<button type="button" id="btn_Right" onclick="btn_Move(1);" class="btnDown"></button>
			<button type="button" id="btn_Left" onclick="btn_Move(3);" class="btnUp"></button>
		</div>
		<div style="clear: both;">
			<form id="stdTestItemForm" name="stdTestItemForm" onsubmit="return false;">
				<div class="sub_blue_01">
					<table  class="select_table" >
						<tr>
							<td width="20%" class="table_title" nowrap="nowrap">
								<span>■</span>
								선택 항목
							</td>
							<td class="table_button" style="text-align: right; padding-right: 30px;">
								<span class="button white mlargep auth_save" id="btn_Insert" onclick="btn_Insert_onclick();">
									<button type="button">시험항목추가</button>
								</span>
							</td>
						</tr>
					</table>
				</div>
				<input type="hidden" id="sortName" name="sortName">
				<input type="hidden" id="sortType" name="sortType">
				<div id="view_grid_sub">
					<table id="stdTestItemGrid"></table>
				</div>
			</form>
		</div>
	</div>
</div>



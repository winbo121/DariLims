
<%
	/***************************************************************************************
	 * 시스템명 	: 통합장비관제시스템
	 * 업무명 		: 부서구매물품등록
	 * 파일명 		: reagentsGlassInOutP01.jsp
	 * 작성자 		: 석은주
	 * 작성일 		: 2015.02.26
	 * 설  명		: 부서별 시약/실험기구 구매 팝업 화면
	 *---------------------------------------------------------------------------------------
	 * 변경일		변경자		변경내역 
	 *---------------------------------------------------------------------------------------
	 * 2015.02.26   석은주		최초 프로그램 작성         
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
	var obj;
	var rowarr;
	$(function() {
		fnDatePickerImg('in_date');
		obj = window.dialogArguments;
		rowarr = obj.rows;

		ajaxComboForm("m_mtlr_info", "", "All", "", 'form'); // 중분류

		grid('reagents/popReagentsGlassInfoList.lims', 'form', 'grid');

		ajaxComboForm("inout_flag", 'C50', 'C50001', "", 'newReagentsGlassInoutForm'); // 수불구분(선택)
		ajaxComboForm("inout_flag_detail", 'C51', 'C51002', "", 'newReagentsGlassInoutForm'); // 수불상세구분(선택)

		$(window).bind('resize', function() {
			$("#grid").setGridWidth($('#view_grid_main').width(), false);
		}).trigger('resize');
		$(window).bind('resize', function() {
			$("#requestGrid").setGridWidth($('#view_grid_sub2').width(), false);
		}).trigger('resize');

		// 엔터키 눌렀을 경우
		fn_Enter_Search('form', 'grid');

		//라디오버튼 체인지 했을때
		$("input[type=radio]").change(function(e) {
			btn_Search_onclick();
		});

		//팝업 윈도우 close버튼으로 닫을때 이벤트
		$(window).on("beforeunload", function() {
			// 			var opener = window.dialogArguments["self"];
			// 			opener.btn_Search_onclick();
		});
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
				label : '시약실험기구코드',
				name : 'mtlr_no',
				align : 'center',
				width : '100',
				key : true,
				hidden : true
			}, {
				label : '대분류',
				width : '60',
				align : 'center',
				name : 'h_mtlr_info'
			}, {
				label : '중분류',
				width : '100',
				align : 'center',
				name : 'm_mtlr_info'
			}, {
				label : '품명',
				width : '250',
				name : 'item_nm'
			}, {
				label : '단위',
				width : '60',
				align : 'center',
				name : 'unit'
			}, {
				label : '제조사',
				width : '230',
				name : 'spec1'
			}, {
				label : 'Cas no.',
				width : '150',
				name : 'spec2'
			}, {
				label : 'Cat # (제품번호)',
				width : '150',
				name : 'spec_etc'
			}, {
				label : 'Lot # (로트번호)',
				width : '150',
				name : 'use',
				hidden : true
			}, {
				label : '용량',
				width : '150',
				name : 'mtlr_vol'
			}, {
				label : '내용',
				width : '200',
				name : 'content'
			}, {
				label : '마스터여부',
				width : '70',
				align : 'center',
				name : 'master_yn'
			}, {
				label : '비고',
				width : '250',
				name : 'etc'
			} ],
			emptyrecords : '데이터가 존재하지 않습니다.',
			gridComplete : function() {
				lastRowId = 0;
				$('#newReagentsGlassInoutDiv').hide();
				//inputBox초기화
				$('#newReagentsGlassInoutForm input, #newReagentsGlassInoutForm textarea').val('');
			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
			},
			onSelectRow : function(rowId, status, e) {
				if (rowId && rowId != lastRowId) {
					//부모창에서 받아온 수불목록리스트
					var check = mtlrNoCheck(rowId);
					if (check) {
						alert("이미 존재하는 목록입니다.");
						$('#' + grid).jqGrid('setSelection', rowId, false);
						$('#newReagentsGlassInoutDiv').hide();
						return 'stop';
					}
					$('#newReagentsGlassInoutDiv').show();
					//inputBox초기화
					$('#newReagentsGlassInoutForm input, #newReagentsGlassInoutForm textarea').val('');
					$('#newReagentsGlassInoutForm').find('#mtlr_no').val(rowId);
					lastRowId = rowId;
				}
			},
			ondblClickRow : function(rowId, iRow, iCol, e) {
			}
		});
	}

	//부모창에서 받아온 선택된 시험항목들
	function mtlrNoCheck(rowId) {
		var check = false;
		var pre_rows = window.dialogArguments["rows"];
		for ( var i in pre_rows) {
			if (pre_rows[i].mtlr_no == rowId)
				check = true;
		}
		return check;
	}

	//신규수불저장 버튼 클릭 이벤트
	function btn_Insert_onclick() {
		var form = "#newReagentsGlassInoutForm"; // form 이름
		var deptCd = window.dialogArguments["deptCd"];
		$(form).find('#dept_cd').val(deptCd);
		var param = $(form).serialize();
		param += '&inout_flag=' + $('#inout_flag').val() + '&inout_flag_detail=' + $('#inout_flag_detail').val();
		
		// 필수값 입력 체크
		var inQty = $(form).find('#in_qty').val();
		var inDate = $(form).find('#in_date').val();

		if (inQty == null || inQty == "") {
			$.showAlert('"입고수량"을 입력 하세요');
			$(form).find('#in_qty').focus();
			return false;
		}
		
		if (inDate == null || inDate == "") {
			$.showAlert('"입고일자"을 입력 하세요');
			$(form).find('#in_date').focus();
			return false;
		}		
		
		var url = 'reagents/insertReagentsGlassInOut.lims';
		// 		alert(param)
		var json = fnAjaxAction(url, param);
		if (json == null) {
			$.showAlert("저장 실패하였습니다.");
		} else {
			//확인창
			$.showAlert("", {
				type : 'insert'
			});

			//부모창 수불목록 재 조회
			var opener = window.dialogArguments["self"];
			opener.btn_Search_onclick();

			//리턴값으로 새로입력된 시약실험기구코드(mtlr_no) 넘기기
			var selRowId = $('#grid').jqGrid('getGridParam', 'selrow');
			var row = $('#grid').jqGrid('getRowData', selRowId);
			window.returnValue = row.mtlr_no;

			//자식창 닫기 클릭이벤트
			btn_Close_onclick();
		}
	}

	//조회버튼 클릭 이벤트
	function btn_Search_onclick() {
		$('#grid').trigger('reloadGrid');
	}

	//닫기클릭이벤트
	function btn_Close_onclick() {
		window.close();
	}

	// 대분류 콤보
	function comboReload() {
		//alert($("#h_mtlr_info").val());
		if ($("#h_mtlr_info").val() == "C42") {
			ajaxComboForm("m_mtlr_info", "C42", "All", "", 'form'); // 중분류			
		} else if ($("#h_mtlr_info").val() == "C43") {
			ajaxComboForm("m_mtlr_info", "C43", "All", "", 'form'); // 중분류
		}
	}
</script>
<div class="popUp">
	<div class="pop_area pop_intro">
		<h2>부서구매물품등록</h2>
		<form id="form" name="form" onsubmit="return false;">
			<div class="sub_purple_01" style="margin-top: 0px;">
				<table  class="select_table" >
					<tr>
						<td width="20%" class="table_title">
							<span>■</span>
							시약/실험기구목록
						</td>
						<td class="table_button">
							<span class="button white mlargep auth_select" id="btn_Select" onclick="btn_Search_onclick();">
								<button type="button">조회</button>
							</span>
							<span class="button white mlargep" id="btn_Close" onclick="btn_Close_onclick();">
								<button type="button">닫기</button>
							</span>
						</td>
					</tr>
				</table>
				<table  class="list_table" >
					<tr>
						<th>대분류</th>
						<td>
							<select class="w80px" name="h_mtlr_info" id="h_mtlr_info" onchange="comboReload()">
								<option value="">전체</option>
								<option value="C42">시약류</option>
								<option value="C43">소모품류</option>
							</select>
						</td>
						<th>중분류</th>
						<td>
							<select class="w120px" name="m_mtlr_info" id="m_mtlr_info"></select>
						</td>
						<th>품명</th>
						<td>
							<input name="item_nm" type="text" class="w120px" />
						</td>
						<th>마스터여부</th>
						<td>
							<label><input type='radio' name='master_yn' value='Y' style="width: 20px" checked="checked" />예</label> 
							<label><input type='radio' name='master_yn' value='N' style="width: 20px" />아니오</label>
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

		<div id="newReagentsGlassInoutDiv" style="width: 100%;">
			<form id="newReagentsGlassInoutForm" name="newReagentsGlassInoutForm" onsubmit="return false;">
				<div class="sub_blue_01">
					<table  class="select_table" >
						<tr>
							<td width="30%" class="table_title">
								<span>■</span>
								부서구매물품등록
							</td>
							<td class="table_button">
								<span class="button white mlargeg auth_save" id="btn_Insert" onclick="btn_Insert_onclick();">
									<button type="button">등록</button>
								</span>
							</td>
						</tr>
					</table>
					<table  class="list_table" >
						<!-- 리스트 width는 th는 10%  td는 15%로 적용-->
						<tr>
							<th>수불구분</th>
							<td>
								<input type="hidden" name="mtlr_no" id="mtlr_no" />
								<input type="hidden" name="dept_cd" id="dept_cd" />
								<select id="inout_flag" name="inout_flag" style="border: 1px solid #afafaf;" disabled="disabled">
								</select>
							</td>
							<th>수불상세구분</th>
							<td colspan="3">
								<select id="inout_flag_detail" name="inout_flag_detail" style="border: 1px solid #afafaf; width: 165px;" disabled="disabled">
								</select>
							</td>
						</tr>
						<tr>
							<th>입고수량</th>
							<td>
								<input name="in_qty" id="in_qty" type="text" class="inputhan" />
							</td>
							<th>입고일자</th>
							<td>
								<input name="in_date" id="in_date" type="text" class="w80px" readonly="readonly" />
								<img src="<c:url value='/images/common/calendar_del.png'/>" id="inDateStop" style="cursor: pointer;" onClick='fn_TextClear("in_date")' />
							</td>
							<th>가격</th>
							<td>
								<input name="price" id="price" type="text" class="inputhan" />
							</td>
						</tr>
						<tr>
							<th>수불적요</th>
							<!--한글우선입력-->
							<td colspan="7">
								<textarea style="width: 97%; height: 100px; border: 1px solid #afafaf;" name="inout_txt" class="inputhan"></textarea>
							</td>
						</tr>
					</table>
				</div>
			</form>
		</div>
	</div>
</div>
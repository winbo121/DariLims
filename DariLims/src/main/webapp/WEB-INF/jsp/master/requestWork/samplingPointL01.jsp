
<%
	/***************************************************************************************
	 * 시스템명 	: 통합장비관제시스템
	 * 업무명 		: 채수장소관리
	 * 파일명 		: samplingPointL01.jsp
	 * 작성자 		: 최은향
	 * 작성일 		: 2015.01.21
	 * 설  명		: 채수장소관리 리스트 조회 화면
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
<style type="text/css">
.rNum {
	background: #dfeffc url("./css/images/ui-bg_glass_85_dfeffc_1x400.png") 50% 50% repeat-x;
	color: #2e6e9e !important;
}
</style>
<script type="text/javascript">
	var water_system;
	$(function() {
		/* 세부권한검사 */
		fn_auth_check();
		
		water_system = fnGridCommonCombo('C02', null); // 정수장수계

		ajaxCombo("sampling_object_L", "C29", "ALL", "", "samplingForm"); // 채수대상(채수장소분류)
		ajaxCombo("water_system", "C02", "ALL", "", "samplingForm"); // 정수장수계

		//url명명 규칙(p.21) 
		grid('master/samplingPoint.lims', 'samplingForm', 'samplingGrid');
		fnViewPage('accept/selectSamplingPointListPaging.lims', 'paging', $('#samplingForm').serialize()); // 하단 게시글 번호
		
		// 엔터키 눌렀을 경우(그리드 조회)
		fn_Enter_Search('samplingForm', 'samplingGrid');

		//그리드 width조절하기
		$(window).bind('resize', function() {
			$("#samplingGrid").setGridWidth($('#view_grid_main').width(), true);
			$("#paging").width($("#view_grid_main").width() + 2); // 하단 페이징
		}).trigger('resize');
	});

	function grid(url, form, grid) {
		//var lastRowId;
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
			rownumbers : false,
			colModel : [ {
				label : '번호',
				name : 'rNum',
				width : '30',
				align : 'center',
				classes : 'rNum',
				sortable : false
			}, {
				label : '번호',
				name : 'sampling_point_no',
				key : true,
				hidden : true
			}, {
				label : '채수장소',
				width : '100',
				name : 'sampling_point_nm'
			}, {
				label : '채수대상',
				width : '60',
				name : 'sampling_object'
			}, {
				label : '채수대상코드(숨김)',
				width : '80',
				name : 'code',
				hidden : true
			}, {
				label : '정수장수계',
				width : '50',
				name : 'water_system'
			}, {
				label : '사업소',
				width : '100',
				name : 'org_nm'
			}, {
				label : '시설유형',
				width : '100',
				name : 'facilities_type'
			}, {
				label : '급수형태',
				width : '50',
				name : 'supply_type'
			}, {
				label : '코스',
				width : '100',
				name : 'course_nm'
			}, {
				label : '상호',
				width : '100',
				name : 'company_nm'
			}, {
				label : '주소',
				width : '300',
				name : 'addr'
			}, {
				label : '우편번호',
				width : '60',
				align : 'center',
				name : 'zip'
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
			} ],
			emptyrecords : '데이터가 존재하지 않습니다.',
			gridComplete : function() {
				$('#btn_Add').show();
				$('#btn_Insert').hide();
				$('#btn_Delete').hide();
			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
			},
			onSelectRow : function(rowId, status, e) {
				$('#btn_Add').show();
				$('#btn_Insert').hide();
				$('#btn_Delete').hide();
				btn_Row_onclick();
			}
		});
	}

	// 주소검색팝업창
	function btn_zipcode_onclick() {
		var obj = new Object();
		obj.msg1 = 'popAddrCode.lims';
		var popup = fnShowModalWindow("popMain.lims", obj, 700, 410);
		var ret = popup;
		var arr = ret.split('◆★◆');
		$('#addr1').val(arr[0]);
		$('#zip_code').val(arr[1]);
	}

	// 저장버튼(저장 & 수정) 클릭 이벤트
	function btn_Insert_onclick() {
		var url;
		var id = $('#samplingDetail').find('#sampling_point_no').val();
		if (id == '' || id == null || id == '0') {
			url = 'master/insertSamplingPoint.lims';
		} else {
			url = 'master/updateSamplingPoint.lims?key=${detail.sampling_point_no}';
		}
		var json = fnAjaxAction(url, $('#samplingDetail').serialize());
		if (json == null) {
			$.showAlert("저장 실패하였습니다.");
		} else {
			$.showAlert("", {
				type : 'insert'
			});
			$('#samplingDetail').empty();
			$('#samplingGrid').trigger('reloadGrid');
		}
	}

	//해당줄 클릭 이벤트(상세페이지 보기)
	function btn_Row_onclick() {
		var param = 'key=' + $('#samplingGrid').getGridParam('selrow');
		fnViewPage('master/samplingPointD01.lims?pageType=detail', 'samplingDetail', param);
		$('#btn_Add').show();
		$('#btn_Insert').show();
		$('#btn_Delete').show();
		return false;
	}

	// 삭제버튼 클릭 이벤트
	function btn_Delete_onclick() {
		if (!confirm("삭제하시겠습니까?")) {
			return false;
		}
		var param = $('#samplingDetail').serialize();
		var json = fnAjaxAction('master/deleteSamplingPoint.lims', param);
		if (json == null) {
			$.showAlert("삭제 실패하였습니다.");
		} else {
			$.showAlert("", {
				type : 'delete'
			});
			$('#samplingDetail').empty();
			$('#samplingGrid').trigger('reloadGrid');
			// 			btn_Select_onclick();
		}
	}

	// 리스트 조회 이벤트
	function btn_Select_onclick() {
		$('#pageNo').val(1);
		$('#samplingDetail').empty();
		$('#samplingGrid').trigger('reloadGrid');
		fnViewPage('accept/selectSamplingPointListPaging.lims', 'paging', $('#samplingForm').serialize()); // 하단 게시글 번호
	}

	// 추가버튼 클릭 이벤트
	function fn_ViewPage(pageType) {
		$('#samplingDetail').find('#sampling_point_no').val(''); // 해당 seq 삭제
		//$('#samplingGrid').trigger('reloadGrid'); // 셀클릭 해제
		$('#samplingGrid').jqGrid('resetSelection');
		fnViewPage('master/samplingPointD01.lims?pageType=' + pageType, 'samplingDetail', null);
		$('#btn_Add').show();
		$('#btn_Insert').show();
		$('#btn_Delete').hide();
	}

	// 사업소 등록팝업
	// 	function btn_Offices_Insert_onclick(type) {
	// 		var args = new Array();
	// 		args["type"] = type;
	// 		args["select"] =  window.self;
	// 		fnEditRelease('samplingGrid');
	// 		var url = 'master/popSamplingPointManage.lims';
	// 		var popOptions = "dialogWidth: 700px; dialogHeight: 400px; center: yes; resizable: yes; status: no; scroll: no;";
	// 		var popup = window.showModalDialog(url, args, popOptions);
	// 		return popup;
	// 	}

	// 사업소 선택
	function selectRow(rowId, org_nm, type) {
		//alert(type);
		// 조회창이면,
		if (type == "search") {
			$('#samplingForm').find('#org_nm').val(org_nm);
		}
		if (type == "insert") {
			// 등록, 수정 창이면,
			$('#samplingDetail').find('#org_nm').val(org_nm);
			$('#samplingDetail').find('#office_cd').val(rowId);
		}
	}

	// 사업소 등록팝업
	function btn_Pop_SamplingPointChoice() {
		var form = 'samplingDetail';
		var obj = new Object();
		obj.req_type = $('#' + form).find('#req_type').val();
		// 		obj.msg1 = 'accept/reqOrgChoice.lims';
		obj.msg1 = 'master/popSamplingPointManage.lims';

		var popup = fnShowModalWindow("popMain.lims", obj, 700, 410);
		if (popup != null) {
			var arr = popup.split('■★■');
			for ( var r in arr) {
				var v = arr[r].split('●★●');
				var id = v[0];
				if (id == 'req_org_no' || id == 'code') {
					id = 'office_cd';
				} else if (id == 'org_nm' || id == 'code_Name') {
					id = 'org_nm';
				}
				$('#' + form).find('#' + id).val(v[1]);
			}
		}
	}
	
	// 페이징 이벤트(하단 번호, >, >> 버튼이벤트)
	function linkPage(pageNo) {
		$('#pageNo').val(pageNo);
		$('#samplingGrid').trigger('reloadGrid');
		fnViewPage('accept/selectSamplingPointListPaging.lims', 'paging', $('#samplingForm').serialize()); // 하단 게시글 번호
	}
</script>

<form id="samplingForm" name="samplingForm" onsubmit="return false;">
	<div class="sub_purple_01">
		<table  class="select_table" >
			<tr>
				<td width="20%" class="table_title">
					<span>■</span>
					채취 장소 목록
				</td>
				<td class="table_button">
					<span class="button white mlargep auth_select" id="btn_Select" onclick="btn_Select_onclick();">
						<button type="button">조회</button>
					</span>
					<span class="button white mlargep auth_save" id="btn_Add" onclick="fn_ViewPage('insert');">
						<button type="button">추가</button>
					</span>
				</td>
			</tr>
		</table>
		<table  class="list_table" >
			<tr>
				<th>채수장소</th>
				<td>
					<input id="sampling_point_nm_L" name="sampling_point_nm" type="text" style="width: 160px;" />
					<!-- 					<select name="sampling_point_nm" id="sampling_point_nm_L" style="width:100px;"></select> -->
				</td>
				<th>채수대상</th>
				<td>
					<select name="sampling_object" id="sampling_object_L" style="width: 100px;"></select>
				</td>
				<th>정수장수계</th>
				<td>
					<select name="water_system" id="water_system" style="width: 100px;"></select>
				</td>
				<th>사업소</th>
				<td>
					<input id="org_nm" name="org_nm" type="text" style="width: 120px;" />
				</td>
				<th>사용여부</th>
				<td>
					<label><input type='radio' name='use_flag' value='' style="width: 20px" checked="checked" />전체</label> <label><input type='radio' name='use_flag' value='Y' style="width: 20px" />사용함</label> <label><input type='radio' name='use_flag' value='N' style="width: 20px" />사용안함</label>
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
<div class="sub_blue_01">
	<form id="samplingDetail" name="samplingDetail" onsubmit="return false;"></form>
</div>
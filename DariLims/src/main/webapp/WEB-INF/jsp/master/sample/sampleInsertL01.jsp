
<%
	/***************************************************************************************
	 * 시스템명 	: 통합장비관제시스템
	 * 업무명 		: 시료유형등록
	 * 파일명 		: sampleInsertL01.jsp
	 * 작성자 		: 최은향
	 * 작성일 		: 2015.01.21
	 * 설  명		: 시료유형등록 리스트 조회 화면
	 *---------------------------------------------------------------------------------------
	 * 변경일		 변경자		변경내역 
	 *---------------------------------------------------------------------------------------
	 * 2015.01.21    최은향		최초 프로그램 작성  
	 * 2015.10.13    윤상준		수정 
	 * 
	 *---------------------------------------------------------------------------------------
	 ****************************************************************************************/
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html >
<link rel="stylesheet" media="screen" type="text/css" href="<c:url value='/css/common/sub.css'/>" />
<script type="text/javascript">
	var sample_gubun_cd ;
	
	$(function() {
		/* 세부권한검사 */
		fn_auth_check();
		
		sample_gubun_cd = fnGridCommonCombo('C62', 'NON');
		ajaxComboForm("sample_gubun_cd", "C62", "${detail.sample_gubun_cd}", "", "form");
		grid('master/sampleInsert.lims', 'form', 'grid');
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
				label : '시료번호',
				name : 'sample_cd',
				key : true,
				hidden : true
			}, {
				label : '시료구분',
				width : '150',
				name : 'sample_gubun_nm',
				editable : true
				/* edittype : "select",
				editoptions : {
					value : sample_gubun_cd
				},
				formatter : 'select' */
			}, {
				label : '시료유형명',
				width : '150',
				name : 'sample_nm'
			}, {
				label : '시료유형영문명',
				width : '110',
				name : 'sample_eng_nm'
			}, {
				label : '시료유형약어',
				width : '80',
				align : 'center',
				name : 'sample_abbr'
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
				label : '생산업체명',
				width : '150',
				name : 'making_org_nm'
			}, {
				label : '수입업체명',
				width : '150',
				name : 'import_org_nm'
			}, {
				label : '설명',
				width : '200',
				name : 'sample_desc'
			} ],
			emptyrecords : '데이터가 존재하지 않습니다.',
			gridComplete : function() {
				$('#btn_Add').show();
				$('#btn_Insert').hide();
				//$('#btn_Delete').hide();
			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
			},
			onSelectRow : function(rowId, status, e) {
				$('#btn_Add').show();
				$('#btn_Insert').hide();
				//$('#btn_Delete').hide();
				btn_Row_onclick();
			}
		});
	}

	//저장버튼(저장 & 수정) 클릭 이벤트
	function btn_Insert_onclick() {
		var url;
		var id = $('#detail').find('#sample_cd').val();
		var param = $('#detail').serialize();

		//alert(id);
		if (id == '' || id == null) {
			url = 'master/insertSample.lims';
		} else {
			url = 'master/updateSample.lims?key=${detail.sample_cd}';
		}
		var json = fnAjaxAction(url, $('#detail').serialize());
		if (json == null) {
			$.showAlert("저장 실패하였습니다.");
		} else {
			$.showAlert("", {
				type : 'insert'
			});
			btn_Select_onclick();
			//$('#detail').empty();
			//$('#grid').trigger('reloadGrid');
		}
	}

	// 해당줄 클릭 이벤트(상세페이지 보기)	
	function btn_Row_onclick() {
		//alert(param);
		var param = 'key=' + $('#grid').getGridParam('selrow');
		fnViewPage('master/sampleInsertD01.lims?pageType=detail', 'detail', param);
		$('#btn_Add').show();
		$('#btn_Insert').show();
		//$('#btn_Delete').show();
		return false;
	}

	// 삭제버튼 클릭 이벤트
	function btn_Delete_onclick() {
		if (!confirm('삭제 하시겠습니까?')) {
			return false;
		} else {
			var param = $('#detail').serialize();
			fnAjaxAction('master/deleteSample.lims', param);
		}
	}

	// 리스트 조회 이벤트
	function btn_Select_onclick() {
		$('#detail').empty();
		$('#grid').trigger('reloadGrid');
	}

	// 추가버튼 클릭 이벤트
	function fn_ViewPage(pageType) {
		$('#detail').find('#sample_cd').val(''); // 해당 seq 삭제
		//$('#grid').trigger('reloadGrid'); // 셀클릭 해제
		$('#grid').jqGrid('resetSelection');
		fnViewPage('master/sampleInsertD01.lims?pageType=' + pageType, 'detail', null);
		$('#btn_Add').show();
		$('#btn_Insert').show();
		//$('#btn_Delete').hide();
	}
	
	// 엑셀 다운로드
	function btn_Excel_onclick() {
		var data = fn_Excel_Data_Make('grid');
		fn_Excel_Download(data);
	}
	
</script>
<form id="form" name="form" onsubmit="return false;">
	<div class="sub_purple_01">
		<table  class="select_table" >
			<tr>
				<td width="20%" class="table_title">
					<span>■</span>
					시료유형등록
				</td>
				<td class="table_button">
					<span class="button white mlargep auth_select" id="btn_Select" onclick="btn_Select_onclick();">
						<button type="button">조회</button>
					</span>
					<span class="button white mlargeb auth_save" id="btn_Add" onclick="fn_ViewPage('insert');">
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
				<th>시료구분</th>
				<td>
					<select name="sample_gubun_cd" id="sample_gubun_cd"></select>
				</td>
				<th>시료유형명/영문명</th>
				<td>
					<input id="sample_nm"  name="sample_nm" type="text" />
				</td>
				<!-- 
				<th>시료영문명</th>
				<td>
					<input name="sample_eng_nm" type="text"  />
				</td>
				 -->
				<th>시료유형약어</th>
				<td>
					<input id="sample_abbr" name="sample_abbr" type="text" />
				</td>
				<th>사용여부</th>
				<td>
					<label><input type='radio' name='use_flag' value='' style="width: 20px" checked="checked" />전체</label> <label><input type='radio' name='use_flag' value='Y' style="width: 20px" />사용함</label> <label><input type='radio' name='use_flag' value='N' style="width: 20px" />사용안함</label>
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
<div class="sub_blue_01">
	<form id="detail" name="detail" onsubmit="return false;"></form>
</div>
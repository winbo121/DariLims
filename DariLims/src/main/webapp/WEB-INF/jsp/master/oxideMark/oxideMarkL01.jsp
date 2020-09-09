
<%
	/***************************************************************************************
	 * 시스템명 	: 통합장비관제시스템
	 * 업무명 		: 산화물표기관리
	 * 파일명 		: oxideMark01.jsp
	 * 작성자 		: 석은주
	 * 작성일 		: 2020.01.14
	 * 설  명		: 산화물표기 추가 및 조회 화면
	 *---------------------------------------------------------------------------------------
	 * 변경일		 변경자		변경내역 
	 *---------------------------------------------------------------------------------------
	 *2020.01.14 한지연        	최초 프로그램 작성         
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
		/* 세부권한검사 */
		fn_auth_check();
		grid('master/selectOxideMarkList.lims', 'form', 'grid');
		$('#grid').clearGridData(); // 최초 조회시 데이터 안나옴

		fn_Enter_Search('form', 'grid');

		//그리드 사이즈 
		$(window).bind('resize', function() {
			$("#grid").setGridWidth($('#view_grid_main').width(), true);
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
			rowNum : -1,
			rownumbers : true,
			shrinkToFit : false,
			colModel : [ {
				label : 'oxide_cd',
				name : 'oxide_cd',
				key : true,
				hidden : true
			}, {
				label : '산화물표기 내용',
				name : 'oxide_content',
				width : '500'
			}, {
				label : '사용여부',
				name : 'used_flag',
				width : '80',
				align : 'center',
				formatter : 'select',
				editoptions : {
					value : 'Y:사용;N:사용안함'
				}
			} ],
			emptyrecords : '데이터가 존재하지 않습니다.',
			gridComplete : function() {
				$('#btn_AddLine').show();
				$('#btn_Insert').hide();
			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
			},
			onSelectRow : function(rowId, status, e) {
				$('#btn_AddLine').show();
				$('#btn_Insert').hide();
				fn_ViewPage('detail');
			}
		});
	}

	//상세보기, 신규 Detail 페이지 열기
	function fn_ViewPage(pageType) {
		var param = 'pageType=' + pageType;
		param += '&key=' + $('#grid').getGridParam('selrow');

		fnViewPage('master/selectOxideMarkListDetail.lims', 'detail', param);

		$('#btn_AddLine').show();
		$('#btn_Insert').show();
	}

	//저장(신규, 수정)버튼 클릭 이벤트
	function btn_Insert_onclick() {
		// 		Validation 체크
		if (!fn_saveValidation())
			return;
		var id = $('#detail').find('#oxide_cd').val();
		if (id == '') {
			var param = $('#detail').serialize();
			var json = fnAjaxAction('master/insertOxideMark.lims', param);
			if (json == null) {
				$.showAlert("저장 실패하였습니다.");
			} else {
				btn_Search_onclick();
				$.showAlert("", {
					type : 'insert'
				});
			}
		} else {
			var param = $('#detail').serialize();
			var json = fnAjaxAction('master/updateOxideMark.lims', param);
			if (json == null) {
				$.showAlert("저장 실패하였습니다.");
			} else {
				btn_Search_onclick();
				$.showAlert("", {
					type : 'insert'
				});
			}
		}
	}

	function fn_suc(json) {
		if (json == null) {
			alert('error');
		} else {
			btn_Search_onclick();
			$.showAlert("", {
				type : 'insert'
			});
		}
	}
	//조회
	function btn_Search_onclick() {
		$('#detail').empty();
		$('#grid').trigger('reloadGrid');
	}
	
	//	Validation 체크	
	function fn_saveValidation() {
		if (fnIsEmpty($('#detail').find('#oxide_content').val())) {
			$.showAlert("산화물표기방법을 입력하십시오.", {
				callback : function() {
					$('#detail').find('#oxide_content').focus();
					return false;
				}
			});
		} else {
			return true;
		}
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
					산화물표기목록
				</td>
				<td class="table_button" style="text-align: right; padding-right: 30px;">
					<span class="button white mlargep auth_select" id="btn_Select" onclick="btn_Search_onclick();">
						<button type="button">조회</button>
					</span>
					<span class="button white mlargeg auth_save" id="btn_AddLine" onclick="fn_ViewPage('insert');">
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
				<th>산화물표기 내용</th>
				<td>
					<input name="oxide_content" type="text" class="inputhan" />
				</td>
				<th>사용여부</th>
				<td>
					<label><input type='radio' name='used_flag' value='' style="width: 20px" checked="checked" />전체</label> <label><input type='radio' name='used_flag' value='Y' style="width: 20px" />사용</label> <label><input type='radio' name='used_flag' value='N' style="width: 20px" />사용안함</label>
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
<form id="detail" name="detail" enctype="multipart/form-data" onsubmit="return false;"></form>

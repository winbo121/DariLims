
<%
	/***************************************************************************************
	 * 시스템명 	: 통합장비관제시스템
	 * 업무명 		: 메뉴관리
	 * 파일명 		: reqOrgL01.jsp
	 * 작성자 		: 석은주
	 * 작성일 		: 2015.01.23
	 * 설  명		: 시험항목별 시험기기 목록 조회 화면
	 *---------------------------------------------------------------------------------------
	 * 변경일		 변경자		변경내역 
	 *---------------------------------------------------------------------------------------
	 * 2015.01.23    석은주		최초 프로그램 작성         
	 * 
	 *---------------------------------------------------------------------------------------
	 ****************************************************************************************/
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<link rel="stylesheet" media="screen" type="text/css" href="<c:url value='/css/common/sub.css'/>" />
<style>
</style> 
<script type="text/javascript">
	var fnGridInit = false;
	
	$(function() {
		/* 세부권한검사 */
		fn_auth_check();
		
		ajaxComboForm("orgType", "C24", "ALL", "", "form");
		reqOrgGrid('master/selectReqOrgList.lims', 'form', 'reqOrgGrid');
		
		$('#reqOrgGrid').clearGridData(); // 최초 조회시 데이터 안나옴

		//그리드 사이즈 
		$(window).bind('resize', function() {
			$("#reqOrgGrid").setGridWidth($('#view_grid_main').width(), false);
		}).trigger('resize');

		// 엔터키 눌렀을 경우
		fn_Enter_Search('form', 'reqOrgGrid');
	});

	// 업체 그리드
	function reqOrgGrid(url, form, grid) {
		$('#' + grid).jqGrid({
			datatype : function(json) {
				fnGridInit ? fn_GridData(url, form, grid) : fnGridInit = true;
			},
			height : '250',
			autowidth : true,
			gridview : true,
			shrinkToFit : false,
			rowNum : 10000,
			rownumbers : true,
			pager : "#"+grid+"Pager",
			viewrecords : true,
			scroll : true,
			rowList:[50,100,200],
			prmNames : {
				id : 'KEY',
				page : 'pageNum',
				rows : 'pageSize',
				sort : 'sortTarget',
				order : 'sortValue'
			},
				jsonReader : {        
				root : 'rows',        
				page : 'pageNum',        
				rowNum : 'pageSize',        
				records : 'total',        
				total : 'totalPage',        
				id : 'row_num',     
				repeatitems : true        
			},
			colModel : [ {
				label : 'req_org_no',
				name : 'req_org_no',
				hidden : true,
				key : true
			}, {
				label : '업체구분',
				name : 'org_type',
				align : 'center',
				width : '80'
			}, {
				label : '업체명',
				name : 'org_nm',
				width : '300'
			}, {
				label : '업체 영문명',
				name : 'eng_nm',
				width : '300'
			}, {
				label : '사업자번호',
				name : 'biz_no',
				width : '100'
			}, {
				label : '담당자',
				name : 'charger',
				align : 'center',
				width : '80'
			}, {
				label : '담당자전화번호',
				name : 'charger_tel',
				width : '100'
			}, {
				label : '담당자이메일',
				name : 'email',
				width : '100'
			}, {
				label : '결제담당자',
				name : 'pay_nm',
				width : '100'			
			}, {
				label : '결제담당자전화번호',
				name : 'pay_tel',
				width : '150'			
			}, {
				label : '결제담당자이메일',
				name : 'pay_email',
				width : '200'			
			}, {
				label : '업태',
				name : 'bsnsc',
				width : '80'
			}, {
				label : '종목',
				name : 'item',
				width : '80'
			}, {
				label : '법인번호',
				name : 'cor_no',
				width : '80'
			}, {
				label : '설명',
				name : 'org_desc',
				width : '200'	
			}, {
				label : '대표자',
				name : 'pre_man',
				width : '80'
			},/*  {
				label : '주민번호',
				name : 'reg_no',
				width : '100'
			},  */{
				label : '대표전화',
				name : 'pre_tel_num',
				width : '100'
			}, {
				label : '대표팩스',
				name : 'pre_fax_num',
				width : '100'
			},  {
				label : '우편번호',
				name : 'zip_code',
				align : 'center',
				width : '60'
			}, {
				label : '주소1',
				name : 'addr1',
				width : '300'
			}, {
				label : '주소2',
				name : 'addr2',
				width : '350'			
			} ],
			gridComplete : function() {
				$('#btn_AddLine').show();
				$('#btn_Insert').hide();
				$('#btn_Delete').hide();
			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
			},
			onSelectRow : function(rowId, status, e) {
				$('#btn_AddLine').show();
				$('#btn_Insert').hide();
				$('#btn_Delete').hide();
				fn_ViewPage('detail');
			}
		});
	}

	//상세보기 및 신규등록 페이지 전환
	function fn_ViewPage(pageType) {
		var param = 'pageType=' + pageType;
		param += '&key=' + $('#reqOrgGrid').getGridParam('selrow');

		fnViewPage('master/selectReqOrgD01.lims', 'detail', param);
		ajaxComboForm("org_type", "C24", $('#detail').find('#org_type_val').val(), "", "detail");

		if (pageType == 'detail')
			$('#btn_Delete').show();
		else
			$('#btn_Delete').hide();

		$('#btn_AddLine').show();
		$('#btn_Insert').show();
	}


	//삭제버튼 클릭 이벤트
	function btn_Delete_onclick() {
		if (!confirm('삭제하시겠습니까?')) {
			return false;
		}
		var param = $('#regOrgForm').serialize();
		var json = fnAjaxAction('master/deleteReqOrg.lims', param);
		if (json == null) {
			$.showAlert("삭제 실패하였습니다.");
		} else {
			btn_Search_onclick();
			$.showAlert("", {
				type : 'delete'
			});
		}
	}
	function btn_Copy_onclick() {
		if (!confirm('복사하시겠습니까?')) {
			return false;
		}
		var param = $('#regOrgForm').serialize();
		var json = fnAjaxAction('master/copyReqOrg.lims', param);
		if (json == null) {
			$.showAlert("복사 실패하였습니다.");
		} else {
			btn_Search_onclick();
			$.showAlert("복사가 되었습니다.");
		}
	}
	//조회버튼클릭이벤트
	function btn_Search_onclick() {
		$('#detail').empty();
		$('#reqOrgGrid').setGridParam({page: 1});
		$('#reqOrgGrid').trigger('reloadGrid');
	}
	//validation 체크
	function saveValidation() {
		if (fnIsEmpty($('#detail').find('#org_nm').val())) {
			$.showAlert("기관/업체/의뢰인명을 입력하십시오.", {
				callback : function() {
					$('#detail').find('#org_nm').focus();
					return false;
				}
			});
		} else if (fnIsEmpty($('#detail').find('#org_type').val())) {
			$.showAlert("업체구분을 선택하십시오.", {
				callback : function() {
					$('#detail').find('#org_type').focus();
					return false;
				}
			});
		} else {
			return true;
		}
	}
	
	// 엑셀 다운로드
	function btn_Excel_onclick() {
		var data = fn_Excel_Data_Make('reqOrgGrid');
		fn_Excel_Download(data);
	}
	
</script>
<form id="form" name="form" onsubmit="return false;">
	<div class="sub_purple_01">
		<table class="select_table" >
			<tr>
				<td width="20%" class="table_title">
					<span>■</span>
					업체목록
				</td>
				<td class="table_button" style="text-align: right; padding-right: 30px;">
					<span class="button white mlargep auth_select" id="btn_Select" onclick="btn_Search_onclick();">
						<button type="button">조회</button>
					</span>
					<span class="button white mlargep auth_save" id="btn_AddLine" onclick="btn_Copy_onclick();">
						<button type="button">복사</button>
					</span>
					<span class="button white mlargep auth_save" id="btn_AddLine" onclick="fn_ViewPage('insert');">
						<button type="button">추가</button>
					</span>
					<span class="button white mlargeb auth_select" onclick="btn_Excel_onclick();">
						<button type="button">EXCEL</button>
					</span>
				</td>
			</tr>
		</table>
		<table class="list_table">
			<tr>
				<th>업체구분</th>
				<td>
					<select id="orgType" name="org_type" class='w150px'></select>
				</td>
				<th>업체명</th>
				<td>
					<input name="org_nm" type="text" class="inputhan" class='w300px'/>
				</td>
				<th>사업자 번호</th>
				<td>
					<input name="biz_no" type="text" class="inputhan" class='w300px'/>
				</td>
			</tr>
			<tr>
				<th>담당자 성명</th>
				<td>
					<input id="charger" name="charger" type="text" class="inputhan" class='w300px'/>
				</td>
				<th>담당자 전화번호</th>
				<td>
					<input name="charger_tel" type="text" class="inputhan" class='w300px'/>
				</td>
				<th>담당자 이메일</th>
				<td>
					<input name="email" type="text" class="inputhan" class='w300px'/>
				</td>
			</tr>
		</table>
	</div>

	<input type="hidden" id="sortName" name="sortName">
	<input type="hidden" id="sortType" name="sortType">
	<input type='hidden' id='pageNum' name='pageNum'/>
	<input type='hidden' id='pageSize' name='pageSize'/>
	<input type='hidden' id='sortTarget' name='sortTarget'/>
	<input type='hidden' id='sortValue' name='sortValue'/>
	<div id="view_grid_main">
		<table id="reqOrgGrid"></table>
		<div id="reqOrgGridPager"></div>
	</div>
</form>
<form id="detail" name="detail" onsubmit="return false;"></form>
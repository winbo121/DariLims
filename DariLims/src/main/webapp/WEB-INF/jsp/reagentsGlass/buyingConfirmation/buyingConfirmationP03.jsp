
<%
	/***************************************************************************************
	 * 시스템명 	: 통합장비관제시스템
	 * 업무명 		: 시약실험기구 마스터 리스트
	 * 파일명 		: buyingConfirmationP03.jsp
	 * 작성자 		: 최은향
	 * 작성일 		: 2015.05.21
	 * 설  명		: 시약실험기구 마스터 리스트 팝업 화면
	 *---------------------------------------------------------------------------------------
	 * 변경일		 변경자		변경내역 
	 *---------------------------------------------------------------------------------------
	 * 2015.05.21    최은향		최초 프로그램 작성         
	 * 
	 *---------------------------------------------------------------------------------------
	 ****************************************************************************************/
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html >
<link rel="stylesheet" media="screen" type="text/css" href="<c:url value='/css/common/sub.css'/>" />
<script type="text/javascript">
	var obj;
	var arr;
	$(function() {	
		obj = window.dialogArguments;
		arr = obj.ids;
		h_mtlr_info = fnGridCommonCombo('C42', null);
		
		ajaxComboForm("m_mtlr_info", "", "All", "", 'form'); // 중분류 검색창 초기화용
		
		grid('reagents/popReagentsGlassInfoList.lims', 'form', 'grid');
		
		$('#tabDiv2').width($('#tabDiv2').width() - 40);
		
		$(window).bind('resize', function() {
			$("#grid").setGridWidth($('#view_grid_main').width(), false);
		}).trigger('resize');
		$(window).bind('resize', function() {
			$("#requestGrid").setGridWidth($('#view_grid_sub2').width(), false);
		}).trigger('resize');
		
		// 엔터키 눌렀을 경우
		fn_Enter_Search('form', 'grid');
		
	 	//라디오버튼 체인지 했을때
	 	$("input[type=radio]").change(function(e){
			btn_Search_onclick();
		});
	 	
		// 팝업 윈도우 close버튼으로 닫을때 이벤트
		$(window).on("beforeunload", function(){
	    });
	});
	
	function grid(url, form, grid) {
		var allselect = false;
		$('#' + grid).jqGrid({
			datatype : function(json) {
				if(grid == 'requestGrid') {					
				} else
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
			multiselect : false,
			colModel : [ {
				label : '시약실험기구코드',
				name : 'mtlr_no',
				align : 'center',
				width : '100',
				key : true,
				hidden : true
			}, {
				label : '마스터여부',
				width : '70',
				align : 'center',
				name : 'master_yn'
			}, {
				label : '대분류',
				width : '80',
				name : 'h_mtlr_info'
			}, {
				label : '중분류',
				width : '80',
				name : 'm_mtlr_info'
			}, {
				label : '대분류코드',
				width : '80',
				hidden : true,
				name : 'h_mtlr_info_grid'
			}, {
				label : '중분류코드',
				width : '80',
				hidden : true,
				name : 'm_mtlr_info_grid'
			},
			{
				label : '시약/실험기구명',
				width : '150',
				name : 'item_nm'
			}, {
				label : '제조사',
				width : '150',
				align : 'center',
				name : 'spec1'
			}, {
				label : 'Cas no.',
				width : '150',
				align : 'center',
				name : 'spec2'
			}, {
				label : 'Cat # (제품번호)',
				width : '200',
				align : 'center',
				name : 'spec_etc'
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
			},  {
				label : '단위',
				width : '100',
				align : 'center',
				hidden : true,
				name : 'unit_code'
			}, {								
				label : 'Lot # (로트번호)',
				width : '200',
				name : 'use',
				hidden : true
			}, {
				label : '내용',
				width : '200',
				name : 'content'
			}, {				
				label : '비고',
				width : '200',
				name : 'etc'
			}, {				
				label : '사용여부',
				width : '200',
				name : 'use_flag'
			}],
			emptyrecords : '데이터가 존재하지 않습니다.',
			gridComplete : function() {
				allselect = false;
				$('#btn_Insert').show();
			},
			onSortCol : function(index, iCol, sortorder) {				
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
			},
			onSelectRow : function(rowId, status, e) {
			},
			ondblClickRow : function(rowId, iRow, iCol, e) {
				btn_Save_onclick(grid);
			}
		});
	}
	
	// 행 선택
	function btn_Save_onclick(grid) {
		var rowId = $('#' + grid).getGridParam('selrow');
		if (rowId != null) {
			var data = '';
			var row = $('#' + grid).getRowData(rowId);
			for ( var column in row) {
				var val = row[column];
				data += column + '●★●' + val + '■★■';
			}
			data = data.substring(0, data.length - 3);
				//alert(data);
			window.returnValue = data;
			window.close();
		} else {
			$.showAlert('선택된 행이 없습니다.');
		}
	}
	
	
	// 대분류 콤보
	function comboReload() {
		//alert($("#h_mtlr_info").val());
		if($("#h_mtlr_info").val() == "C42"){
			ajaxComboForm("m_mtlr_info", "C42", "All", "", 'form'); // 중분류			
		}else if($("#h_mtlr_info").val() == "C43"){
			ajaxComboForm("m_mtlr_info", "C43", "All", "", 'form'); // 중분류
		}
	}
	
	// 부모창에서 받아온 선택된 시험항목들
	function stdTestItems(rowId) {
		var check = false;
		var pre_ids = window.dialogArguments["ids"];
		for (var i in pre_ids) {
			if(pre_ids[i] == rowId)
				check = true;
		}
		return check;
	}
	
	// 조회버튼 클릭 이벤트
	function btn_Search_onclick() {
		$('#grid').trigger('reloadGrid');
	}
	
	// 선택클릭이벤트
	function btn_Save_Sub2_onclick() {
		var returnValue = new Array();
		var selar = $("#requestGrid").jqGrid('getDataIDs');
		if(selar.length > 0) {
			var i = 0;
			for(var row in selar) {
				var r = $('#requestGrid').jqGrid('getRowData', selar[row]);
				returnValue[i] = r;
				i++;
			}
			window.returnValue = returnValue;
			window.close();
		} else {
			$.showAlert('선택된 행이 없습니다.');
		}
	}
	
	
	// 닫기클릭이벤트
	function btn_Close_onclick() {
		window.close();		
	}

</script>

<div class="popUp">
	<div class="pop_area pop_intro">
	<h2>시약/실험기구 등록</h2>
		<div id="tabDiv2" style="margin-top: 20px;">
			<form id="form" name="form" onsubmit="return false;">
				<div class="sub_purple_01">
					<table  class="select_table" >
						<tr>
							<td width="20%" class="table_title">
								<span>■</span>
								시약/실험기구목록
							</td>
							<td class="table_button" style="text-align: right; padding-right: 30px;">
								<span class="button white mlargep auth_select" id="btn_Select" onclick="btn_Search_onclick();">
									<button type="button">조회</button>
								</span>
								<span class="button white mlargeg auth_save" id="btn_Save" onclick="btn_Save_onclick('grid');">
									<button type="button">선택</button>
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
							<select name="h_mtlr_info" id="h_mtlr_info" style="width:95px"	onchange="comboReload()">
								<option value=" ">전체</option>
								<option value="C42">시약류</option>
								<option value="C43">소모품류</option>
							</select>
						</td>
						<th>중분류</th>
						<td>
							<select name="m_mtlr_info" id="m_mtlr_info" style="width:115px"></select>
						</td>
						<th>시약/실험기구명</th>
						<td>
							<input name="item_nm" type="text" class="inputhan"/>
						</td>
						<input type='hidden' name='master_yn' value='Y'/>
						<!-- 
						<th>마스터여부</th>
						<td>
							<label><input type='radio' name='master_yn' value='Y' style="width:20px" checked="checked"/>예</label>
							<label><input type='radio' name='master_yn' value='N' style="width:20px"/>아니오</label>
						</td>
						 -->
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
	</div>
</div>
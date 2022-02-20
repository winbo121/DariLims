
<%
	/***************************************************************************************
	 * 시스템명 : 통합장비관제시스템
	 * 업무명 	: 검사기준관리
	 * 파일명 	: pretreatmentL01.jsp
	 * 작성자 	: 최은향
	 * 작성일 	: 2015.12.22
	 * 설  명	: 검사기준관리 목록 조회 화면
	 *---------------------------------------------------------------------------------------
	 * 변경일		 변경자		변경내역 
	 *---------------------------------------------------------------------------------------
	 * 2015.12.22    최은향		최초 프로그램 작성         
	 * 
	 *---------------------------------------------------------------------------------------
	 ****************************************************************************************/
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html >
<link rel="stylesheet" media="screen" type="text/css" href="<c:url value='/css/common/sub.css'/>" />
<style>
.not-editable-cell {
	background-color: gray;
}

/* 한글우선입력 */
.imeon input {
	ime-mode: active;
}
</style>
<script type="text/javascript">
var fnGridInit = false;

$(function() {
	fn_auth_check();
	
	ajaxComboForm("htrk_prdlst_cd", "CP1", "CHOICE", "", "allPrdForm");

	// 품목그리드
	prdGrid('master/selectPrdLstList.lims', 'allPrdForm', 'allPrdGrid');

	//엔터이벤트
	fn_Enter_Search('allPrdForm', 'allPrdGrid');
});


// 품목 그리드
function prdGrid(url, form, grid) {	
	$('#' + grid).jqGrid({
		datatype : function(json) {
			fn_GridData(url, form, grid);
			//fnGridInit ? fnGridData(url, form, grid) : fnGridInit = true;
		},
		colModel : [ {
			label : '품목코드',
			name : 'prdlst_cd',
			key : true,
			hidden : true
		}, {
			label : '품목분류',
			width : '100',
			align : 'center',
			hidden : true,
			name : 'htrk_prdlst_nm'
		}, {
			label : '품목명',
			width : '300',
			hidden : true,
			name : 'prdlst_nm'
		}, {
			label : '품목한글명',
			width : '200',
			name : 'kor_nm'
		}, {
			label : '품목영문명',
			width : '200',
			hidden : true,
			name : 'eng_nm'
		}, {
			label : '레벨',
			width : '60',
			align : 'center',
			name : 'lv',
			hidden : true
		}, {
			label : '품목여부',
			width : '100',
			name : 'prdlst_yn',
			hidden : true
		}, {
			label : '속성한글명',
			width : '100',
			name : 'piam_kor_nm',
			align : 'center',
			hidden : true
		}, {
			label : '조합품목여부',
			width : '100',
			name : 'mxtr_prdlst_yn',
			hidden : true
		}, {
			label : '사용여부',
			width : '100',
			name : 'use_yn',
			hidden : true
		}, {
			label : '유효개시일자',
			width : '100',
			name : 'vald_begn_dt',
			align : 'center',
			hidden : true
		}, {
			label : '유효종료일자',
			width : '100',
			name : 'vald_end_dt',
			align : 'center',
			hidden : true
		}, {
			label : '최종수정일',
			width : '100',
			name : 'last_updt_dtm',
			hidden : true
		}, {
			label : '정의',
			width : '100',
			name : 'dfn',
			hidden : true
		}, {
			label : '비고',
			width : '200',
			name : 'rm',
			width: '200'
		}, {
			label : 'kfda_yn',
			hidden : true,
			name : 'kfda_yn'
		} ],
				height : '710',
				rowNum : -1,
				rownumbers : true,
				autowidth : false,
				gridview : false,
				shrinkToFit : false,
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
		gridComplete : function(data) {
			gridPrdLstPopComplete();
		},
		onSortCol : function(index, iCol, sortorder) {
			if(!com_auth_select){return 'stop';} else {fnSortCol(form, index, sortorder);}
		},			
		onSelectRow : function(rowId, status, e) {
			var row = $('#' + grid).getRowData(rowId);
			$("#testPrdStdRevGridForm").find("#prdlst_cd").val(row.prdlst_cd);
			$("#testPrdStdRevGridForm").find("#prdlst_nm").val(row.kor_nm);
			$("#insPrdForm").find("#prdlst_cd").val(row.prdlst_cd);

			btn_Search_onclick(1);
		},
		ondblClickRow : function(rowId, iRow, iCol, e) {
		}
	});
}

function gridPrdLstPopComplete(){	
	$(window).bind('resize', function() {
		$("#allPrdGrid").setGridWidth($('#view_grid_prd').width(), false);
	}).trigger('resize');
}

// 품목 조회
function btn_Select_Sub_onclick() {
	$('#allPrdGrid').setGridParam({page: 1});
	$('#allPrdGrid').trigger('reloadGrid');
}

</script>
<div class="sub_purple_01 w30p">
<form id="allPrdForm" name="allPrdForm" onsubmit="return false;">
	<table width="100%" border="0" class="select_table" >
		<tr>
			<td width="20%" class="table_title">
				<span>■</span>
				품목 목록
			</td>
			<td class="table_button" style="text-align: right; padding-right: 30px;">
				<span class="button white mlargeb auth_select" id="btn_Select" onclick="btn_Select_Sub_onclick();">
					<button type="button">조회</button>
				</span>
			</td>
		</tr>
	</table>
	<!-- 조회 테이블 -->
	<table  class="list_table" >
		<tr>
			<th>품목명</th>
			<td>
				<input type="text" name="kor_nm"/>
			</td>
		</tr>
	</table>
	<input type="hidden" id="prdlst_yn" name="prdlst_yn" value='Y'>
	<input type="hidden" id="use_yn" name="use_yn" value='Y'>
	<input type="hidden" id="sortName" name="sortName">
	<input type="hidden" id="sortType" name="sortType">
	<input type='hidden' id='pageNum' name='pageNum'/>
	<input type='hidden' id='pageSize' name='pageSize'/>
	<input type='hidden' id='sortTarget' name='sortTarget'/>
	<input type='hidden' id='sortValue' name='sortValue'/>
	<div id="view_grid_prd">
		<table id="allPrdGrid"></table>
		<div id="gridPrdLstPopPager"></div>
	</div>
</form>
</div>

<div class="w5p"></div>

<script type="text/javascript">
	var unit_cd_sel;
	var result_type;
	var mxmm_val_dvs_cd;
	var mimm_val_dvs_cd;
	var choic_fit;
	var choic_impropt;
	$(function() {
		/* 세부권한검사 */
		fn_auth_check();
		
		ajaxCombo('result_type', 'C31', 'ALL', '');
		ajaxCombo('unit_cd', 'C08', 'ALL', '');
		
		unit_cd_sel = fnGridCommonCombo('C08', null);
		result_type = fnGridCommonCombo('C31', null);
		mxmm_val_dvs_cd = fnGridCommonCombo('C36', null);
		mimm_val_dvs_cd = fnGridCommonCombo('C35', null);
		choic_fit = fnGridCommonCombo('C34', null);
		choic_impropt = fnGridCommonCombo('C34', null);

		grid('master/selectPretMList.lims', 'testPrdStdRevGridForm', 'testPrdStdRevGrid');
		$('#testPrdStdRevGrid').clearGridData(); // 최초 조회시 데이터 안나옴

		
		//그리드 사이즈 
		$(window).bind('resize', function() {
			$("#testPrdStdRevGrid").setGridWidth($('#view_grid_rev').width(), false);
		}).trigger('resize');

		$(window).bind('resize', function() {
			$("#testPrdStdRevGrid").setGridWidth($('#view_grid_rev').width(), false);
		}).trigger('resize');

		fnDatePicker('rev_date');

		// 엔터키 눌렀을 경우
		fn_Enter_Search('testPrdStdRevGridForm', 'testPrdStdRevGrid');
	});

	function grid(url, form, grid) {
		var lastRowId = 0;
		$('#' + grid).jqGrid({
			datatype : function(json) {
				fnGridData(url, form, grid);
			},
			height : '530px',
			autowidth : true,
			loadonce : true,
			mtype : "POST",
			gridview : true,
			shrinkToFit : false,
			rowNum : -1,
			rownumbers : true,
			colModel : [ {
					label : 'prdlst_cd',
					name : 'prdlst_cd',
					hidden : true,
					width : '250'
				}, {
					label : '품목명',
					name : 'kor_nm',
					hidden : true
					
				}, {
					label : 'pretreatment_cd',
					name : 'pretreatment_cd',
					hidden : true
				}, {
					label : '전처리명',
					name : 'pretreatment_nm',
					width : '300'
				}, { 
					label : '전처리방법',
					name : 'pre_method',
					width : '300'
				}, {
					label : '비용',
					name : 'pre_cost',
					width : '300'
					
				}, {
					label : '삭제여부',
					name : 'pre_del',
					width : '150',
					hidden : true
				}],
			emptyrecords : '데이터가 존재하지 않습니다.',
			gridComplete : function() {
				// 				$('#btn_Delete').hide();
			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
				if (!confirm('저장하지 않은 정보는 사라집니다. 정렬하시겠습니까?')) {
					return 'stop';
				}
			},
			beforeSelectRow : function(rowId, e) {
				if (rowId && rowId != lastRowId) {
					if (!valiCheck(lastRowId))
						return 'stop';
				}
				return true;
				//  				$('#' + grid).jqGrid("setSelection", rowId, true);				
			},
			onCellSelect : function(rowId, iCol, cellcontent, e) {
				var colArr = $('#' + grid).jqGrid('getGridParam', 'colModel');
				var col = colArr[iCol].name;
				if (col == 'fee_group_pop') {
					var ret = popFeeGroup();
					if (ret != null && ret != '') {
						var arr = ret.split('◆★◆');
						$('#' + grid).jqGrid('setCell', rowId, 'fee', arr[2]);
						$('#' + grid).jqGrid('setCell', rowId, 'fee_group_nm', arr[1]);
						$('#' + grid).jqGrid('setCell', rowId, 'fee_group_no', arr[0]);
						testPrdStdRevGridEditCell(grid, rowId);
					}
				} else if (col == 'fee_group_del') {
					$('#' + grid).jqGrid('setCell', rowId, 'fee_group_nm', null);
					$('#' + grid).jqGrid('setCell', rowId, 'fee_group_no', null);
					$('#' + grid).jqGrid('setCell', rowId, 'fee', null);
					testPrdStdRevGridEditCell(grid, rowId);
				}
			},
			onSelectRow : function(rowId, status, e) {
				if(grid == "testPrdStdRevGrid"){
					var row = $('#' + grid).getRowData(rowId);
					$("#insPrdForm").find("#prdlst_cd").val(row.prdlst_cd);
					$("#insPrdForm").find("#pretreatment_cd").val(row.pretreatment_cd);
					$("#insPrdForm").find("#pretreatment_nm").val(row.pretreatment_nm);
					$("#insPrdForm").find("#pre_method").val(row.pre_method);
					$("#insPrdForm").find("#pre_cost").val(row.pre_cost);
					btn_Search2_onclick(1);
				}
				
				if (rowId && rowId != lastRowId) {
					fnEditRelease(grid);
					lastRowId = rowId;
				}
			},
			ondblClickRow : function(rowId, iRow, iCol, e) {
				fnEditRelease(grid);
				testPrdStdRevGridEdit(grid, rowId);
				var colArr = $('#' + grid).jqGrid('getGridParam', 'colModel');
				$('#' + rowId + '_' + colArr[iCol].name).focus();
			},
		});

		$('#' + grid).jqGrid('setGroupHeaders', {
			useColSpanStyle : true,
			groupHeaders : [ {
				startColumnName : 'unit_cd',
				numberOfColumns : 6,
				titleText : '수치형기준'
			}, {
				startColumnName : 'choic_fit',
				numberOfColumns : 2,
				titleText : '선택형기준'
			} ]
		});
	}

	//에디트모드
	function testPrdStdRevGridEdit(grid, rowId) {
		var row = $('#' + grid).getRowData(rowId);
		if (row.crud != 'n') {
			$('#' + grid).setCell(rowId, 'icon', gridU);
			$('#' + grid).setCell(rowId, 'crud', 'u');
			$('#' + grid).setCell(rowId, 'chk', 'Yes');
		}
		editable(grid,'');
	}
	
	// 조회버튼 클릭 이벤트
	function btn_Search_onclick(type) {
		fnEditRelease('testPrdStdRevGrid');
		$('#testPrdStdRevGrid').trigger('reloadGrid');

	}

	

	// 기준별 시험항목 목록에 수정, 삭제, 업데이트 된 항목이 있는지 확인
	function editCount(grid) {
		var check = false;
		var ids = $('#' + grid).jqGrid("getDataIDs");
		for ( var i in ids) {
			var row = $('#' + grid).getRowData(ids[i]);
			if (row.crud == 'n' || row.crud == 'd' || row.crud == 'u')
				check = true;
		}
		return check;
	}

	/* // 저장버튼 클릭이벤트
	function btn_Update_onclick(grid) {
		var rowId = $('#' + grid).jqGrid('getGridParam', "selrow");
		if (!valiCheck(rowId))
			return;
		fnEditRelease(grid);
		
		var ids = $('#' + grid).jqGrid("getDataIDs");		
		for ( var i in ids ) {
			var row = $('#' + grid).getRowData(ids[i]);
			if (row.chk == 'Yes'){
				if ($.trim(row.spec_val) == '' || $.trim(row.spec_val) == '-') {
					alert(row.test_item_nm + ' 기준값을 입력해주세요.');
					fnGridEdit(grid, ids[i], null);
					$("#" + ids[i] + "_spec_val").focus();
					return false;
				}
			}
		}
		
		if (ids.length < 1) {
			$.showAlert("시험항목 목록이 존재하지 않습니다.");
			return;
		}

		if (!editCount(grid)) {
			alert("변경된 시험항목 목록이 없습니다.");
			return;
		}
		var data = fnGetGridAllData(grid);

		if(grid == "testPrdStdRevGrid"){
			var json = fnAjaxAction('master/insertStdPrdTestItem.lims', data);
			if (json == null) {
				$.showAlert("저장 실패하였습니다.");
			} else {
				$.showAlert("", {
					type : 'insert'
				});
				btn_Search_onclick(2);
			}			
		}else{
			var json = fnAjaxAction('master/insertStdPrdTestItem.lims', data);
			if (json == null) {
				$.showAlert("저장 실패하였습니다.");
			} else {
				$.showAlert("", {
					type : 'insert'
				});
				btn_Search2_onclick(2);
			}
		}
		return data;
	} */
	

	// 시험항목추가 팝업
	function btn_Add_onclick(form) {
		var prdlst_cd = $("#"+form).find("#prdlst_cd").val();
		var prdlst_nm = $("#"+form).find("#prdlst_nm").val();
		var indv_spec_seq = $("#"+form).find("#indv_spec_seq").val();
		
		if(form == "testPrdStdRevGridForm"){
			if(prdlst_cd == "" || prdlst_nm == ""){
				alert("품목을 선택해야 합니다.");
				return;
			}
		}else{
			if(prdlst_cd == "" || prdlst_nm == "" || indv_spec_seq == ""){
				alert("기준규격을 선택해야 합니다.");
				return;
			}
		}
		param =  prdlst_cd + "◆★◆" + prdlst_nm + "◆★◆" + indv_spec_seq;

		var url = "master/testSampleGradeChoice.lims";
		var height = "867";
		var width = "1000";
		var option = "toolbar=no, location=no, menubar=no, scrollbars=yes, status=no, resizable=yes, top=50%, left=50%, width=" + width + 'px, height=' + height +'px' ;
		openPopup = window.open(url, param, option);

		fnBasicStartLoading();
	}
	
	// 자식 -> 부모창 함수 호출
	function fnpop_callback(returnParam){
		btn_Search_onclick(1);
		fnBasicEndLoading();
	}
	
	
	// 기준값 validation체크
	function valiCheck(rowId) {
		var result_id = $('#' + rowId + '_jdgmnt_fom_cd ').val();
		var check = true;
		if (result_id == 'C31002') { // 수치형
			var stdHval = $('#' + rowId + '_mxmm_val');
			var stdLval = $('#' + rowId + '_mimm_val');
			var lvalType = $('#' + rowId + '_mimm_val_dvs_cd');
			var hvalType = $('#' + rowId + '_mxmm_val_dvs_cd');
			if (stdHval.val() != '' && stdLval.val() != '') {
				if (parseFloat(stdLval.val()) >= parseFloat(stdHval.val())) {
					alert("기준상한값보다 큰 값을 입력하셔야 합니다.");
					stdHval.val(null);
					stdHval.focus();
					check = false;
				}
			}
			if (check) {
				if (stdLval.val() == '') {
					if (lvalType.val() != '') {
						$.showAlert("기준하한값을 입력하세요.", {
							callback : function() {
								stdLval.focus();
							}
						});
						check = false;
					}
				} else {
					if (lvalType.val() == '') {
						$.showAlert("하한값구분을 선택하세요.", {
							callback : function() {
								lvalType.focus();
							}
						});
						check = false;
					}
				}
			}
			if (check) {
				if (stdHval.val() == '') {
					if (hvalType.val() != '') {
						$.showAlert("기준상한값을 입력하세요.", {
							callback : function() {
								stdHval.focus();
							}
						});
						check = false;
					}
				} else {
					if (hvalType.val() == '') {
						$.showAlert("상한값구분을 선택하세요.", {
							callback : function() {
								hvalType.focus();
							}
						});
						check = false;
					}
				}
			}
			if (check) {
				if ($('#' + rowId + '_unit_cd').val() == '') {
					$.showAlert("단위를 선택하세요.", {
						callback : function() {
							$('#' + rowId + '_unit_cd').focus();
						}
					});
					check = false;
				}
			}
		}
		return check;
	}
	
	//폼 초기화
	function btn_Reset_Sub_onclick() {
		$("#insPrdForm")[0].reset();
	}
	
	//전처리 저장
	function btn_Insert_Sub_onclick() {
		var url;
		var prdlst_cd = $("[name=prdlst_cd]").val();
		var pretreatment_nm = $("[name=pretreatment_nm]").val();
		var pretreatment_nm = $("#insPrdForm").children().next().children().next().children().next().children().val();
		//alert($('#insPrdForm').serialize());
		
		if(pretreatment_nm == "") {
			alert("전처리명 : 필수 입력 입니다.");
			return false;
		} else if(prdlst_cd == "") {
			alert("품목 : 필수 선택 입니다.");
			return false;
		}
		
		url = 'master/insertPretreatment.lims';
		
		var json = fnAjaxAction(url, $('#insPrdForm').serialize());
		
		if (json == null) {
			$.showAlert('저장 실패되었습니다.');
		} else {
			$.showAlert('저장이 완료되었습니다.');
			$("#insPrdForm")[0].reset();
			$('#testPrdStdRevGrid').trigger('reloadGrid');
		}
	}
	
	//전처리 삭제
	function btn_Del_Sub_onclick() {
		var url;
		
		var prdlst_cd = $("[name=prdlst_cd]").val();
		var pretreatment_nm = $("#insPrdForm").children().next().children().next().children().next().children().val();
		//alert($('#insPrdForm').serialize());
		
		if(pretreatment_nm == "") {
			alert("전처리명 : 필수 입력 입니다.");
			return false;
		} else if(prdlst_cd == "") {
			alert("품목 : 필수 선택 입니다.");
			return false;
		}
		
		url = 'master/deletePretreatment.lims';
		//alert($('#insPrdForm').serialize());
		
		var json = fnAjaxAction(url, $('#insPrdForm').serialize());
		
		if (json == null) {
			$.showAlert('삭제 실패되었습니다.');
		} else {
			$.showAlert('삭제가 완료되었습니다.');
			$("#insPrdForm")[0].reset();
			$('#testPrdStdRevGrid').trigger('reloadGrid');
		}
	}
	function btn_preSearch_onclick() {
		$('#testPrdStdRevGrid').setGridParam({page: 1});
		$('#testPrdStdRevGrid').trigger('reloadGrid');
	}
	
</script>

<div class="sub_blue_01 w65p" style="margin-top:0px;">
	<div class="sub_blue_01">
		<form id="testPrdStdRevGridForm" name="testPrdStdRevGridForm" onsubmit="return false;">
		<table  class="select_table" >
			<tr>
				<td width="20%" class="table_title">
					<span>■</span>
					전처리 목록
				</td>
				<td class="table_button" style="text-align: right;">
					<span class="button white mlargeg auth_save" id="btn_Ins1" onclick="btn_preSearch_onclick();">
						<button type="button">조회</button>
					</span>
				</td>
			</tr>
		</table>
		<table  class="list_table" >
		<tr>
			<th>전처리명</th>
			<td>
				<input type="text" name="pretreatment_nm"/>
			</td>
		</tr>
	</table>
	
		<div id="view_grid_rev">
			<table id="testPrdStdRevGrid"></table>
		</div>
		<input type="hidden" id="prdlst_cd" name="prdlst_cd">
		<input type="hidden" id="prdlst_nm" name="prdlst_nm">
		<input type="hidden" id="indv_spec_seq" name="indv_spec_seq">
		<input type="hidden" id="sortName" name="sortName">
		<input type="hidden" id="sortType" name="sortType">
		</form>
	</div>
	<div style="clear:both; padding-top:30px; text-align:center;">
	</div>
	<div class="sub_purple_01">
		<form id="insPrdForm" name="insPrdForm" onsubmit="return false;">
			<table width="100%" border="0" class="select_table">
				<tr>
					<td width="20%" class="table_title"><span>■</span> 전처리 등록</td>
					<td class="table_button" style="text-align: right; padding-right: 30px;">
						<span	class="button white mlargeb auth_select" id="btn_Insert" onclick="btn_Reset_Sub_onclick();">
							<button type="button">초기화</button>
						</span> 
						<span class="button white mlargeb auth_select" id="btn_Insert" onclick="btn_Insert_Sub_onclick();">
							<button type="button">저장</button>
						</span> 
						<span class="button white mlargeb auth_select" id="btn_Insert" onclick="btn_Del_Sub_onclick();">
							<button type="button">삭제</button>
						</span>
					</td>
				</tr>
			</table>
			<table class="list_table">
				<tr>
					<th>전처리명</th>
					<td><input type="text" name="pretreatment_nm" id="pretreatment_nm" class="pretreatment_nm2"/></td>
				</tr>
				<tr>
					<th>전처리방법</th>
					<td><textarea name="pre_method" id="pre_method" style="width:600px"></textarea></td>
				</tr>
				<tr>
					<th>비용</th>
					<td><input type="text" name="pre_cost" id="pre_cost" /></td>
				</tr>
			</table>
			<input type="hidden" name="prdlst_cd" id="prdlst_cd" /> 
			<input type="hidden" name="pretreatment_cd" id="pretreatment_cd" />
		</form>
	</div>
</div>

<%
	/***************************************************************************************
	 * 시스템명 		: 실험실정보관리시스템
	 * 업무명 		: 검체위치관리
	 * 파일명 		: samplePositionL01.jsp
	 * 작성자 		: 허태원
	 * 작성일 		: 2020.05.19
	 * 설  명		: 
	 *---------------------------------------------------------------------------------------
	 * 변경일			변경자		변경내역 
	 *---------------------------------------------------------------------------------------
	 * 2020.05.19	허태원		최초 프로그램 작성         
	 * 
	 *---------------------------------------------------------------------------------------
	 ****************************************************************************************/
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" media="screen" type="text/css" href="<c:url value='/css/common/sub.css'/>" />
<!DOCTYPE html>
<style>
</style>
<script type="text/javascript" src="<c:url value='/script/resultInputCommon.js'/>"></script>
<script type="text/javascript">
	$(function() {
		/* 세부권한검사 */
		fn_auth_check();
		
		sampleGrid('analysis/selectSamplePositionSampleList.lims', 'positionForm', 'sampleGrid');
		historyGrid('analysis/selectSamplePositionHistoryList.lims', 'positionSubForm', 'historyGrid');
		$('#sampleGrid').clearGridData(); // 최초 조회시 데이터 안나옴
		$('#historyGrid').clearGridData(); // 최초 조회시 데이터 안나옴
		
		$(window).bind('resize', function() {
			$("#sampleGrid").setGridWidth($('#view_grid_main').width(), false);
		}).trigger('resize');
		$(window).bind('resize', function() {
			$("#historyGrid").setGridWidth($('#view_grid_sub').width(), false);
		}).trigger('resize');
		
		fn_Enter_Search('positionForm', 'sampleGrid');
	});

	// 검체 리스트
	function sampleGrid(url, form, grid) {
		$('#' + grid).jqGrid({
			datatype : function(json) {
				fnGridData(url, form, grid);
			},
			height : '230',
			loadonce : true,
			mtype : "POST",
			gridview : true,
			rowNum : -1,
			rownumbers : true,
			colModel : [ {
				type : 'not',
				label : '<input type="checkbox" id="chk" onclick="fn_chk(\'' + grid + '\' , \'' + form + '\');" />',
				name : 'chk',
				width : '40',
				sortable : false,
				align : 'center',
				formatter : "checkbox",
				formatoptions : {
					disabled : false
				}
			}, {
				label : 'test_sample_seq',
				name : 'test_sample_seq',
				hidden : true,
				key: true
			}, {
				label : 'test_req_seq',
				name : 'test_req_seq',
				hidden : true
			}, {
				label : '검체상태',
				name : 'disuse_flag',
				width : '100',
				align : 'center'
			}, {
				label : '검체명',
				width : '150',
				name : 'sample_reg_nm',
				align : 'center'
			}, {
				type : 'not',
				label : '품목명',
				name : 'prdlst_nm',
				classes : 'prdlst_nm',
				width : '150',
				editoptions : {
					readonly : "readonly"
				},
				align : 'center'
			}, {
				label : '스탠다드명',
				width : '150',
				name : 'sm_name',
				editoptions : {
					readonly : "readonly"
				},
				align : 'center'
			}, {
				label : '전처리비용',
				name : 'pre_cost',
				formatter : 'integer',
				formatoptions : {
					thousandsSeparator : ','
				},
				width : '100',
				align : 'right'
			}, {
				label : '검체수수료',
				name : 'sample_fee',
				formatter : 'integer',
				formatoptions : {
					thousandsSeparator : ','
				},
				width : '100',
				align : 'right'
			}, {
				label : '생산/수입일',
				width : '100',
				name : 'produce_date'
			}, {
				label : '수입ㆍ제조번호',
				width : '100',
				name : 'produce_no',
				align : 'center'
			},  {
				label : '제조사/생산자',
				width : '100',
				name : 'producer_nm',
				align : 'center'
			}, {
				label : '제조국/생산지',
				width : '100',
				name : 'produce_place',
				align : 'center'
			}, {
				label : '공급자',
				width : '100',
				name : 'supplier',
				align : 'center'
			}, {
				label : '목재제품 용도',
				width : '150',
				name : 'sample_etc_nm',
				align : 'center'
			}, {
				label : '유통기한',
				width : '100',
				name : 'expiry_date',
				align : 'center'
			}, {
				label : '생산량/수입량',
				width : '150',
				name : 'sample_weight',
				align : 'center'
			}, {
				label : '보관방법',
				width : '150',
				name : 'keep_method',
				align : 'center'
			}, {
				label : '발주자',
				width : '100',
				name : 'orderer_nm',
				align : 'center'
			}, {
				label : '시공자',
				width : '100',
				name : 'builder_nm',
				align : 'center'
			}, {
				label : '입회자',
				width : '100',
				name : 'joiner_nm',
				align : 'center'
			}, {
				label : '비고',
				width : '400',
				name : 'etc_desc',
				edittype:"textarea",
				editoptions:{rows:"2",cols:"55"}
			}],
			gridComplete : function() {
				$("#test_std_no").attr("disabled", "disabled");
			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
				if (!confirm('저장하지 않은 정보는 사라집니다. 정렬하시겠습니까?')) {
					return 'stop';
				}
			},
			onSelectRow : function(rowId, status, e) {
				var row = $('#'+grid).getRowData(rowId);
				$('#positionSubForm').find('#test_req_seq').val(row.test_req_seq);
				$('#positionSubForm').find('#test_sample_seq').val(row.test_sample_seq);
				$('#historyGrid').trigger('reloadGrid');
			}
		});
	}
	
	// 검체 리스트
	function historyGrid(url, form, grid) {
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
				label : 'test_sample_seq',
				name : 'test_sample_seq',
				hidden : true
			}, {
				label : 'test_req_seq',
				name : 'test_req_seq',
				hidden : true
			}, {
				label : 'seqno',
				name : 'seqno',
				hidden : true,
				key: true
			}, {
				label : '위치',
				name : 'position_desc',
				width : '100',
			}, {
				label : '등록자',
				name : 'creater_id',
				width : '50',
				align : 'center'
			}, {
				label : '등록일',
				name : 'create_date',
				width : '150',
				align : 'center'
			}, {
				label : '등록IP',
				name : 'create_ip',
				width : '150',
				align : 'center'
			}, {
				label : '수정자',
				name : 'updater_id',
				width : '50',
				align : 'center'
			}, {
				label : '수정일',
				name : 'update_date',
				width : '150',
				align : 'center'
			}, {
				label : '수정IP',
				name : 'update_ip',
				width : '150',
				align : 'center'
			}, {
				label : '특이사항',
				name : 'etc_desc',
				edittype:"textarea",
				editoptions:{rows:"2",cols:"55"}
			} ],
			gridComplete : function() {
				$("#test_std_no").attr("disabled", "disabled");
			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
				if (!confirm('저장하지 않은 정보는 사라집니다. 정렬하시겠습니까?')) {
					return 'stop';
				}
			},
			onSelectRow : function(rowId, status, e) {
				var row = $('#'+grid).getRowData(rowId);
				console.log(row)
				$('#positionSubForm').find('#seqno').val(row.seqno);
				$('#position_desc').val(row.position_desc);
				$('#etc_desc').val(row.etc_desc);
			}
		});
	}

	// 조회 이벤트
	function btn_Select_onclick() {
		$('#sampleGrid').trigger('reloadGrid');
		$('#historyGrid').clearGridData();
	}

	function btn_Insert_onclick() {
		if (!confirm('등록하시겠습니까?')) {
			return;
		}
		
		if($('#positionSubForm').find('#position_desc').val() == ''){
			alert('위치를 입려하여주세요.');
			$('#positionSubForm').find('#position_desc').focus();
			return;
		}
		
		var grid = 'sampleGrid';

		var ids = $('#' + grid).jqGrid("getDataIDs");
		var c = 0;
		var arrTestReqSeq = new Array();
		var arrTestSampleSeq = new Array();
		
		for ( var i in ids) {
			var row = $('#' + grid).getRowData(ids[i]);
			if (row.chk == 'Yes') {
				arrTestReqSeq.push(row.test_req_seq);
				arrTestSampleSeq.push(row.test_sample_seq);
				c++;
			}
		}
		
		if (c == 0) {
			alert('선택된 검체가 없습니다.');
		} else {
			for(var i=0; i<c; i++){
				var data = '';
				data += 'test_req_seq='+arrTestReqSeq[i];
				data += '&test_sample_seq='+arrTestSampleSeq[i];
				data += '&position_desc='+$('#positionSubForm').find('#position_desc').val();
				data += '&etc_desc='+$('#positionSubForm').find('#etc_desc').val();
				var json = fnAjaxAction('analysis/insertSamplePosition.lims', data);	
			}
			
			if (json == null) {
				alert('error');
			} else {
				alert('선택된 검체가 저장이 완료되었습니다.');
				btn_Select_onclick();
				$('#positionSubForm').find('#position_desc').val('');
				$('#positionSubForm').find('#etc_desc').val('');
			}
			
		}
	}
	
	function btn_Modify_onclick() {
		if (!confirm('수정하시겠습니까?')) {
			return;
		}
		
		var rowId = $('#historyGrid').getGridParam('selrow');		
		
		if (rowId == '') {
			alert('선택된 검체가 없습니다.');
		} else {
			var data = $('#positionSubForm').serialize();
			var json = fnAjaxAction('analysis/updateSamplePosition.lims', data); 
			
			if (json == null) {
				alert('error');
			} else {
				alert('선택된 검체가 저장이 완료되었습니다.');
				$('#historyGrid').trigger('reloadGrid');
				$('#positionSubForm').find('#position_desc').val('');
				$('#positionSubForm').find('#etc_desc').val('');
			}
		}
	}
	
</script>

<div class="sub_purple_01">
<form id="positionForm" name="positionForm" onsubmit="return false;">
	<div class="sub_purple_01 w100p">
		<table width="100%" border="0" class="select_table">
			<tr>
				<td width="20%" class="table_title">
					<span>■</span>
					검체정보
				</td>
				<td class="table_button" style="text-align: right; padding-right: 30px;">
					<span class="button white mlargeb auth_select" id="btn_Select" onclick="btn_Select_onclick();">
						<button type="button">조회</button>
					</span>
				</td>
			</tr>
		</table>
	</div>
	<div>
		<table width="100%" border="0" class="list_table" >
			<tr>
				<th>접수번호</th>
				<td>
					<input name="test_req_no" type="text" class="w100px" />
				</td>
			</tr>
		</table>
	</div>
	<input type="hidden" id="sortName" name="sortName">
	<input type="hidden" id="sortType" name="sortType">
	<div id="view_grid_main">
		<table id="sampleGrid"></table>
	</div>
</form>
<form id="positionSubForm" name="positionSubForm" onsubmit="return false;">
	<div class="sub_purple_01 w100p">
		<table width="100%" border="0" class="select_table">
			<tr>
				<td width="20%" class="table_title">
					<span>■</span>
					검체정보
				</td>
				<td class="table_button" style="text-align: right; padding-right: 30px;">
					<span class="button white mlargeb auth_select" onclick="btn_Insert_onclick();">
						<button type="button">등록</button>
					</span>
					<span class="button white mlargeb auth_select" onclick="btn_Modify_onclick();">
						<button type="button">수정</button>
					</span>
				</td>
			</tr>
		</table>
	</div>
	<div>
		<table width="100%" border="0" class="list_table" >
			<tr>
				<th class="indispensable">위치</th>
				<td>
					<input name="position_desc" id="position_desc" type="text" style="width: 30%" />
				</td>
			</tr>
			<tr>
				<th>특이사항</th>
				<td>
					<input name="etc_desc" id="etc_desc" type="text" style="width: 99%" />
				</td>
			</tr>
		</table>
	</div>
	<input type="hidden" id="sortName" name="sortName">
	<input type="hidden" id="sortType" name="sortType">
	<input type="hidden" id="test_req_seq" name="test_req_seq">
	<input type="hidden" id="test_sample_seq" name="test_sample_seq">
	<input type="hidden" id="seqno" name="seqno">
	<div id="view_grid_sub">
		<table id="historyGrid"></table>
	</div>
</form>
</div>
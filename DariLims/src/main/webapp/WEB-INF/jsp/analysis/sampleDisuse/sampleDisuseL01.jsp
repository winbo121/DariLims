
<%
	/***************************************************************************************
	 * 시스템명 	: 통합장비관제시스템
	 * 업무명 		: 시료폐기관리
	 * 파일명 		: sampleDisuseL01.jsp
	 * 작성자 		: 정우용
	 * 작성일 		: 2015.03.05
	 * 설  명		: 
	 *---------------------------------------------------------------------------------------
	 * 변경일			변경자		변경내역 
	 *---------------------------------------------------------------------------------------
	 * 2015.03.05    	정우용		최초 프로그램 작성         
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
	var disuse_flag;

	$(function() {
		/* 세부권한검사 */
		fn_auth_check();
		
		
		fnDatePickerImg('startDate');
		fnDatePickerImg('endDate');
		
		fnDatePickerImg('disuse_date');


		ajaxComboForm("req_type", "C23", "ALL", "EX1", "disuseForm");
		ajaxComboForm("dept_cd", "", '${session.dept_cd}', null, 'disuseForm');
		ajaxComboForm("disuse_flag", "C52", "ALL", "", "disuseForm");
		
		
		ajaxComboForm("disuse_flag", "C52", "NON", "", "disuseDetailForm");
		$('#disuseDetailForm').find('#disuse_flag option[value=C52003]').remove();
		$('#disuseDetailForm').find('#disuse_flag option[value=C52004]').remove();

		disuse_flag = fnGridCommonCombo('C52', '');
		
		disuseGrid('analysis/selectSampleDisuseList.lims', 'disuseForm', 'disuseGrid');
		$('#disuseGrid').clearGridData(); // 최초 조회시 데이터 안나옴
		
		$(window).bind('resize', function() {
			$("#disuseGrid").setGridWidth($('#sampleDiv').width(), true);
		}).trigger('resize');

		fn_Enter_Search('disuseForm', 'disuseGrid');
		
 		fn_show_type('disuseDetailForm', "N");
		
 		$('#disuseDetailForm').find('#disuse_flag1').change(function() {
 			
 			fn_show_type('disuseDetailForm', $(this).val());
		});
		
	});

	function disuseGrid(url, form, grid) {
		var lastRowId;
		$('#' + grid).jqGrid({
			datatype : function(json) {
				fnGridData(url, form, grid);
			},
			height : '245px',
			autowidth : true,
			loadonce : true,
			mtype : "POST",
			gridview : true,
			shrinkToFit : false,
			rowNum : -1,
			rownumbers : true,
			colModel : [{
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
				type : 'not',
				label : ' ',
				name : 'icon',
				width : '20',
				sortable : false,
				align : 'center'
			}, {
				label : 'crud',
				name : 'crud',
				hidden : true
			}, {
				label : 'test_req_seq',
				name : 'test_req_seq',
				hidden : true
			}, {
				type : 'not',
				label : '접수번호',
				name : 'test_req_no',
				width : '150',
				align : 'center'
			}, {
				type : 'not',
				label : '의뢰구분',
				name : 'req_type',
				width : '70',
				align : 'center'
			}, {
				type : 'not',
				label : '접수부서',
				name : 'dept_nm',
				width : '100'
			}, {
				label : '시료번호',
				name : 'test_sample_seq',
				width : '100',
				align : 'center',
				key : true
			}, {
				type : 'not',
				label : '시료명',
				name : 'sample_reg_nm',
				width : '200'
			}, {
				type : 'not',
				label : '접수일자',
				name : 'sample_arrival_date',
				width : '100',
				align : 'center'
			}, {
				type : 'not',
				label : '성적서 발행예정일',
				name : 'deadline_date',
				width : '100',
				align : 'center'
			}, {
				label : '시료관리구분',
				name : 'disuse_flag',
				width : '100',
				align : 'center',
				edittype : "select",
				editoptions : {
					value : 'C52001:반환;C52002:폐기;C52003:폐기요청;C52004:반환요청'
				},
				formatter : 'select'
			}, {
				label : '폐기/반납 일자',
				name : 'disuse_date',
				width : '120',
				align : 'center',
				editable : true,
				editoptions : {
					dataInit : function(elem) {
						fnDatePicker(elem.getAttribute('id'));
					},
					readonly : "readonly"
				},
				align : 'center'
			}, {
				label : '폐기/반납자',
				name : 'sender_nm',
				width : '100',
				align : 'center'
			}, {
				type : 'not',
				label : ' ',
				name : 'userInfo_pop',
				sortable : true,
				width : '20',
				align : 'center',
				formatter : imageFormat
			}, {
				label : '수신자',
				name : 'recipient_nm',
				width : '100',
				align : 'center'
			}, {
				label : '폐기/반납자 id',
				name : 'sender_id',
				width : '100',
				align : 'center',
				hidden : true
			}, {
				label : '수신자 id',
				name : 'recipient_id',
				width : '100',
				align : 'center',
				hidden : true
			}, {
				label : '폐기/반납내용',
				name : 'etc',
				width : '100',
				align : 'center'
			}, {
				type : 'not',
				label : '의뢰업체명',
				name : 'req_org_nm'
			}, {
				type : 'not',
				label : '의뢰자',
				name : 'req_nm',
				width : '100',
			} ],
			gridComplete : function() {
			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
			},
			onCellSelect : function(rowId, iCol, cellcontent, e) {
				var colArr = $('#' + grid).jqGrid('getGridParam', 'colModel');
				var col = colArr[iCol].name;
				var row = $('#' + grid).getRowData(rowId);
				if(col == 'userInfo_pop'){
					fnpop_UserInfo1("K",rowId);
				}
			},
			onSelectRow : function(rowId, status, e) {
			/*
			if($("#disuseGrid").jqGrid('getCell',rowId,'disuse_flag') == 'C52001'){
				fn_show_type('disuseDetailForm' , 'C52001')
				$("#disuse_flag1 option[value='C52001']").prop("selected", true);
			}
			else if($("#disuseGrid").jqGrid('getCell',rowId,'disuse_flag') == 'C52002'){
				fn_show_type('disuseDetailForm' , 'C52002')
				$("#disuse_flag1 option[value='C52002']").prop("selected", true);
			}
			else if($("#disuseGrid").jqGrid('getCell',rowId,'disuse_flag') == 'C52003'){
				fn_show_type('disuseDetailForm' , 'C52003')
				$("#disuse_flag1 option[value='C52003']").prop("selected", true);
			}
			else if($("#disuseGrid").jqGrid('getCell',rowId,'disuse_flag') == 'C52004'){
				fn_show_type('disuseDetailForm' , 'C52004')
				$("#disuse_flag1 option[value='C52004']").prop("selected", true);
			}
			$('#sender_id').val($("#disuseGrid").jqGrid('getCell',rowId,'sender_id'));
			$('#sender_nm').val($("#disuseGrid").jqGrid('getCell',rowId,'sender_nm'));
			$('#disuse_date').val($("#disuseGrid").jqGrid('getCell',rowId,'disuse_date'));
			$('#recipient_id').val($("#disuseGrid").jqGrid('getCell',rowId,'recipient_id'));
			$('#recipient_nm').val($("#disuseGrid").jqGrid('getCell',rowId,'recipient_nm'));
			$('#etc').val($("#disuseGrid").jqGrid('getCell',rowId,'etc'));
			*/
			},
			ondblClickRow : function(rowId, iRow, iCol, e) {
				fnEditRelease(grid);
				stateGridEdit(grid, rowId);	
				
			}
		});
	}
	
	function stateGridEdit(grid, rowId) {
		var row = $('#' + grid).getRowData(rowId);
		if (row.crud != 'n') {
			$('#' + grid).setCell(rowId, 'icon', gridU);
			$('#' + grid).setCell(rowId, 'crud', 'u');
		}
		editable('');
	}
	
	function editable(e) {
		var grid = 'disuseGrid';
		var rowId = $('#' + grid).jqGrid('getGridParam', 'selrow');
		var arr = new Array();
		// 결과값형태
		var row = $("#" + grid).jqGrid('getRowData', rowId);
		arr.push('recipient_nm');
		arr.push('etc');
		arr.push('disuse_flag');
		arr.push('disuse_date');
		for ( var column in row) {
			if ($.inArray(column, arr) !== -1) {
				$("#" + grid).jqGrid('setColProp', column, {
					editable : true
				});
			} else {
				$("#" + grid).jqGrid('setColProp', column, {
					editable : false
				});
			}
		}
		if (e != '') {
			for ( var column in row)
				if (column != 'test_item_nm' && column != 'test_item_cd' && column != 'crud' && column != 'icon')
					$("#" + grid).jqGrid('setCell', rowId, column, null);
		}
		$("#" + grid).jqGrid('editRow', rowId);
		// selectbox 막음
		$("#testStdDiv select").attr("disabled", "disabled");
	}
	

	// 조회 이벤트
	function btn_Select_onclick() {
		$("#disuseDetailForm")[0].reset();
		$('#disuseGrid').trigger('reloadGrid');
	}

	// 의뢰정보 팝업
	function fnpop_reqInfo() { //btn_pop_req_info
		var rowId = $('#disuseGrid').getGridParam('selrow');
		if (rowId == null) {
			alert('시료를 선택해주세요.');
		} else {
			var row = $('#disuseGrid').getRowData(rowId);
			fnBasicStartLoading();
			fnpop_reqInfoPop("disuseGrid", "900" , "660" , rowId, row.test_req_seq, true);
		}
	}
	
	
	function btn_Save_onclick() {
		var grid = 'disuseGrid';
		fnEditRelease(grid);
			
		var ids = $('#' + grid).jqGrid("getDataIDs");
		var c = 0;
		var id = $('#disuseDetailForm').find('#seq').val();
		
		for ( var i in ids) {
			var row = $('#' + grid).getRowData(ids[i]);
			
			if (row.chk == 'Yes') {
				c++;
			}
		}
		
		if (c == 0) {
			alert('선택된 항목이 없습니다.');
		} else {

			var data = fnGetGridCheckData(grid);
			
			var json = fnAjaxAction('analysis/updateSampleDisuse.lims', data); 
			
			if (json == null) {
				alert('error');
			} else {
				alert('선택된 시료의 저장이 완료되었습니다.');
				ajaxComboForm("disuse_flag", "C52", "ALL", "", "disuseForm");
				$('#disuseGrid').trigger('reloadGrid');
			}
			
		}
	}
	
	// 콜백
	function fnpop_usercallback(){		
		fnBasicEndLoading();
	}
	function fnpop_usercallback1(rowId,user_id,user_nm){
		$('#disuseGrid').jqGrid('setCell', rowId, 'sender_id', user_id);
		$('#disuseGrid').jqGrid('setCell', rowId, 'sender_nm', user_nm);
		fnBasicEndLoading();
	}
	
	// 폐기 / 반납
	function fn_show_type(form, flag) {
		$('#sender_id').val('');
		$('#sender_nm').val('');
		$('#recipient_nm').val('');
		$('#etc').val('');
		
		if (flag == 'C52002' || flag == 'C52003'){ // 폐기
			$('#date_d').text('폐기일자');
			$('#s_d').text('폐기자');
			$('#s_d2').attr("colspan", 3);
			$('#etc_d').text('폐기내용');			
			$('#' + form).find("#r_d").hide();
			$('#' + form).find("#r_d2").hide();
		} 
		else {
			if(flag == 'C52001'){
				$('#sender_id').val('jyj');
 				$('#sender_nm').val('정지연');
			}	
			$('#date_d').text('반납일자');
			$('#s_d').text('반납자');
			$('#r_d').text('수신자');
			$('#s_d2').attr("colspan", 1);
			$('#etc_d').text('반납내용');
			$('#' + form).find("#r_d").show();
			$('#' + form).find("#r_d2").show();
		}
	}
	
	// 엑셀 다운로드
	function btn_Excel_onclick() {
		var data = fn_Excel_Data_Make('disuseGrid');
		fn_Excel_Download(data);
	}
	
	// 사용자 추가 팝업
	function fnpop_UserInfo(user){		
		fnBasicStartLoading();		
		fnpop_UserInfoPop("disuseDetailForm", "500", "500", user, '');

	}
	function fnpop_UserInfo1(user,rowId){		
		fnBasicStartLoading();		
		fnpop_UserInfoPop("disuseDetailForm", "500", "500", user, rowId);

	}
	
	//일괄입력
	function btn_insertDisuse_onclick() {
		var grid = 'disuseGrid';
		var ids = $('#' + grid).jqGrid("getDataIDs");
		var rowCnt = 0;
		var flagDate = "";
		var flagUser = "";

		for ( var i in ids) {
			var row = $('#' + grid).getRowData(ids[i]);
			if (row.chk == 'Yes') {
				rowCnt++;
			}
		}

		if (rowCnt == 0) {
			alert("선택된 항목이 없습니다.");
			return;
		} else {
			var disuse_date = $('#disuseDetailForm').find('#disuse_date').val();
			var recipient_id = $('#disuseDetailForm').find('#recipient_id').val();
			var sender_id = $('#disuseDetailForm').find('#sender_id').val();
			var recipient_nm = $('#disuseDetailForm').find('#recipient_nm').val();
			var sender_nm = $('#disuseDetailForm').find('#sender_nm').val();
			var etc = $('#disuseDetailForm').find('#etc').val();
			var disuse_flag = $('#disuseDetailForm').find('#disuse_flag1').val();
			
			if(recipient_nm==''){
				recipient_nm=null
			}
			if(etc==''){
				etc=null
			}			
			if(disuse_flag == "C52001"){
				flagDate = "반납일자";
				flagUser = "반납자";
			}else{
				flagDate = "폐기일자";
				flagUser = "폐기자";
			}
			
			if (disuse_date == null || sender_id == "") {
				alert(flagDate+"를 입력해주세요.");
 				$('#disuseDetailForm').find('#disuse_date').focus(); 
 				return;
			}
			
			if (sender_id == null || disuse_date == "") {
				alert(flagUser+"를 입력해주세요.");
 				$('#disuseDetailForm').find('#sender_id').focus(); 
 				return;
			}
			var nids = $('#' + grid).jqGrid("getDataIDs");
			for ( var j in nids) {
				var nrow = $('#' + grid).getRowData(nids[j]);
				if (nrow.chk == 'Yes') {
					$('#' + grid).jqGrid('setCell', ids[j], 'disuse_date', disuse_date);
					$('#' + grid).jqGrid('setCell', ids[j], 'recipient_id', recipient_id);
					$('#' + grid).jqGrid('setCell', ids[j], 'sender_id', sender_id);
					$('#' + grid).jqGrid('setCell', ids[j], 'recipient_nm', recipient_nm);
					$('#' + grid).jqGrid('setCell', ids[j], 'sender_nm', sender_nm);
					$('#' + grid).jqGrid('setCell', ids[j], 'etc', etc);
					$('#' + grid).jqGrid('setCell', ids[j], 'disuse_flag', disuse_flag);
					$('#' + grid).jqGrid('setCell', ids[j], 'icon', gridU);
					$('#' + grid).jqGrid('setCell', ids[j], 'crud', 'u');
				}
			}
		}
	}
	
	//일괄입력(보관)
	function btn_Reset_onclick() {
		var grid = 'disuseGrid';
		var ids = $('#' + grid).jqGrid("getDataIDs");
		var rowCnt = 0;
	
		for ( var i in ids) {
			var row = $('#' + grid).getRowData(ids[i]);
			if (row.chk == 'Yes') {
				rowCnt++;
			}
		}

		if (rowCnt == 0) {
			alert("선택된 항목이 없습니다.");
			return;
		} else {
			var disuse_flag = $('#disuseDetailForm').find('#disuse_flag').val();
			fn_show_type('disuseDetailForm' , 'C52001')
			$("#disuse_flag1 option[value='C52001']").prop("selected", true);
			$('#sender_id').val('jyj');
			$('#sender_nm').val('정지연');
			$('#disuse_date').val('');
			$('#recipient_id').val('');
			$('#recipient_nm').val('');
			$('#etc').val('');
			var nids = $('#' + grid).jqGrid("getDataIDs");
			for ( var j in nids) {
				var nrow = $('#' + grid).getRowData(nids[j]);
				if (nrow.chk == 'Yes') {
					$('#' + grid).jqGrid('setCell', ids[j], 'disuse_date', null);
					$('#' + grid).jqGrid('setCell', ids[j], 'recipient_id', null);
					$('#' + grid).jqGrid('setCell', ids[j], 'sender_id', null);
					$('#' + grid).jqGrid('setCell', ids[j], 'recipient_nm', null);
					$('#' + grid).jqGrid('setCell', ids[j], 'sender_nm', null);
					$('#' + grid).jqGrid('setCell', ids[j], 'etc', null);
					$('#' + grid).jqGrid('setCell', ids[j], 'disuse_flag', 'C52001');
					$('#' + grid).jqGrid('setCell', ids[j], 'icon', gridU);
					$('#' + grid).jqGrid('setCell', ids[j], 'crud', 'u');
				}
			}
		}
	}
	
</script>

<div id="sampleDiv">
	<form id="disuseForm" name="disuseForm" onsubmit="return false;">
		<div class="sub_purple_01 w100p">
			<table width="100%" border="0" class="select_table">
				<tr>
					<td width="20%" class="table_title">
						<span>■</span>
						시료정보
					</td>
					<td class="table_button" style="text-align: right; padding-right: 30px;">
						<span class="button white mlargeb auth_select" id="reqViewBtn" onclick="fnpop_reqInfo();">
							<button type="button">의뢰정보</button>
						</span>
						<span class="button white mlargeb auth_select" onclick="btn_Excel_onclick();">
							<button type="button">EXCEL</button>
						</span>
						<span class="button white mlargeb auth_select" id="btn_Select" onclick="btn_Select_onclick();">
							<button type="button">조회</button>
						</span>
						<span class="button white mlargeg auth_select" id="btn_Select" onclick="btn_Save_onclick();">
							<button type="button">저장</button>
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
					<th>의뢰구분</th>
					<td>
						<select name="req_type" id="req_type" class="w100px"></select>
					</td>
					<th>의뢰자</th>
					<td>
						<input name="req_nm" type="text" class="inputhan w100px" />
					</td>
					<th>접수부서</th>
					<td>
						<select name="dept_cd" id="dept_cd" class="w200px"></select>
					</td>
				</tr>
				<tr>
					<th>시료번호</th>
					<td>
						<input name="test_sample_seq" type="text" class="w100px" />
					</td>
					<th>시료명</th>
					<td>
						<input name="sample_reg_nm" type="text" class="inputhan w100px" />
					</td>
					<th>접수일자</th>
					<td nowrap="nowrap">
						<input name="startDate" id="startDate" type="text" class="w80px" readonly="readonly" />
						<img src="<c:url value='/images/common/calendar_del.png'/>" id="startDateStop" style="cursor: pointer;" onClick='fn_TextClear("startDate")' /> ~
						<input name="endDate" id="endDate" type="text" class="w80px" readonly="readonly" />
						<img src="<c:url value='/images/common/calendar_del.png'/>" id="endDateStop" style="cursor: pointer;" onClick='fn_TextClear("endDate")' />
					</td>
					<th>시료관리구분</th>
					<td>
						<select id="disuse_flag" name="disuse_flag" class="w100px"></select>
					</td>
				</tr>
				<tr>
					<th>의뢰업체</th>
					<td colspan="7">
						<input name="req_org_nm" type="text" class="w100px" />
					</td>
				</tr>
			</table>
		</div>
		<input type="hidden" id="sortName" name="sortName">
		<input type="hidden" id="sortType" name="sortType">
		<div id="view_grid_main">
			<table id="disuseGrid"></table>
		</div>
	</form>
</div>
<div class="sub_blue_01">
	<form id="disuseDetailForm" name="disuseDetailForm" onsubmit="return false;">
	<table  class="select_table" >
		<tr>
			<td width="20%" class="table_title">
				<span>■</span>
				상세정보
			</td>
			<td class="table_button">
				<span class="button white mlargeg auth_save" id="btn_Insert" onclick="btn_insertDisuse_onclick();">
					<button type="button">일괄입력</button>
				</span>
			</td>
		</tr>
	</table>
	<input type="hidden" id="test_sample_seq" name="test_sample_seq">
	<input type="hidden" name="test_sample_seq" id="seq" value="${detail.test_sample_seq}"/>
	<table  class="list_table">
		<tr>
			<th>폐기/반납</th>
			<td>
				 <select id='disuse_flag1' name="disuse_flag1" style="width: 100px">
    				<option value="" selected="selected">선택</option>
    				<option value="C52001">반환</option>
    				<option value="C52002">폐기</option>
    				<option value="C52003">폐기요청</option>
    				<option value="C52004">반환요청</option>
  				</select>
			</td>
			<th class="indispensable" id="date_d">일자</th>
			<td>
				<input name="disuse_date" id="disuse_date" type="text" class="w80px inputCheck" value="${detail.disuse_date}" />
				<img src="<c:url value='/images/common/calendar_del.png'/>" id="dateDel" style="cursor: pointer;" onClick='fn_TextClear("disuse_date")' />
			</td>
		</tr>
		<tr>
			<th class="indispensable" id="s_d">반납자</th>
			<td id="s_d2">
				<input name="sender_id" id="sender_id" type="hidden" value="${detail.sender_id}" style="width:120px;"/>
				<input name="sender_nm" id="sender_nm" type="text" value="${detail.sender_nm}" style="width:120px;"/>
				<img style="vertical-align: text-bottom;" src="images/common/icon_search.png" class="auth_select" id="" onclick='fnpop_UserInfo("S");'/>				
				
			</td>
			<th id="r_d">수신자</th>
			<td id="r_d2">
				<input name="recipient_id" id="recipient_id" type="hidden" value="${detail.recipient_id}" style="width:120px;"/>
				<input name="recipient_nm" id="recipient_nm" type="text" value="${detail.recipient_nm}" style="width:120px;"/>
				
			</td>
		</tr>		
		<tr>
			<th id="etc_d">내용</th>
			<td colspan="3">
				<textarea rows="3" name="etc" id="etc" class="w100p">${detail.etc}</textarea>
			</td>
		</tr>			
	</table>
	</form>
	
</div>
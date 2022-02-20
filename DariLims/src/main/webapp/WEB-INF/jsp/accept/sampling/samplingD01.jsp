
<%
	/***************************************************************************************
	 * 업무명 		: 시료채취 상세
	 * 파일명 		: samplingD01.jsp
	 * 작성자 		: 허태원
	 * 작성일 		: 2019.12.03
	 * 설  명		: 
	 *---------------------------------------------------------------------------------------
	 * 변경일		 변경자		변경내역 
	 *---------------------------------------------------------------------------------------
	 * 2019.12.03   허태원		최초 프로그램 작성         
	 * 
	 *---------------------------------------------------------------------------------------
	 ****************************************************************************************/
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html >
<link rel="stylesheet" media="screen" type="text/css" href="<c:url value='/css/common/sub.css'/>" />
<script type="text/javascript">
$(function() {
	fnDatePickerImg('pick_dt');
	
	ajaxComboForm("pick_purps", "C73", "", "ALLNAME", 'detail');
	ajaxComboForm("pick_place", "C74", "", "ALLNAME", 'detail'); // 시료채취 장소1
	ajaxComboForm("rawmtrl_gbn", "C87", "", "ALLNAME", 'detail');
	ajaxComboForm("pick_utnsil_unit", "C93", "", "ALLNAME", 'detail');
	ajaxComboForm("pick_place_method", "C94", "", "ALLNAME", 'detail'); //시료채취 장소2
	ajaxComboForm("mesure_utnsil_nm", "C95", "", "ALLNAME", 'detail');  //측정기구 명
	ajaxComboForm("mesure_scope", "C96", "", "ALLNAME", 'detail'); // 측정범위
	
	
	leftGrid('accept/selectSamplingLtList.lims', 'detail', 'leftGrid');
	$('#leftGrid').clearGridData(); // 최초 조회시 데이터 안나옴
	
	rightGrid('accept/selectSamplingMesureList.lims', 'detail', 'rightGrid');
	$('#rightGrid').clearGridData(); // 최초 조회시 데이터 안나옴
	
	$(window).bind('resize', function() {
		$("#leftGrid").setGridWidth($('#detail').width(), false);
	}).trigger('resize');
	
	$(window).bind('resize', function() {
		$("#rightGrid").setGridWidth($('#detail').width(), false);
	}).trigger('resize');
	
	$('#tabs').tabs({
		active : 0
	});
	
	$('#tabs').tabs({
		create : function(event, ui) {
			$(window).bind('resize', function() {
				$("#leftGrid").setGridWidth($('#view_grid_sub1').width(), false);
			}).trigger('resize');

			$(window).bind('resize', function() {
				$("#rightGrid").setGridWidth($('#view_grid_sub2').width(), false);
			}).trigger('resize');
		},
		activate : function(event, ui) {
			$(window).bind('resize', function() {
				$("#leftGrid").setGridWidth($('#view_grid_sub1').width(), false);
			}).trigger('resize');

			$(window).bind('resize', function() {
				$("#rightGrid").setGridWidth($('#view_grid_sub2').width(), false);
			}).trigger('resize');
		}
	});
	//저장된 값
	fnDetailData();
	
	//디폴트 값
	if($("#lt_co").val() == null || $("#lt_co").val() == '') {
		$("#lt_co").val('1'); //로트개수
	}
	if($("#increment_co").val() == null || $("#increment_co").val() == '') {
		$("#increment_co").val('24'); //1개 로트당 인크리먼트 개수
	}
	if($("#increment_pick_qy").val() == null || $("#increment_pick_qy").val() == '') {
		$("#increment_pick_qy").val('3'); // 1개 인크리먼트의 채취량
	}

	$('#leftGrid').trigger('reloadGrid');
	$('#rightGrid').trigger('reloadGrid');
	
	/* if("${detail.state }" != "A" && "${detail.state }" != "G" && "${detail.state }" != "H"){
		if("${detail.pick_no}" == ""){
			$("#btnRowAddLeft").hide();// 채취 로트 > 행추가
			$("#btnSaveLeft").hide(); //채취 로트> 저장
			$("#btnRowAddRight").hide();// 채취 측정 > 행추가
			$("#btnSaveRight").hide();//채취 측정> 저장 
			$("#btnRowDelLeft").hide();//채취 로트 > 행삭제
			$("#btnRowDelRight").hide();//채취 측정 > 행삭제
		}else{
			if("${detail.prduct_knd}" == "A"){
				$("#btnRowAddLeft").show();
				$("#btnRowAddRight").show();
				$("#btnSaveLeft").show();
				$("#btnSaveRight").show();
				$("#btnRowDelLeft").show();
				$("#btnRowDelRight").show();
			}else{
				$("#btnRowAddLeft").show();
				$("#btnRowAddRight").hide();
				$("#btnSaveLeft").show();
				$("#btnSaveRight").hide();
				$("#btnRowDelRight").hide();
			}
		}
	}else{
		$("#btnRowAddLeft").hide();
		$("#btnSaveLeft").hide();
		$("#btnRowAddRight").hide();
		$("#btnSaveRight").hide();
		$("#btnRowDelLeft").hide();
		$("#btnRowDelRight").hide();
		$("#btnSaveCenter").hide();		
		$("#btnSaveExtra").hide();
	} */
	
	if("${detail.prduct_knd}" == "A"){
		$("#btnRowInputLeft").show();
		$("#btnRowAddLeft").show();
		$("#btnRowInputRight").show();
		$("#btnRowAddRight").show();
		$("#btnSaveLeft").show();
		$("#btnSaveRight").show();
		$("#btnRowDelLeft").show();
		$("#btnRowDelRight").show();
	}else{
		$("#btnRowInputLeft").show();
		$("#btnRowAddLeft").show();
		$("#btnRowInputRight").hide();
		$("#btnRowAddRight").hide();
		$("#btnSaveLeft").show();
		$("#btnSaveRight").hide();
		$("#btnRowDelRight").hide();
	}	
	
});

function fnDetailData(){
	$("#bio_no").val("${detail.bio_no}");
	$("#pick_dt").val("${detail.pick_dt}");
	$("#pick_time").val("${detail.pick_time}");
	$("#pick_lc").val("${detail.pick_lc}");
	$("#pick_purps").val("${detail.pick_purps}");
	$("input:radio[name='prduct_knd']:radio[value='${detail.prduct_knd}']").prop('checked', true);
	$("#prduct_qy").val("${detail.prduct_qy}");
	$("#lt_mg").val("${detail.lt_mg}");
	$("#lt_co").val("${detail.lt_co}");
	$("#pick_dn").val("${detail.pick_dn}");
	$("#pick_place").val("${detail.pick_place}");
	$("#pick_place_method").val("${detail.pick_place_method}");
	$("#pick_utnsil_nm").val("${detail.pick_utnsil_nm}");
	$("#pick_utnsil_manp").val("${detail.pick_utnsil_manp}");
	$("#pick_utnsil_unit").val("${detail.pick_utnsil_unit}");
	$("#increment_pick_qy").val("${detail.increment_pick_qy}");
	$("#increment_co").val("${detail.increment_co}");
	$("#outage_mixtrsplore_dth").val("${detail.outage_mixtrsplore_dth}");
	$("#outage_mixtrsplore_dtm").val("${detail.outage_mixtrsplore_dtm}");
	$("#outage_mixtrsplore_qy").val("${detail.outage_mixtrsplore_qy}");
	$("#mesure_utnsil_nm").val("${detail.mesure_utnsil_nm}");
	$("#mesure_scope").val("${detail.mesure_scope}");
	/* $("#mesure_mth").val("${detail.mesure_mth}"); */
	
	if("${detail.prduct_knd}" == "B"){
// 		$("#mesure_atch_photo1_img").hide();
//		$("#mesure_atch_photo2_img").hide();
//		$("#mesure_atch_photo3_img").hide();
//		$("#mesure_atch_photo4_img").hide();
//		$("#mesure_atch_photo1_stop").hide();
//		$("#mesure_atch_photo2_stop").hide();
//		$("#mesure_atch_photo3_stop").hide();
//		$("#mesure_atch_photo4_stop").hide();
//		$("#mesure_atch_name1").hide();
//		$("#mesure_atch_name2").hide();
//		$("#mesure_atch_name3").hide();
//		$("#mesure_atch_name4").hide(); 
	}else{
		$("#mesure_atch_photo1_img").show();
		$("#mesure_atch_photo2_img").show();
		$("#mesure_atch_photo3_img").show();
		$("#mesure_atch_photo4_img").show();
		$("#mesure_atch_photo1_stop").show();
		$("#mesure_atch_photo2_stop").show();
		$("#mesure_atch_photo3_stop").show();
		$("#mesure_atch_photo4_stop").show();
		$("#mesure_atch_name1").show();
		$("#mesure_atch_name2").show();
		$("#mesure_atch_name3").show();
		$("#mesure_atch_name4").show();
	}
	
	$("input:radio[name='solid_gbn']:radio[value='${detail.solid_gbn}']").prop('checked', true);
	$("#rawmtrl_gbn").val("${detail.rawmtrl_gbn}");
	$("#width").val("${detail.width}");
	$("#vrticl").val("${detail.vrticl}");
	$("#sungsang1").val("${detail.sungsang1}");
	$("#sungsang2").val("${detail.sungsang2}");
	$("#sungsang3").val("${detail.sungsang3}");
	$("#sungsang4").val("${detail.sungsang4}");
	$("#sungsang5").val("${detail.sungsang5}");
	$("#sungsang6").val("${detail.sungsang6}");
	$("#sungsang0").val("${detail.sungsang0}");
	$("#sungsang_etc").val("${detail.sungsang_etc}");
}

function leftGrid(url, form, grid) {
	var lastRowId;
	$('#' + grid).jqGrid({
		datatype : function(json) {
			fnGridData(url, form, grid);
		},
		height : '250',
		autowidth : true,
		loadonce : true,
		mtype : "POST",
		gridview : true,
		rowNum : -1,
		rownumbers : true,
		sortname : 'pick_lt_no',
		sortorder : 'asc',
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
			label : 'pick_lt_no',
			name : 'pick_lt_no',
			hidden : true,
			key : true
		}, {
			label : 'pick_no',
			name : 'pick_no',
			hidden : true
		} , {
			label : '인크리먼트 번호',
			name : 'increment_no',			
			align : 'center',
			editable : true,
			editrules : {
// 				required : true
			}
		}, {
			label : '일시/시간(시)',
			name : 'lt_dt_h',
			editable : true,
			editrules : {
// 				required : true
			},
			align : 'center'
		}, {
			label : '일시/시간(분)',
			name : 'lt_dt_m',
			editable : true,
			editrules : {
// 				required : true
			},
			editoptions:{maxlength:"2"},
			align : 'center'
		}, {
			label : '채취량',
			name : 'lt_pick_qy',
			editable : true,
			editrules : {
// 				required : true,
				number : true
			},
			align : 'center'
		}],
		gridComplete : function() {
			fnSelectFirst(grid);
		},
		onSortCol : function(index, iCol, sortorder) {
			if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
		},
		onSelectRow : function(rowId, status, e) {
		},
		ondblClickRow : function(rowId, iRow, iCol, e) {
			fnGridEdit(grid, rowId, fn_Row_Click_sampling);
			$('#' + grid).jqGrid('editRow', rowId, true);
		}
	});
}

function rightGrid(url, form, grid) {
	$('#' + grid).jqGrid({
		datatype : function(json) {
			fnGridData(url, form, grid);
		},
		height : '250',
		autowidth : true,
		loadonce : true,
		mtype : "POST",
		gridview : true,
		rowNum : -1,
		rownumbers : true,
		sortname : 'pick_mesure_no',
		sortorder : 'asc',
		colModel : [ {
			label : 'pick_mesure_no',
			name : 'pick_mesure_no',
			hidden : true,
			key : true
		}, {
			label : 'pick_no',
			name : 'pick_no',
			hidden : true
		} , {
			label : '시료 번호',
			name : 'splore_no',
			align : 'center',
			editable : true,
			editrules : {
// 				required : true
			}
		}, {
			label : '측정 직경',
			name : 'mesure_dm',
			editable : true,
			editrules : {
// 				required : true,
				number : true
			},
			align : 'center'
		}, {
			label : '측정 길이',
			name : 'mesure_lt',
			editable : true,
			editrules : {
// 				required : true,
				number : true
			},
			align : 'center'
		}],
		gridComplete : function() {
		},
		onSortCol : function(index, iCol, sortorder) {
			if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
		},
		onSelectRow : function(rowId, status, e) {
		},
		ondblClickRow : function(rowId, iRow, iCol, e) {
			fnGridEdit(grid, rowId, fn_Row_Click_sampling);
			$('#' + grid).jqGrid('editRow', rowId, true);
			$("#btnRowAddRight").hide();
			$("#btnSaveRight").show();
		}
	});
}

function btnSave_onclick(){
	var test_req_seq = $('#test_req_seq').val();
	var pick_no = $('#pick_no').val();
	
	if (test_req_seq == '' || test_req_seq == null) {
		alert('의뢰를 선택하여 주세요.');
		return false;
	}
	
	if (confirm('저장하시겠습니까?')) {
		// 벨리데이션 체크
		if($('#pick_time').val() != ""){
			var timeFormat = /^([01][0-9]|2[0-3]):([0-5][0-9])$/; 
			if(!timeFormat.test($('#pick_time').val())){
				alert('시료채취의 시간은 [HH:MM] 형식으로 입력하시기 바랍니다.');
				$('#pick_time').val('');
				return false;
			}
		}
		
		if ($('#lt_co').val() != "" && !$.isNumeric($('#lt_co').val())) {
			alert('[로트 개수(개)]의 값은 숫자만 입력가능합니다.');
			$('#lt_co').val('');
			return false;
		}
		if ($('#pick_dn').val() != "" && !$.isNumeric($('#pick_dn').val())) {
			alert('[겉보기 밀도(kg/m³)]의 값은 숫자만 입력가능합니다.');
			$('#pick_dn').val('');
			return false;
		}
		if ($('#increment_co').val() != "" && !$.isNumeric($('#increment_co').val())) {
			alert('[1개 로트당 인크리먼트의 개수]의 값은 숫자만 입력가능합니다.');
			$('#increment_co').val('');
			return false;
		}
		if ($('#increment_pick_qy').val() != "" && !$.isNumeric($('#increment_pick_qy').val())) {
			alert('[1개 인크리먼트의 채취량(kg)]의 값은 숫자만 입력가능합니다.');
			$('#increment_pick_qy').val('');
			return false;
		}
		if ($('#outage_mixtrsplore_qy').val() != "" && !$.isNumeric($('#outage_mixtrsplore_qy').val())) {
			alert('[감량화된 시료량(kg)]의 값은 숫자만 입력가능합니다.');
			$('#outage_mixtrsplore_qy').val('');
			return false;
		}
		if(parseInt($('#increment_co').val()) > 24){
			alert('[1개 로트당 인크리먼트의 개수]의 값은 24개 이상을 입력할 수 없습니다.');
			$('#increment_co').val('');
			return false;
		}
		
		var outage_mixtrsplore_dt;
		
		if($("#outage_mixtrsplore_dth").val() == '' && $("#outage_mixtrsplore_dtm").val() == ''){
			outage_mixtrsplore_dt = '';
		}else if($("#outage_mixtrsplore_dth").val() != '' && $("#outage_mixtrsplore_dtm").val() == ''){
			alert('감량후 혼합시료의 분을 입력하여 주세요.');
			return false;
		}else if($("#outage_mixtrsplore_dth").val() == '' && $("#outage_mixtrsplore_dtm").val() != ''){
			alert('감량후 혼합시료의 시를 입력하여 주세요.');
			return false;
		}else{
			outage_mixtrsplore_dt = $("#outage_mixtrsplore_dth").val() + ":" + $("#outage_mixtrsplore_dtm").val();
		}
		$("#outage_mixtrsplore_dt").val(outage_mixtrsplore_dt);
			
		var img_chk = false;
		if($('#pick_place_photo_img').val() != ''){
			img_chk = true;
		}
		if($('#pick_utnsil_photo_img').val() != ''){
			img_chk = true;
		}
		if($('#lt_atch_photo1_img').val() != ''){
			img_chk = true;
		}
		if($('#lt_atch_photo2_img').val() != ''){
			img_chk = true;
		}
		if($('#lt_atch_photo3_img').val() != ''){
			img_chk = true;
		}
		if($('#lt_atch_photo4_img').val() != ''){
			img_chk = true;
		}
		if($('#mesure_atch_photo1_img').val() != ''){
			img_chk = true;
		}
		if($('#mesure_atch_photo2_img').val() != ''){
			img_chk = true;
		}
		if($('#mesure_atch_photo3_img').val() != ''){
			img_chk = true;
		}
		if($('#mesure_atch_photo4_img').val() != ''){
			img_chk = true;
		}
		
		// 모든 벨리데이션 체크에 이상이 없으면
		// 등록
		if (pick_no == '' || pick_no == null) {
			// 이미지 파일이 있을때
			if (img_chk) {
				var json = fnAjaxFileAction2('accept/insertSampling.lims', 'detail', fn_suc);
				fn_Save_splore_pick_lt(json);
				fn_Save_splore_pick_ms(json);
			} else {
				var param = $('#detail').serialize();
				var json = fnAjaxAction('accept/insertSampling.lims', param);
				if (json == null) {
					$.showAlert("저장 실패하였습니다.");
				} else {
					$.showAlert("", {
						type : 'insert'
					});
					fn_Save_splore_pick_lt(json);
					fn_Save_splore_pick_ms(json);
					btnSearch_onclick();
				}
			}		
		// 수정
		} else {
			var pick_no = $('#pick_no').val();	
			// 이미지 파일이 있을때
			if (img_chk) {
				var pick_no = $('#pick_no').val();					
				fn_Save_splore_pick_update(pick_no);
				fnAjaxFileAction2('accept/updateSampling.lims', 'detail', fn_suc);
			} else {
				fn_Save_splore_pick_update(pick_no);
				var param = $('#detail').serialize();
				var json = fnAjaxAction('accept/updateSampling.lims', param);
				if (json == null) {
					$.showAlert("저장 실패하였습니다.");
				} else {
					$.showAlert("", {
						type : 'insert'
					});
					btnSearch_onclick();
				}
			}
		}
	}
}

function fn_suc(json) {
	if (json == null) {
		$.showAlert("저장 실패하였습니다.");
	} else {
		$.showAlert("", {
			type : 'insert'
		});
		btnSearch_onclick();
	}
}

function btnRowAdd_onclick(grid){	
	var test_req_seq = $('#test_req_seq').val();
	var pick_no = $('#pick_no').val();	
	
	if (pick_no == '' || pick_no == null) {
		alert('선택된 의뢰에 채취정보가 없습니다.');
		return false;
	}else{
		if(grid == "leftGrid"){
			var increment_co = $("#increment_co").val();
			if(increment_co == "" || increment_co == "0"){
				alert('인크리먼트 개수가 없거나 0입니다.');
				return false;
			}else{
				if($("#"+grid).getGridParam("reccount") == parseInt(increment_co)){
					alert('입력된 인크리먼트 개수보다 더 추가할 수 없습니다.');
					return false;
				}
			}
		}else{
			if($("input:radio[name=prduct_knd]:checked").val() == "B"){
				alert('선택된 채취 제품정보는 비성형입니다.');
				return false;
			}
			if($("#"+grid).getGridParam("reccount") == 20){
				alert('입력된 인크리먼트 개수보다 더 추가할 수 없습니다.');
				return false;
			}
		}		
		
		var rowId = fnNextRowId(grid);
		$('#' + grid).jqGrid('addRow', {
			rowID : rowId,
			position : 'last'
		});
		fnEditRelease(grid);
	}
}

function btnRowDel_onclick(grid){
	var test_req_seq = $('#test_req_seq').val();
	var pick_no = $('#pick_no').val();	
	
	if (pick_no == '' || pick_no == null) {
		alert('선택된 의뢰에 채취정보가 없습니다.');
		return false;
	}else{
		var rowId = $('#'+grid).getGridParam('selrow');
		
		if(rowId == "" || rowId == null){
			alert("행을 선택해주세요.");
			return;
		}
		
		$('#'+grid).jqGrid('delRowData', rowId);
	}
}

function btnSubSave_onclick(grid){
	var test_req_seq = $('#test_req_seq').val();
	var pick_no = $('#pick_no').val();
	var url = '';
	var data = '';
	var pageType = '';
	
	if($("#"+grid).getGridParam("reccount") == 0){
		alert('추가된 정보가 없습니다.');
		return false;
	}
	
	if (pick_no == '' || pick_no == null) {
		alert('선택된 의뢰에 채취정보가 없습니다.');
		return false;
	}else{
		if(grid == "leftGrid"){
			fnEditRelease(grid);
// 			if(!fnSaveGridDataChk(grid)){
// 				alert('입력이 안된 행이 있습니다.');
// 				return false;
// 			}
			url = 'accept/saveSamplingLt.lims';
		}else{
			fnEditRelease(grid);
			if(!fnSaveGridDataChk(grid)){
				alert('입력이 안된 행이 있습니다.');
				return false;
			}
			if($("input:radio[name=prduct_knd]:checked").val() == "B"){
				alert('선택된 채취 제품정보는 비성형입니다.');
				return false;
			}
			url = 'accept/saveSamplingMesure.lims';			
		}
		
		data = "pick_no="+pick_no + "&" + fnGetGridAllData(grid);
		var json = fnAjaxAction(url, data)
		
		if (json == null) {
			$.showAlert("저장 실패하였습니다.");
		} else {
			$.showAlert("저장되었습니다.");
			$('#'+grid).trigger('reloadGrid');
		}
	}
}

function fn_Row_Click_sampling(rowId) {
	var lt_dt_h = rowId + "_lt_dt_h";
	var lt_dt_m = rowId + "_lt_dt_m";

	$('#' + lt_dt_h).keyup(function() {
		var hour = $('#' + lt_dt_h).val();
		if (hour != '') {
			if (!fnIsNumeric(hour)) {
				$.showAlert('숫자만 입력가능합니다.');
				$('#' + lt_dt_h).val(hour.substring(0, hour.length - 1));
			} else {
				if (hour.length > 2) {
					$('#' + lt_dt_h).val(hour.substring(0, hour.length - 1));
				} else {
					if (Number(hour) > 23) {
						$.showAlert('0 ~ 23 까지만 입력가능합니다.');
						$('#' + lt_dt_h).val('');
					}
				}
			}
		}
		$('#' + lt_dt_h).focus();
	});
	$('#' + lt_dt_h).blur(function() {
		var hour = $('#' + lt_dt_h).val();
		if (hour.length == 1) {
			hour = '0' + hour;
		} else if (hour.length == 0) {
			hour = '00';
		}
		$('#' + lt_dt_h).val(hour);
	});
	
	$('#' + lt_dt_m).keyup(function() {
		increment_pick_qy
		if (min != '') {
			if (!fnIsNumeric(min)) {
				$.showAlert('숫자만 입력가능합니다.');
				$('#' + lt_dt_m).val(min.substring(0, min.length - 1));
			} else {
				if (min.length > 2) {
					$('#' + lt_dt_m).val(min.substring(0, min.length - 1));
				} else {
					if (Number(min) > 60) {
						$.showAlert('0 ~ 60 까지만 입력가능합니다.');
						$('#' + lt_dt_m).val('');
					}
				}
			}
		}
		$('#' + lt_dt_m).focus();
	});
	$('#' + lt_dt_m).blur(function() {
		var min = $('#' + lt_dt_m).val();
		if (min.length == 1) {
			min = '0' + min;
		} else if (min.length == 0) {
			min = '00';
		}
		$('#' + lt_dt_m).val(min);
	});
}

function fnSaveGridDataChk(grid){
	var ids = $("#"+grid).jqGrid("getDataIDs");
	if(grid == "leftGrid"){		
		for ( var i in ids) {
			var row = $("#"+grid).getRowData(ids[i]);
			if(row.increment_no.trim() == ""){
				return false;
			}
			if(row.lt_dt_h.trim() == ""){
				return false;
			}
			if(row.lt_dt_m.trim() == ""){
				return false;
			}
			if(row.lt_pick_qy.trim() == ""){
				return false;
			}
		}
	}else{
		for ( var i in ids) {
			var row = $("#"+grid).getRowData(ids[i]);
			if(row.splore_no.trim() == ""){
				return false;
			}
			if(row.mesure_dm.trim() == ""){
				return false;
			}
			if(row.mesure_lt.trim() == ""){
				return false;
			}
		}
	}
	return true;
}

function btnRowInput_onclick(grid){
	if($("#"+grid).getGridParam("reccount") != 0){
		var ids = $("#"+grid).jqGrid("getDataIDs");
		for ( var i in ids) {
			$('#' + grid).jqGrid('editRow', ids[i], true, fn_Row_Click_sampling, null, 'clientArray');
		}
	}
}
/*채취정보 수정할떄 	1. 제품종류 변경(성형>비성형) 			=> 측정생성
 * 				2. 제품종류 변경(비성형>성형)			=> 측정삭제 
 *
 */
function fn_Save_splore_pick_update(pick_no){

		
		if ($("input:radio[name=prduct_knd]:checked").val() != "${detail.prduct_knd}" ) {
			//1.
			if($("input:radio[name=prduct_knd]:checked").val() == "A" ) {
				fn_Save_splore_pick_ms(pick_no);
			}
			//2.
			if($("input:radio[name=prduct_knd]:checked").val() == "B" ) {
				fn_Delete_splore_pick_ms(pick_no);
			}
		} 
}
 
//채취정보 첫 저장시 자동으로 로트 생김
function fn_Save_splore_pick_lt(pick_no){
	var test_req_seq = $('#test_req_seq').val();
	//var increment_co = parseInt($('#increment_co').val())+1; // 1개 로트당 인크리먼트의 개수	=> 24개로 고정

 	for (var i = 1; i < 25; i++){
		var url = 'accept/saveSplorePick.lims'; 
		var data = "pick_no="+pick_no +"&pick_lt_no="+ i + "&increment_no=" + i;
		var json = fnAjaxAction(url, data)
		} 
}

//채취정보 첫 저장시 자동으로 측정 생김
function fn_Save_splore_pick_ms(pick_no){
	var test_req_seq = $('#test_req_seq').val();
	//var increment_pick_qy = parseInt($('#increment_pick_qy').val())+1; //1개 인크리먼트의 채취량(kg)	 => 20개로 고정
	
	//비성형일때
	if($("input:radio[name=prduct_knd]:checked").val() != "B") {
		for (var i = 1; i < 21; i++){
			var url = 'accept/saveMesure.lims'; 
			var data = "pick_no="+pick_no +"&pick_mesure_no="+ i + "&splore_no=" + i;
			var json = fnAjaxAction(url, data)
		}
	} 
}

//로트전체삭제
function fn_Delete_splore_pick_lt(pick_no){
	var url = 'accept/deleteSamplingLt.lims'; 
	var data = "pick_no="+pick_no;
	var json = fnAjaxAction(url, data)

}

//측정전체삭제
function fn_Delete_splore_pick_ms(pick_no){
	var url = 'accept/deleteSamplingMesure.lims'; 
	var data = "pick_no="+pick_no;
	var json = fnAjaxAction(url, data)
}



//일괄입력
function btn_insert_onclick() {
	var grid = 'leftGrid';
	var ids = $('#' + grid).jqGrid("getDataIDs");
	var rowCnt = 0;
	
	alert("채취량 작성 후 저장버튼을 누르셔야 반영됩니다.");
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
		var lt_dt_h = $('#resultDetailForm').find('#lt_dt_h').val();
		var lt_dt_m = $('#resultDetailForm').find('#lt_dt_m').val();
		var lt_pick_qy = $('#resultDetailForm').find('#lt_pick_qy').val();
		
		var nids = $('#' + grid).jqGrid("getDataIDs");
		for ( var j in nids) {
			var nrow = $('#' + grid).getRowData(nids[j]);
			if (nrow.chk == 'Yes') {
				$('#' + grid).jqGrid('setCell', ids[j], 'lt_dt_h', lt_dt_h);
				$('#' + grid).jqGrid('setCell', ids[j], 'lt_dt_m', lt_dt_m);
				$('#' + grid).jqGrid('setCell', ids[j], 'lt_pick_qy', lt_pick_qy);
			}
		}
	}
}

</script>
<div id="tabs">
	<ul>
		<li id="tab1">
			<a href="#tabDiv1">채취정보</a>
		</li>
		<li id="tab2">
			<a href="#tabDiv2">고형연료품질내용</a>
		</li>
		<li id="tab3">
			<a href="#tabDiv3">로트/측정</a>
		</li>
	</ul>
	<div id="tabDiv1">
		<div class="sub_purple_01">
			<table class="select_table" >
				<tr>
					<td width="20%" class="table_title">
						<span>■</span>
						채취 정보
					</td>
					<td class="table_button" style="text-align: right; padding-right: 30px;">
						<span class="button white mlargeb auth_save" id="btnSaveCenter" onclick="btnSave_onclick();">
							<button type="button">저장</button>
						</span>
					</td>
				</tr>
			</table>
			<table class="list_table">
				<tr>
					<th>고형성적서 번호</th>
					<td>
						<input name="bio_no" id="bio_no" type="text" class="w150px" />
					</td>
					<th>시료채취 일시</th>
					<td>
						<input name="pick_dt" id="pick_dt" type="text" class="w80px" readonly="readonly" />
						<img src="<c:url value='/images/common/calendar_del.png'/>" id="pickDtStop" style="cursor: pointer;" onClick='fn_TextClear("pick_dt")' />
						<input name="pick_time" id="pick_time" type="text" class="w50px"  />
					
					</td>
					<th>시료채취 위치</th>
					<td>
						<input name="pick_lc" id="pick_lc" type="text" class="w150px" />
					</td>
					<th>시료채취 목적</th>
					<td>				
						<select name="pick_purps" id="pick_purps" class="w150px"></select>
					</td>
				</tr>
				<tr>
					<th>제품 종류</th>
					<td>
						<input name="prduct_knd" id="prduct_kndA" type="radio" value="A" checked="checked"/> 성형
						<input name="prduct_knd" id="prduct_kndB" type="radio" value="B" /> 비성형
					</td>
					<th>제품 양(톤,kg)</th>
					<td>
						<input name="prduct_qy" id="prduct_qy" type="text" class="w150px" />
					</td>
					<th>로트 크기(톤,kg)</th>
					<td>				
						<input name="lt_mg" id="lt_mg" type="text" class="w150px" />
					</td>
					<th>로트 개수(개)</th>
					<td>
						<input name="lt_co" id="lt_co" type="text" class="w150px"  />
					</td>
				</tr>
				<tr>
					<th>겉보기 밀도(kg/m³)</th>
					<td>
						<input name="pick_dn" id="pick_dn" type="text" class="w150px" />
					</td>
					<th>시료채취 장소</th>
					<td>				
						<select name="pick_place" id="pick_place" class="w80px" ></select> 
						<select name="pick_place_method" id="pick_place_method" class="w80px" ></select>
					</td>
					<th>시료채취기구 명칭</th>
					<td>
						<input name="pick_utnsil_nm" id="pick_utnsil_nm" type="text" class="w150px" />
					</td>
					<th>시료채취기구 제원</th>
					<td>
						<input name="pick_utnsil_manp" id="pick_utnsil_manp" type="text" class="w50px" />
						<select name="pick_utnsil_unit" id="pick_utnsil_unit" class="w80px"></select>
					</td>
				</tr>
				<tr>
					<th>1개 로트당 인크리먼트의 개수</th>
					<td>
						<input name="increment_co" id="increment_co" type="text" class="w150px" />
					</td>
					<th>1개 인크리먼트의 채취량(kg)</th>
					<td>
						<input name="increment_pick_qy" id="increment_pick_qy" type="text" class="w150px" />
					</td>
					<th>감량후 혼합시료</th>
					<td>				
						<input name="outage_mixtrsplore_dth" id="outage_mixtrsplore_dth" type="text" class="w50px" />시
						<input name="outage_mixtrsplore_dtm" id="outage_mixtrsplore_dtm" type="text" class="w50px" />분
						<input name="outage_mixtrsplore_dt" id="outage_mixtrsplore_dt" type="hidden"/>
					</td>
					<th>감량화된 시료량(kg)</th>
					<td>				
						<input name="outage_mixtrsplore_qy" id="outage_mixtrsplore_qy" type="text" class="w150px" />
					</td>
				</tr>
				<tr>
					<th>채취장소 첨부</th>
					<td>
						<input name="pick_place_pn" id="pick_place_pn" type="hidden" value="${detail.pick_place_pn }" />
						<c:if test="${detail.pick_place_pn == null || detail.pick_place_pn == ''}">
							<label id="pick_place_name">첨부파일이 없습니다.</label>
						</c:if>
						<c:if test="${detail.pick_place_pn != null && detail.pick_place_pn != ''}">
							<label id="pick_place_name">${detail.pick_place_pn }</label>
							<img src="<c:url value='/images/common/icon_stop.png'/>" style="cursor: pointer;" onClick='fn_LabelClear("pick_place_name"),fn_TextClear("pick_place_photo_img"),fn_TextClear("pick_place_pn")'/>
						</c:if>
						<br>
						<input name="pick_place_photo_img" id="pick_place_photo_img" type="file" style="width: 165px;" />
					</td>
					<th>채취기구 첨부</th>
					<td>
						<input name="pick_utnsil_pn" id="pick_utnsil_pn" type="hidden" value="${detail.pick_utnsil_pn }" />
						<c:if test="${detail.pick_utnsil_pn == null || detail.pick_utnsil_pn == ''}">
							<label id="pick_utnsil_name">첨부파일이 없습니다.</label>
						</c:if>
						<c:if test="${detail.pick_utnsil_pn != null && detail.pick_utnsil_pn != ''}">
							<label id="pick_utnsil_name">${detail.pick_utnsil_pn }</label>
							<img src="<c:url value='/images/common/icon_stop.png'/>" style="cursor: pointer;" onClick='fn_LabelClear("pick_utnsil_name"),fn_TextClear("pick_utnsil_photo_img"),fn_TextClear("pick_utnsil_pn")'/>
						</c:if>
						<br>
						<input name="pick_utnsil_photo_img" id="pick_utnsil_photo_img" type="file" style="width: 165px;" />
					</td>
					<th>측정기구 명</th>
					<td>
						<select name="mesure_utnsil_nm" id="mesure_utnsil_nm" class="w150px"></select>
					</td>
					<th>측정범위</th>
					<td>
						<select name="mesure_scope" id="mesure_scope" class="w150px"></select>
					</td>				
				</tr>
				<tr>
					<th>측정방법</th>
					<td colspan="7">
						<textarea rows="3" name="mesure_mth" id="mesure_mth" style="width: 100%;">${detail.mesure_mth}</textarea>
					</td>
				</tr>
				<tr>
					<th>로트 첨부파일1</th>
					<td>
						<input name="lt_atch_pn1" id="lt_atch_pn1" type="hidden" value="${detail.lt_atch_pn1 }" />
						<c:if test="${detail.lt_atch_pn1 == null || detail.lt_atch_pn1 == ''}">
							<label id="lt_atch_name1">첨부파일이 없습니다.</label>
						</c:if>
						<c:if test="${detail.lt_atch_pn1 != null && detail.lt_atch_pn1 != ''}">
							<label id="lt_atch_name1">${detail.lt_atch_pn1 }</label>
							<img src="<c:url value='/images/common/icon_stop.png'/>" style="cursor: pointer;" onClick='fn_LabelClear("lt_atch_name1"),fn_TextClear("lt_atch_photo1_img"),fn_TextClear("lt_atch_pn1")'/>
						</c:if>
						<br>
						<input name="lt_atch_photo1_img" id="lt_atch_photo1_img" type="file" style="width: 165px;" />
					</td>
					<th>로트 첨부파일2</th>
					<td>
						<input name="lt_atch_pn2" id="lt_atch_pn2" type="hidden" value="${detail.lt_atch_pn2 }" />
						<c:if test="${detail.lt_atch_pn2 == null || detail.lt_atch_pn2 == ''}">
							<label id="lt_atch_name2">첨부파일이 없습니다.</label>
						</c:if>
						<c:if test="${detail.lt_atch_pn2 != null && detail.lt_atch_pn2 != ''}">
							<label id="lt_atch_name2">${detail.lt_atch_pn2 }</label>
							<img src="<c:url value='/images/common/icon_stop.png'/>" style="cursor: pointer;" onClick='fn_LabelClear("lt_atch_name2"),fn_TextClear("lt_atch_photo2_img"),fn_TextClear("lt_atch_pn2")'/>
						</c:if>
						<br>
						<input name="lt_atch_photo2_img" id="lt_atch_photo2_img" type="file" style="width: 165px;" />
					</td>
					<th>로트 첨부파일3</th>
					<td>
						<input name="lt_atch_pn3" id="lt_atch_pn3" type="hidden" value="${detail.lt_atch_pn3 }" />
						<c:if test="${detail.lt_atch_pn3 == null || detail.lt_atch_pn3 == ''}">
							<label id="lt_atch_name3">첨부파일이 없습니다.</label>
						</c:if>
						<c:if test="${detail.lt_atch_pn3 != null && detail.lt_atch_pn3 != ''}">
							<label id="lt_atch_name3">${detail.lt_atch_pn3 }</label>
							<img src="<c:url value='/images/common/icon_stop.png'/>" style="cursor: pointer;" onClick='fn_LabelClear("lt_atch_name3"),fn_TextClear("lt_atch_photo3_img"),fn_TextClear("lt_atch_pn3")'/>
						</c:if>
						<br>
						<input name="lt_atch_photo3_img" id="lt_atch_photo3_img" type="file" style="width: 165px;" />
					</td>
					<th>로트 첨부파일4</th>
					<td>
						<input name="lt_atch_pn4" id="lt_atch_pn4" type="hidden" value="${detail.lt_atch_pn4 }" />
						<c:if test="${detail.lt_atch_pn4 == null || detail.lt_atch_pn4 == ''}">
							<label id="lt_atch_name4">첨부파일이 없습니다.</label>
						</c:if>
						<c:if test="${detail.lt_atch_pn4 != null && detail.lt_atch_pn4 != ''}">
							<label id="lt_atch_name4">${detail.lt_atch_pn4 }</label>
							<img src="<c:url value='/images/common/icon_stop.png'/>" style="cursor: pointer;" onClick='fn_LabelClear("lt_atch_name4"),fn_TextClear("lt_atch_photo4_img"),fn_TextClear("lt_atch_pn4")'/>
						</c:if>
						<br>
						<input name="lt_atch_photo4_img" id="lt_atch_photo4_img" type="file" style="width: 165px;" />
					</td>				
				</tr>
				<tr>
					<th>측정 첨부파일1</th>
					<td>
						<input name="mesure_atch_pn1" id="mesure_atch_pn1" type="hidden" value="${detail.mesure_atch_pn1 }" />
						<c:if test="${detail.mesure_atch_pn1 == null || detail.mesure_atch_pn1 == ''}">
							<label id="mesure_atch_name1">첨부파일이 없습니다.</label>
						</c:if>
						<c:if test="${detail.mesure_atch_pn1 != null && detail.mesure_atch_pn1 != ''}">
							<label id="mesure_atch_name1">${detail.mesure_atch_pn1 }</label>
							<img src="<c:url value='/images/common/icon_stop.png'/>" id="mesure_atch_photo1_stop" style="cursor: pointer;" onClick='fn_LabelClear("mesure_atch_name1"),fn_TextClear("mesure_atch_photo1_img"),fn_TextClear("mesure_atch_pn1")'/>
						</c:if>
						<br>
						<input name="mesure_atch_photo1_img" id="mesure_atch_photo1_img" type="file" style="width: 165px;" />
					</td>
					<th>측정 첨부파일2</th>
					<td>
						<input name="mesure_atch_pn2" id="mesure_atch_pn2" type="hidden" value="${detail.mesure_atch_pn2 }" />
						<c:if test="${detail.mesure_atch_pn2 == null || detail.mesure_atch_pn2 == ''}">
							<label id="mesure_atch_name2">첨부파일이 없습니다.</label>
						</c:if>
						<c:if test="${detail.mesure_atch_pn2 != null && detail.mesure_atch_pn2 != ''}">
							<label id="mesure_atch_name2">${detail.mesure_atch_pn2 }</label>
							<img src="<c:url value='/images/common/icon_stop.png'/>" id="mesure_atch_photo2_stop" style="cursor: pointer;" onClick='fn_LabelClear("mesure_atch_name2"),fn_TextClear("mesure_atch_photo2_img"),fn_TextClear("mesure_atch_pn2")'/>
						</c:if>
						<br>
						<input name="mesure_atch_photo2_img" id="mesure_atch_photo2_img" type="file" style="width: 165px;" />
					</td>
					<th>측정 첨부파일3</th>
					<td>
						<input name="mesure_atch_pn3" id="mesure_atch_pn3" type="hidden" value="${detail.mesure_atch_pn3 }" />
						<c:if test="${detail.mesure_atch_pn3 == null || detail.mesure_atch_pn3 == ''}">
							<label id="mesure_atch_name3">첨부파일이 없습니다.</label>
						</c:if>
						<c:if test="${detail.mesure_atch_pn3 != null && detail.mesure_atch_pn3 != ''}">
							<label id="mesure_atch_name3">${detail.mesure_atch_pn3 }</label>
							<img src="<c:url value='/images/common/icon_stop.png'/>" id="mesure_atch_photo3_stop" style="cursor: pointer;" onClick='fn_LabelClear("mesure_atch_name3"),fn_TextClear("mesure_atch_photo3_img"),fn_TextClear("mesure_atch_pn3")'/>
						</c:if>
						<br>
						<input name="mesure_atch_photo3_img" id="mesure_atch_photo3_img" type="file" style="width: 165px;" />
					</td>
					<th>측정 첨부파일4</th>
					<td>
						<input name="mesure_atch_pn4" id="mesure_atch_pn4" type="hidden" value="${detail.mesure_atch_pn4 }" />
						<c:if test="${detail.mesure_atch_pn4 == null || detail.mesure_atch_pn4 == ''}">
							<label id="mesure_atch_name4">첨부파일이 없습니다.</label>
						</c:if>
						<c:if test="${detail.mesure_atch_pn4 != null && detail.mesure_atch_pn4 != ''}">
							<label id="mesure_atch_name4">${detail.mesure_atch_pn4 }</label>
							<img src="<c:url value='/images/common/icon_stop.png'/>" id="mesure_atch_photo4_stop" style="cursor: pointer;" onClick='fn_LabelClear("mesure_atch_name4"),fn_TextClear("mesure_atch_photo4_img"),fn_TextClear("mesure_atch_pn4")'/>
						</c:if>
						<br>
						<input name="mesure_atch_photo4_img" id="mesure_atch_photo4_img" type="file" style="width: 165px;" />
					</td>				
				</tr>
			</table>
			<input type="hidden" id="test_req_seq" name="test_req_seq" value="${detail.test_req_seq }">
			<input type="hidden" id="pick_no" name="pick_no" value="${detail.pick_no }">
		</div>
	</div>
	<div id="tabDiv2" style="overflow: hidden;">
		<div class="sub_purple_01">
			<table class="select_table" >
				<tr>
					<td width="20%" class="table_title">
						<span>■</span>
						고형연료품질내용
					</td>
					<td class="table_button" style="text-align: right; padding-right: 30px;">
						<span class="button white mlargeb auth_save" id="btnSaveExtra" onclick="btnSave_onclick();">
							<button type="button">저장</button>
						</span>
					</td>
				</tr>
			</table>
			<table class="list_table">
				<tr>
					<th>수입/제조 구분</th>
					<td>
						<input name="solid_gbn" id="solid_gbnA" type="radio" value="A" checked="checked"/> 수입
						<input name="solid_gbn" id="solid_gbnB" type="radio" value="B" /> 제조
					</td>
<!-- 					<th>원재료 구분</th>
					<td>
						<select name="rawmtrl_gbn" id="rawmtrl_gbn" class="w150px"></select>
					</td> -->
					<th>직경/가로</th>
					<td>
						<input name="width" id="width" type="text" class="w150px" />
					</td>
					<th>길이/세로</th>
					<td>
						<input name="vrticl" id="vrticl" type="text" class="w150px" /> 
					</td>
				</tr>
				<tr>
					<th>원재료의 종류 및 구성비율</th>
					<td colspan = "5">
						<textarea rows="3" name="sungsang0" id="sungsang0" style="width: 100%;">${detail.sungsang0}</textarea>
					</td>
				</tr>
				<tr>
					<th>금속성분 함유량 - 기타</th>
					<td colspan = "5">
						<textarea rows="3" name="sungsang_etc" id="sungsang_etc" style="width: 100%;">${detail.sungsang_etc}</textarea>
					</td>
				</tr>
<!-- 			<tr>
					<th>폐목재류</th>
					<td>
						<input name="sungsang1" id="sungsang1" type="text" class="w100px" />%
					</td>
					<th>폐종이류</th>
					<td>
						<input name="sungsang2" id="sungsang2" type="text" class="w100px" />%
					</td>
					<th>폐비닐 및 플라스틱</th>
					<td>
						<input name="sungsang3" id="sungsang3" type="text" class="w100px" />%
					</td>
					<th>폐고무류</th>
					<td>
						<input name="sungsang4" id="sungsang4" type="text" class="w100px" />%
					</td>
				</tr>
				<tr>
					<th>폐섬유류</th>
					<td>
						<input name="sungsang5" id="sungsang5" type="text" class="w100px" />%
					</td>
					<th>기 타</th>
					<td colspan="5">
						<input name="sungsang6" id="sungsang6" type="text" class="w100px" />%
					</td>
				</tr> -->
			</table>
		</div>
	</div>
	<div id="tabDiv3" style="overflow: hidden;">
		<div class="sub_purple_01" style="width: 48%; float: left;">
			<table class="select_table" >
				<tr>
					<td width="20%" class="table_title">
						<span>■</span>
						채취 로트
					</td>
					<td class="table_button" style="text-align: right; padding-right: 30px;">
						<span class="button white mlargeb auth_save" id="btnRowInputLeft" onclick="btnRowInput_onclick('leftGrid');">
							<button type="button">입력하기</button>
						</span>
						<span class="button white mlargeb auth_save" id="btnRowAddLeft" onclick="btnRowAdd_onclick('leftGrid');">
							<button type="button">행추가</button>
						</span>
						<span class="button white mlargeb auth_save" id="btnRowDelLeft" onclick="btnRowDel_onclick('leftGrid');">
							<button type="button">행삭제</button>
						</span>
						<span class="button white mlargeb auth_save" id="btnSaveLeft" onclick="btnSubSave_onclick('leftGrid');">
							<button type="button">저장</button>
						</span>
					</td>
				</tr>
			</table>
			<input type="hidden" id="sortName" name="sortName">
			<input type="hidden" id="sortType" name="sortType">
			<div id="view_grid_sub1">
				<table id="leftGrid"></table>
			</div>
		</div>
		<div class="sub_purple_01" style="margin-left: 4%; width: 48%; float: left;">
			<table class="select_table" >
				<tr>
					<td width="20%" class="table_title">
						<span>■</span>
						채취 측정
					</td>
					<td class="table_button" style="text-align: right; padding-right: 30px;">
						<span class="button white mlargeb auth_save" id="btnRowInputRight" onclick="btnRowInput_onclick('rightGrid');">
							<button type="button">입력하기</button>
						</span>
						<span class="button white mlargeb auth_save" id="btnRowAddRight" onclick="btnRowAdd_onclick('rightGrid');">
							<button type="button">행추가</button>
						</span>
						<span class="button white mlargeb auth_save" id="btnRowDelRight" onclick="btnRowDel_onclick('rightGrid');">
							<button type="button">행삭제</button>
						</span>
						<span class="button white mlargeb auth_save" id="btnSaveRight" onclick="btnSubSave_onclick('rightGrid');">
							<button type="button">저장</button>
						</span>
					</td>
				</tr>
			</table>
			<input type="hidden" id="sortName" name="sortName">
			<input type="hidden" id="sortType" name="sortType">
			<div id="view_grid_sub2">
				<table id="rightGrid"></table>
			</div>
		</div>
		<div class="sub_purple_01 ">
			<form id="resultDetailForm" name="resultDetailForm" onsubmit="return false;">
				<table width="100%" border="0" class="select_table">
					<tr>
						<td width="20%" class="table_title">
							<span>■</span>
							수동 일괄입력
						</td>
						<td class="table_button" style="text-align: right; padding-right: 30px;">
							<span class="button white mlargeg auth_select" id="btn_insertItemVal" onclick="btn_insert_onclick();">
								<button type="button">결과일괄입력</button>
							</span>
						</td>
					</tr>
				</table>
				<table width="100%" border="0" class="list_table">
					<tr>
						<th>일시/시간(시)</th>
						<td>
							<input name="lt_dt_h" id="lt_dt_h" type="text" class="w100px" />
						</td>
						<th>일시/시간(분)</th>
						<td>
							<input name="lt_dt_m" id="lt_dt_m" type="text" class="w100px" />
						</td>
						<th>채취량</th>
						<td>
							<input name="lt_pick_qy" id="lt_pick_qy" type="text" class="w100px" />
						</td>
					</tr>
				</table>
			</form>
		</div>
	</div>
</div>
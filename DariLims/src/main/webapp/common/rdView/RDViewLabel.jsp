<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>시료라벨출력</title>
<link rel="stylesheet" media="screen" type="text/css" href="<c:url value='/css/jquery-ui.css'/>" />
<link rel="stylesheet" media="screen" type="text/css" href="<c:url value='/css/jqgrid/ui.jqgrid.css'/>" />
<link rel="stylesheet" media="screen" type="text/css" href="<c:url value='/css/common/sub.css'/>" />
<script type="text/javascript" src="<c:url value='/script/jquery-1.11.0.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/script/jquery-ui.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/script/jquery.blockUI.js'/>"></script>
<script type="text/javascript" src="<c:url value='/script/jquery.message.js'/>"></script>
<script type="text/javascript" src="<c:url value='/script/common.js'/>"></script>
<script type="text/javascript" src="<c:url value='/script/gridCommon.js'/>"></script>
<script type="text/javascript" src="<c:url value='/script/jqgrid/jquery.jqGrid.min.js'/>"></script>
<script type="text/javascript">
	var file;
	var reportData;
	var print;
	var publish;
	var sampling_method;
	var test_std;
	$(function() {
		/* var obj;
		obj = window.dialogArguments;
		var file = obj.file;
		var param = obj.param;
		var print = obj.print;
		if (print == true) {
			$('#printTd').show();
		} */
		//alert(file + "/" + param + '/' + print);
		var param = '${report.gridData}';
		//alert(param);
		var arr = param.split('|');
		file = arr[0];
		reportData = arr[1];
		print = arr[2];
		publish = arr[3];
		if (print == 'true') {
			$('#printTd').show();
		}

		test_std = fnGridCombo('test_std', null);
		sampling_method = fnGridCommonCombo('C32', null);

		//시료목록 조회 
		$('#sampleForm').find('#test_req_no').val(reportData);
		sampleGrid('accept/selectAcceptSampleList.lims', 'sampleForm', 'sampleGrid');

		//툴바 숨김
		rdViewer.HideToolBar();
		//rdViewer.DisableToolbar (0);
		rdViewer.AutoAdjust = false;
		rdViewer.ZoomRatio = 100;
		//rdViewer.SetBackgroundColor(255,255,255);
		//rdViewer.ViewShowMode(1);

		//file = "Sample_label2";

		var rd_url = '${rd_url}';
		rdViewer.FileOpen("http://" + rd_url + "/RDServer/mrd/" + file + '.mrd', "/rdonotreport /rnpu ");
		//alert(reportData);
		//rdViewer.FileOpen("http://98.28.5.217:9090/RDServer/mrd/" + file + ".mrd", "/rp " + reportData + ' /rwait /rnpu ');
		//rdViewer.FileOpen("http://98.28.5.217:9090/RDServer/mrd/" + file + ".mrd", "/rv " + param + " );
		//var ret = rdViewer.SaveAsPdfFile("E:\\aaa\\a.pdf"); //PDF 파일로 저장 

	});

	function sampleGrid(url, form, grid) {
		$('#' + grid).jqGrid({
			datatype : function(json) {
				fnGridData(url, form, grid);
			},
			height : '240',
			autowidth : true,
			loadonce : true,
			mtype : "POST",
			gridview : true,
			shrinkToFit : false,
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
				label : 'sample_temp_cd',
				name : 'sample_temp_cd',
				hidden : true
			}, {
				label : 'test_req_no',
				name : 'test_req_no',
				hidden : true
			}, {
				label : '시료번호',
				name : 'test_sample_seq',
				width : '100',
				align : 'center'
			}, {
				label : '시료명',
				name : 'sample_reg_nm'
			}, {
				label : 'sample_cd',
				name : 'sample_cd',
				hidden : true
			}, {
				type : 'not',
				label : '시료유형',
				name : 'sample_nm'
			}, {
				label : '채수일자',
				name : 'sampling_date',
				width : '100',
				align : 'center'
			}, {
				label : '채수자',
				name : 'sampling_id',
				width : '60',
				align : 'center'
			}, {
				type : 'not',
				label : '채수장소',
				name : 'sampling_point_nm',
				editoptions : {
					readonly : "readonly"
				}
			}, {
				label : '채수방법',
				name : 'sampling_method',
				editable : true,
				edittype : "select",
				editoptions : {
					value : sampling_method
				},
				formatter : 'select'
			}, {
				label : '시험기준',
				name : 'test_std_no',
				width : '200',
				editable : true,
				edittype : "select",
				editoptions : {
					value : test_std
				},
				formatter : 'select'
			}, {
				label : '비고',
				name : 'etc_desc',
				editable : true
			} ],
			gridComplete : function() {
			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
			},
			onSelectRow : function(rowId, status, e) {
				//	$("#reportWriteSampleForm").find('#report_doc_seq').val(rowId);
				//	$('#reportWriteSampleGrid').trigger('reloadGrid');
			}
		});
	}

	var img_cnt = 8;
	var first_img = new Array(img_cnt);
	for (var i = 0; i < img_cnt; i++) {
		first_img[i] = new Image();
	}
	//first_img[1].src = "images/rd/img/menu/save_1.gif";
	first_img[0].src = "images/rd/img/menu/print_1.gif";
	first_img[1].src = "images/rd/img/menu/first_1.gif";
	first_img[2].src = "images/rd/img/menu/back_1.gif";
	first_img[3].src = "images/rd/img/menu/next_1.gif";
	first_img[4].src = "images/rd/img/menu/last_1.gif";
	first_img[5].src = "images/rd/img/menu/zoomin_1.gif";
	first_img[6].src = "images/rd/img/menu/zoomout_1.gif";
	//first_img[9].src = "images/rd/img/menu/excel_1.gif";
	//first_img[10].src = "images/rd/img/menu/hwp_1.gif";
	first_img[7].src = "images/rd/img/menu/close_1.gif";

	var over_img = new Array(img_cnt);
	for (var i = 0; i < img_cnt; i++) {
		over_img[i] = new Image();
	}
	//over_img[1].src = "images/rd/img/menu/save_2.gif";
	over_img[0].src = "images/rd/img/menu/print_2.gif";
	over_img[1].src = "images/rd/img/menu/first_2.gif";
	over_img[2].src = "images/rd/img/menu/back_2.gif";
	over_img[3].src = "images/rd/img/menu/next_2.gif";
	over_img[4].src = "images/rd/img/menu/last_2.gif";
	over_img[5].src = "images/rd/img/menu/zoomin_2.gif";
	over_img[6].src = "images/rd/img/menu/zoomout_2.gif";
	//over_img[9].src = "images/rd/img/menu/excel_2.gif";
	//over_img[10].src = "images/rd/img/menu/hwp_2.gif";
	over_img[7].src = "images/rd/img/menu/close_2.gif";

	function msover(num) {
		document.images[num].src = over_img[num].src;
	}

	function msout(num) {
		document.images[num].src = first_img[num].src;
	}
	function btn_Print_onclick() {
		labelView();
		if (publish == 'true') {
			if (!confirm($("#label_cnt").text() + '건의 라벨을 출력 하시겠습니까.')) {
			} else {
				rdViewer.PrintDialog();
			}
		} else {
			rdViewer.PrintDialog();
		}
	}

	function labelView() {
		var ids = $('#sampleGrid').jqGrid("getDataIDs");
		if (ids.length == 0) {
			$.showAlert('등록된 시료가 없습니다.');
		} else {
			var sampleDatas = "";
			var sample_cnt = 0;
			for ( var i in ids) {
				var row = $('#sampleGrid').getRowData(ids[i]);
				if (row.chk == 'Yes') {
					sampleDatas += "'" + row.test_sample_seq + "',";
					sample_cnt++;
				}
			}
			if (sampleDatas == "") {
				alert('선택된 시료가 없습니다.');
				return;
			}

			$("#label_cnt").text(sample_cnt);
			var param = "/rp [" + sampleDatas.substring(0, sampleDatas.length - 1) + "] /rnpu";
			rdViewer.FileOpen('http://98.28.5.217:9090/RDServer/mrd/' + file + '.mrd', param);
		}
	}
</script>
<SCRIPT LANGUAGE=JavaScript FOR=rdViewer EVENT="PrintFinished()">
	alert('라벨 발행이 완료되었습니다.');
</SCRIPT>
</head>
<body>
	<div class="sub_purple_01 w100p">
		<form id="sampleForm" name="sampleForm" onsubmit="return false;">
			<table width="100%" border="0" class="select_table" cellpadding="0" cellspacing="0">
				<tr>
					<td width="20%" class="table_title" nowrap="nowrap">
						<span>■</span>
						시료 목록
					</td>
					<td class="table_button" style="text-align: right; padding-right: 30px;">
						<span class="button white mlargeb" id="btn_labelView" onclick="labelView();">
							<button type="button">미리보기</button>
						</span>
					</td>
				</tr>

			</table>
			<input type="hidden" id="test_req_no" name="test_req_no" />
			<input type="hidden" id="sortName" name="sortName">
			<input type="hidden" id="sortType" name="sortType">
			<div id="view_grid" >
				<table id="sampleGrid" style="width: 700px;"></table>
			</div>
		</form>
	</div>

	<div class="sub_purple_01 w100p">
		<table width="100%" border="0" class="select_table" cellpadding="0" cellspacing="0">
			<tr>
				<td width="20%" class="table_title" nowrap="nowrap">
					<span>■</span>
					라벨 미리보기(<label id="label_cnt">0</label>건)
				</td>
			</tr>
		</table>

	</div>
	<div id="printTd" style="text-align: center;">
		<image src="images/rd/img/menu/print_1.gif" OnMouseOver="msover(0) ; return false" OnMouseOut="msout(0)" OnClick="btn_Print_onclick();"></image>
		<image src="images/rd/img/menu/first_1.gif" OnMouseOver="msover(1) ; return false" OnMouseOut="msout(1)" OnClick="rdViewer.FirstPage()"></image>
		<image src="images/rd/img/menu/back_1.gif" OnMouseOver="msover(2) ; return false" OnMouseOut="msout(2)" OnClick="rdViewer.PrevPage()"></image>
		<image src="images/rd/img/menu/next_1.gif" OnMouseOver="msover(3) ; return false" OnMouseOut="msout(3)" OnClick="rdViewer.NextPage()"></image>
		<image src="images/rd/img/menu/last_1.gif" OnMouseOver="msover(4) ; return false" OnMouseOut="msout(4)" OnClick="rdViewer.LastPage()"></image>
		<image src="images/rd/img/menu/zoomin_1.gif" OnMouseOver="msover(5) ; return false" OnMouseOut="msout(5)" OnClick="rdViewer.ZoomIn()"></image>
		<image src="images/rd/img/menu/zoomout_1.gif" OnMouseOver="msover(6) ; return false" OnMouseOut="msout(6)" OnClick="rdViewer.ZoomOut()"></image>
		<image src="images/rd/img/menu/close_1.gif" OnMouseOver="msover(7) ; return false" OnMouseOut="msout(7)" OnClick="window.close();"></image>
	</div>
	<div style="width: 600px; height: 300px;">
		<OBJECT id=rdViewer classid="clsid:5A7B56B3-603D-4953-9909-1247D41967F8" codebase="http://${rd_url}/RDServer/cab/rdviewer50u.cab#version=5,0,0,521" name=rdViewer width=100% height=100%></OBJECT>
	</div>

</body>
</html>
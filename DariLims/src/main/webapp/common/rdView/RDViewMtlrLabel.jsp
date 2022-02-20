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
		var param = "${report.gridData}";
		var arr = param.split('|');
		file = arr[0];
		reportData = arr[1];
		print = arr[2];
		publish = arr[3];
		if (print == 'true') {
			$('#printTd').show();
		}

		//툴바 숨김
		rdViewer.HideToolBar();
		//rdViewer.DisableToolbar (0);
		rdViewer.AutoAdjust = false;
		rdViewer.ZoomRatio = 120;
		//rdViewer.SetBackgroundColor(255,255,255);
		//rdViewer.ViewShowMode(1);

		labelView();

	});

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
		if (publish == 'true') {
			if (!confirm('라벨을 출력 하시겠습니까.')) {
			} else {
				rdViewer.PrintDialog();
			}
		} else {
			rdViewer.PrintDialog();
		}
	}

	function labelView() {
		var rd_url = '${rd_url}';
		rdViewer.FileOpen("http://" + rd_url + "/RDServer/mrd/" + file + '.mrd', reportData);
	}
</script>
<SCRIPT LANGUAGE=JavaScript FOR=rdViewer EVENT="PrintFinished()">
	alert('라벨 발행이 완료되었습니다.');
</SCRIPT>
</head>
<body>
	<div class="sub_purple_01 w100p">
		<table width="100%" border="0" class="select_table" cellpadding="0" cellspacing="0">
			<tr>
				<td width="20%" class="table_title" nowrap="nowrap">
					<span>■</span>
					라벨 미리보기
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
	<div style="width: 100%; height: 300px;">
		<OBJECT id=rdViewer classid="clsid:5A7B56B3-603D-4953-9909-1247D41967F8" codebase="http://${rd_url}/RDServer/cab/rdviewer50u.cab#version=5,0,0,521" name=rdViewer width=100% height=100%></OBJECT>
	</div>

</body>
</html>
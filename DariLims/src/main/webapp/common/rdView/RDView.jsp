<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>RDServer</title>
<script type="text/javascript" src="<c:url value='/script/jquery-1.11.0.min.js'/>"></script>
<script type="text/javascript">
	var file;
	var reportData;
	var print;
	var publish;
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
		//alert(file + "/" + reportData + '/' + print + '/' + publish);

		//툴바 숨김
		rdViewer.HideToolBar();
		//rdViewer.DisableToolbar (0);
		rdViewer.AutoAdjust = false;
		rdViewer.ZoomRatio = 80;
		//rdViewer.SetBackgroundColor(255,255,255);
		//rdViewer.ViewShowMode(1);
		var rd_url = '${rd_url}';
		rdViewer.FileOpen("http://" + rd_url + "/RDServer/mrd/" + file + ".mrd", "/rp " + reportData + ' /rwait /rnpu ');
		//rdViewer.FileOpen("http://98.28.5.217:9090/RDServer/mrd/" + file + ".mrd", "/rv " + param + " );
		//var ret = rdViewer.SaveAsPdfFile("E:\\aaa\\a.pdf"); //PDF 파일로 저장 
	});

	var img_cnt = 9;
	var first_img = new Array(img_cnt);
	for (var i = 0; i < img_cnt; i++) {
		first_img[i] = new Image();
	}

	first_img[0].src = "images/rd/img/menu/print_1.gif";
	first_img[1].src = "images/rd/img/menu/save_1.gif";
	first_img[2].src = "images/rd/img/menu/first_1.gif";
	first_img[3].src = "images/rd/img/menu/back_1.gif";
	first_img[4].src = "images/rd/img/menu/next_1.gif";
	first_img[5].src = "images/rd/img/menu/last_1.gif";
	first_img[6].src = "images/rd/img/menu/zoomin_1.gif";
	first_img[7].src = "images/rd/img/menu/zoomout_1.gif";
	//first_img[9].src = "images/rd/img/menu/excel_1.gif";
	//first_img[10].src = "images/rd/img/menu/hwp_1.gif";
	first_img[8].src = "images/rd/img/menu/close_1.gif";

	var over_img = new Array(img_cnt);
	for (var i = 0; i < img_cnt; i++) {
		over_img[i] = new Image();
	}

	over_img[0].src = "images/rd/img/menu/print_2.gif";
	over_img[1].src = "images/rd/img/menu/save_2.gif";
	over_img[2].src = "images/rd/img/menu/first_2.gif";
	over_img[3].src = "images/rd/img/menu/back_2.gif";
	over_img[4].src = "images/rd/img/menu/next_2.gif";
	over_img[5].src = "images/rd/img/menu/last_2.gif";
	over_img[6].src = "images/rd/img/menu/zoomin_2.gif";
	over_img[7].src = "images/rd/img/menu/zoomout_2.gif";
	//over_img[9].src = "images/rd/img/menu/excel_2.gif";
	//over_img[10].src = "images/rd/img/menu/hwp_2.gif";
	over_img[8].src = "images/rd/img/menu/close_2.gif";

	function msover(num) {
		document.images[num].src = over_img[num].src;
	}

	function msout(num) {
		document.images[num].src = first_img[num].src;
	}
	function btn_Print_onclick() {
		if (publish == 'true') {
			if (!confirm('성적서를 발행하시겠습니까.')) {
			} else {
				var data = 'report_doc_seq=' + reportData;
				$.ajax({
					url : 'report/checkReportPublish.lims',
					type : 'post',
					dataType : 'json',
					async : false,
					data : data,
					success : function(json) {
						if (json == null) {
							alert('성적서발행을 실패하였습니다.');
						} else if (json == '1') {
							alert('이미 발행된 성적서입니다.');
							if (!confirm('성적서를 재발행하시겠습니까.')) {
							} else {
								rdViewer.PrintDialog();
							}
						} else {
							rdViewer.PrintDialog();
						}
					},
					error : function() {
						alert('viewPage error');
					}
				});
			}
		} else {
			rdViewer.PrintDialog();
		}
	}

	// 성적서 파일로 저장 2015.05.06
	function fn_SavePDF() {
		var fileName;
		var d = new Date();
		var year = d.getFullYear();
		var month = (d.getMonth() + 1).toString();
		if (month.length == 1) {
			month = '0' + month;
		}
		var date = (d.getDate()).toString();
		if (date.length == 1) {
			date = '0' + date;
		}
		fileName = "(" + year + '_' + month + '_' + date + ")" + file + ".pdf";
		rdViewer.SetSaveDialog("c:\\ReportDown\\", fileName, 5);

		var ret = rdViewer.SaveAsDialog();
		if (ret) {
			alert("저장이 완료되었습니다.");

		}
	}
</script>
<SCRIPT LANGUAGE=JavaScript FOR=rdViewer EVENT="PrintFinished()">
	if (publish == 'true') {
		var data = 'report_doc_seq=' + reportData + '&state=Y';
		$.ajax({
			url : 'report/updateReportPublish.lims',
			type : 'post',
			dataType : 'json',
			async : false,
			data : data,
			success : function(json) {
				if (json != null) {
					alert('성적서발행이 완료되었습니다.');
				}
			},
			error : function() {
				alert('viewPage error');
			}
		});
	}
</SCRIPT>
</head>
<body style="text-align: right;">
	<table border=0>
		<tr>
			<!-- <td>
				<img src="images/rd/img/logo.gif">
			</td> -->
			<td id="printTd" style="display: none;">
				<image src="images/rd/img/menu/print_1.gif" OnMouseOver="msover(0) ; return false" OnMouseOut="msout(0)" OnClick="btn_Print_onclick();">
			</td>
			<td>
				<image src="images/rd/img/menu/save_1.gif" OnMouseOver="msover(1) ; return false" OnMouseOut="msout(8)" OnClick="fn_SavePDF();">
			</td>
			<td>
				<image src="images/rd/img/menu/first_1.gif" OnMouseOver="msover(2) ; return false" OnMouseOut="msout(1)" OnClick="rdViewer.FirstPage()">
			</td>
			<td>
				<image src="images/rd/img/menu/back_1.gif" OnMouseOver="msover(3) ; return false" OnMouseOut="msout(2)" OnClick="rdViewer.PrevPage()">
			</td>
			<td>
				<image src="images/rd/img/menu/next_1.gif" OnMouseOver="msover(4) ; return false" OnMouseOut="msout(3)" OnClick="rdViewer.NextPage()">
			</td>
			<td>
				<image src="images/rd/img/menu/last_1.gif" OnMouseOver="msover(5) ; return false" OnMouseOut="msout(4)" OnClick="rdViewer.LastPage()">
			</td>
			<td>
				<image src="images/rd/img/menu/zoomin_1.gif" OnMouseOver="msover(6) ; return false" OnMouseOut="msout(5)" OnClick="rdViewer.ZoomIn()">
			</td>
			<td>
				<image src="images/rd/img/menu/zoomout_1.gif" OnMouseOver="msover(7) ; return false" OnMouseOut="msout(6)" OnClick="rdViewer.ZoomOut()">
			</td>
			<!-- <td>
				<image src="images/rd/img/menu/excel_1.gif" OnMouseOver="msover(9) ; return false" OnMouseOut="msout(9)" OnClick="rdViewer.ViewExcel()">
			</td>
			<td>
				<image src="images/rd/img/menu/hwp_1.gif" OnMouseOver="msover(10) ; return false" OnMouseOut="msout(10)" OnClick="rdViewer.ViewHWP()">
			</td> -->
			<td>
				<image src="images/rd/img/menu/close_1.gif" OnMouseOver="msover(8) ; return false" OnMouseOut="msout(7)" OnClick="window.close();">
			</td>
		</tr>
	</table>
	<OBJECT id=rdViewer classid="clsid:5A7B56B3-603D-4953-9909-1247D41967F8" codebase="http://${rd_url}/RDServer/cab/rdviewer50u.cab#version=5,0,0,521" name=rdViewer width=100% height=100%> </OBJECT>
</body>
</html>
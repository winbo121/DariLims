
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<link rel="stylesheet" media="screen" type="text/css" href="<c:url value='/css/jquery-ui.css'/>" />
<link rel="stylesheet" media="screen" type="text/css" href="<c:url value='/css/jqgrid/ui.jqgrid.css'/>" />
<link rel="stylesheet" media="screen" type="text/css" href="<c:url value='/css/tree/ui.fancytree.css'/>" />
<link rel="stylesheet" media="screen" type="text/css" href="<c:url value='/css/common/common.css'/>" />
<link rel="stylesheet" media="screen" type="text/css" href="<c:url value='/css/common/main.css'/>" />
<link rel="stylesheet" media="screen" type="text/css" href="<c:url value='/css/common/sub.css'/>" />
<script type="text/javascript" src="<c:url value='/script/jquery-1.11.0.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/script/jquery-ui.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/script/jquery.blockUI.js'/>"></script>
<script type="text/javascript" src="<c:url value='/script/jquery.form.js'/>"></script>
<script type="text/javascript" src="<c:url value='/script/jquery.message.js'/>"></script>
<script type="text/javascript" src="<c:url value='/script/jqgrid/grid.locale-kr.js'/>"></script>
<script type="text/javascript" src="<c:url value='/script/jqgrid/jquery.jqGrid.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/script/tree/jquery.fancytree-all.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/script/lims.com.js'/>"></script>
<script type="text/javascript" src="<c:url value='/script/lims.com.grid.js'/>"></script>

<title>LIMS</title>
<style>

.ui-dialog {
	z-index: 9999 !important;
}
@page 
    {
         size: 70mm 40mm;   /* auto is the initial value */
        margin: 0mm;  /* this affects the margin in the printer settings */
    }

    html
    {
        background-color: #FFFFFF;          
        margin: 0px;  /* this affects the margin on the html before sending to printer */
    }

    body
    {       
       /*  margin: 1mm 3mm 1mm 1mm; margin you want for the content */
        align:center;
    }
.table5_1 {width:100%;}
.table5_1 th {text-align:left; vertical-align:middle; Letter-spacing:1px; padding-left:2px; box-sizing: border-box;}
.table5_1 td {text-align:left; vertical-align:middle; Letter-spacing:1px; box-sizing: border-box;}
.table5_1 tr {text-shadow: 0 1px 1px rgba(256, 256, 256, 0.1); }
.table5_1 td {text-align:left; vertical-align:middle; Letter-spacing:1px; box-sizing: border-box;}

</style>

<script type="text/javascript">
	$(function() {
		var test_req_seq = "${test_req_seq}";
		var json = fnAjaxAction('labelPrint.lims', "test_req_seq="+test_req_seq);
		if (json == null) {
			alert('error');
		} else {
			var content;			
			content = "<div id='printArea' width='100%'><center>";
			
			$(json).each(function(index, entry) {
				//content +="<p style='page-break-before:always;'></p>";
				content +="<table class='table5_1'  style='table-layout: fixed'>";
				content +="<tr>";
				content +="	<th width='25%'>???????????? :</th><td colspan='3'  width='75%'>" + entry["test_sample_seq"] + "</td>";
				content +="</tr>";
				content +="<tr>";
				content +="<th width='25%'>????????? :</th><td colspan='3'  width='75%'>" + entry["sample_reg_nm"] + "</td>";
				content +="</tr>";
				content +="<tr>";
				content +="<th width='25%'>???????????? :</th><td colspan='3'  width='75%'>" + entry["accept_item_info"] + "dddddddddddddddddddddddddd</td>";
				content +="</tr>";
				content +="<tr>";
				content +="<th width='25%'>???????????? :</th><td colspan='3'  width='75%'>" + entry["sample_arrival_date"] + "</td>";
				content +="</tr>";
				content +="<tr>";
				content +="<th width='25%'>???????????? :</th><td  width='35%'>&nbsp;</td><th width='30%'>?????? :</th><th style='text-align:right;' width='10%'>(???)</th>";
				content +="</tr>";
				content +="<tr>";
				content +="<th width='25%'>???????????? :</th><td  width='35%'>&nbsp;</td><th width='30%'>?????? :</th><th style='text-align:right;' width='10%'>(???)</th>";
				content +="</tr>";
				content +="</table>";
				content +="<p style='page-break-after:always;'></p>";
			});
			content += "</center></div>";
			/* content += "<input type=button value='?????? ?????? ??????' onclick='PrintOption(7,1)'>";  
			content += "<input type=button value='?????? ?????? ??????' onclick='PrintOption(6,-1)'>";
			content += "<input type=button value='????????? ??????' onclick='PrintOption(8,1)'>"; */
			
			document.body.innerHTML = content;
			
			PrintOption(7,1);
			
		}
		//window.close();
	});
	
	function labelPrint(test_req_seq){
		
	}
	


	function Print_Area(){
		
		window.print();
	 }

	//??????????????????
	var initBody;
	 function Before_Print() {
	//	initBody = document.body.innerHTML;
		document.body.innerHTML = printArea.innerHTML;
	 }
	var initBody;
	 //????????? ??? ??????
	function After_Print() {
		document.body.innerHTML = initBody;
	 }


	function PrintOption(pram1,pram2){

	        if(pram1 != 8){
	 	window.onbeforeprint = Before_Print;
		//window.onafterprint = After_Print;
		}
	          var browser = navigator.userAgent.toLowerCase();
	          if ( -1 != browser.indexOf('chrome') ){
	                     window.print();
	          }else if ( -1 != browser.indexOf('trident') ){
	                     try{
	                              //????????? IE 5.5 ??????????????? ?????????
	 						//		alert('1');
	                              //??? ???????????? ????????? ??????
	                              var webBrowser = '<OBJECT ID="previewWeb" WIDTH=0 HEIGHT=0 CLASSID="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2"></OBJECT>';
	                          //    alert('2');
	                              //??? ???????????? ?????? ??????
	                              document.body.insertAdjacentHTML('beforeEnd', webBrowser);
	                          //    alert('3');
	                              //ExexWB ????????? ?????? (7 : ???????????? , 8 : ????????? ?????? , 6 : ????????????(????????????))
	                              previewWeb.ExecWB(pram1, pram2);
	                         //     alert('4');
	                              //?????? ??????
	                        //      previewWeb.outerHTML = "/"; 
	                     }catch (e) {
	                              alert("- ?????? > ????????? ?????? > ?????? ??? > ????????? ??? ?????? ????????? ??????\n   1. ????????? ?????? ?????? > ????????? ??????\n   2. ????????? ?????? ?????? ?????? > ?????????????????? ???????????? ?????? ????????? ????????? ActiveX ????????? (??????)?????? ??????\n\n??? ??? ????????? ????????? ????????? ???????????? ?????????");
	                     }
	                    
	          }
	          
	}
</script>
</head>
<body>	
</body>
</html>




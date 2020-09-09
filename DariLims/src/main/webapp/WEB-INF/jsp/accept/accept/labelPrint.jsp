
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
				content +="	<th width='25%'>접수번호 :</th><td colspan='3'  width='75%'>" + entry["test_sample_seq"] + "</td>";
				content +="</tr>";
				content +="<tr>";
				content +="<th width='25%'>시료명 :</th><td colspan='3'  width='75%'>" + entry["sample_reg_nm"] + "</td>";
				content +="</tr>";
				content +="<tr>";
				content +="<th width='25%'>검사항목 :</th><td colspan='3'  width='75%'>" + entry["accept_item_info"] + "dddddddddddddddddddddddddd</td>";
				content +="</tr>";
				content +="<tr>";
				content +="<th width='25%'>입고일자 :</th><td colspan='3'  width='75%'>" + entry["sample_arrival_date"] + "</td>";
				content +="</tr>";
				content +="<tr>";
				content +="<th width='25%'>개봉일자 :</th><td  width='35%'>&nbsp;</td><th width='30%'>이름 :</th><th style='text-align:right;' width='10%'>(인)</th>";
				content +="</tr>";
				content +="<tr>";
				content +="<th width='25%'>폐기일자 :</th><td  width='35%'>&nbsp;</td><th width='30%'>이름 :</th><th style='text-align:right;' width='10%'>(인)</th>";
				content +="</tr>";
				content +="</table>";
				content +="<p style='page-break-after:always;'></p>";
			});
			content += "</center></div>";
			/* content += "<input type=button value='인쇄 미리 보기' onclick='PrintOption(7,1)'>";  
			content += "<input type=button value='인쇄 바로 하기' onclick='PrintOption(6,-1)'>";
			content += "<input type=button value='페이지 설정' onclick='PrintOption(8,1)'>"; */
			
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

	//프린트할내용
	var initBody;
	 function Before_Print() {
	//	initBody = document.body.innerHTML;
		document.body.innerHTML = printArea.innerHTML;
	 }
	var initBody;
	 //프린트 후 내용
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
	                              //참고로 IE 5.5 이상에서만 동작함
	 						//		alert('1');
	                              //웹 브라우저 컨트롤 생성
	                              var webBrowser = '<OBJECT ID="previewWeb" WIDTH=0 HEIGHT=0 CLASSID="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2"></OBJECT>';
	                          //    alert('2');
	                              //웹 페이지에 객체 삽입
	                              document.body.insertAdjacentHTML('beforeEnd', webBrowser);
	                          //    alert('3');
	                              //ExexWB 메쏘드 실행 (7 : 미리보기 , 8 : 페이지 설정 , 6 : 인쇄하기(대화상자))
	                              previewWeb.ExecWB(pram1, pram2);
	                         //     alert('4');
	                              //객체 해제
	                        //      previewWeb.outerHTML = "/"; 
	                     }catch (e) {
	                              alert("- 도구 > 인터넷 옵션 > 보안 탭 > 신뢰할 수 있는 사이트 선택\n   1. 사이트 버튼 클릭 > 사이트 추가\n   2. 사용자 지정 수준 클릭 > 스크립팅하기 안전하지 않은 것으로 표시된 ActiveX 컨트롤 (사용)으로 체크\n\n※ 위 설정은 프린트 기능을 사용하기 위함임");
	                     }
	                    
	          }
	          
	}
</script>
</head>
<body>	
</body>
</html>




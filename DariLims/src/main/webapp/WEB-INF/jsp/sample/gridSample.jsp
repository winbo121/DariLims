<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 필요한 라이브러리만 등록  -->
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
	/***************************************************************************************
	 * 시스템명 		: 
	 * 업무명 		: 
	 * 파일명 		: gridSample.jsp
	 * 작성자 		: 윤상준
	 * 작성일 		: 2015.06.01
	 * 설  명			: 
	 *---------------------------------------------------------------------------------------
	 * 변경일		변경자		변경내역 
	 *---------------------------------------------------------------------------------------
	 * 2015.06.01    윤상준		최초 프로그램 작성         
	 * 
	 *---------------------------------------------------------------------------------------
	 ****************************************************************************************/
%>
<link rel="stylesheet" media="screen" type="text/css" href="<c:url value='/css/common/sub.css'/>" />
<!-- 스크립트 -->
<script type="text/javascript">
	var pageVal = "gridSample";
	var grid = "sampleGrid";
	$(function() {
		fn_gridInit(
				"sample/selectSampleList.lims", 
				pageVal+"Form", 
				"sampleGrid",
				"view_grid_main", 
				setColModel(),
				"auto", //  auto : 자동, "100" 100px;
				10	// -1 : 무한, 10 : 10개,
		);
	});
	
	/* grid 헤더 셋팅  */
	function setColModel(){
		var colModel = [{label: "샘플seq",name:"test_sample_seq",width : '100',align : 'center'},
		                {label: "샘플번호",name:"test_item_seq"},
		                {label: "샘플명",name:"test_item_nm"},
		                {label: "샘플기타",name:"sample_etc",editable : true},
		                {label: "샘플파일명",name:"sample_file_nm"},
		                {label: "샘플파일경로",name:"sample_file_path"},
		                {label: "샘플파일기타",name:"sample_file_etc"},
		                {label: "샘플사용여부",name:"sample_use_yn"},
		                {label: "샘플생성자",name:"sample_creater_id"},
		                {label: "샘플생성일",name:"sample_create_date"},
		                {label: "샘플수정자",name:"sample_updater_id"},
		                {label: "샘플수정일",name:"sample_update_date"}];
		return colModel;
	}
	
	
	
	function sampleGridComplete(grid, girdDiv){		
		$(window).bind('resize', function() {
			$("#"+grid).setGridWidth($('#'+girdDiv).width(), false);
		}).trigger('resize');
	}
	
	function btn_search(){
		//$('#' + grid).setGridParam({page: 1});
		$('#sampleGrid').trigger('reloadGrid');
		//fn_GridData("sample/selectSampleList.lims",pageVal+"Form","sampleGrid");
	}

</script>

<!-- 화면  -->	
<body>
<div>	
	<form name="gridSampleForm" id="gridSampleForm" onsubmit="return false;"> 
	<!-- form 네이밍규칙 화면명+Form  
		name과 id는 동일하게 구성
	-->

	
     	
	<div class="sub_purple_01 w100p">
		<table class="select_table" >
			<tr>
				<td class="table_title">
					<span>■</span>
					샘플 목록
				</td>
				<td class="table_button">
					<span class="button white mlargep" id="btn_search" onclick="btn_search();">
				   		<button type="button"><spring:message code="button.search"/></button>
				   	</span>
					<span class="button white mlargep" id="btn_Select" onclick="">
						<button type="button"><spring:message code="button.insert"/></button>
					</span>
					<span class="button white mlargep" id="btn_Select" onclick="">
						<button type="button"><spring:message code="button.update"/></button>
					</span>
					<span class="button white mlargep" id="btn_Select" onclick="">
						<button type="button"><spring:message code="button.delete"/></button>
					</span>
					<span class="button white mlargep" id="btn_Select" onclick="">
						<button type="button"><spring:message code="button.save"/></button>
					</span>
				</td>
			</tr>
		</table>
		<table class="list_table" >
			<tr>
				<th>
					샘플일련번호
				</th>
				<td>
					<input type="text" name="" id="" value="">
				</td>
				<th>
					샘플명
				</th>
				<td>
					<input type="text" name="sample_nm" id="sample_nm" value="">
				</td>
				<th>
					샘플번호
				</th>
				<td>
					<input type="text" name="" id="" value="">
				</td>
			</tr>
			<tr>
				<th>
					사용여부
				</th>
				<td>
					<input type="text" name="" id="" value="">
				</td>
				<th>
					생성일
				</th>
				<td>
					<input type="text" name="" id="" value="">
				</td>
				<th>
					작성자
				</th>
				<td>
					<input type="text" name="" id="" value="">
				</td>
			</tr>
		</table>
	</div>
	<!-- 그리드영역 -->
	<%-- <input type="hidden" id="type" name="type" value="${type}"> --%>
	<input type="hidden" id="sortName" name="sortName">
	<input type="hidden" id="sortType" name="sortType">
	<input type='hidden' id='pageNum' name='pageNum'/>
	<input type='hidden' id='pageSize' name='pageSize'/>
	<input type='hidden' id='sortTarget' name='sortTarget'/>
	<input type='hidden' id='sortValue' name='sortValue'/>
	<div id="view_grid_main">
		<table id="sampleGrid"></table>
		<div id="sampleGridPager"></div>
	</div>
   	
	</form>
</div>
</body>
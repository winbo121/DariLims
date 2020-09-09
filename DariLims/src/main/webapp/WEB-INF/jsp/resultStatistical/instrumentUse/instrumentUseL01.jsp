
<%
	/***************************************************************************************
	 * 시스템명 	: 통합장비관제시스템
	 * 업무명 		: 장비활용조회
	 * 파일명 		: instrumentUseL01.jsp
	 * 작성자 		: 허태원
	 * 작성일 		: 2015.12.10
	 * 설  명		: 장비활용 조회 화면
	 *---------------------------------------------------------------------------------------
	 * 변경일		변경자		변경내역 
	 *---------------------------------------------------------------------------------------
	 * 2015.12.10   허태원		최초 프로그램 작성         
	 * 
	 *---------------------------------------------------------------------------------------
	 ****************************************************************************************/
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html >
<link rel="stylesheet" media="screen" type="text/css" href="<c:url value='/css/common/sub.css'/>" />
<script type="text/javascript">
	var colModel;
	var groupHeaders;
	$(function() {
		/* 세부권한검사 */
		fn_auth_check();

		//올해년도조회
		checkYear('ALL', new Date().getFullYear(), 'year');

		// 그리드 사이즈 
		$(window).bind('resize', function() {
			$("#instrumentUseGrid").setGridWidth($('#view_grid_main').width(), false);
		}).trigger('resize');

		// 엔터키 눌렀을 경우(구매목록 그리드 조회)
		fn_Enter_Search('instrumentUseForm', 'instrumentUseGrid');
	});

	// 실적 및 통계 그리드
	function instrumentUseGrid(url, form, grid) {
		$('#' + grid).jqGrid({
			datatype : function(json) {
				fnGridData(url, form, grid);
			},
			height : '431',
			autowidth : false,
			loadonce : true,
			mtype : "POST",
			gridview : true,
			shrinkToFit : true,
			rowNum : -1,
			rownumbers : true,
			colModel : colModel,
			gridComplete : function() {
			},
			onSortCol : function(index, iCol, sortorder) {
				if(!com_auth_select){return 'stop';}else{fnSortCol(form, index, sortorder);}
			},
			onSelectRow : function(rowId, status, e) {
			}
		});
		$('#' + grid).jqGrid('setGroupHeaders', {
			useColSpanStyle : true,
			groupHeaders : groupHeaders
		});

	}
	
	//조회버튼
	function btn_Select_onclick() {
		colModel = new Array();
		groupHeaders = new Array();
		colModel.push({
			label : '장비번호',
			name : 'inst_no',
			width : '100',
			hidden : true
		});
		colModel.push({
			label : '장비명(KOR)',
			name : 'inst_kor_nm',
			width : '200'
		});
		colModel.push({
			label : '장비명(ENG)',
			name : 'inst_eng_nm',
			width : '200'
		});
		colModel.push({
			label : '관리자(정)',
			name : 'mng_nm',
			width : '100'
		});
		colModel.push({
			label : '관리자(부)',
			name : 'mng_sub_nm',
			width : '100'
		});
		colModel.push({
			label : '가동',
			name : 'manage_flag',
			width : '50',
			align : 'center',
			edittype : "select",
			editoptions : {
				value : 'Y:상시;N:활용'
			},
			formatter : 'select'
		});
		colModel.push({
			label : 'NTIS',
			name : 'ntis_no',
			width : '150'
		});
		colModel.push({
			label : '설치일',
			name : 'instl_date',
			width : '90',
			align : 'center'
		});

		var type = $("#instrumentUseForm input[type='radio']:checked").val();
		switch (type) {
		case 'month':
			colModel.push({
				label : '1월',
				name : 'm01',
				width : '50',
				align : 'right'
			});
			colModel.push({
				label : '2월',
				name : 'm02',
				width : '50',
				align : 'right'
			});
			colModel.push({
				label : '3월',
				name : 'm03',
				width : '50',
				align : 'right'
			});
			colModel.push({
				label : '4월',
				name : 'm04',
				width : '50',
				align : 'right'
			});
			colModel.push({
				label : '5월',
				name : 'm05',
				width : '50',
				align : 'right'
			});
			colModel.push({
				label : '6월',
				name : 'm06',
				width : '50',
				align : 'right'
			});
			colModel.push({
				label : '7월',
				name : 'm07',
				width : '50',
				align : 'right'
			});
			colModel.push({
				label : '8월',
				name : 'm08',
				width : '50',
				align : 'right'
			});
			colModel.push({
				label : '9월',
				name : 'm09',
				width : '50',
				align : 'right'
			});
			colModel.push({
				label : '10월',
				name : 'm10',
				width : '50',
				align : 'right'
			});
			colModel.push({
				label : '11월',
				name : 'm11',
				width : '50',
				align : 'right'
			});
			colModel.push({
				label : '12월',
				name : 'm12',
				width : '50',
				align : 'right'
			});
			break;
		default:
			colModel.push({
				label : '1분기',
				name : 'q01',
				width : '50',
				align : 'right'
			});
			colModel.push({
				label : '2분기',
				name : 'q02',
				width : '50',
				align : 'right'
			});
			colModel.push({
				label : '3분기',
				name : 'q03',
				width : '50',
				align : 'right'
			});
			colModel.push({
				label : '4분기',
				name : 'q04',
				width : '50',
				align : 'right'
			});
			break;
		}
		colModel.push({
			label : '가용시간',
			name : 'tot_use_time',
			width : '70',
			align : 'right'
		});
		colModel.push({
			label : '가동시간',
			name : 'manage_time',
			width : '70',
			align : 'right'
		});
		colModel.push({
			label : '가동률',
			name : 'manage_rate',
			width : '50',
			align : 'right'
		});
		
		$('#instrumentUseGrid').jqGrid('GridUnload');
		instrumentUseGrid('resultStatistical/selectInstrumentUseList.lims', 'instrumentUseForm', 'instrumentUseGrid');
		//$('#instrumentUseGrid').clearGridData(); // 최초 조회시 데이터 안나옴
		
		$("#instrumentUseGrid").setGridWidth($('#view_grid_main').width(), false);
	}

	//구매년도 콤보박스
	function checkYear(type, year, id) {
		var name = id;
		if (type == 'ALL') {
			$('#' + name).append($('<option />').val('').html('전체'));
		}
		for (var i = new Date().getFullYear() + 5; i > new Date().getFullYear() - 6; i--) {
			if (year == i) {
				$('#' + name).append($('<option selected />').val(i).html(i + ' 년'));
			} else
				$('#' + name).append($('<option />').val(i).html(i + ' 년'));
		}
	}
	function btn_Excel_onclick() {
		var data = fn_Excel_Data_Make('instrumentUseGrid');
		fn_Excel_Download(data);
	}
</script>

<!-- 실적 및 통계 그리드 -->
<div class="sub_purple_01 w100p" id="view_grid_main">
	<form id="instrumentUseForm" name="instrumentUseForm" onsubmit="return false;">
		<table  class="select_table" >
			<tr>
				<td class="table_title">
					<span>■</span>
					과별단위업무실적
				</td>
				<td class="table_button">
					<span class="button white mlargep auth_select" id="btn_Select" onclick="btn_Select_onclick();">
						<button type="button">조회</button>
					</span>
					<span class="button white mlargeb auth_select" onclick="btn_Excel_onclick();">
						<button type="button">EXCEL</button>
					</span>
				</td>
			</tr>
		</table>
		<table  class="list_table" >
			<tr>
				<th>구분</th>
				<td>
					<input type="radio" name="type" id="type" style="margin-left: 15px; top: 1px;" class="w15" value="month" checked="checked" />
					월별
					<input type="radio" name="type" id="type" style="margin-left: 15px; top: 1px;" class="w15" value="quarter" />
					분기
				</td>
				<th>조회년도</th>
				<td colspan="5">
					<select name="year" id="year" class="w120px"></select>
				</td>
			</tr>
		</table>
		<input type="hidden" id="sortName" name="sortName">
		<input type="hidden" id="sortType" name="sortType">
		<table id="instrumentUseGrid"></table>
	</form>
</div>
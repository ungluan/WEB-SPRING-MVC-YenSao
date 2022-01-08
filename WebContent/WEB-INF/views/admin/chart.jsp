<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c'%>
<%@ taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="f"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="tg" tagdir="/WEB-INF/tags"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="IE=edge">

<title>Chart</title>
<base href="${pageContext.servletContext.contextPath}/">

<script type="text/javascript">
	window.onload = function() {

		var dps = [ [] ];
		var chart = new CanvasJS.Chart("chartContainer", {
			theme : "light1", // "light1", "dark1", "dark2"
			animationEnabled : true,
			title : {

			},
			axisX : {
				prefix : "Tháng ",
				valueFormatString : "####"
			},
			axisY : {
				title : "Doanh thu (VNĐ)",
				includeZero : true,
				suffix : " VNĐ"
			},
			data : [ {
				type : "line",
				xValueFormatString : "Tháng ####",
				yValueFormatString : "#,### VNĐ",
				dataPoints : dps[0]
			} ]
		});

		var xValue;
		var yValue;

		<c:forEach items="${dataPointsList}" var="dataPoints" varStatus="loop">
		<c:forEach items="${dataPoints}" var="dataPoint">
		xValue = parseInt("${dataPoint.x}");
		yValue = parseFloat("${dataPoint.y}");
		dps[parseInt("${loop.index}")].push({
			x : xValue,
			y : yValue
		});
		</c:forEach>
		</c:forEach>

		chart.render();

	}
</script>
<%@ include file="/WEB-INF/views/include/admin-header.jsp"%>
</head>

<body>
	<div class="wrapper">
		<!-- Sidebar  -->
		<%@ include file="/WEB-INF/views/include/admin-slider-bar.jsp"%>

		<div class="white-box">
			<h5 class="box-title">Năm:</h5>
			<!-- ==== -->
			<form:form class="d-inline-flex" action="admin/home" method="POST">
				<input name="searchInput" id="searchInput" class="form-control me-2"
					type="search" placeholder="Nhập năm cần xem doanh thu"
					aria-label="Search" value="${nam}">
				<button name="btnSearch" id="btnSearch"
					class="btn btn-outline-success" type="submit">Search</button>
			</form:form>
		</div>
		<div class="row" style="margin-top: 16px; margin-left: 6px">
			<h6>
				Tổng doanh thu:  
				<h6 style="font-weight: bold; color: red;">
					<f:formatNumber value="${total}" type="currency"
						currencySymbol="VND" />
				</h6>
			</h6>
		</div>
		<h3 style="margin-top: 16px;">
			<center>Biểu đồ doanh thu năm ${ nam }</center>
		</h3>
		<div class="container-fluid">
			<div id="chartContainer" style="height: 370px; width: 100%;"></div>
			<script src="https://canvasjs.com/assets/script/canvasjs.min.js"></script>
		</div>
	</div>
	<!-- jQuery CDN - Slim version (=without AJAX) -->
	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
		integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
		crossorigin="anonymous"></script>
	<!-- Popper.JS -->
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"
		integrity="sha384-cs/chFZiN24E4KMATLdqdvsezGxaGsi4hLGOzlXwp5UZB1LY//20VyM2taTB4QvJ"
		crossorigin="anonymous"></script>
	<!-- Bootstrap JS -->
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"
		integrity="sha384-uefMccjFJAIv6A+rW+L4AHf99KvxDjWSu1z9VI8SKNVmz4sk7buKt/6v9KI65qnm"
		crossorigin="anonymous"></script>
	<!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script> -->
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
	<script type="text/javascript">
		$(document).ready(function() {
			$('#sidebarCollapse').on('click', function() {
				$('#sidebar').toggleClass('active');
			});
		});
	</script>
	<script type="text/javascript"
		src="<c:url value='/resources/js/dialog.js'/>">
		
	</script>

</body>
</html>

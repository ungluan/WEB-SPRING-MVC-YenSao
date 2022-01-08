<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c'%>
<%@ taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="f"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="tg" tagdir="/WEB-INF/tags/admin/"%>

<!DOCTYPE html>
<html>

<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="IE=edge">

<title>Orders</title>
<base href="${pageContext.servletContext.contextPath}/">

<style type="text/css">
table {
	font-family: arial, sans-serif;
	border-collapse: collapse;
	width: 100%;
}

td, th {
	border: 1px solid #dddddd;
	text-align: left;
	padding: 8px;
}

.thumb-image {
	float: left;
	width: 100px;
	position: relative;
	padding: 5px;
}

.selectedItem {
	border: 2px solid blue;
}
</style>

<%@ include file="/WEB-INF/views/include/admin-header.jsp"%>

</head>

<body>
	<div class="wrapper">
		<!-- Sidebar  -->
		<%@ include file="/WEB-INF/views/include/admin-slider-bar.jsp"%>

		<!-- Here -->
		<div class="container-fluid">
			<div class="row">
				<div class="col-sm-12">
					<div class="white-box">
						<center>
							<h3 class="box-title"
								style="font-size: 32px; font-weight: 500; margin-top: 32px; margin-bottom: 32px;">Đơn
								đặt hàng ${ orderId } </h3>
						</center>
						<!-- ==== -->
						<%-- <form class="d-inline-flex">
				<input name="searchInput" id="searchInput" class="form-control me-2"
					type="search" placeholder="Search" aria-label="Search">
				<button name="btnSearch" id="searchBranch"
					class="btn btn-outline-success" type="submit">Search</button>
			</form>
		</div> --%>

						<!-- ==== -->
						<jsp:useBean id="pagedListHolder" scope="request"
							class="org.springframework.beans.support.PagedListHolder" />
						<c:url value="admin/order/detail" var="pagedLink">
							<c:param name="p" value="~">
							</c:param>
						</c:url>
						<%-- <p class="text-muted">Add class <code>.table</code></p> --%>
						<div>
							<div class="table-responsive">
								<table class="table text-nowrap" style="align-content: center">
									<thead>
										<tr>
											<th class="border-top-0">Id</th>
											<th class="border-top-0">Tên sản phẩm</th>
											<th class="border-top-0">Số lượng</th>
											<th class="border-top-0">Giảm giá</th>
											<th class="border-top-0">Giá tiền</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach var="detail" items="${pagedListHolder.pageList}"
											varStatus="loop">
											<tr>
												<td>${detail.id}</td>
												<td>${detail.product.name}</td>
												<td>${detail.numbers}</td>
												<td><f:formatNumber
														value="${detail.numbers*detail.product.price*0.01*detail.product.sale}"
														type="currency" currencySymbol="VND" /></td>
												<td><f:formatNumber
														value="${detail.numbers*detail.product.price*0.01*(100-detail.product.sale)}"
														type="currency" currencySymbol="VND" /></td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
							</div>
							<div style="margin-bottom: 32px">
								<tg:paging pagedListHolder="${pagedListHolder}"
									pagedLink="${pagedLink}" />
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	</div>
	</div>

	</div>
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

	<script type="text/javascript"
		src="<c:url value='/resources/dist/js/img_script.js'/>">
		
	</script>

</body>

</html>
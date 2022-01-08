<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c'%>
<%@ taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="f"%>
<%@ taglib prefix="tg" tagdir="/WEB-INF/tags/"%>
<%-- <%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%> --%>

<!DOCTYPE html>
<head>
<%@ include file="/WEB-INF/views/include/header.jsp"%>
<base href="${pageContext.servletContext.contextPath}/">
<title>Xác nhận</title>
</head>

<%@ include file="/WEB-INF/views/include/menu.jsp"%>

<!-- END nav -->

<div class="hero-wrap hero-bread"
	style="background-image: url('resources/images/bg_1.jpg');">
	<div class="container">
		<div
			class="row no-gutters slider-text align-items-center justify-content-center">
			<div class="col-md-9 ftco-animate text-center">
				<p class="breadcrumbs">
					<span class="mr-2"><a >Chi</a></span>tiết<span></span>
				</p>
				<h1 class="mb-0 bread">Đơn hàng của tôi</h1>
			</div>
		</div>
	</div>
</div>

<div class="row">
	<div class="col-sm-12"
		style="margin-left: 32px; margin-right: 32px; margin-left: 32px;">
		<div class="white-box">
			<!-- ==== -->
			<%-- <form class="d-inline-flex">
				<input name="searchInput" id="searchInput" class="form-control me-2"
					type="search" placeholder="Search" aria-label="Search">
				<button name="btnSearch" id="searchBranch"
					class="btn btn-outline-success" type="submit">Search</button>
			</form>
		</div> --%>

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
						<c:url value="cart/ordered/detail" var="pagedLink">
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


<%@ include file="/WEB-INF/views/include/footer.jsp"%>


<%@ include file="/WEB-INF/views/include/loader.jsp"%>


<!-- <script src="js/jquery.min.js"></script> -->
<script src="<c:url value='/resources/js/jquery.min.js'/>"></script>
<!-- <script src="js/jquery-migrate-3.0.1.min.js"></script> -->
<script src="<c:url value='/resources/js/jquery-migrate-3.0.1.min.js'/>"></script>
<!-- <script src="js/popper.min.js"></script> -->
<script src="<c:url value='/resources/js/popper.min.js'/>"></script>
<!-- <script src="js/bootstrap.min.js"></script> -->
<script src="<c:url value='/resources/js/bootstrap.min.js'/>"></script>
<!-- <script src="js/jquery.easing.1.3.js"></script> -->
<script src="<c:url value='/resources/js/jquery.easing.1.3.js'/>"></script>
<!-- <script src="js/jquery.waypoints.min.js"></script> -->
<script src="<c:url value='/resources/js/jquery.waypoints.min.js'/>"></script>
<!-- <script src="js/jquery.stellar.min.js"></script> -->
<script src="<c:url value='/resources/js/jquery.stellar.min.js'/>"></script>
<!-- <script src="js/owl.carousel.min.js"></script> -->
<script src="<c:url value='/resources/js/owl.carousel.min.js'/>"></script>
<!-- <script src="js/jquery.magnific-popup.min.js"></script> -->
<script
	src="<c:url value='/resources/js/jquery.magnific-popup.min.js'/>"></script>
<!-- <script src="js/aos.js"></script> -->
<script src="<c:url value='/resources/js/aos.js'/>"></script>
<!-- <script src="js/jquery.animateNumber.min.js"></script> -->
<script src="<c:url value='/resources/js/jquery.animateNumber.min.js'/>"></script>
<!-- <script src="js/bootstrap-datepicker.js"></script> -->
<script src="<c:url value='/resources/js/bootstrap-datepicker.js'/>"></script>
<!-- <script src="js/scrollax.min.js"></script> -->
<script src="<c:url value='/resources/js/scrollax.min.js'/>"></script>
<script
	src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBVWaKrjvy3MaE7SQ74_uJiULgl1JY0H2s&sensor=false"></script>
<!-- <script src="js/google-map.js"></script> -->
<script src="<c:url value='/resources/js/google-map.js'/>"></script>
<!-- <script src="js/main.js"></script> -->
<script src="<c:url value='/resources/js/main.js'/>"></script>


</body>
</html>
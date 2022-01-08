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
<title>Đơn hàng</title>
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
					<span class="mr-2"><a>Tất cả</a></span> <span>Đơn hàng</span>
				</p>
				<h1 class="mb-0 bread">Đơn hàng</h1>
			</div>
		</div>
	</div>
</div>

<div class="row">
	<div class="col-sm-12"
		style="margin-left: 32px; margin-right: 32px; margin-left: 32px;">
		<div class="white-box">
			<center>
				<h3 class="box-title"
					style="font-size: 32px; font-weight: 500; margin-top: 32px; margin-bottom: 32px;">Đơn
					hàng đã đặt</h3>
			</center>
			<!-- ==== -->
			<form class="d-inline-flex">
				<input name="searchInput" id="searchInput" class="form-control me-2"
					type="search" placeholder="Nhập id đơn hàng"
					aria-label="Nhập id đơn hàng">
				<button name="btnSearch" id="searchBranch"
					class="btn btn-outline-success" type="submit">Tìm kiếm</button>
			</form>
		</div>

		<!-- ==== -->
		<jsp:useBean id="pagedListHolder" scope="request"
			class="org.springframework.beans.support.PagedListHolder" />
		<c:url value="cart/ordered" var="pagedLink">
			<c:param name="p" value="~">
			</c:param>
		</c:url>
		<%-- <p class="text-muted">Add class <code>.table</code></p> --%>

		<div style="margin-left: 32px; margin-right: 32px; margin-left: 32px;">
			<div class="table-responsive">
				<table class="table text-nowrap" style="align-content: center">
					<thead>
						<tr>
							<th class="border-top-0">Id</th>
							<th class="border-top-0">Tên người nhận</th>
							<th class="border-top-0">Địa chỉ</th>
							<th class="border-top-0">Ngày đặt hàng</th>
							<th class="border-top-0">Số điện thoại</th>
							<th class="border-top-0">Tổng tiền</th>
							<th class="border-top-0">Trạng Thái</th>
							<th class="border-top-0">Hủy đơn hàng</th>
							<th class="border-top-0">Xem chi tiết</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="order" items="${pagedListHolder.pageList}"
							varStatus="loop">
							<tr>
								<td>${order.id}</td>
								<td>${order.name}</td>
								<td>${order.address}</td>
								<td><f:formatDate value="${order.date}"
										pattern="dd/MM/yyyy" /></td>
								<td>${order.numberPhone}</td>
								<td><f:formatNumber value="${order.total}" type="currency"
										currencySymbol="VND" /></td>

								<%-- <c:choose>
									<c:when test="${order.finished == true}">
										<td style="color: #ff0000">Đã hoàn thành</td>
									</c:when>
									<c:when test="${order.delivered == true}">
										<td style="color: #2b099b">Đang giao hàng</td>
									</c:when>
									<c:when test="${order.cancel == true}">
										<td style="color: #bc1616">Đã hủy đơn hàng</td>
									</c:when>
									<c:otherwise>
										<td style="color: #247f0b">Đang xử lý đơn hàng</td>
									</c:otherwise>
								</c:choose>


								<td><c:choose>
										<c:when test="${order.finished == true }">
											<!-- <button type="button" disabled="true"
																class="btn btn-secondary">Hủy đơn hàng</button> -->
										</c:when>
										<c:when test="${order.delivered == true }">
											<button type="button" readonly="true"
												class="btn btn-secondary">Hủy đơn hàng</button>
										</c:when>
										<c:when test="${order.cancel == true }">
											<button type="button" readonly="true" class="btn btn-danger">Đã
												hủy</button>
										</c:when>
										<c:otherwise>
											<a href="admin/order/cancel/${order.id}"><button
													type="submit" onclick="" class="btn btn-warning">Hủy
													đơn hàng</button></a>
										</c:otherwise>
									</c:choose></td> --%>
								<c:choose>
									<c:when test="${order.orderStatus.id == 4}">
										<td style="color: #ff0000; font-weight: bold">Đã hoàn
											thành</td>
									</c:when>
									<c:when test="${order.orderStatus.id == 3}">
										<td style="color: #400656; font-weight: bold">Đã hủy đơn
											hàng</td>
									</c:when>
									<c:when test="${order.orderStatus.id == 2}">
										<td style="color: #2b099b; font-weight: bold">Đang giao
											hàng</td>
									</c:when>
									<c:when test="${order.orderStatus.id == 1}">
										<td style="color: #247f0b; font-weight: bold">Đang xử lý
											đơn hàng</td>
									</c:when>
									<c:otherwise>
										<td></td>
									</c:otherwise>
								</c:choose>
								<td><c:choose>
										<c:when test="${order.orderStatus.id == 4 }">
											<!-- <button type="button" disabled="true"
																class="btn btn-secondary">Hủy đơn hàng</button> -->
										</c:when>
										<c:when test="${order.orderStatus.id == 2}">
											<button type="button" readonly="true"
												class="btn btn-secondary">Hủy đơn hàng</button>
										</c:when>
										<c:when test="${order.orderStatus.id == 3 }">
											<button type="button" readonly="true" class="btn btn-danger">Đã
												hủy</button>
										</c:when>
										<c:when test="${order.orderStatus.id == 1 }">
											<a href="order/cancel/${order.id}"><button type="submit"
													onclick="" class="btn btn-warning">Hủy đơn hàng</button></a>
										</c:when>
										<c:otherwise>
											<td></td>
										</c:otherwise>
									</c:choose></td>

								<td><a href="cart/ordered/detail/${order.id}"><button
											type="submit" onclick="" class="btn btn-primary">Xem
											chi tiết</button></a></td>
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

<section class="ftco-section ftco-no-pt ftco-no-pb py-5 bg-light">
	<div class="container py-4">
		<div class="row d-flex justify-content-center py-5">
			<div class="col-md-6">
				<h2 style="font-size: 22px;" class="mb-0">Subcribe to our
					Newsletter</h2>
				<span>Get e-mail updates about our latest shops and special
					offers</span>
			</div>
			<div class="col-md-6 d-flex align-items-center">
				<form action="#" class="subscribe-form">
					<div class="form-group d-flex">
						<input type="text" class="form-control"
							placeholder="Enter email address"> <input type="submit"
							value="Subscribe" class="submit px-3">
					</div>
				</form>
			</div>
		</div>
	</div>
</section>


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
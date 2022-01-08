	<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c'%>
<%@ taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="f"%>
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
					<span class="mr-2"><a>Đơn hàng</a></span> <span>Của tôi</span>
				</p>
				<h1 class="mb-0 bread">Xác nhận</h1>
			</div>
		</div>
	</div>
</div>
<form action="cart/orders" method="post" >
	<div>
		<section class="ftco-section ftco-cart">
			<div class="row justify-content-end">
				<div class="col-lg-6 mt-5 cart-wrap ftco-animate">
					<div class="cart-total mb-3">
						<h3>Thông tin mua hàng</h3>
						<p>Vui lòng nhập chính xác địa chỉ nhận hàng</p>

						<div class="form-group">
							<label>Họ và tên</label> <input type="text" name="name"
								class="form-control text-left px-3" value="${name }"
								placeholder="Vui lòng nhập họ tên" required="true" minlenght="8" maxlength="40" />
						</div>
						<div class="form-group">
							<label>Số điện thoại</label> <input type="text" name="phone"
								class="form-control text-left px-3" value="${phone }"
								placeholder="Vui lòng nhập số điện thoại" required="true" minlength="10" maxlength="10"/>
						</div>
						<div class="form-group">
							<label>Địa chỉ</label> <input type="text" name="address" value="${address}"
								class="form-control text-left px-3"
								placeholder="Vui lòng nhập địa chỉ" required="true" minlength="32" />
						</div>
					</div>
				</div>
				<div class="col-lg-4 mt-5 cart-wrap ftco-animate">
					<div class="cart-total mb-3">
						<h3>Thanh Toán</h3>
						<p class="d-flex">
							<span>Tổng số tiền</span> <span><f:formatNumber
									value="${ sumPrice }" type="currency" currencySymbol="VND" /></span>
						</p>
						<p class="d-flex">
							<span>Tổng tiền giảm</span> <span><f:formatNumber
									value="${ sumSale }" type="currency" currencySymbol="VND" /></span>
						</p>
						<hr>
						<p class="d-flex total-price">
							<span>Tổng thanh toán</span> <span><f:formatNumber
									value="${ sumPrice - sumSale }" type="currency"
									currencySymbol="VND" /></span>
						</p>
					</div>
				</div>
			</div>
		</section>
		<center>
			<button style="margin-bottom: 32px"
				class="btn btn-primary py-3 px-4">Đặt hàng</button>
		</center>
	</div>
</form>


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



<%-- <!-- loader -->
<div id="ftco-loader" class="show fullscreen">
	<svg class="circular" width="48px" height="48px">
		<circle class="path-bg" cx="24" cy="24" r="22" fill="none"
			stroke-width="4" stroke="#eeeeee" />
		<circle class="path" cx="24" cy="24" r="22" fill="none"
			stroke-width="4" stroke-miterlimit="10" stroke="#F96D00" /></svg>
</div>
 --%>

<!-- <script src="js/jquery.min.js"></script>
<script src="js/jquery-migrate-3.0.1.min.js"></script>
<script src="js/popper.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/jquery.easing.1.3.js"></script>
<script src="js/jquery.waypoints.min.js"></script>
<script src="js/jquery.stellar.min.js"></script>
<script src="js/owl.carousel.min.js"></script>
<script src="js/jquery.magnific-popup.min.js"></script>
<script src="js/aos.js"></script>
<script src="js/jquery.animateNumber.min.js"></script>
<script src="js/bootstrap-datepicker.js"></script>
<script src="js/scrollax.min.js"></script>
<script
	src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBVWaKrjvy3MaE7SQ74_uJiULgl1JY0H2s&sensor=false"></script>
<script src="js/google-map.js"></script>
<script src="js/main.js"></script> -->

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
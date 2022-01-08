<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%-- <%@ taglib uri="http://java.sun.com/jstl/core" prefix="c"%> --%>
<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c'%>
<%@ taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="f"%>

<!DOCTYPE html>
<head>
<%@ include file="/WEB-INF/views/include/header.jsp"%>
<base href="${pageContext.servletContext.contextPath}/">
<title>Trang chủ</title>
</head>

<%@ include file="/WEB-INF/views/include/menu.jsp"%>

<!-- Slider Item -->
<section id="home-section" class="hero">
	<div class="home-slider owl-carousel">
		<div class="slider-item"
			style="background-image: url(resources/images/bg_1.jpg);">
			<div class="overlay"></div>
			<div class="container">
				<div
					class="row slider-text justify-content-center align-items-center"
					data-scrollax-parent="true">

					<div class="col-md-12 ftco-animate text-center">
						<h1 class="mb-2"> Yến sào thượng hạng</h1>
						<h2 class="subheading mb-4"> Chất lượng đã được 
							kiểm chứng</h2>
						<p>
							<a href="products/" class="btn btn-primary">Xem chi tiết</a>
						</p> -->
					</div>

				</div>
			</div>
		</div>

		<div class="slider-item"
			style="background-image: url(resources/images/bg_2.jpg);">
			<div class="overlay"></div>
			<div class="container">
				<div
					class="row slider-text justify-content-center align-items-center"
					data-scrollax-parent="true">

					<div class="col-sm-12 ftco-animate text-center">
						<h1 class="mb-2">100% từ thiên nhiên</h1>
						<h2 class="subheading mb-4"> Chúng tôi chuyên cung cấp thực phẩm
							&amp; yến sào</h2>
						<p>
							<a href="products/" class="btn btn-primary">Xem chi tiết</a>
						</p>
					</div>

				</div>
			</div>
		</div>
	</div>
</section>
<!-- End Slider Item -->
<section class="ftco-section">
	<div class="container">
		<div class="row no-gutters ftco-services">
			<div
				class="col-md-3 text-center d-flex align-self-stretch ftco-animate">
				<div class="media block-6 services mb-md-0 mb-4">
					<div
						class="icon bg-color-1 active d-flex justify-content-center align-items-center mb-2">
						<span class="flaticon-shipped"></span>
					</div>
					<div class="media-body">
						<h3 class="heading">Miễn phí giao hàng</h3>
						<span>Cho đơn hàng từ 1 triệu trở lên</span>
					</div>
				</div>
			</div>
			<div
				class="col-md-3 text-center d-flex align-self-stretch ftco-animate">
				<div class="media block-6 services mb-md-0 mb-4">
					<div
						class="icon bg-color-2 d-flex justify-content-center align-items-center mb-2">
						<span class="flaticon-diet"></span>
					</div>
					<div class="media-body">
						<h3 class="heading">Sản phẩm từ thiên nhiên</h3>
						<span>Chất lượng đặt lên hàng đầu</span>
					</div>
				</div>
			</div>
			<div
				class="col-md-3 text-center d-flex align-self-stretch ftco-animate">
				<div class="media block-6 services mb-md-0 mb-4">
					<div
						class="icon bg-color-3 d-flex justify-content-center align-items-center mb-2">
						<span class="flaticon-award"></span>
					</div>
					<div class="media-body">
						<h3 class="heading">Vệ sinh thực phẩm</h3>
						<span>Có chứng nhận đạt tiêu chuẩn vệ sinh an toàn thực phẩm</span>
					</div>
				</div>
			</div>
			<div
				class="col-md-3 text-center d-flex align-self-stretch ftco-animate">
				<div class="media block-6 services mb-md-0 mb-4">
					<div
						class="icon bg-color-4 d-flex justify-content-center align-items-center mb-2">
						<span class="flaticon-customer-service"></span>
					</div>
					<div class="media-body">
						<h3 class="heading">Hỗ trợ</h3>
						<span>Hỗ trợ 24/7</span>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>

<section class="ftco-section ftco-category ftco-no-pt">
	<div class="container">
		<div class="row">
			<div class="col-md-8">
				<div class="row">
					<div class="col-md-6 order-md-last align-items-stretch d-flex">
						<div
							class="category-wrap-2 ftco-animate img align-self-stretch d-flex"
							style="background-image: url(resources/images/category_0.jpg);">
							<div class="text text-center">
								<h2 style="font-weight: bold;">Yến Sào</h2>
								<p style="color: rgb(83, 112, 96);">Món quà ý nghĩa cho mọi nhà</p>
								<p>
									<a href="products/" class="btn btn-primary">Mua sắm</a>
								</p>
							</div>
						</div>
					</div>
					<div class="col-md-6">
						<div
							class="category-wrap ftco-animate img mb-4 d-flex align-items-end"
							style="background-image: url(resources/images/category_1.jpg);">
							<div class="text px-3 py-1">
								<h2 class="mb-0">
									<a href="products/1?linkCategory">Bạch yến</a>
								</h2>
							</div>
						</div>
						<div class="category-wrap ftco-animate img d-flex align-items-end"
							style="background-image: url(resources/images/category_2.jpg);">
							<div class="text px-3 py-1">
								<h2 class="mb-0">
									<a href="products/2?linkCategory">Hồng yến</a>
								</h2>
							</div>
						</div>
					</div>
				</div>
			</div>

			<div class="col-md-4">
				<div
					class="category-wrap ftco-animate img mb-4 d-flex align-items-end"
					style="background-image: url(resources/images/category_3.jpg);">
					<div class="text px-3 py-1">
						<h2 class="mb-0">
							<a href="products/3?linkCategory">Huyết yến</a>
						</h2>
					</div>
				</div>
				<div class="category-wrap ftco-animate img d-flex align-items-end"
					style="background-image: url(resources/images/category_4.jpg);">
					<div class="text px-3 py-1">
						<h2 class="mb-0">
							<a href="products/7?linkCategory">Tổ yến trưng</a>
						</h2>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>

<section class="ftco-section">
	<div class="container">
		<div class="row justify-content-center mb-3 pb-3">
			<div class="col-md-12 heading-section text-center ftco-animate">
				<span class="subheading">Sản phẩm nổi bật</span>
				<h2 class="mb-4">Của chúng tôi</h2>
				<p>100% từ thiên nhiên</p>
			</div>
		</div>
	</div>
	<div class="container">
		<div class="row">
			<c:forEach var="product" items="${products}" begin="0"
				end="${products.size()}">

				<c:if test="${product.highlight}">
					<div class="col-md-6 col-lg-3 ftco-animate">
						<div class="product">
							<a href="products/product-detail/${product.id}" class="img-prod"><img
								class="img-fluid"
								src="resources/images/${product.getFirstImagePath()}"
								alt="Colorlib Template"> <span class="status">${product.sale }%</span>
								<div class="overlay"></div> </a>
							<div class="text py-3 pb-4 px-3 text-center">
								<h3>
									<a href="products/product-detail/${product.id}">${product.name}</a>
								</h3>
								<div class="d-flex">
									<div class="pricing">
										<p class="price">
											<span class="mr-2 price-dc"><f:formatNumber
													value="${product.price}" type="currency"
													currencySymbol="VND" /></span> <br> <span class="price-sale"><f:formatNumber
													value="${product.price *(100 - product.sale)* 0.01}"
													type="currency" currencySymbol="VND" /></span>
										</p>
									</div>
								</div>
								<div class="bottom-area d-flex px-3">
									<div class="m-auto d-flex">
										<a href="products/add-product-highlight/${product.id}"
											class="buy-now d-flex justify-content-center align-items-center mx-1">
											<span><i class="ion-ios-cart"></i></span>
										</a>
									</div>
								</div>
							</div>
						</div>
					</div>
				</c:if>

			</c:forEach>
</section>


<%@ include file="/WEB-INF/views/include/partner.jsp"%>

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
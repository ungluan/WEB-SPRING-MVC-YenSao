<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c'%>
<%@ taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="f"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>


</head>
<!DOCTYPE html>
<html lang="en">
<head>
<%@ include file="/WEB-INF/views/include/header.jsp"%>
<base href="${pageContext.servletContext.contextPath}/">
<title>Chi tiết sản phẩm</title>
<body class="goto-here">
	<%@ include file="/WEB-INF/views/include/menu.jsp"%>
	<!-- END nav -->

	<div class="hero-wrap hero-bread"
		style="background-image: url('resources/images/bg_1.jpg');">
		<div class="container">
			<div
				class="row no-gutters slider-text align-items-center justify-content-center">
				<div class="col-md-9 ftco-animate text-center">
					<p class="breadcrumbs">
						<span class="mr-2"><a ></a></span> <span
							class="mr-2"><a >Chi</a></span> <span> tiết</span>
					</p>
					<h1 class="mb-0 bread">sản phẩm</h1>
				</div>
			</div>
		</div>
	</div>
	<form:form action="products/add-products/${product.id}">
		<section class="ftco-section">
			<div class="container">
				<div class="row">
					<div class="col-lg-6 mb-5 ftco-animate"
						style="border-radius: 16px;">
						<a href="resources/images/${product.getFirstImagePath()}"
							class="image-popup"><img
							src="resources/images/${product.getFirstImagePath()}"
							class="img-fluid" alt="Colorlib Template"></a>
					</div>
					<div class="col-lg-6 product-details pl-md-5 ftco-animate">
						<h3>${product.name}</h3>
						<div class="rating d-flex">
							<p class="text-left mr-4">
								<a class="mr-2">5.0</a> <span class="ion-ios-star-outline"></span>
								<span class="ion-ios-star-outline"></span><span
									class="ion-ios-star-outline"></span><span
									class="ion-ios-star-outline"></span><span
									class="ion-ios-star-outline"></span>
							</p>
							<p class="text-left mr-4">
								<a href="##" class="mr-2" style="color: #000;">100 <span
									style="color: #bbb;">Rating</span></a>
							</p>
							<p class="text-left">
								<a href="##" class="mr-2" style="color: #000;">500 <span
									style="color: #bbb;">Sold</span></a>
							</p>
						</div>

						<%-- <p class="price">
						<span style="color: red; font-weight: 600;"><f:formatNumber
								value="${product.price}" type="currency" currencySymbol="VND" /></span>
					</p> --%>
						<div class="row">
							<h6 style="font-weight: bold; color: black; margin-top: 6px">Giảm
								giá:</h6>
							<h6 style="margin-left: 10px; font-size: 22; color: red">${ product.sale }
								%</h6>
						</div>
						<div class="row">
							<div class="d-flex">
								<div class="pricing">
									<s><p class="price">
											<span style="font-size: 18; color: #AB9E8A;"
												class="mr-2 price-dc"><f:formatNumber
													value="${product.price}" type="currency"
													currencySymbol="VND" /></span></s> <span
										style="color: red; font-weight: bold" class="price-sale"><f:formatNumber
											value="${product.price *(100 - product.sale)* 0.01}"
											type="currency" currencySymbol="VND" /></span>
									</p>
								</div>
							</div>
						</div>

						<p>${product.description}</p>

						<div class="row">
							<h6 style="font-weight: bold; color: black">Khối lượng:</h6>
							<h6 style="margin-left: 10px">${ product.weight }</h6>
							<h6 style="margin-left: 4px">${product.unit }</h6>
						</div>

						<div class="row">
							<h6 style="font-weight: bold; color: black">Hạn sử dụng:</h6>
							<h6 style="margin-left: 10px">${ product.expiry }tháng</h6>
						</div>

						<div class="row">
							<h6 style="font-weight: bold; color: black">Xuất xứ:</h6>
							<h6 style="margin-left: 10px">${ product.origin }</h6>
						</div>

						<div class="row mt-4">
							<div class="w-100"></div>
							<div class="input-group col-md-6 d-flex mb-3">
								<input type="number" name="quantity"
									class="form-control input-number" value="1" min="1" max="100">

							</div>
							<div class="row"></div>
							<div class="w-100"></div>
							<div class="col-md-12">
								<p style="color: #000;">600 kg available</p>
							</div>
						</div>
						<p>
							<button type="submit" class="btn btn-primary btn-lg"
								style="padding-left: 2.5rem; padding-right: 2.5rem; color: green;">Add
								to Cart</button>
						</p>
					</div>
				</div>
			</div>
		</section>
	</form:form>
	<section class="ftco-section">
		<div class="container">
			<div class="row justify-content-center mb-3 pb-3">
				<div class="col-md-12 heading-section text-center ftco-animate">
					<span class="subheading">Sản phẩm</span>
					<h2 class="mb-4">Sản phẩm liên quan</h2>
					<p>Có thể bạn sẽ thích</p>
				</div>
			</div>
		</div>
		<div class="container">
			<div class="row">
				<c:forEach var="productRelate" items="${productsRelated}">
					<div class="col-md-6 col-lg-3 ftco-animate">
						<div class="product">
							<a href="products/product-detail/${productRelate.id}"
								class="img-prod"><img class="img-fluid"
								src="resources/images/${productRelate.getFirstImagePath()}"
								alt="Colorlib Template"> <span class="status">${productRelate.sale}%</span>
								<div class="overlay"></div> </a>
							<div class="text py-3 pb-4 px-3 text-center">
								<h3>
									<a href="product">${productRelate.name}</a>
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
										<a href="products/add-product-relate/${product.id}"
											class="buy-now d-flex justify-content-center align-items-center mx-1">
											<span><i class="ion-ios-cart"></i></span>
										</a>
									</div>
								</div>
							</div>
						</div>
					</div>
				</c:forEach>

			</div>
	</section>



	<footer class="ftco-footer ftco-section">
		<div class="container">
			<div class="row">
				<div class="mouse">
					<a href="#" class="mouse-icon">
						<div class="mouse-wheel">
							<span class="ion-ios-arrow-up"></span>
						</div>
					</a>
				</div>
			</div>
			<div class="row mb-5">
				<div class="col-md">
					<div class="ftco-footer-widget mb-4">
						<h2 class="ftco-heading-2">Bird's Nests</h2>
						<p>Cung cấp sản phẩm chất lượng</p>
						<ul
							class="ftco-footer-social list-unstyled float-md-left float-lft mt-5">
							<li class="ftco-animate"><a href="##"><span
									class="icon-twitter"></span></a></li>
							<li class="ftco-animate"><a href="##"><span
									class="icon-facebook"></span></a></li>
							<li class="ftco-animate"><a href="##"><span
									class="icon-instagram"></span></a></li>
						</ul>
					</div>
				</div>


				<div class="col-md">
				<div class="ftco-footer-widget mb-4">
					<h2 class="ftco-heading-2">Có câu hỏi?</h2>
					<div class="block-23 mb-3">
						<ul>
							<li><span class="icon icon-map-marker"></span><span
								class="text">97, Man Thiện, Hiệp Phú, TP.Thủ Đức, TP.HCM</span></li>
							<li><a href="##"><span class="icon icon-phone"></span><span
									class="text"> +84 382 916 0220</span></a></li>
							<li><a href="##"><span class="icon icon-envelope"></span><span
									class="text">n18dccn120@ptithcm.edu.vn</span></a></li>
						</ul>
					</div>
				</div>
			</div>
			</div>
			<div class="row">
				<div class="col-md-12 text-center">

					<p>
						<!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
						Copyright &copy;
						<script>
							document.write(new Date().getFullYear());
						</script>
						All rights reserved | This template is made with <i
							class="icon-heart color-danger" aria-hidden="true"></i> by <a
							href="https://colorlib.com" target="_blank">Colorlib</a>
						<!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
					</p>
				</div>
			</div>
		</div>
	</footer>



	<!-- loader -->
	<div id="ftco-loader" class="show fullscreen">
		<svg class="circular" width="48px" height="48px">
			<circle class="path-bg" cx="24" cy="24" r="22" fill="none"
				stroke-width="4" stroke="#eeeeee" />
			<circle class="path" cx="24" cy="24" r="22" fill="none"
				stroke-width="4" stroke-miterlimit="10" stroke="#F96D00" /></svg>
	</div>
	<script src="<c:url value='/resources/js/jquery.min.js'/>"></script>
	<script src="<c:url value='/resources/js/jquery.min.js'/>"></script>

	<script
		src="<c:url value='/resources/js/jquery-migrate-3.0.1.min.js'/>"></script>
	<script src="<c:url value='/resources/js/popper.min.js'/>"></script>
	<script src="<c:url value='/resources/js/bootstrap.min.js'/>"></script>
	<script src="<c:url value='/resources/js/jquery.easing.1.3.js'/>"></script>
	<script src="<c:url value='/resources/js/jquery.waypoints.min.js'/>"></script>
	<script src="<c:url value='/resources/js/jquery.stellar.min.js'/>"></script>
	<script src="<c:url value='/resources/js/owl.carousel.min.js'/>"></script>
	<script
		src="<c:url value='/resources/js/jquery.magnific-popup.min.js'/>"></script>
	<script src="<c:url value='/resources/js/aos.js'/>"></script>
	<script
		src="<c:url value='/resources/js/jquery.animateNumber.min.js'/>"></script>
	<script src="<c:url value='/resources/js/bootstrap-datepicker.js'/>"></script>
	<script src="<c:url value='/resources/js/scrollax.min.js'/>"></script>
	<script
		src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBVWaKrjvy3MaE7SQ74_uJiULgl1JY0H2s&sensor=false"></script>
	<script src="<c:url value='/resources/js/google-map.js'/>"></script>
	<script src="<c:url value='/resources/js/main.js'/>"></script>

	<script>
		$(document).ready(
				function() {

					var quantitiy = 0;
					$('.quantity-right-plus').click(
							function(e) {

								// Stop acting like a button
								e.preventDefault();
								// Get the field name
								var quantity = parseInt($('#quantity').val());

								// If is not undefined

								document.getElementById("demo").value = $(
										'#quantity').val(quantity + 1);

								// Increment

							});

					$('.quantity-left-minus').click(
							function(e) {
								// Stop acting like a button
								e.preventDefault();
								// Get the field name
								var quantity = parseInt($('#quantity').val());

								// If is not undefined

								// Increment
								if (quantity > 0) {
									document.getElementById("demo").value = $(
											'#quantity').val(quantity - 1);
								}
							});

				});
	</script>
</body>
</html>
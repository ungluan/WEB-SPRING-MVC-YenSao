<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%-- <%@ taglib uri="http://java.sun.com/jstl/core" prefix="c"%> --%>
<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c'%>
<%@ taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="f"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<!DOCTYPE html>
<head>
<%@ include file="/WEB-INF/views/include/header.jsp"%>
<base href="${pageContext.servletContext.contextPath}/">
<title>Giỏ hàng</title>
<style type="text/css">
.errors {
	color: red;
	font-style: italic;
}
</style>
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
					<span class="mr-2"><a>Giỏ hàng</a></span> <span>của tôi</span>
				</p>
				<h1 class="mb-0 bread">Giỏ hàng</h1>
			</div>
		</div>
	</div>
</div>
<form:form action="cart/confirm">
	<section class="ftco-section ftco-cart">
		<div class="container">
			<div class="row">
				<div class="col-md-12 ftco-animate">
					<div class="cart-list">
						<table class="table">
							<thead class="thead-primary">
								<tr class="text-center">
									<th>&nbsp;</th>
									<th>&nbsp;</th>
									<th>Tên sản phẩm</th>
									<th>Giá</th>
									<th>Số lượng</th>
								</tr>
							</thead>
							<tbody>
								<c:if test="${order!=null}">
									<c:forEach var="orderDetail" items="${order.orderDetails}"
										varStatus="">
										<tr class="text-center">
											<td class="product-remove"><a
												href="cart/remove/${orderDetail.id}"><span
													class="ion-ios-close"></span></a></td>

											<td class="image-prod"><div class="img"
													style="background-image: url(resources/images/${orderDetail.product.getFirstImagePath()});"></div></td>


											<td class="product-name">
												<h3>${orderDetail.product.name}</h3>
											</td>

											<td class="price"><span style="font-weight: 500;"><f:formatNumber
														value="${orderDetail.product.price}" type="currency"
														currencySymbol="VND" /></span></td>

											<td class="quantity">
												<div class="input-group mb-3">
													<input type="number" name="${orderDetail.product.id}"
														class="quantity form-control input-number"
														value="${ orderDetail.numbers }" min="1" max="100"
														required="true">

												</div> <label class="errors"
												name="message${orderDetail.product.id}" />
											</td>
										</tr>
									</c:forEach>
								</c:if>

								<c:if test="${order==null}">
									<td>
										<center>Giỏ hàng rỗng</center>
									</td>
								</c:if>
							</tbody>
						</table>
					</div>
				</div>
			</div>

			<div style="margin-top: 32px">
				<c:if test="${order == null}">
					<center>
						<a style="background-color: #b9bac6"
							class="btn btn-primary py-3 px-4">Mua hàng</a>
					</center>
				</c:if>
				<c:if test="${order != null}">
					<center>
						<button type="submit" class="btn btn-primary py-3 px-4">Mua
							hàng</button>
					</center>
				</c:if>
			</div>
	</section>
</form:form>
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

<script>
	$(document).ready(function() {

		var quantitiy = 0;
		$('.quantity-right-plus').click(function(e) {

			// Stop acting like a button
			e.preventDefault();
			// Get the field name
			var quantity = parseInt($('#quantity').val());

			// If is not undefined

			$('#quantity').val(quantity + 1);

			// Increment

		});

		$('.quantity-left-minus').click(function(e) {
			// Stop acting like a button
			e.preventDefault();
			// Get the field name
			var quantity = parseInt($('#quantity').val());

			// If is not undefined

			// Increment
			if (quantity > 0) {
				$('#quantity').val(quantity - 1);
			}
		});

	});
</script>

</body>
</html>
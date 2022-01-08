<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%-- <%@ taglib uri="http://java.sun.com/jstl/core" prefix="c"%> --%>
<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c'%>
<%@ taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="f"%>
<%@ taglib prefix="tg" tagdir="/WEB-INF/tags"%>


<!DOCTYPE html>
<html lang="en">

<head>
<%@ include file="/WEB-INF/views/include/header.jsp"%>
<base href="${pageContext.servletContext.contextPath}/">
<title>Shop</title>
</head>

<%@ include file="/WEB-INF/views/include/menu.jsp"%>

<!-- END nav -->

<div class="hero-wrap hero-bread"
	style="background-image: url('resources/images/bg_4.png');">
	<div class="container">
		<div
			class="row no-gutters slider-text align-items-center justify-content-center">
			<div class="col-md-9 ftco-animate text-center">
				<p class="breadcrumbs">
					<span class="mr-2"><a >Sản phẩm</a></span> <span>của chúng tôi</span>
				</p>
				<h1 class="mb-0 bread">Sản phẩm</h1>
			</div>
		</div>
	</div>
</div>
<jsp:useBean id="pagedListHolder" scope="request"
	class="org.springframework.beans.support.PagedListHolder" />
<c:url var="pagedLink" value="${action}">
	<c:param name="p" value="~">
	</c:param>
</c:url>


<section class="ftco-section">
	<div class="container">
		<div class="row justify-content-center">
			<div class="col-md-10 mb-5 text-center">
				<ul class="product-category">
					<li><a href="products/"
						class="${ activeId == 0 ? 'active' : '' }">All</a></li>
					<c:forEach var="category" items="${categories}" varStatus="loop">
						<li><a href="products/${category.id}?linkCategory"
							class="${ activeId == category.id ? 'active' : '' }">${category.name}
						</a></li>
					</c:forEach>
				</ul>
			</div>
		</div>
		<div class="row">
			<c:forEach var="product" items="${pagedListHolder.pageList}"
				varStatus="loop">
				<div class="col-md-6 col-lg-3 ftco-animate">
					<div class="product">
						<a href="products/product-detail/${product.id}" class="img-prod"><img
							class="img-fluid"
							src="resources/images/${product.getFirstImagePath()}"
							alt="Colorlib Template"> <span class="status">${product.sale}%</span>
							<div class="overlay"></div> </a>
						<div class="text py-3 pb-4 px-3 text-center">
							<h3>
								<a href="product-detail/${product.id}">${product.name}</a>
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
							<c:set var="idLink" value="${product.id}_${activeId}"  >
							</c:set>
							<div class="bottom-area d-flex px-3">
								<div class="m-auto d-flex">
									<a href="products/add-product-cate/${idLink}"
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
		<div>
			<tg:paging pagedListHolder="${pagedListHolder}"
				pagedLink="${pagedLink}" />
		</div>

	</div>
</section>



<%@ include file="/WEB-INF/views/include/footer.jsp"%>





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
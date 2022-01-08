<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c'%>
<div class="py-1 bg-primary">
	<div class="container">
		<div
			class="row no-gutters d-flex align-items-start align-items-center px-md-0">
			<div class="col-lg-12 d-block">
				<div class="row d-flex">
					<div class="col-md pr-4 d-flex topper align-items-center">
						<div
							class="icon mr-2 d-flex justify-content-center align-items-center">
							<span class="icon-phone2"></span>
						</div>
						<span class="text">+84 382 916 020</span>
					</div>
					<div class="col-md pr-4 d-flex topper align-items-center">
						<div
							class="icon mr-2 d-flex justify-content-center align-items-center">
							<span class="icon-paper-plane"></span>
						</div>
						<span class="text">n18dccn120@student.ptithcm.edu.vn</span>
					</div>
					<div
						class="col-md-5 pr-4 d-flex topper align-items-center text-lg-right">
						<span class="text">Thời gian vận chuyển từ 3-5 ngày &amp; miễn phí đổi trả</span>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<nav
	class="navbar navbar-expand-lg navbar-dark ftco_navbar bg-dark ftco-navbar-light"
	id="ftco-navbar">
	<div class="container">
		<a class="navbar-brand" href="/N18DCCN120_Luan/" style="color: #82AE46;">Bird's Nests</a>
		<button class="navbar-toggler" type="button" data-toggle="collapse"
			data-target="#ftco-nav" aria-controls="ftco-nav"
			aria-expanded="false" aria-label="Toggle navigation">
			<span class="oi oi-menu"></span> Menu
		</button>

		<div class="collapse navbar-collapse" id="ftco-nav">
			<ul class="navbar-nav ml-auto">
				<li class="nav-item active"><a href="/N18DCCN120_Luan/"
					class="nav-link">Trang chủ</a></li>
				<c:if test="${ userLogin != null }">
					<li class="nav-item active"><a href="userInfo/profile" class="nav-link"><label
							style="font-family: serif; font-size: 12px; font-weight: 900; color: #7d119b">
								Hi!</label><label style="font-family: monospace; font-size: 10px; color: #3b0a70; font-weight: bold "> ${ customer.fullname }</label>
					
					<c:if test="${userLogin.role.trim()=='ADMIN'}">
					<li class="nav-item active"><a href="admin/home" class="nav-link">Admin</a></li>
					</c:if>
					</a></li>
					<li class="nav-item active"><a href="logout" class="nav-link">Đăng
							xuất</a></li>
				</c:if>
				<li class="nav-item dropdown"><a
					class="nav-link dropdown-toggle" href="#" id="dropdown04"
					data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Cửa hàng</a>
					<div class="dropdown-menu" aria-labelledby="dropdown04">
						<a class="dropdown-item" href="products/">Cửa hàng</a>
						<!-- <a
							class="dropdown-item" href="wishlist.html">Wishlist</a> -->
						<!-- <a
							class="dropdown-item" href="product-single.html">Single
							Product</a> -->
						<a class="dropdown-item" href="cart/checkout">Giỏ hàng</a> <a
							class="dropdown-item" href="cart/ordered">Đơn hàng đã mua</a>
					</div></li>
				<c:if test="${ userLogin == null }">
					<li class="nav-item active"><a href="login" class="nav-link">Đăng
							nhập</a></li>
					<li class="nav-item active"><a href="register"
						class="nav-link">Đăng ký</a></li>
				</c:if>

				<li class="nav-item cta cta-colored"><a href="cart/checkout"
					class="nav-link"><span style="color: red;" class="icon-shopping_cart"></span>[ ${ numberOfProducts == null ? 0 : numberOfProducts } ]</a></li>
			</ul>
		</div>
	</div>
</nav>
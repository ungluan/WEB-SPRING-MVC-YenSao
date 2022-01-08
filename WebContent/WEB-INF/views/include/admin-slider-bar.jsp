<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<nav id="sidebar">
	<div class="sidebar-header">
		<a href="" >
		<h3>Nest's Bird</h3>
		</a>
	</div>

	<ul class="list-unstyled components">
		<li>
		<p style="font-family: monospace; font-size:16px; font-weight: bold" > ${ customer.fullname } </p>
		</li>
	
		<li><a href="admin/home">Trang chủ</a></li>
		<li class="active"><a href="#homeSubmenu" data-toggle="collapse"
			aria-expanded="false" class="dropdown-toggle">Quản lý</a>
			<ul class="collapse list-unstyled" id="homeSubmenu">
				<li><a href="admin/index">Tài khoản</a></li>
				<li><a href="product/index">Sản phẩm</a></li>
				<li><a href="branch/index">Thương hiệu</a></li>
				<li><a href="category/index">Loại sản phẩm</a></li>
				<li><a href="admin/order/index">Đơn đặt hàng</a></li>
				<li><a href="orderstatus/index">Trạng thái đơn đặt hàng</a></li>
				<li><a href="supplier/index">Nhà cung cấp</a></li>
			</ul></li>

		<li><a href="#pageSubmenu" data-toggle="collapse"
			aria-expanded="false" class="dropdown-toggle">Thống kê</a>
			<ul class="collapse list-unstyled" id="pageSubmenu">
				<li><a href="admin/home">Doanh thu theo năm</a></li>
			</ul></li>
	</ul>
</nav>

<!-- Page Content  -->
<div id="content">
	<nav class="navbar navbar-expand-lg navbar-light bg-light">
		<div class="container-fluid">

			<button type="button" id="sidebarCollapse" class="btn btn-info">
				<i class="fas fa-align-left"></i> <span></span>
			</button>
			<button class="btn btn-dark d-inline-block d-lg-none ml-auto"
				type="button" data-toggle="collapse"
				data-target="#navbarSupportedContent"
				aria-controls="navbarSupportedContent" aria-expanded="false"
				aria-label="Toggle navigation">
				<i class="fas fa-align-justify"></i>
			</button>

			<div class="collapse navbar-collapse" id="navbarSupportedContent">
				<ul class="nav navbar-nav ml-auto">
					<li class="nav-item active"><a class="nav-link" href="logout">Đăng
							xuất</a></li>
				</ul>
			</div>
		</div>
	</nav>
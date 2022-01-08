<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c'%>
<%@ taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="f"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>


<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/header.jsp"%>
<base href="${pageContext.servletContext.contextPath}/">
<meta charset="UTF-8">
<title>Profile</title>
<style type="text/css">
.errors {
	color: red;
	font-style: italic;
}
</style>
</head>

<%@ include file="/WEB-INF/views/include/menu.jsp"%>
<body>


	<center>
		<label style="font-size: 32px; font-weight: bold; color: #13183a">Thông
			tin cá nhân</label>
	</center>
	<div
		style="margin-left: 300px; margin-right: 300px; margin-top: 32px; margin-bottom: 100px">
		<form:form action="userInfo/profile" method="POST"
			modelAttribute="customer">
			<form:input type="hidden" path="id" id="form3Example3"
				class="form-control form-control-lg" />
			<form:input type="hidden" path="userId" id="form3Example3"
				class="form-control form-control-lg" />
			<h5 style="color: red;">${message}</h5>
			
			<div class="form-outline mb-4">
				<label class="form-label" for="form3Example3">Họ và tên</label>
				<form:input type="text" path="fullname" id="form3Example3"
					class="form-control form-control-lg" placeholder="Nhập họ và tên" />
				<form:errors class="errors" path="fullname" />
			</div>
			<label class="form-label" for="form3Example3">Ngày sinh</label>
			<div class="form-outline mb-4">

				<form:input type="date" path="birthday" id="form3Example3x"
					class="form-control form-control-lg" />
				<form:errors class="errors" path="birthday" />
			</div>
			<label class="form-label" for="form3Example3">Địa chỉ</label>
			<div class="form-outline mb-4">
				<form:input type="text" path="address" id="form3Example3"
					class="form-control form-control-lg" placeholder="Nhập địa chỉ" />
				<form:errors class="errors" path="address" />
			</div>
			<div class="form-outline mb-4">
				<label class="form-label" for="form3Example3">Giới tính </label>
				<div class="form-check form-check-inline">
					<form:radiobutton class="form-check-input" path="gender"
						name="inlineRadioOptions" id="inlineRadio1" value="Nam" />
					<label class="form-check-label" for="inlineRadio1">Nam</label>
				</div>
				<div class="form-check form-check-inline">
					<form:radiobutton class="form-check-input" path="gender"
						name="inlineRadioOptions" id="inlineRadio2" value="Nữ" />
					<label class="form-check-label" for="inlineRadio2">Nữ</label>
				</div>
				<br>
			</div>

			<div class="text-center text-lg-start mt-4 pt-2">
				<button class="btn btn-primary btn-lg"
					style="padding-left: 2.5rem; padding-right: 2.5rem;">Edit
					Profile</button>
			</div>

		</form:form>

	</div>


	<%@ include file="/WEB-INF/views/include/footer.jsp"%>


	<%@ include file="/WEB-INF/views/include/loader.jsp"%>


	<!-- <script src="js/jquery.min.js"></script> -->
	<script src="<c:url value='/resources/js/jquery.min.js'/>"></script>
	<!-- <script src="js/jquery-migrate-3.0.1.min.js"></script> -->
	<script
		src="<c:url value='/resources/js/jquery-migrate-3.0.1.min.js'/>"></script>
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
	<script
		src="<c:url value='/resources/js/jquery.animateNumber.min.js'/>"></script>
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
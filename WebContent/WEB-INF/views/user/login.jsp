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
<title>Đăng nhập</title>
<style type="text/css">
.divider:after, .divider:before {
	content: "";
	flex: 1;
	height: 1px;
	background: #eee;
}

.h-custom {
	height: calc(100% - 73px);
}

@media ( max-width : 450px) {
	.h-custom {
		height: 100%;
	}
}

.errors {
	color: red;
	font-style: italic;
}
</style>
</head>

<%@ include file="/WEB-INF/views/include/menu.jsp"%>
<hr>
<!-- Slider Item -->
<h2 style="text-align: center; font-weight: 500;">Đăng nhập</h2>
<section class="vh-100">
	<div class="container-fluid h-custom">
		<div
			class="row d-flex justify-content-center align-items-center h-100">
			<div class="col-md-9 col-lg-6 col-xl-5">
				<img
					src="https://mdbootstrap.com/img/Photos/new-templates/bootstrap-login-form/draw2.png"
					class="img-fluid" alt="Sample image">
			</div>
			<div class="col-md-8 col-lg-6 col-xl-4 offset-xl-1">

				<!-- Code Here -->
				<form:form action="check-login" method="post" modelAttribute="user">
					<h5 style="color: red;">${message}</h5>
					<!-- Email input -->
					<div class="form-outline mb-4">
						<label class="form-label" for="form3Example3">Email</label> <input
							type="email" name="email" id="form3Example3"
							class="form-control form-control-lg"
							placeholder="Nhập địa chỉ email" />
						<form:errors class="errors" path="email" />
					</div>

					<!-- Password input -->
					<div class="form-outline mb-3">
						<label class="form-label" for="form3Example4">Password</label> <input
							type="password" name="password" id="form3Example4"
							class="form-control form-control-lg" placeholder="Nhập mật khẩu" />
						<form:errors class="errors" path="password" />
					</div>

					<div class="d-flex justify-content-between align-items-center">
						<!-- Checkbox -->
						<div class="form-check mb-0">
							<input class="form-check-input me-2" type="checkbox" value=""
								id="form2Example3" /> <label class="form-check-label"
								for="form2Example3"> Remember me </label>
						</div>
						<a href="#!" class="text-body">Forgot password?</a>
					</div>

					<div class="text-center text-lg-start mt-4 pt-2">
						<button type="submit" class="btn btn-primary btn-lg"
							style="padding-left: 2.5rem; padding-right: 2.5rem;">Login</button>
						<p class="small fw-bold mt-2 pt-1 mb-0">
							Don't have an account? <a href="/N18DCCN120_Luan/register"
								class="link-danger">Register</a>
						</p>
					</div>

				</form:form>
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
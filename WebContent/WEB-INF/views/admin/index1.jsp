<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c'%>
<%@ taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="f"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="tg" tagdir="/WEB-INF/tags/admin/"%>

<!DOCTYPE html>
<html>

<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="IE=edge">

<title>Dashboard</title>
<base href="${pageContext.servletContext.contextPath}/">

<!-- Bootstrap CSS CDN -->
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css"
	integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4"
	crossorigin="anonymous">
<!-- Our Custom CSS -->
<link rel="stylesheet"
	href="<c:url value='/resources/dist1/style.css' />">
<link rel="stylesheet"
	href="<c:url value='/resources/css/dialog.css' />">
<!-- Font Awesome JS -->
<script defer
	src="https://use.fontawesome.com/releases/v5.0.13/js/solid.js"
	integrity="sha384-tzzSw1/Vo+0N5UhStP3bvwWPq+uvzCMfrN1fEFe+xBmv1C/AtVX5K0uZtmcHitFZ"
	crossorigin="anonymous"></script>
<script defer
	src="https://use.fontawesome.com/releases/v5.0.13/js/fontawesome.js"
	integrity="sha384-6OIrr52G08NpOFSZdxxz1xdNSndlD4vdcf/q2myIUVO0VsqaGHJsB0RaBE01VTOY"
	crossorigin="anonymous"></script>

</head>

<body>
	<div class="wrapper">
		<!-- Sidebar  -->
		<%@ include file="/WEB-INF/views/include/admin-slider-bar.jsp"%>

		<div class="container-fluid">
			<!-- ============================================================== -->
			<!-- Start Page Content -->
			<!-- ============================================================== -->
			<jsp:useBean id="pagedListHolder" scope="request"
				class="org.springframework.beans.support.PagedListHolder" />
			<c:url value="admin/index" var="pagedLink">
				<c:param name="p" value="~">
				</c:param>
			</c:url>

			<c:if test="${btnStatus=='btnAdd'}">
				<%-- <form:form action="admin/index" method="post"
					modelAttribute="userChange">
					<h5 style="color: red;">${message}</h5>
					<form:input type="hidden" path="id" id="form3Example4"
							class="form-control form-control-lg" required="true"
							readonly="true" />
					<div class="form-outline mb-3">
						<label class="form-label" for="form3Example4">Email</label>
						<form:input type="text" path="email" id="form3Example4"
							class="form-control form-control-lg" required="true"
							readonly="true" />
					</div>
					<div class="form-outline mb-3">
						<label class="form-label" for="form3Example4">Password</label>
						<form:input type="text" path="password" id="form3Example4"
							class="form-control form-control-lg" placeholder="Nhập password"
							required="true" minlength="6" maxlength="32"/>
					</div>
					<div class="row">
						<div class="col-md-3">
							<label for="exampleFormControlInput1" class="form-label" style="margin-right: 12px" >Role:</label>
							<form:select class="form-select" path="role" items="${roles}"
								style="margin-top: 10px; padding: 6px" value="${userChange.role}"
								aria-label="Default select example"
								id="exampleFormControlInput1">
							</form:select>
						</div>
						<!-- itemValue="id" itemLabel="name" -->
						<div class="col-md-3" style="margin-top: 16px" >
							<label class="form-label" for="form3Example3" style="margin-right: 12px">Enable:</label>
							<div class="form-check form-check-inline">
								<form:radiobutton class="form-check-input"
									path="enable" name="inlineRadioOptions"
									id="inlineRadio1" value="true" />
								<label class="form-check-label" for="inlineRadio1">True</label>
							</div>
							<div class="form-check form-check-inline">
								<form:radiobutton class="form-check-input"
									path="enable" name="inlineRadioOptions"
									id="inlineRadio2" value="false" />
								<label class="form-check-label" for="inlineRadio2">False</label>
							</div>
						</div>
					</div>
					<div class="col-12" style="margin-top: 32px">
						<button name="${btnStatus}" class="btn btn-info">Thêm</button>
					</div>
					<br>
			</form:form> --%>
			</c:if>
			<h5 style="color: red;">${message}</h5>
			<c:if test="${ btnStatus == 'btnEdit' }">
				<form:form method="post" modelAttribute="userChange">
					<form:input type="hidden" path="id" id="form3Example4"
							class="form-control form-control-lg" required="true"
							readonly="true" />
					<div class="form-outline mb-3">
						<label class="form-label" for="form3Example4">Email</label>
						<form:input type="text" path="email" id="form3Example4"
							class="form-control form-control-lg" required="true"
							readonly="true" />
					</div>
					<div class="form-outline mb-3">
						<label class="form-label" for="form3Example4">Password</label>
						<form:input type="password" path="password" id="form3Example4"
							class="form-control form-control-lg" placeholder="Nhập password"
							required="true" />
					</div>
					<div class="row">
						<div class="col-md-3">
							<label for="exampleFormControlInput1" class="form-label">Role</label>
							<form:select class="form-select" path="role" items="${roles}"
								style="margin-top: 10px; padding: 6px"
								aria-label="Default select example"
								id="exampleFormControlInput1">
							</form:select>
						</div>
						<!-- itemValue="id" itemLabel="name" -->
						<div class="col-md-3" style="margin-top: 16px" >
							<label class="form-label" for="form3Example3" style="margin-right: 12px">Enable:</label>
							<div class="form-check form-check-inline">
								<form:radiobutton class="form-check-input"
									path="enable" name="inlineRadioOptions"
									id="inlineRadio1" value="true" />
								<label class="form-check-label" for="inlineRadio1">True</label>
							</div>
							<div class="form-check form-check-inline">
								<form:radiobutton class="form-check-input"
									path="enable" name="inlineRadioOptions"
									id="inlineRadio2" value="false" />
								<label class="form-check-label" for="inlineRadio2">False</label>
							</div>
						</div>
					</div>
					
					<div class="col-12" style="margin-top: 32px" >
						<button name="${btnStatus}" class="btn btn-info">Sửa</button>
					</div>
				</form:form>
			</c:if>


			<div class="row">
				<div class="col-sm-12">
					<div class="white-box">
						<h3 class="box-title">Danh sách tài khoản</h3>
						<!-- ==== -->
						<form class="d-inline-flex">
							<input name="searchInput" id="searchInput"
								class="form-control me-2" type="search" placeholder="Nhập mã hoặc email"
								aria-label="Tìm kiếm">
							<button name="btnSearch" id="searchUser"
								class="btn btn-outline-success" type="submit">Tìm kiếm</button>
						</form>
					</div>

					<!-- ==== -->
					<%-- <p class="text-muted">Add class <code>.table</code></p> --%>
					<div class="table-responsive">
						<table class="table text-nowrap" style="align-content: center">
							<thead>
								<tr>
									<th class="border-top-0">Mã id</th>
									<th class="border-top-0">Email</th>
									<th class="border-top-0">Quyền</th>
									<!-- <th class="border-top-0">Hoạt động</th> -->
									<th class="border-top-0">Chỉnh sửa</th>
									<th class="border-top-0">Vô hiệu/Khôi phục</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="u" items="${pagedListHolder.pageList}"
									varStatus="loop">
									<tr>
										<td>${u.id}</td>
										<td>${u.email}</td>
										<%-- <td>${u.role}</td> --%>
										<td>${u.enable}</td>
										<c:choose>
											<c:when test="${u.enable ==true }">
												
												<td><a href="admin/index/${u.id}?linkEdit"><i
														class="fas fa-edit"
														style="font-size: 24px; color: #138496;"></i></a></td>
												<td><a href="admin/index/${u.id}?linkDelete"><i
														class="fas fa-trash-alt"
														style="font-size: 24px; color: #fc0000;"></i></a></td>
											</c:when>
											<c:otherwise>
											
												<td><i class="fas fa-edit"
													style="font-size: 24px; color: #4f4b4b;"></i>
												<td><a href="admin/index/${u.id}?linkDelete"><i
														class="fas fa-trash-alt"
														style="font-size: 24px; color: #3ba30e;"></i></a></td>
											</c:otherwise>
										</c:choose>
									</tr>
								</c:forEach>
							</tbody>
						</table>
						<div>
							<tg:paging pagedListHolder="${pagedListHolder}"
								pagedLink="${pagedLink}" />
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- ============================================================== -->
		<!-- End PAge Content -->
		<!-- ============================================================== -->
		<!-- ============================================================== -->
		<!-- Right sidebar -->
		<!-- ============================================================== -->
		<!-- .right-sidebar -->
		<!-- ============================================================== -->
		<!-- End Right sidebar -->
		<!-- ============================================================== -->
	</div>
	</div>
	</div>

	<!-- jQuery CDN - Slim version (=without AJAX) -->
	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
		integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
		crossorigin="anonymous"></script>
	<!-- Popper.JS -->
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"
		integrity="sha384-cs/chFZiN24E4KMATLdqdvsezGxaGsi4hLGOzlXwp5UZB1LY//20VyM2taTB4QvJ"
		crossorigin="anonymous"></script>
	<!-- Bootstrap JS -->
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"
		integrity="sha384-uefMccjFJAIv6A+rW+L4AHf99KvxDjWSu1z9VI8SKNVmz4sk7buKt/6v9KI65qnm"
		crossorigin="anonymous"></script>
	<!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script> -->
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
	<script type="text/javascript">
		$(document).ready(function() {
			$('#sidebarCollapse').on('click', function() {
				$('#sidebar').toggleClass('active');
			});
		});
	</script>
	<script type="text/javascript"
		src="<c:url value='/resources/js/dialog.js'/>">
		
	</script>
</body>

</html>
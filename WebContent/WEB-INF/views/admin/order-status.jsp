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

<title>OrderStatus</title>
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
		<%@ include file="/WEB-INF/views/include/admin-slider-bar.jsp" %>

			<!-- Here -->


			<div class="container-fluid">
				<!-- ============================================================== -->
				<!-- Start Page Content -->
				<!-- ============================================================== -->
				<jsp:useBean id="pagedListHolder" scope="request"
					class="org.springframework.beans.support.PagedListHolder" />
				<c:url value="orderstatus/index" var="pagedLink">
					<c:param name="p" value="~">
					</c:param>
				</c:url>

				<c:if test="${btnStatus=='btnAdd'}">
					<form:form action="orderstatus/index" method="post"
						modelAttribute="orderStatus">
						<h5 style="color: red;">${message}</h5>
						<div class="form-outline mb-3">
							<label class="form-label" for="form3Example4">Tr???ng th??i ????n h??ng</label>
							<form:input type="text" path="status" id="form3Example4"
								class="form-control form-control-lg"
								placeholder="Nh???p tr???ng th??i m???i" />
						</div>
				
						<div class="col-12">
							<button name="${btnStatus}" class="btn btn-info">Th??m</button>
						</div>
						<br>
					</form:form>
				</c:if>
				<c:if test="${ btnStatus == 'btnEdit' }">
					<form:form method="post" modelAttribute="orderStatus">
						<h5 style="color: red;">${message}</h5>
						<div class="form-outline mb-3">
							<label class="form-label" for="form3Example4">Tr???ng th??i ????n h??ng</label>
							<form:input type="text" path="status" id="form3Example4"
								class="form-control form-control-lg"
								placeholder="Nh???p lo???i s???n ph???m m???i" />
						</div>
						<div class="col-12">
							<button name="${btnStatus}" class="btn btn-info">S???a</button>
						</div>
						<br>
					</form:form>
				</c:if>


				<div class="row">
					<div class="col-sm-12">
						<div class="white-box">
							<h3 class="box-title">Danh s??ch tr???ng th??i ????n h??ng</h3>
							<!-- ==== -->
							<form class="d-inline-flex">
								<input name="searchInput" id="searchInput"
									class="form-control me-3" type="search" placeholder="Vui l??ng n???i dung"
									aria-label="Search">
								<button name="btnSearch" id="searchBranch"
									class="btn btn-outline-success" type="submit">T??m ki???m</button>
							</form>
						</div>

						<!-- ==== -->

						<%-- <p class="text-muted">Add class <code>.table</code></p> --%>
						<div class="table-responsive">
							<table class="table text-nowrap" style="align-content: center">
								<thead>
									<tr>
										<th class="border-top-0">Id</th>
										<th class="border-top-0">Tr???ng th??i</th>
										<th class="border-top-0">Edit</th>
										<th class="border-top-0">Delete</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="orderStatus" items="${pagedListHolder.pageList}"
										varStatus="loop">
										<tr>
											<td>${orderStatus.id}</td>
											<td>${orderStatus.status}</td>

											<td><a href="orderstatus/index/${ orderStatus.id }?linkEdit"><i
													class="fas fa-edit"
													style="font-size: 24px; color: #138496;"></i></a></td>
											<td><a href="orderstatus/index/${ orderStatus.id }?linkDelete"><i
													class="fas fa-trash-alt"
													style="font-size: 24px; color: #fc0000;"></i></a></td>
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
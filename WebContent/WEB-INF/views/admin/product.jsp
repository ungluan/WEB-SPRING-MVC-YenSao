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

<title>Products</title>
<base href="${pageContext.servletContext.contextPath}/">

<style type="text/css">
table {
	font-family: arial, sans-serif;
	border-collapse: collapse;
	width: 100%;
}

td, th {
	border: 1px solid #dddddd;
	text-align: left;
	padding: 8px;
}

.thumb-image {
	float: left;
	width: 100px;
	position: relative;
	padding: 5px;
}

.selectedItem {
	border: 2px solid blue;
}
</style>

<%@ include file="/WEB-INF/views/include/admin-header.jsp"%>

</head>

<body>
	<div class="wrapper">
		<!-- Sidebar  -->
		<%@ include file="/WEB-INF/views/include/admin-slider-bar.jsp"%>

		<!-- Here -->
		<div class="container-fluid">
			<!-- ============================================================== -->
			<!-- Start Page Content -->
			<!-- ============================================================== -->
			<jsp:useBean id="pagedListHolder" scope="request"
				class="org.springframework.beans.support.PagedListHolder" />
			<c:url value="product/index " var="pagedLink">
				<c:param name="p" value="~">
				</c:param>
			</c:url>
			<h5 style="color: red;">${message}</h5>
			<form:form class="row g-3" modelAttribute="product"
				enctype="multipart/form-data" action="product/index">
				<form:input path="id" type="hidden" class="form-control"
					id="exampleFormControlInput1"
					placeholder="Vui lòng nhập tên sản phẩm" />
				<div class="col-md-4">
					<label for="exampleFormControlInput1" class="form-label">Tên
						sản phẩm</label>
					<form:input path="name" type="text" class="form-control"
						id="exampleFormControlInput1"
						placeholder="Vui lòng nhập tên sản phẩm" required="true" />
				</div>
				<div class="col-md-4">
					<label for="exampleFormControlInput1" class="form-label">Giá
						tiền (VNĐ)</label>
					<form:input path="price" type="number" class="form-control"
						id="exampleFormControlInput1" placeholder="Vui lòng nhập giá tiền"
						min="1000" required="true" />
				</div>
				<div class="col-md-4">
					<label for="exampleFormControlInput1" class="form-label">Khối
						lượng</label>
					<form:input path="weight" type="number" class="form-control"
						id="exampleFormControlInput1"
						placeholder="Vui lòng nhập khối lượng" min="1" required="true" />
				</div>
				<div class="col-md-4">
					<label for="exampleFormControlInput1" class="form-label">Thương
						hiệu</label>
					<form:select class="form-select" path="branch.id"
						items="${branchList}" itemValue="id" itemLabel="name"
						style="margin-top: 10px; padding: 6px"
						aria-label="Default select example" id="exampleFormControlInput1">
					</form:select>
				</div>
				<div class="col-md-3">
					<label for="exampleFormControlInput1" class="form-label">
						Loại yến</label>
					<form:select class="form-select" path="category.id"
						items="${categoryList}" itemValue="id" itemLabel="name"
						style="margin-top: 10px; padding: 6px"
						aria-label="Default select example" id="exampleFormControlInput1"></form:select>
					</select>
				</div>


				<label style="margin-top: 14px; margin-right: 4px; padding: 4px"
					class="form-label" for="form3Example3">Ngày sản xuất </label>
				<div class="form-outline mb-4">
					<form:input type="date" path="manufacturingDate" id="form3Example3"
						style="margin-top: 8px; padding: 6px"
						placeholder="Vui lòng nhập ngày sản xuất" />
				</div>

				<div class="col-md-4">
					<label for="exampleFormControlInput1" class="form-label">Giảm
						giá (%)</label>
					<form:input type="number" path="sale" class="form-control"
						id="exampleFormControlInput1"
						placeholder="Vui lòng nhập phần trăm giảm" min="0" required="true" />
				</div>

				<div class="col-md-4">
					<label for="exampleFormControlInput1" class="form-label">Đơn
						vị tính</label><br>
					<form:select class="form-select" path="unit" items="${unitList}"
						style="padding: 6px" aria-label="Default select example"
						id="exampleFormControlInput1"></form:select>
				</div>
				<div class="col-md-4">
					<!-- Date Select -->
					<label for="exampleFormControlInput1" class="form-label">Hạn
						sử dụng (tháng)</label>
					<form:input path="expiry" type="number" class="form-control"
						id="exampleFormControlInput1"
						placeholder="Vui lòng nhập giá của sản phẩm" min="1"
						required="true" />
				</div>

				<div class="col-md-4">
					<label style="margin-top: 10px;" for="exampleFormControlInput1"
						class="form-label">Sản phẩm mới</label><br>
					<form:select class="form-select" path="newProduction"
						items="${selectList}" style="padding: 6px"
						aria-label="Default select example" id="exampleFormControlInput1"></form:select>
					</select>
				</div>

				<div class="col-md-4">
					<label style="margin-top: 10px;" for="exampleFormControlInput1"
						class="form-label">Sản phẩm nổi bật</label><br>
					<form:select class="form-select" path="highlight"
						items="${selectList}" style="padding: 6px"
						aria-label="Default select example" id="exampleFormControlInput1"></form:select>
					</select>
				</div>

				<div class="col-md-4">
					<label style="margin-top: 10px;"
						exampleFormControlInput1" class="form-label">Xuất xứ</label>
					<form:input path="origin" type="text" class="form-control"
						id="exampleFormControlInput1" placeholder="Vui lòng nhập xuất xứ"
						required="true" />
				</div>
				<div class="col-md-3">
					<label for="exampleFormControlInput1" class="form-label">
						Nhà cung cấp</label>
					<form:select class="form-select" path="supplier.id"
						items="${suppliers}" itemValue="id" itemLabel="name"
						style="margin-top: 10px; padding: 6px"
						aria-label="Default select example" id="exampleFormControlInput1"></form:select>
					</select>
				</div>
				<div class="col-12" style="margin-top: 10px;">
					<label class="form-label" for="form3Example4">Mô tả</label>
					<div class="row">
						<div class="col-md-12 form-group">
							<form:textarea style="font-size: 15pt" class="form-control"
								path="description" name="description" id="description" cols="30"
								rows="5" placeholder="Nhập mô tả loại sản phẩm" required="true"></form:textarea>
						</div>
					</div>
				</div>


				<c:if test="${btnStatus=='btnAdd'}">
					<div>
						<label>Hình ảnh</label> <br> <input type="file" value="image"
							name="image" multiple="multiple" required="true" />
					</div>
				</c:if>
				<c:if test="${btnStatus=='btnEdit'}">
					<div class="image-upload">
						<label for="file-input"> <img width="200px" height="200px"
							style="border-radius: 12px" src="resources/images/${image_name}" />
						</label><br> <input style="margin-top: 12px" id="file-input"
							name="image" type="file" />
					</div>
				</c:if>
				<div class="col-12" style="margin-top: 20px; margin-bottom: 20px">

					<c:if test="${btnStatus == 'btnAdd'}">
						<button name="${btnStatus}"
							style="padding-left: 20px; padding-right: 20px;"
							class="btn btn-primary">Thêm</button>
					</c:if>

					<c:if test="${btnStatus == 'btnEdit'}">
						<button name="${btnStatus}"
							style="padding-left: 20px; padding-right: 20px;"
							class="btn btn btn-info">Sửa</button>
					</c:if>
				</div>
			</form:form>

			<div class="row">
				<div class="white-box">
					<h3 class="box-title">Danh sách sản phẩm</h3>
					<!-- ==== -->
					<form class="d-inline-flex">
						<input name="searchInput" id="searchInput"
							class="form-control me-2" type="search"
							placeholder="Nhập mã hoặc tên" aria-label="Search">
						<button name="btnSearch" id="searchBranch"
							class="btn btn-outline-success" type="submit">Tìm kiếm</button>
					</form>
				</div>

				<!-- ==== -->

				<%-- <p class="text-muted">Add class <code>.table</code></p> --%>
				<div class="table-responsive">
					<!-- class="table text-nowrap" style="align-content: center" -->
					<table>
						<thead>
							<!-- class="border-top-0" -->
							<tr>
								<th>Id</th>
								<th>Tên sản phẩm</th>
								<th>Hình ảnh</th>
								<th>Loại sản phẩm</th>
								<th>Thương hiệu</th>
								<th>Giá</th>
								<th>Giảm giá</th>
								<th>Khối lượng</th>
								<th>Đơn vị</th>
								<!-- <th>Ngày tạo</th>
								<th>Ngày cập nhật</th> -->
								<th>Nhà cung cấp</th>
								<th>Xuất xứ</th>
								<!-- <th>Sản phẩm mới</th>
									<th>Sản phẩm tiêu biểu</th>
									
									 -->
								<th>Chỉnh sửa</th>
								<th>Xóa</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="product" items="${pagedListHolder.pageList}"
								varStatus="loop">
								<%-- <c:set var="createAt" value="" > </c:set> --%>
								<tr>
									<td>${product.id}</td>
									<td>${product.name }</td>
									<td><img style="margin-top: 5pt; border-radius: 12px"
										width="200" height="200"
										src="resources/images/${ product.getFirstImagePath() }"></td>
									<td>${product.category.name }</td>
									<td>${product.branch.name}</td>
									<td><f:formatNumber value="${product.price}"
											type="currency" currencySymbol="VND" /></td>
									<td><f:formatNumber value="${product.sale}"
											type="currency" currencySymbol="%" /></td>
									<td>${product.weight }</td>
									<td>${product.unit }</td>
									<%-- <td><f:formatDate value="${product.createdAt}"
											pattern="dd/MM/yyyy" /></td>
									<td><f:formatDate value="${product.updatedAt }" 
											pattern="dd/MM/yyyy" /></td>--%>
									<%-- <td>${product.highlight }</td>
										<td>${product.newProduction }</td>
										 --%>
									<td> ${product.supplier.name } </td>
									<td> ${product.origin } </td>
									<td><a href="product/index/${product.id}?linkEdit"><i
											class="fas fa-edit" style="font-size: 24px; color: #138496;"></i></a></td>
									<td><a href="product/index/${product.id}?linkDelete"><i
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

	<script type="text/javascript"
		src="<c:url value='/resources/dist/js/img_script.js'/>">
		
	</script>

</body>

</html>
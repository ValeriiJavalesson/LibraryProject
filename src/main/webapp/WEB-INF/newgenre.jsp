<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Додати новий жанр</title>
<link rel="icon" type="image/x-icon" href="style/images/favicon.ico">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link href="https://getbootstrap.com/docs/5.3/assets/css/docs.css"
	rel="stylesheet">
<link rel="stylesheet" href="style/css/newgenre.css">
</head>
<body>
	<jsp:include page="header.jsp"></jsp:include>
	<div class="container main-content">
		<form:form modelAttribute="genreform"
			enctype="application/x-www-form-urlencoded" id="genreform">
			<div>
				<input name="id" type="hidden" class="form-control" id="id"
					value="${genre.id}">
			</div>
			<div>
				<label for="name" class="form-label">Назва жанру:</label> <input
					name="name" type="text" class="form-control" id="name"
					value="${genre.name}">
			</div>			
			<div class="btn btn-primary mt-3" onclick='checkForm()'>Зберегти</div>
		</form:form>
	</div>
	<script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
	<script src="js/newgenre.js"></script>
</body>
</html>
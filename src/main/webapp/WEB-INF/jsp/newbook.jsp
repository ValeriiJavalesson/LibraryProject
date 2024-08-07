<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Add new book</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link href="https://getbootstrap.com/docs/5.3/assets/css/docs.css"
	rel="stylesheet">
<link rel="stylesheet" href="style/css/newbook.css">
</head>
<body>
	<jsp:include page="header.jsp"></jsp:include>
	<div class="container main-content">
		<form:form modelAttribute="bookform" enctype="application/x-www-form-urlencoded" id="bookform">			
			<div>
				<label for="name" class="form-label">Назва книги:</label> 
				<input name="name" type="text" class="form-control" id="name">
			</div>
			<div>
				<label for="author" class="form-label">Автор книги:</label> 
				<input name="author" type="text" class="form-control" id="author">
			</div>
			<div>
				<label for="registrationNumber" class="form-label">Реєстраційний номер:</label> 
				<input name="registrationNumber" type="text" class="form-control" id="registrationNumber">
			</div>
			<div>
				<label for="edition" class="form-label">Видання:</label> 
				<input name="edition" type="text" class="form-control" id="edition">
			</div>
			<div>
				<label for="numberOfPages" class="form-label">Кількість сторінок:</label> 
				<input name="numberOfPages" type="text" class="form-control" id="numberOfPages">
			</div>
			<div>
				<label for="price" class="form-label">Ціна:</label> 
				<input name="price" type="text" class="form-control" id="price">
			</div>
			<div>
				<label for="year" class="form-label">Рік друку:</label> 
				<input name="year" type="text" class="form-control" id="year">
			</div>
			<div>
				<label for="language" class="form-label">Мова перекладу:</label> 
				<select name="language" class="form-select" aria-label="Language select" id="language">
					  <option selected="selected" value="Ukrainian">Українска</option>
					  <option value="Russian">Російська</option>
				</select>
			</div>			
			<div class="form-floating mt-2">
				<textarea name="notes" class="form-control" placeholder="Додайте опис книги" id="notes" style="height: 100px"></textarea>
				<label for="notes">Опис книги:</label>
			</div>
			<div class="btn btn-primary mt-3" onclick='checkForm()'>Зберегти</div>
		</form:form>
	</div>
	<script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
	<script src="js/newbook.js"></script>
</body>
</html>
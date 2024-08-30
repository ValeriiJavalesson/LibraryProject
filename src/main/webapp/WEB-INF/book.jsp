<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Library</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link href="https://getbootstrap.com/docs/5.3/assets/css/docs.css"
	rel="stylesheet">
<link rel="stylesheet" href="style/css/book.css">
</head>
<body>
	<jsp:include page="header.jsp"></jsp:include>
	<div class="container main-content">
		<div class="bookCard container d-flex justify-content-center mt-5">
			<div class="book_img" alt="Book photo"></div>
			<div class="book_info m-3 w-50">
				<table class="table">
					<thead>
						<tr>
							<th scope="col">Назва книги:</th>
							<td>${book.name}</td>
						</tr>
					</thead>
					<tbody>
						<tr>
							<th scope="row">Автор:</th>
							<td>${book.author}</td>
						</tr>
						<tr>
							<th scope="row">Реєстраційний номер:</th>
							<td>${book.registrationNumber}</td>
						</tr>
						<tr>
							<th scope="row">Видання:</th>
							<td>${book.edition}</td>
						</tr>
						<tr>
							<th scope="row">Кількість сторінок:</th>
							<td>${book.numberOfPages}</td>
						</tr>
						<tr>
							<th scope="row">Ціна:</th>
							<td>${book.price} ${book.currency}</td>
						</tr>
						<tr>
							<th scope="row">Рік друку:</th>
							<td>${book.year}</td>
						</tr>
						<tr>
							<th scope="row">Мова перекладу:</th>
							<td>${book.language}<c:choose>
									<c:when test="${book.language == 'Russian'}">
										<img src='style/images/ru.png' class='' alt='lang_icon'
											height='15px'>
									</c:when>
									<c:when test="${book.language == 'Ukrainian'}">
										<img src='style/images/ua.png' class='' alt='lang_icon'
											height='15px'>
									</c:when>
								</c:choose>
							</td>
						</tr>
						<tr class="table-borderless">
							<th scope="row" class="border-bottom-0">Опис:</th>
							<td class="border-bottom-0">${book.notes}</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
		<div class="container d-flex justify-content-center">
			<button class="btn btn-danger m-2" value="${book.id}" data-bs-toggle="offcanvas" data-bs-target="#offcanvasTop" aria-controls="offcanvasTop">Видалити книгу</button>
			<button class="btn btn-primary m-2" value="${book.id}" onclick="editBook(${book.id})">Редагувати книгу</button>
			
			<!--  <button class="btn btn-primary" type="button" data-bs-toggle="offcanvas" data-bs-target="#offcanvasTop" aria-controls="offcanvasTop">Toggle top offcanvas</button>-->

			<div class="offcanvas offcanvas-top" tabindex="-1" id="offcanvasTop" aria-labelledby="offcanvasTopLabel">
			  <div class="d-flex justify-content-center offcanvas-header">
			    <h2 class="offcanvas-title" id="offcanvasTopLabel">Видалити книгу з бібліотеки?</h2>
			  </div>
				<div class="d-flex justify-content-center">
				     <button type="button" class="btn btn-danger m-2" onclick="deleteBook(${book.id})">Так</button>
				     <button type="button" class="btn btn-primary m-2" data-bs-dismiss="offcanvas" aria-label="Close">Ні</button>
			  </div>
			</div>
		</div>
	</div>
<script src="js/book.js"></script>
</body>
</html>
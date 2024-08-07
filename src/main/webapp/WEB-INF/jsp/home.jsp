<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Welcome to Library!</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link href="https://getbootstrap.com/docs/5.3/assets/css/docs.css"
	rel="stylesheet">
<link rel="stylesheet" href="style/css/home.css">
</head>
<body>
	<jsp:include page="header.jsp"></jsp:include>
	<div>
		<div class="searchedword bold h5 ms-4"></div>
	</div>
	<div class="container main-content">
		<div class="d-flex flex-wrap justify-content-evenly"
			id="product-cards">

			<c:forEach var="book" items="${allbooks}">
				<div class='card m-2 shadow' role='button'
					style='width: 24rem; height: 550px;' onclick="getbook(${book.id})">
					<img src='style/images/book.jpg' class='card-img-top'
						alt='book_image' height='220px'>
					<div class="card-body">
						<h4 class="card-title" id="name">${book.name}</h4>
						<h6 class="card-title" id="author">${book.author}</h6>
						<hr>
						<p class="card-text m-0" id="registrationNumber">
							<b>Реєстраційний номер: </b>${book.registrationNumber}</p>
						<p class="card-text m-0" id="edition">
							<b>Видання: </b>${book.edition}</p>
						<p class="card-text m-0" id="numberOfPages">
							<b>Кількість сторінок: </b>${book.numberOfPages}</p>
						<p class="card-text m-0" id="price">
							<b>Ціна: </b>${book.price}</p>
						<p class="card-text m-0" id="year">
							<b>Рік друку: </b>${book.year}</p>

						<p class='card-text m-0' id='language'>
							<b>Мова перекладу:</b>
							<c:choose>
								<c:when test="${book.language == 'Russian'}">
									<img src='style/images/ru.png' class='' alt='lang_icon'
										height='15px'>
								</c:when>
								<c:when test="${book.language == 'Ukrainian'}">
									<img src='style/images/ua.png' class='' alt='lang_icon'
										height='15px'>
								</c:when>
							</c:choose>
						</p>
						<c:if test="${book.notes ne ''}">
							<p class="card-text m-0 overflow-hidden" id="notes" style="height: 46px;">
								<b>Опис: </b> ${book.notes}
							</p>
						</c:if>

					</div>
				</div>
			</c:forEach>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
	<script src="js/home.js"></script>
</body>
</html>
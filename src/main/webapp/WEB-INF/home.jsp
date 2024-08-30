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
	<div class="container">
		<div class="d-flex fw-bold justify-content-between mb-2">		
				<a role="button" onclick="getBooksByLetter('#')">#</a>	
				<a role="button" onclick="getBooksByLetter('А')">А</a> 
				<a role="button" onclick="getBooksByLetter('Б')">Б</a> 
				<a role="button" onclick="getBooksByLetter('В')">В</a>
				<a role="button" onclick="getBooksByLetter('Г')">Г</a>
				<a role="button" onclick="getBooksByLetter('Д')">Д</a>
				<a role="button" onclick="getBooksByLetter('Е')">Е</a>
				<a role="button" onclick="getBooksByLetter('Є')">Є</a>
				<a role="button" onclick="getBooksByLetter('Ж')">Ж</a>
				<a role="button" onclick="getBooksByLetter('З')">З</a>
				<a role="button" onclick="getBooksByLetter('И')">И</a>
				<a role="button" onclick="getBooksByLetter('І')">І</a>
				<a role="button" onclick="getBooksByLetter('Ї')">Ї</a>
				<a role="button" onclick="getBooksByLetter('Й')">Й</a>
				<a role="button" onclick="getBooksByLetter('К')">К</a>
				<a role="button" onclick="getBooksByLetter('Л')">Л</a>
				<a role="button" onclick="getBooksByLetter('М')">М</a>
				<a role="button" onclick="getBooksByLetter('Н')">Н</a>
				<a role="button" onclick="getBooksByLetter('О')">О</a>
				<a role="button" onclick="getBooksByLetter('П')">П</a>
				<a role="button" onclick="getBooksByLetter('Р')">Р</a>
				<a role="button" onclick="getBooksByLetter('С')">С</a>
				<a role="button" onclick="getBooksByLetter('Т')">Т</a>
				<a role="button" onclick="getBooksByLetter('У')">У</a>
				<a role="button" onclick="getBooksByLetter('Ф')">Ф</a>
				<a role="button" onclick="getBooksByLetter('Х')">Х</a>
				<a role="button" onclick="getBooksByLetter('Ц')">Ц</a>
				<a role="button" onclick="getBooksByLetter('Ч')">Ч</a>
				<a role="button" onclick="getBooksByLetter('Ш')">Ш</a>
				<a role="button" onclick="getBooksByLetter('Щ')">Щ</a>
				<a role="button" onclick="getBooksByLetter('Ю')">Ю</a>
				<a role="button" onclick="getBooksByLetter('Я')">Я</a>		
			</div>
		</div>	
	<div class="container main-content">		
		<div class="d-flex flex-wrap justify-content-evenly"
			id="product-cards">
			<c:forEach var="book" items="${allbooks}">
				<div class='card m-2 shadow' role='button'
					style='width: 24rem; height: 550px;' onclick="getbook(${book.id})">
					<img class='card-img-top book-image' alt='book_image'
						height='220px'>
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
							<b>Ціна: </b>${book.price} ${book.currency}</p>
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
							<p class="card-text m-0 overflow-hidden" id="notes"
								style="height: 46px;">
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
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Welcome to Library!</title>
<link rel="icon" type="image/x-icon" href="style/images/favicon.ico">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link href="https://getbootstrap.com/docs/5.3/assets/css/docs.css"
	rel="stylesheet">
<link rel="stylesheet" href="style/css/home.css">
</head>
<body>
	<jsp:include page="header.jsp"></jsp:include>
	
		<div class="container">
			<div class="d-flex fw-bold justify-content-between mb-2 text-light ">		
				<a role="button" onclick="getBooksByLetter('0')">#</a>	
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
			<div class="d-flex fw-bold justify-content-between mb-2 text-light">	
				<a role="button" onclick="getBooksByLetter('A')">A</a> 
				<a role="button" onclick="getBooksByLetter('B')">B</a> 
				<a role="button" onclick="getBooksByLetter('C')">C</a>
				<a role="button" onclick="getBooksByLetter('D')">D</a>
				<a role="button" onclick="getBooksByLetter('E')">E</a>
				<a role="button" onclick="getBooksByLetter('F')">F</a>
				<a role="button" onclick="getBooksByLetter('G')">G</a>
				<a role="button" onclick="getBooksByLetter('H')">H</a>
				<a role="button" onclick="getBooksByLetter('I')">I</a>
				<a role="button" onclick="getBooksByLetter('J')">J</a>
				<a role="button" onclick="getBooksByLetter('K')">K</a>
				<a role="button" onclick="getBooksByLetter('L')">L</a>
				<a role="button" onclick="getBooksByLetter('M')">M</a>
				<a role="button" onclick="getBooksByLetter('N')">N</a>
				<a role="button" onclick="getBooksByLetter('O')">O</a>
				<a role="button" onclick="getBooksByLetter('P')">P</a>
				<a role="button" onclick="getBooksByLetter('Q')">Q</a>
				<a role="button" onclick="getBooksByLetter('R')">R</a>
				<a role="button" onclick="getBooksByLetter('S')">S</a>
				<a role="button" onclick="getBooksByLetter('T')">T</a>
				<a role="button" onclick="getBooksByLetter('Y')">Y</a>
				<a role="button" onclick="getBooksByLetter('V')">V</a>
				<a role="button" onclick="getBooksByLetter('W')">W</a>
				<a role="button" onclick="getBooksByLetter('X')">X</a>
				<a role="button" onclick="getBooksByLetter('Y')">Y</a>
				<a role="button" onclick="getBooksByLetter('Z')">Z</a>		
			</div>
		</div>	
	<div class="main-content">		
		<c:forEach var="genre" items="${allgenres}" >
		<c:set value="${genre.key.name}" var="genre_name"></c:set>
			<div class="genre_self">
				<div class="genre_title">
					<c:out value="${genre_name}"></c:out>
				</div>
				<div class="books_self"	id="product-cards">			
					<c:forEach var="book" items="${genre.value}">
					 <div class="book" data-pages="${book.numberOfPages}" data-author="${book.author}" data-name="${book.name}"
					 data-book_id="${book.id}" data-year="${book.year}" data-edition="${book.edition}">		
						<div class="book_title">
							<div class="book_author" data-content="${book.author}">${book.author}</div>
							<div class="book_name" data-content="${book.name}">${book.name}</div>
						</div>
						<div class="book_year">${book.year}</div> 					
					</div>
					</c:forEach>
				</div>
				<div class="more_books">
					<a role="button" href="genre?id=${genre.key.id}">Більше книг...</a>
				</div>
			</div>
		</c:forEach>
	</div>
	<script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
	<script src="js/home.js"></script>
</body>
</html>
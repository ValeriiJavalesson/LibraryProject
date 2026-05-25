<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Welcome to Library!</title>
<link rel="icon" type="image/x-icon" href="style/images/favicon.ico">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://getbootstrap.com/docs/5.3/assets/css/docs.css" rel="stylesheet">
<link rel="stylesheet" href="style/css/home.css">
<link rel="stylesheet" href="style/css/search.css">
</head>
<body>
	<jsp:include page="header.jsp"></jsp:include>
	<div>
		<div class="searchedword bold h5 ms-4 text-light">Жанр: ${genre.name}</div>
	</div>
	<div class="main-content">
		<c:forEach var="self" items="${selfs}">
			<div class="genre_self">
				<div class="books_self" id="product-cards">
					<c:forEach var="book" items="${self}">
						<div class="book" data-pages="${book.numberOfPages}" data-author="${book.author}" data-name="${book.name}"
						data-book_id="${book.id}" data-year="${book.year}" data-edition="${book.edition}">
							<div class="book_title">
								<div class="book_author">${book.author}</div>
								<div class="book_name">${book.name}</div>
							</div>
							<div class="book_year">${book.year}</div>
						</div>
					</c:forEach>
				</div>
			</div>
		</c:forEach>
	</div>
	<script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
	<script src="js/search.js"></script>
</body>
</html>
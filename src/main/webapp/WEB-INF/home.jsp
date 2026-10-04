<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>

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
	    <!-- Український алфавіт (# + А-Я) -->
	    <div class="d-flex fw-bold justify-content-between mb-2 text-light">
	        <a role="button" onclick="getBooksByLetter('0')">#</a>
	        <c:forEach var="letter" items="${fn:split('А,Б,В,Г,Д,Е,Є,Ж,З,И,І,Ї,Й,К,Л,М,Н,О,П,Р,С,Т,У,Ф,Х,Ц,Ч,Ш,Щ,Ю,Я', ',')}">
	            <a role="button" onclick="getBooksByLetter('${letter}')">${letter}</a>
	        </c:forEach>
	    </div>
	    
	    <!-- Англійський алфавіт (A-Z) -->
	    <div class="d-flex fw-bold justify-content-between mb-2 text-light">
	        <c:forEach var="letter" items="${fn:split('A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z', ',')}">
	            <a role="button" onclick="getBooksByLetter('${letter}')">${letter}</a>
	        </c:forEach>
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
					 <div class="book" style="--pages: ${book.numberOfPages};" data-author="${book.author}" data-name="${book.name}"
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
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<link rel="stylesheet" href="style/css/header.css">
</head>
<body>
	<nav class="">
		<div class="nav-container">
			<div>
				<a class="brand" href="home" data-content="ПИСАРІВСЬКА">Бібліотека</a>
				<security:authorize access="hasRole('ROLE_ADMIN')">
					<a class="btn btn-primary" href="books">Всі книги</a>
					<a class="btn btn-primary" href="newbook?id=0">Додати нову книгу</a>
					<a class="btn btn-primary" href="addgenre">Жанри</a>
				</security:authorize>
			</div>

			<div class="d-flex">	
				<c:set var="search_placeholder" value="${word}"></c:set>
				<c:if test="${search_placeholder eq ''}">
					<c:set var="search_placeholder" value="Пошук..."></c:set>
				</c:if>							
				<input class="form-control  me-2" type=search id="search" placeholder="${search_placeholder}">
				<security:authorize access="isAuthenticated()">
					<button class="btn btn-outline-dark me-2" onclick="findBookAdmin()">Пошук</button>
				</security:authorize>
				<security:authorize access="!isAuthenticated()">
					<button class="btn btn-outline-dark me-2" onclick="findBook()">Пошук</button>
				</security:authorize>
				<security:authorize access="!isAuthenticated()">
					<button class="btn btn-secondary" onclick="login()">Ввійти</button>
				</security:authorize>
				<security:authorize access="isAuthenticated()">
					<button class="btn btn-danger " onclick="logout()">Вийти</button>
				</security:authorize>

			</div>
		</div>
		<div>
			<input hidden="hidden" id="searchedword" value="${searchedword}" />
			<input id="currentpage" hidden="hidden" value="${page}">
			<input hidden="hidden" id="genreId" value="${genreId}" />
		</div>
		<div class="scrollButtons">
			<button onclick="topFunction()" id="toTopButton" title="TOP">↑</button>
			<button onclick="buttomFunction()" id="toButtomButton" title="BOTTOM">↓</button>
		</div>
	</nav>
	<script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
	<script src="js/header.js"></script>
</body>
</html>
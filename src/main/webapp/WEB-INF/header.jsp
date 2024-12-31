<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<link rel="stylesheet" href="style/css/header.css">
</head>
<body>
	<nav class="navbar navbar-expand-lg mb-3 border-bottom sticky-top ">
		<div class="container-fluid">
			<div>
				<a class="navbar-brand" href="home">LIBRARY</a>
				<security:authorize access="hasRole('ROLE_ADMIN')">
					<a class="btn btn-primary" href="allbooks?page=1&word=">Всі книги</a>
					<a class="btn btn-primary" href="newbook?id=0">Додати нову книгу</a>
				</security:authorize>
			</div>

			<div class="d-flex">
				<input class="form-control me-2" type=search id="search" placeholder="Search" value="${word}">
				<security:authorize access="isAuthenticated()">
					<button class="btn btn-outline-success" onclick="findBookAdmin()">Пошук</button>
				</security:authorize>
				<security:authorize access="!isAuthenticated()">
					<button class="btn btn-outline-success" onclick="findBook()">Пошук</button>
				</security:authorize>


				<security:authorize access="!isAuthenticated()">
					<button class="btn btn-success" onclick="login()">Ввійти</button>
				</security:authorize>
				<security:authorize access="isAuthenticated()">
					<button class="btn btn-danger " onclick="logout()">Вийти</button>
				</security:authorize>

			</div>
		</div>
		<div>
			<input hidden="hidden" id="username" value="${username}" />
		</div>
		<div>
			<input hidden="hidden" id="searchedword" value="${searchedword}" />
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
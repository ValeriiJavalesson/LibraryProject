<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<link rel="stylesheet" href="style/css/header.css">
</head>
<body>
	<nav
		class="navbar navbar-expand-lg mb-3 border-bottom sticky-top ">
		<div class="container-fluid">
			<div>
				<a class="navbar-brand" href="home">LIBRARY</a> 
				<a class="h5 link-body-emphasis link-offset-2 link-underline-opacity-0 link-underline-opacity-100-hover"
					href="newbook?id=0">Додати нову книгу</a>
			</div>

			<div class="d-flex">
				<input class="form-control me-2" type=search id="search"
					placeholder="Search">
				<button class="btn btn-outline-success" onclick="findBook()">Search</button>
			</div>
		</div>

	</nav>
	<script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
	<script src="js/header.js"></script>
</body>
</html>
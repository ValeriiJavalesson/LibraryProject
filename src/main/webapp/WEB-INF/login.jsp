<%-- <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login page</title>
<link rel="icon" type="image/x-icon" href="style/images/favicon.ico">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://getbootstrap.com/docs/5.3/assets/css/docs.css" rel="stylesheet">
<link rel="stylesheet" href="css/login.css">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
</head>
<body>
	<jsp:include page="header.jsp"></jsp:include>
	<main>
		<div class="container d-flex flex-column align-items-center">
			<h1 class="m-3">Вхід для адміністраторів бібліотеки</h1>
			<form name='f' action="login" method='POST'>
				<div class="mb-3">
					<label for="inputEmail" class="form-label">Логін-email</label> <input type="text" class="" id="inputEmail" aria-describedby="emailHelp" name="username">
				</div>
				<div class="mb-3">
					<label for="inputPassword" class="form-label">Пароль</label> <input type="password" class="" id="inputPassword" name="password">
				</div>
				<label> <input type="checkbox" name="remember-me" /> Запам'ятати мене
				</label>
				<button name="submit" type="submit" value="submit" class="">Ввійти</button>
			</form>
		</div>
	</main>
	<script type="text/javascript" src="js/login.js"></script>

</body>
</html> --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Вхід до бібліотеки</title>
<link rel="icon" type="image/x-icon" href="style/images/favicon.ico">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://getbootstrap.com/docs/5.3/assets/css/docs.css" rel="stylesheet">
<link rel="stylesheet" href="style/css/login.css">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
</head>
<body class="login-body">
	<jsp:include page="header.jsp"></jsp:include>
	
	<main class="d-flex align-items-center justify-content-center login-container">
		<div class="card login-card p-4 shadow-sm">
			<div class="card-body">
				<h2 class="card-title text-center mb-4 login-title">Вхід для адміністраторів</h2>
				
				<!-- Повідомлення про помилку, якщо Spring Security повернув error -->
				<c:if test="${param.error != null}">
					<div class="alert alert-danger text-center p-2 small" role="alert">
						Неправильний логін або пароль!
					</div>
				</c:if>

				<form name="f" action="login" method="POST">
					<div class="mb-3">
						<label for="inputEmail" class="form-label text-secondary">Логін-email</label> 
						<input type="text" class="form-control" id="inputEmail" name="username" placeholder="name@example.com" required>
					</div>
					
					<div class="mb-3">
						<label for="inputPassword" class="form-label text-secondary">Пароль</label> 
						<input type="password" class="form-control" id="inputPassword" name="password" placeholder="••••••••" required>
					</div>
					
					<div class="form-check mb-4 text-start">
						<input type="checkbox" class="form-check-input" id="rememberMe" name="remember-me">
						<label class="form-check-label text-secondary" for="rememberMe">Запам'ятати мене</label>
					</div>
					
					<button name="submit" type="submit" value="submit" class="btn btn-primary w-100 btn-login">Увійти</button>
				</form>
			</div>
		</div>
	</main>
	<script type="text/javascript" src="js/login.js"></script>
</body>
</html>

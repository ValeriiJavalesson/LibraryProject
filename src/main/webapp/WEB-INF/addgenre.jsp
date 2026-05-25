<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
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
<link rel="stylesheet" href="style/css/addgenre.css">
</head>
<body>
	<jsp:include page="header.jsp"></jsp:include>	
	<div class="main-content">
		
		
		<table>
			<colgroup>
				<col width="60%">
				<col width="40%">
			</colgroup>
			<thead>
				<tr>
					<th></th>
					<th></th>
				</tr>
			</thead>
			<tbody>
				<tr class="genre_clear_form" hidden="hidden" data-genre_id="">
					<td>
					<form:form modelAttribute="genreform" enctype="application/x-www-form-urlencoded">
					<input class="genre_id" type="number" hidden="hidden"> 
					<input class="genre_name" type="text">
					</form:form>
					
					</td>
					<td class="genre_form_buttons">
						<button class="save_genre_button" onclick="checkForm()"></button>
						<button class="close_genre_button" onclick="closeGenre()"></button>
					</td>
				</tr>
				<c:forEach var="genre" items="${allgenres}">
					<c:if test="${genre.id ne 1}">
						<tr class="genre_row" data-genre_id="${genre.id}" data-genre_name="${genre.name}">
							<td><div class="genre_name">${genre.name}</div></td>
							<td><div class="genre_edit">
									<div class="edit_buttons" data-genre_id="${genre.id}">
										<button class="edit_button" onclick="editGenre(${genre.id})"></button>
										<button class="confirm_delete_button" onclick="confirm_delete_genre(${genre.id})"></button>
									</div>									
									<div class="confirm_buttons" style="display: none;">
										<button  class="cancelButton" onclick="hide_delete_genre(${genre.id})">Ні</button>
										<button class="deleteButton" onclick="delete_genre(${genre.id})">Так</button>
										
									</div>
								</div></td>
						</tr>
					</c:if>
				</c:forEach>				
			</tbody>
		</table>
		<div><button class="newgenrebutton" onclick="showNewGenreForm()">Додати новий жанр</button></div>
		<div class="form_wrap">
			<form:form modelAttribute="genreform" enctype="application/x-www-form-urlencoded" id="newgenreform">
				<div>
					<input name="id" type="hidden" class="form-control" id="id">
				</div>
				<div>
					<label for="name" class="form-label">Назва жанру:</label> 
					<input name="name" type="text" class="form-control" id="name">
				</div>			
				<div class="btn btn-primary mt-3" onclick='checkNewForm()'>Зберегти</div>
			</form:form>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
	<script src="js/search.js"></script>
	<script src="js/addgenre.js"></script>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Список книг бібліотеки</title>
<link rel="icon" type="image/x-icon" href="style/images/favicon.ico">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://getbootstrap.com/docs/5.3/assets/css/docs.css" rel="stylesheet">
<link rel="stylesheet" href="style/css/home.css">
<link rel="stylesheet" href="style/css/allbooks.css">
</head>
<body>

	<c:set var="currentpage" value="${page}" />
	<input id="currentpage" hidden="hidden" value="${page}">
	<input id="word" hidden="hidden" value="${word}">
	<jsp:include page="header.jsp"></jsp:include>
	<div class="titleTableContent">
		<security:authorize access="hasRole('ROLE_ADMIN')">
			<textarea id="table_title" hidden="hidden" oninput="auto_grow(this)" placeholder="Введіть назву таблиці..." /></textarea>
			<input type="button" id="table_title_button" onclick="print('printableArea')" value="Друкувати" hidden="hidden" />
		</security:authorize>
	</div>
	<div class="ms-2">
		<div class="h6">
			<c:if test="${word ne ''}">
				<button class="btn btn-close" onclick="clearSearchedWord()"></button><span>Результати пошуку за запитом "<c:out value="${word}"></c:out>"</span>
			</c:if>
		</div>
		<div>
			<c:set var="genreName" value="Всі жанри"></c:set>
			<c:forEach var="genre" items="${allGenres}">
				<c:choose>
					<c:when test="${genre.id == genreId}">
						<c:set var="genreName" value="${genre.name}"></c:set>						
					</c:when>
				</c:choose>
			</c:forEach>			
			<div>
				<label class="h3 mb-3">${genreName}</label>
				<div class="h6">
					<c:choose>
						<c:when test="${numberOfAllBooks > 0}">
							<fmt:formatNumber value="${booksOnPage * (page - 1) + 1}" maxFractionDigits="0" pattern="0"/>
						</c:when>
						<c:otherwise>
							<fmt:formatNumber value="0" maxFractionDigits="0" />
						</c:otherwise>
					</c:choose>
					
					-
					<c:choose>
						<c:when test="${booksOnPage * page > numberOfAllBooks}">
							<fmt:formatNumber value="${numberOfAllBooks}" maxFractionDigits="0" pattern="0"/>
						</c:when>
						<c:otherwise>
							<fmt:formatNumber value="${booksOnPage * page}" maxFractionDigits="0" pattern="0"/>
						</c:otherwise>
					</c:choose>
					з
					<fmt:formatNumber value="${numberOfAllBooks}" maxFractionDigits="0" pattern="0"/>
					книг
				</div>
			</div>
		</div>
		<div>
			<c:forEach var="i" begin="1" end="${numberOfPages}">
				<c:url value="/allbooks" var="pageURL">
					<c:param name="page" value="${i}" />
					<c:param name="word" value="${word}" />
					<c:param name="genreId" value="${genreId}" />
				</c:url>
				<a role="button" class="btn btn-light m-1" href="${pageURL}">${i}</a>
			</c:forEach>
		</div>
	</div>
	<div class="main-content d-flex justify-content-center" id="printableArea">
		<table class="allbooks_table" style="counter-reset: row-num ${booksOnPage * (page - 1)-1}">
			<colgroup>
				<col width="7%">
				<col width="6%">
				<col width="8%">
				<col width="10%">
				<col width="8%">
				<col width="8%">
				<col width="6%">
				<col width="6%">
				<col width="8%">
				<col width="5%">
				<col width="16%">
				<security:authorize access="hasRole('ROLE_ADMIN')">
					<col width="6%">
					<col width="6%">
				</security:authorize>

			</colgroup>
			<thead>
				<tr>
					<th colspan="1">
						<div class="titleTableContent">
							<security:authorize access="hasRole('ROLE_ADMIN')">
								<input type="button" id="preparePrintButton" onclick="showPrintBtn()" data-print="false" />
							</security:authorize>
						</div>
					</th>
					<th colspan="1">Реєстра-ційний номер</th>
					<th colspan="1">Автор</th>
					<th colspan="1">Назва</th>
					<th colspan="1">Видання</th>
					<th colspan="1">Кількість сторінок</th>
					<th colspan="1">Вартість</th>
					<th colspan="1">Рік випуску</th>
					<th colspan="1">Мова перекладу</th>
					<th colspan="1">Жанр</th>
					<th colspan="1">Опис</th>
					<security:authorize access="hasRole('ROLE_ADMIN')">
						<th>Дитяче</th>
						<th>Закрита секція</th>
					</security:authorize>

				</tr>
			</thead>
			<tbody>
				<c:forEach var="book" items="${allbooks}">
					<tr class="book_id${book.id}">
						<td colspan="1"><security:authorize access="hasRole('ROLE_ADMIN')">
								<button class="btn toEditButton" onclick="editbook(${book.id})"></button>
							</security:authorize></td>
						<td colspan="1">${book.registrationNumber}</td>
						<td colspan="1">${book.author}</td>
						<td colspan="1">${book.name}</td>
						<td colspan="1">${book.edition}</td>
						<td colspan="1" class="centerAlign">${book.numberOfPages}</td>
						<td colspan="1" class="rightAlign"><fmt:formatNumber value="${book.price}" maxFractionDigits="2" /> ${book.currency}</td>
						<td colspan="1" class="centerAlign">${book.year}</td>
						<td colspan="1">${book.language}</td>
						<td colspan="1"><c:set var="genre" value="${book.genre}"></c:set>${genre.name}</td>
						<td>${book.notes}</td>
						<security:authorize access="hasRole('ROLE_ADMIN')">
							<td class="checkbox_td"><c:choose>
									<c:when test="${book.childhood==true}">
										<input type="checkbox" data-book_id="${book.id}" id="${book.id}_checkbox_childhood" checked onclick="checkbox_childhood(this)" />
									</c:when>
									<c:otherwise>
										<input type="checkbox" data-book_id="${book.id}" id="${book.id}_checkbox_childhood" onclick="checkbox_childhood(this)" />
									</c:otherwise>
								</c:choose></td>
							<td class="checkbox_td"><c:choose>
									<c:when test="${book.closedSection==true}">
										<input type="checkbox" data-book_id="${book.id}" id="${book.id}_checkbox_closedSection" checked onclick="closedSection_change(this)" />
									</c:when>
									<c:otherwise>
										<input type="checkbox" data-book_id="${book.id}" id="${book.id}_checkbox_closedSection" onclick="closedSection_change(this)" />
									</c:otherwise>
								</c:choose></td>
						</security:authorize>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
	<div class="ms-2 mb-3">
		<c:forEach var="i" begin="1" end="${numberOfPages}">
			<a role="button" class="btn btn-light m-1" href="allbooks?page=${i}&word=${word}">${i}</a>
		</c:forEach>
	</div>
	<div id="filter">
		<button role="button" class="filter_button" onclick="displayFilters()"></button>
		<div id="filter_list">
				<label for="genre0">Всі жанри<input name="genre" class="filter_value" type="radio" data-filter_id="0" value="0" id="genre0" onclick="applyFilter()"
					></label>
			<c:forEach var="genre" items="${allGenres}">
				<label for="genre${genre.id}">${genre.name}<input name="genre" class="filter_value" type="radio" data-filter_id="${genre.id}" value="${genre.id}" id="genre${genre.id}" onclick="applyFilter()"
					></label>
			</c:forEach>
		</div>
	</div>



	<script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
	<script type="text/javascript" src="js/allbooks.js"></script>
</body>
</html>
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
<script>
    // Зчитуємо поточний стан сортування безпосередньо з моделі Spring
    var currentSortField = "${sortField != null ? sortField : 'id'}";
    var currentSortDir = "${sortDir != null ? sortDir : 'asc'}";
    var page = ${page != null ? page : 1};
    var word = "${word != null ? word : ''}";
</script>

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
	<div  class="ms-2" data-bs-theme="dark">
		<div class="h6 text-light" data-bs-theme="dark">
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
				<label class="h3 mb-3 text-light">${genreName}</label>
				<div class="h6 text-light">
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
					<c:param name="sort" value="${sortField}" /> 
           			<c:param name="dir" value="${sortDir}" />
											
				</c:url>
				<c:set var="sectionURL" value=""></c:set>							
					<c:forEach var="section" items="${sections}">
						<c:set var="sectionURL" value="${sectionURL}&sections=${section}" />
					</c:forEach>	
					<c:if test="${sectionURL eq ''}">
						<c:set var="sectionURL" value="&sections="></c:set>
					</c:if>
					<c:choose>
						<c:when test="${i eq page}">
							<a role="button" class="btn btn-light fw-bold m-1 text-bg-info" href="${pageURL}${sectionURL}">${i}</a>
						</c:when>
						<c:otherwise>
							<a role="button" class="btn btn-light m-1" href="${pageURL}${sectionURL}">${i}</a>
						</c:otherwise>
					</c:choose>				
			</c:forEach>
		</div>
	</div>
	<div class="main-content d-flex justify-content-center" id="printableArea">
		<c:forEach var="section" items="${sections}">
			<input type="text" name="section" value="${section}" hidden="hidden"/>
		</c:forEach>
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
					<!-- <th colspan="1" onclick="sortBy('registrationNumber')">Реєстра-ційний номер</th>
					<th colspan="1" onclick="sortBy('author')">Автор</th>
					<th colspan="1" onclick="sortBy('name')">Назва</th>
					<th colspan="1" onclick="sortBy('edition')">Видання</th>
					<th colspan="1" onclick="sortBy('numberOfPages')">Кількість сторінок</th>
					<th colspan="1" onclick="sortBy('price')">Вартість</th>
					<th colspan="1" onclick="sortBy('year')">Рік випуску</th>
					<th colspan="1" onclick="sortBy('language')">Мова перекладу</th>
					<th colspan="1" onclick="sortBy('genre')">Жанр</th>
					<th colspan="1" onclick="sortBy('notes')">Опис</th> -->
					<th onclick="sortBy('registrationNumber')" style="cursor: pointer;">
			            Реєстраційний номер 
			            <c:if test="${sortField eq 'registrationNumber'}">${sortDir eq 'asc' ? ' ▲' : ' ▼'}</c:if>
			        </th>
			        <th onclick="sortBy('author')" style="cursor: pointer;">
			            Автор 
			            <c:if test="${sortField eq 'author'}">${sortDir eq 'asc' ? ' ▲' : ' ▼'}</c:if>
			        </th>
			        <th onclick="sortBy('name')" style="cursor: pointer;">
			            Назва 
			            <c:if test="${sortField eq 'name'}">${sortDir eq 'asc' ? ' ▲' : ' ▼'}</c:if>
			        </th>
			        <th onclick="sortBy('edition')" style="cursor: pointer;">
			            Видання 
			            <c:if test="${sortField eq 'edition'}">${sortDir eq 'asc' ? ' ▲' : ' ▼'}</c:if>
			        </th>
			        <th onclick="sortBy('numberOfPages')" style="cursor: pointer;">
			            Кількість сторінок 
			            <c:if test="${sortField eq 'numberOfPages'}">${sortDir eq 'asc' ? ' ▲' : ' ▼'}</c:if>
			        </th>
			        <th onclick="sortBy('price')" style="cursor: pointer;">
			            Вартість 
			            <c:if test="${sortField eq 'price'}">${sortDir eq 'asc' ? ' ▲' : ' ▼'}</c:if>
			        </th>
			        <th onclick="sortBy('year')" style="cursor: pointer;">
			            Рік випуску 
			            <c:if test="${sortField eq 'year'}">${sortDir eq 'asc' ? ' ▲' : ' ▼'}</c:if>
			        </th>
			        <th onclick="sortBy('language')" style="cursor: pointer;">
			            Мова перекладу 
			            <c:if test="${sortField eq 'language'}">${sortDir eq 'asc' ? ' ▲' : ' ▼'}</c:if>
			        </th>
			        <th onclick="sortBy('genre')" style="cursor: pointer;">
			            Жанр 
			            <c:if test="${sortField eq 'genre'}">${sortDir eq 'asc' ? ' ▲' : ' ▼'}</c:if>
			        </th>
			        <th onclick="sortBy('notes')" style="cursor: pointer;">
			            Опис 
			            <c:if test="${sortField eq 'notes'}">${sortDir eq 'asc' ? ' ▲' : ' ▼'}</c:if>
			        </th>
					<security:authorize access="hasRole('ROLE_ADMIN')">
											
						<th>
							<div class="align-items-center d-flex flex-column">
								<div class="text-center">Дитяче</div>
								<input type="checkbox" class="sectionFilter" name="childhood" onclick="section_filter()">
							</div>
						</th>
						<th>
							<div class="align-items-center d-flex flex-column">
								<div class="text-center">Закрита секція</div>
								<input type="checkbox" class="sectionFilter"  name="closedSection" onclick="section_filter()">
							</div>
						</th>
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
							<td class="checkbox_td">								
								<c:choose>
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
	<div>
		<c:forEach var="i" begin="1" end="${numberOfPages}">
			<c:url value="/allbooks" var="pageURL">				
				<c:param name="page" value="${i}" />
				<c:param name="word" value="${word}" />
				<c:param name="genreId" value="${genreId}" />	
				<c:param name="sort" value="${sortField}" /> 
           		<c:param name="dir" value="${sortDir}" />
										
			</c:url>
			<c:set var="sectionURL" value=""></c:set>							
				<c:forEach var="section" items="${sections}">
					<c:set var="sectionURL" value="${sectionURL}&sections=${section}" />
				</c:forEach>	
				<c:if test="${sectionURL eq ''}">
					<c:set var="sectionURL" value="&sections="></c:set>
				</c:if>
				<c:choose>
					<c:when test="${i eq page}">
						<a role="button" class="btn btn-light fw-bold m-1 text-bg-info" href="${pageURL}${sectionURL}">${i}</a>
					</c:when>
					<c:otherwise>
						<a role="button" class="btn btn-light m-1" href="${pageURL}${sectionURL}">${i}</a>
					</c:otherwise>
				</c:choose>
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
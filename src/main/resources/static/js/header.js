let books = null;
let filteredBooks = null;
let searchedword = "";
$(document).ready(function() {
	//getBooks("");
});

searchBar = document.getElementById('search');
searchBar.addEventListener("keydown", (e) => {
	if (e.key === 'Enter') {
		findBook();
	}
});

function findBook() {
	var word = $("input#search").val();
	word = word.trim();
	if (word.length > 2) {
		$.get("getbooksbyword", { word: word }, function(data) {
			if (data !== '') {
				filteredBooks = data;
				searchedword = word;
			}
		}).done(function() {
			showResults();
			$("input#search").val("");
		});
	}
}

function getBooks(word) {
	searchedword = '"' + word + '"';
	if (books == null) {
		$.get("getbooksbyword", { word: word }, function(data) {
			if (data !== '') {
				books = data;
				filteredBooks = data;
			}
		});
	}

};



function showResults() {
	var cardsContent = "<div class='d-flex flex-wrap justify-content-evenly' id='product-cards'>";
	jQuery.each(filteredBooks, function(i, book) {
		var lang;
		if (book.language === 'Russian') lang = "src='style/images/ru.png'";
		if (book.language === 'Ukrainian') lang = "src='style/images/ua.png'";
		var image_lang = '';
		image_lang += "<img " + lang + " class='' alt='lang_icon' height='15px'>";

		cardsContent += " <div class='card m-2 shadow' role='button' style='width: 24rem; height: 550px;' onclick='getbook(" + book.id + ")'>" +
			"<img src='style/images/book.jpg' class='card-img-top' alt='book_image' height='220px'>" +


			"<div class='card-body'>" +
			"<h4 class='card-title' id='name'>" + book.name + "</h4>" +
			"<h6 class='card-title' id='author'>" + book.author + "</h6><hr>" +
			"<p class='card-text m-0' id='registrationNumber'><b>Реєстраційний номер: </b>" + book.registrationNumber + "</p>" +
			"<p class='card-text m-0' id='edition'><b>Видання: </b>" + book.edition + "</p>" +
			"<p class='card-text m-0' id='numberOfPages'><b>Кількість сторінок: </b>" + book.numberOfPages + "</p>" +
			"<p class='card-text m-0' id='price'><b>Ціна: </b>" + book.price + "</p>" +
			"<p class='card-text m-0' id='year'><b>Рік друку: </b>" + book.year + "</p>" +
			"<p class='card-text m-0' id='language'><b>Мова перекладу: </b>" + image_lang + "</p>";
		if (book.notes != '') cardsContent += "<p class='card-text m-0 overflow-hidden' id='notes' style='height: 46px;'><b>Опис: </b>" + book.notes + "</p>";
		cardsContent += "</div>" +
			"</div>";

	});
	cardsContent += "</div>";
	$('.main-content').html(cardsContent);
	$('.searchedword').html('Результати пошуку за запитом "' + searchedword + '" - ' + filteredBooks.length + ' шт');
	searchedword = '';

};

function getbook(id){
	window.location = `/book?id=${id}`;
}

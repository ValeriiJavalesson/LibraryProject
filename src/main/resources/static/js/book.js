function deleteBook(book_id){
	var id = { id: book_id };
	$.ajax({
		url: 'delete_book',
		type: 'DELETE',
		data: id,
		complete: function(data) {
			alert(data.responseText);
			window.location = "home";
		}
	});
}

function editBook(id){
	window.location = `newbook?id=${id}`;
}
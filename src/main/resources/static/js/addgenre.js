$(document).ready(function() {
	let form = $(".form_wrap")[0];
	$(form).hide();

});

function showNewGenreForm(){
	let form = $(".form_wrap")[0];
	$(form).toggle();
	buttomFunction();
}


function editGenre(id) {
	let row = $("table").find(`.genre_row[data-genre_id='${id}']`);
	let name = $(row).data("genre_name");
	let genre_form = $('.genre_clear_form').clone();
	$(row).after(genre_form);
	$(row).hide();


	$(genre_form).toggleClass('genre_clear_form');
	$(genre_form).toggleClass('genre_form');
	$(genre_form).attr('hidden', false);
	$(genre_form).attr('data-genre_id', id);
	$(genre_form).find('input.genre_id').val(id);
	$(genre_form).find('input.genre_id').attr('name', 'id');
	$(genre_form).find('input.genre_name').attr('name', "name");
	$(genre_form).find('input.genre_name').val(name);
	$(genre_form).find('form').attr('id', "genreform" + id);
	$(genre_form).find('button.close_genre_button').attr('onclick', `closeGenre('${id}')`);
	$(genre_form).find('button.save_genre_button').attr('onclick', `checkForm('${id}')`);

}

function closeGenre(id) {
	let row = $("table").find(`.genre_row[data-genre_id='${id}']`);
	$(row).show();
	let genre_form = $("table").find(`.genre_form[data-genre_id='${id}']`);
	$(genre_form).remove();
}

function checkForm(id) {
	const form = $("#genreform" + id)[0];
	var formData = new FormData(form);
	$.ajax({
		type: "POST",
		url: 'save_genre',
		data: formData,
		contentType: false,
		processData: false,
		complete: function(data) {
			window.location = data.responseText;
		}
	});
}

function checkNewForm() {
	const form = $("#newgenreform")[0];
	var formData = new FormData(form);
	$.ajax({
		type: "POST",
		url: 'save_genre',
		data: formData,
		contentType: false,
		processData: false,
		complete: function(data) {
			window.location = data.responseText;
		}
	});
}

function delete_genre(id) {
	$.post("delete_genre", { id: id }, function(data) {
		window.location = data;
	});
}

function confirm_delete_genre(id){	
	let edit_buttons = $("table").find(`.edit_buttons[data-genre_id='${id}']`);
	let confirm_buttons = $(edit_buttons).next();
	$(edit_buttons).hide();
	$(confirm_buttons).show();
}

function hide_delete_genre(id){
	let edit_buttons = $("table").find(`.edit_buttons[data-genre_id='${id}']`);
	let confirm_buttons = $(edit_buttons).next();
	$(confirm_buttons).hide();
	$(edit_buttons).show();
}
















function checkForm() {
	const form = $("#genreform")[0];
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
	})
}

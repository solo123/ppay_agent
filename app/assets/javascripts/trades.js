var trades=function () {
	$('#trade_search_btn').click(function(){
		$.ajax({
			cache: true,
			type: "GET",
			url:'/trades',
			data:$('#trade_search').serialize(),
			dataType: 'json',
			error: function(request) {
				alert("Connection error");
			},
			success: function(data) {
				$("#trade_body").html(data);
			}
		});
	});
}
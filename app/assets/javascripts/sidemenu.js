var sidemenu =function () {
	$('.pagination').addClass('m-t-0 m-b-10');
	$('.pagination span').css('padding','10px');
	$('.pagination span').css('font-size','18px');

	// $("#weixin").mouseover(function(){
	// 	$('#weixinjy').show();
	// })
	// $("#weixin").mouseout(function(){
	// 	$('#weixinjy').hide();
	// })

	if (window.location.pathname=='/') {
		$('#sidemenu').children().eq(0).addClass('active');
	};
	if (window.location.pathname=='/clients') {
		$('#sidemenu').children().eq(1).addClass('active');
	};
	if (window.location.pathname=='/salesmen') {
		$('#sidemenu').children().eq(2).addClass('active');
	};
	if (window.location.pathname=='/trades') {
		$('#sidemenu').children().eq(3).addClass('active');
	};
	if (window.location.pathname=='/home/profile') {
		$('#sidemenu').children().eq(4).addClass('active');
	};

	
}

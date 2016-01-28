var sidemenu =function () {

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

var sidemenu = function () {
	if (window.location.pathname=='/') {
		$('#sidemenu > li:nth-child(2)').addClass('active');
	} else {
    $('#sidemenu li ul li a[href="'+ window.location.pathname +'"]').parents('li').addClass('active');
  }
}

var sidemenu = function () {
	if (window.location.pathname=='/') {
		$('#sidemenu > li:nth-child(1)').addClass('active');
	} else {
    $('#sidemenu a[href="'+ window.location.pathname +'"]').parents('li').addClass('active');
  }
}

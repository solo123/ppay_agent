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
		$('#sidemenu').children().eq(1).find('ul li').eq(0).addClass('active');
	};
	if (window.location.pathname=='/salesmen') {
		$('#sidemenu').children().eq(1).addClass('active');
		$('#sidemenu').children().eq(1).find('ul li').eq(1).addClass('active');
	};
	if (window.location.pathname=='/contacts') {
		$('#sidemenu').children().eq(1).addClass('active');
		$('#sidemenu').children().eq(1).find('ul li').eq(2).addClass('active');
	};
	if (window.location.pathname=='/trades') {
		$('#sidemenu').children().eq(2).addClass('active');
		$('#sidemenu').children().eq(2).find('ul li').eq(0).addClass('active');
	};
	if (window.location.pathname=='/clearings') {
		$('#sidemenu').children().eq(2).addClass('active');
		$('#sidemenu').children().eq(2).find('ul li').eq(1).addClass('active');
	};
	if (window.location.pathname=='/imp_logs') {
		$('#sidemenu').children().eq(3).addClass('active');
		$('#sidemenu').children().eq(3).find('ul li').eq(0).addClass('active');
	};
	if (window.location.pathname=='/imp_qf_customers') {
		$('#sidemenu').children().eq(3).addClass('active');
		$('#sidemenu').children().eq(3).find('ul li').eq(1).addClass('active');
	};
	if (window.location.pathname=='/imp_qf_trades') {
		$('#sidemenu').children().eq(3).addClass('active');
		$('#sidemenu').children().eq(3).find('ul li').eq(2).addClass('active');
	};
	if (window.location.pathname=='/imp_qf_clearings') {
		$('#sidemenu').children().eq(3).addClass('active');
		$('#sidemenu').children().eq(3).find('ul li').eq(3).addClass('active');
	};
	if (window.location.pathname=='/users') {
		$('#sidemenu').children().eq(4).addClass('active');
		$('#sidemenu').children().eq(4).find('ul li').eq(0).addClass('active');
	};
	if (window.location.pathname=='/agents') {
		$('#sidemenu').children().eq(4).addClass('active');
		$('#sidemenu').children().eq(4).find('ul li').eq(1).addClass('active');
	};
	if (window.location.pathname=='/data_manage') {
		$('#sidemenu').children().eq(4).addClass('active');
		$('#sidemenu').children().eq(4).find('ul li').eq(2).addClass('active');
	};
	if (window.location.pathname=='/addresses') {
		$('#sidemenu').children().eq(5).addClass('active');
		$('#sidemenu').children().eq(5).find('ul li').eq(1).addClass('active');
	};
	if (window.location.pathname=='/pos_machines') {
		$('#sidemenu').children().eq(5).addClass('active');
		$('#sidemenu').children().eq(5).find('ul li').eq(2).addClass('active');
	};
	if (window.location.pathname=='/profile/info') {
		$('#sidemenu').children().eq(6).addClass('active');
		$('#sidemenu').children().eq(6).find('ul li').eq(0).addClass('active');
	};

	
}

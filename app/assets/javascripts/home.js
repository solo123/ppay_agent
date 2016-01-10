var homejs=function(){
	$('#nextmonth_monthsum').click(function(){
		var month=parseInt($('#date_monthsum').text().substr(-2,2));
		var year=parseInt($('#date_monthsum').text().substr(0,4));
		if (month==12) {month=1;year+=1;}else {month+=1;}
		$('#date_monthsum').text(year+'-'+('0'+month).substr(-2,2));
		$('#month_client_day_tradetotals_path').attr('href','/client_day_tradetotals/month?q='+year+month);
		$('#month_client_day_tradetotals_path').trigger("click");
	});
	$('#premonth_monthsum').click(function(){
		var month=parseInt($('#date_monthsum').text().substr(-2,2));
		var year=parseInt($('#date_monthsum').text().substr(0,4));
		if (month==1) {year-=1;month=12;}else{month-=1;};
		$('#date_monthsum').text(year+'-'+('0'+month).substr(-2,2));
		$('#month_client_day_tradetotals_path').attr('href','/client_day_tradetotals/month?q='+year+month);
		$('#month_client_day_tradetotals_path').trigger("click");
	});

	$('#nextmonth_activeclient').click(function(){
		var month=parseInt($('#date_activeclient').text().substr(-2,2));
		var year=parseInt($('#date_activeclient').text().substr(0,4));
		if (month==12) {month=1;year+=1;}else {month+=1;}
		$('#date_activeclient').text(year+'-'+('0'+month).substr(-2,2));
		$('#active_client_day_tradetotals_path').attr('href','/client_day_tradetotals/active?q='+year+month);
		$('#active_client_day_tradetotals_path').trigger("click");
	});
	$('#premonth_activeclient').click(function(){
		var month=parseInt($('#date_activeclient').text().substr(-2,2));
		var year=parseInt($('#date_activeclient').text().substr(0,4));
		if (month==1) {year-=1;month=12;}else{month-=1;};
		$('#date_activeclient').text(year+'-'+('0'+month).substr(-2,2));
		$('#active_client_day_tradetotals_path').attr('href','/client_day_tradetotals/active?q='+year+month);
		$('#active_client_day_tradetotals_path').trigger("click");
	});

	$('#nextmonth_activeagent').click(function(){
		var month=parseInt($('#date_activeagent').text().substr(-2,2));
		var year=parseInt($('#date_activeagent').text().substr(0,4));
		if (month==12) {month=1;year+=1;}else {month+=1;}
		$('#date_activeagent').text(year+'-'+('0'+month).substr(-2,2));
		$('#agent_day_tradetotal_path').attr('href','/agent_day_tradetotals/active?q='+year+month);
		$('#agent_day_tradetotal_path').trigger("click");
	});
	$('#premonth_activeagent').click(function(){
		var month=parseInt($('#date_activeagent').text().substr(-2,2));
		var year=parseInt($('#date_activeagent').text().substr(0,4));
		if (month==1) {year-=1;month=12;}else{month-=1;};
		$('#date_activeagent').text(year+'-'+('0'+month).substr(-2,2));
		$('#agent_day_tradetotal_path').attr('href','/agent_day_tradetotals/active?q='+year+month);
		$('#agent_day_tradetotal_path').trigger("click");
	});
}












// var homejs =function() {
// 	function month_sum () {
// 		var date_text=$('#date_monthsum').text();
// 		var mydate=new Date(Date.parse(date_text));
// 		var year=mydate.getFullYear();
// 		var month=mydate.getMonth();
// 		$.ajax({
// 			type:'GET',
// 			url:'/activeinfo/month_sum.json?year='+year+'&&month='+month,
// 			dataType:'json',
// 			success:function(data){
// 				var str='';
// 				for (var i = 0; i < data.length-1; i++) {
// 					str+="<tr><td>"+(i+1)+"</td><td>"+data[i].amount_sum+"</td><td>"+data[i].num_sum+"</td><td>"+data[i].wechat_amount_sum+"</td><td>"+data[i].wechat_num_sum+"</td><td>"+data[i].alipay_amount_sum+"</td><td>"+data[i].alipay_num_sum+"</td><td>"+data[i].t0_amount_sum+"</td><td>"+data[i].t0_num_sum+"</td></tr>"
// 				};
// 				var str_last ="<tr><td>汇总"+"</td><td>"+data[data.length-1].amount_sum+"</td><td>"+data[data.length-1].num_sum+"</td><td>"+data[data.length-1].wechat_amount_sum+"</td><td>"+data[data.length-1].wechat_num_sum+"</td><td>"+data[data.length-1].alipay_amount_sum+"</td><td>"+data[data.length-1].alipay_num_sum+"</td><td>"+data[data.length-1].t0_amount_sum+"</td><td>"+data[data.length-1].t0_num_sum+"</td></tr>"
// 				$('#monthsum_tbody').html(str+str_last);
// 			},
// 		});
// 	}
// 	month_sum();
// 	$('#nextmonth_monthsum').click(function(){
// 		var month=parseInt($('#date_monthsum').text().substr(-2,2));
// 		var year=parseInt($('#date_monthsum').text().substr(0,4));
// 		if (month==12) {month=1;year+=1;}else {month+=1;}
// 		a='0'+month;
// 		// alert(a.substr(-2,2));
// 		$('#date_monthsum').text(year+'-'+a.substr(-2,2));
// 		month_sum();
// 	});
// 	$('#premonth_monthsum').click(function(){
// 		var month=parseInt($('#date_monthsum').text().substr(-2,2));
// 		var year=parseInt($('#date_monthsum').text().substr(0,4));
// 		if (month==1) {year-=1;month=12;}else{month-=1;};
// 		a='0'+month;
// 		$('#date_monthsum').text(year+'-'+a.substr(-2,2));
// 		month_sum();
// 	});
//
// 	$.ajax({
// 		type:'GET',
// 		url:'http:/activeinfo/new_client.json',
// 		dataType:'json',
// 		success:function(data){
// 			var str='';
// 			for (var i = 0; i < data.length; i++) {
// 				str+="<tr><td>"+data[i].shop_name+"</td><td>"+data[i].shid+"</td><td>"+data[i].shop_tel+"</td><td>"+data[i].category_id+"</td><td>"+data[i].salesman_id+"</td><td>"+data[i].rate+"</td><td>"+data[i].created_at+"</td><td><a href='#'>详细</a></td></tr>"
// 			};
// 			$('#newclient_tbody').append(str);
// 		},
// 	});
//
//
// 	function active_client () {
// 		var date_text=$('#date_activeclient').text();
// 		var mydate=new Date(Date.parse(date_text));
// 		var year=mydate.getFullYear();
// 		var month=mydate.getMonth();
// 		$.ajax({
// 			type:'GET',
// 			url:'http:/activeinfo/client.json?year='+year+'&&month='+month,
// 			dataType:'json',
// 			success:function(data){
// 				var str='';
// 				for (var i = 0; i < data.length; i++) {
// 					str+="<tr><td>"+data[i].id+"</td><td>"+data[i].shop_name+"</td><td>"+data[i].shid+"</td><td>"+data[i].shop_tel+"</td><td>"+data[i].category_id+"</td><td>"+data[i].salesman_id+"</td><td>"+data[i].qudao+"</td><td>"+data[i].created_at+"</td><td>"+data[i].rate+"</td></tr>"
// 				};
// 				$('#activeclient_tbody').html(str);
// 			},
// 		});
// 	}
// 	active_client();
// 	$('#nextmonth_activeclient').click(function(){
// 		var month=parseInt($('#date_activeclient').text().substr(-2,2));
// 		var year=parseInt($('#date_activeclient').text().substr(0,4));
// 		if (month==12) {month=1;year+=1;}else {month+=1;}
// 		a='0'+month;
// 		// alert(a.substr(-2,2));
// 		$('#date_activeclient').text(year+'-'+a.substr(-2,2));
// 		active_client();
// 	});
// 	$('#premonth_activeclient').click(function(){
// 		var month=parseInt($('#date_activeclient').text().substr(-2,2));
// 		var year=parseInt($('#date_activeclient').text().substr(0,4));
// 		if (month==1) {year-=1;month=12;}else{month-=1;};
// 		a='0'+month;
// 		$('#date_activeclient').text(year+'-'+a.substr(-2,2));
// 		active_client();
// 	});
//
//
//
// 	$.ajax({
// 		type:'GET',
// 		url:'http:/activeinfo/agent.json',
// 		dataType:'json',
// 		success:function(data){
// 			var str='';
// 			for (var i = 0; i < data.length; i++) {
// 				str+="<tr><td>"+data[i].id+"</td><td>"+data[i].shop_name+"</td><td>"+data[i].shid+"</td><td>"+data[i].shop_tel+"</td><td>"+data[i].category_id+"</td><td>"+data[i].salesman_id+"</td><td>"+data[i].qudao+"</td><td>"+data[i].created_at+"</td><td>"+data[i].rate+"</td></tr>"
// 			};
// 			$('#activeagent_tbody').append(str);
// 		},
// 	});
// }

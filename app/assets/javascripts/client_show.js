var client_show = function() {
	$('#beizhubtn').click(function(){
		var checkedradio = $(".radio-inline input[name='optionsRadios']:checked").val();
	 	var bztextval = $('#beizhutext').val();
	 	var mydate = new Date();
		$('#beizhuxinxi').append("<div class='row'><div class='col-md-6'><strong>"+
				checkedradio+"</strong><span>"+bztextval+
				"</span></div><div class='col-md-2'><span>usename</span></div><div class='col-md-2'><span>"
				+mydate+"</span></div><div class='col-md-2'><button class='btn btn-xs btn-default'>归档</button></div></div>");
		$.ajax({
			type:'POST',
			url:'http://localhost:3000/clients/1/note',
			dataType:'json',
			data: {
				tip: 'info',
				note: '你是天边的一度云啊，在那里飘荡啊.',
				user_id: 1
			},
		});
	});


	$('#biaoqianbtn').click(function(){
		var urlval = window.location.pathname;
		var urlval_last = urlval.substring(urlval.indexOf("clients/")+8);
		// alert(urlval_last);
		var bqtextval=$('#biaoqiantext').val();
		$('#biaoqianxinxi').append(bqtextval+'，');
		$.ajax({
      // 以post方式发送
      type:'POST',
      url:'http://localhost:3000/clients/'+urlval_last+'/tags',
      dataType:'json',
      data: {
        // 把标签以数组的形式放在这里
        tags: [bqtextval]
       },
       success:function(data){
       	console.log('ok---');
       },
       error: function(jqXHR){
       	console.log('error---');
       }
      });
	});
	$('#cybq button').click(function(){
		var cybqval = $(this).text();
		var dqbqtextval=$('#biaoqiantext').val();
		var newbqtextval=dqbqtextval+cybqval;
		$('#biaoqiantext').val(newbqtextval+' ');
	});
}
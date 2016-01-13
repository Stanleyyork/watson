$(function() {

	console.log("settings.js working");
	var counter = 5;

	$('#retrieve-tweets-submit').on('submit', function(e){
		e.preventDefault();
		$("div.hidden").removeClass("hidden");
		var twitter_username = $('#twitter_username')[0]['value'];
		progressBarCount();
		$.ajax({
			type: "POST",
			url: '/twitter',
			data: {twitter_username: twitter_username},
			success: function (data) {
				console.log("Sent");
				clearInterval(time);
				$('#progress_bar').css('width', 351);
				setInterval(function(){
					$('#progress_bar').append('<span class="glyphicon glyphicon-ok"></span>');
				},2500);
				
		    },
		    error: function (error) {
		      console.log("Error: ");
		      console.error(error);
		    }
		});

	});

	function progressBarCount() {
		time=setInterval(function(){
			if(counter > 325){
				clearInterval(time);
			} else if (counter > 260) {
				counter += 3;
			} else {
				counter += 7;
			}
			console.log(counter);
			$('#progress_bar').css('width', counter);
		},300);
	}

});
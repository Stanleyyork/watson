$(function() {

	console.log("settings.js working");
	var counter = 5;

	$('#retrieve-tweets-submit').on('submit', function(e){
		e.preventDefault();
		$(".progress.hidden").removeClass("hidden");

		var twitter_username = $('#twitter_username')[0]['value'];
		progressBarCount();
		$.ajax({
			type: "POST",
			url: '/twitter',
			data: {twitter_username: twitter_username},
			success: function (data) {
				console.log("Sent");
				clearInterval(time);
				$('#progress_bar').css('width', "100%");
				setInterval(function(){
					$('#progress-bar-check').append('<span class="glyphicon glyphicon-ok"></span>');
				},2000);
				setInterval(function(){
					$('#retrieve-tweets').addClass("hidden");
					$('#analyze-tweets').removeClass("hidden");
				},4000);
		    },
		    error: function (error) {
		      console.log("Error: ");
		      console.error(error);
		    }
		});

	});

	function progressBarCount() {
		time=setInterval(function(){
			if(counter > 90){
				clearInterval(time);
			} else if (counter > 80) {
				counter += 0.5;
			} else {
				counter += 2;
			}
			counter_percent = String(counter) + "%";
			console.log(counter);
			$('#progress_bar').css('width', counter_percent);
		},300);
	}

});
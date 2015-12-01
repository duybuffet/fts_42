var interval;

function time_remaining(total_seconds){
  if (total_seconds <= 0) {
    $("#time_remaining").text(time_over_msg);
    if(total_seconds == 0){
      $("form").submit();
    }
    $("[type='submit']").remove();
    return;
  }else{
    var minutes = Math.floor(total_seconds / 60);
    var seconds = total_seconds % 60;
    $("#time-remaining").text(minutes + " : " + seconds);
  }
}

var ready_var = function(){
  total_times = $("#hidden-data").data("time-remaining");
  time_over_msg = $("#hidden-data").data("time-over-msg");
  time_remaining(total_times);
  clearInterval(interval);
  interval = setInterval(function() {
    time_remaining(total_times--);
  }, 1000);
}

$(document).ready(ready_var);
$(document).on("page:load", ready_var);

var task;

$(document).ready(function(){
  if ($('.task-in-progress').length > 0) {
    var inProgress = $(".task-in-progress");
    var taskID = inProgress.attr("id");
    var request = $.ajax({
      url: "/tasks/" + taskID,
      method: "get",
    }).done(function(response){
      console.log(response);
      task = response;
      getEachSecond();
    });
  }
});

function getEachSecond() {
     window.setTimeout(getEachSecond, 1000);

     calculateTime(task);
 }

 function calculateTime(response){
    var startTime = response.start_time;
    var timeBox = response.time_box;
    var now = new Date();
    var start = new Date(startTime);
    var timeDifference = Math.floor(((now - start)/1000));

    var hours = Math.floor(timeDifference/3600);

    var minutes = Math.floor((timeDifference/60) % 60);

    var seconds = Math.floor(timeDifference % 60);

    $(".hours").html(hours);
    $(".minutes").html(minutes);
    $(".seconds").html(seconds);

  }

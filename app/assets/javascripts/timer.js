$(document).ready(function(){
  var request = $.ajax({
    url: "/tasks/45",
    method: "get",
    // dataType: "json",
    // data: $this.serialize()
  }).done(function(response){
    var startTime = response.start_time;
    var timeBox = response.time_box
  //   console.log("@task")
  var now = new Date();
  var now_utc = new Date(now.getUTCFullYear(), now.getUTCMonth(), now.getUTCDate(),  now.getUTCHours(), now.getUTCMinutes(), now.getUTCSeconds());

    var start = new Date(startTime);

    console.log(now_utc)
    console.log(start)
    // console.log(Time.now())
    // console.log(startTime);
    // console.log(response);
    // console.log(timeBox);
  })
  // })

    // console.log(JSON.parse(data));

  // console.log(data)
  // var task = task.evalJSON();
  // console.log("hello")


})

// <script>
// function startTime() {
//     var today=new Date();
//     var h=today.getHours();
//     var m=today.getMinutes();
//     var s=today.getSeconds();
//     m = checkTime(m);
//     s = checkTime(s);
//     document.getElementById('txt').innerHTML = h+":"+m+":"+s;
//     var t = setTimeout(function(){startTime()},500);
// }

// function checkTime(i) {
//     if (i<10) {i = "0" + i};  // add zero in front of numbers < 10
//     return i;
// }
// </script>
$(document).ready(function(){
	getEachMinute();
	$(document).on("click", ".snooze", setSnoozeTime)
});

function getSuggestedTask() {
  $.get("/").done(parseTask);
}

function parseTask(task) {
	if (task !== null) {
		onScreenNotify(task);
		if (!document.hasFocus()) {
			hudNotify(task);
		}
	}
}

function onScreenNotify(task) {
  $.get("/tasks/" + task.id + "/start").done(appendAlert);

}

function hudNotify(task) {
  if (!Notification) {
  	browserUnsupported();
  }

  if (Notification.permission !== "granted") {
    Notification.requestPermission();
  }

  var notification = new Notification("You've got spare time!", {
    icon: 'https://raw.githubusercontent.com/chi-rock-doves-2015/Timetris/master/app/assets/images/notification-logo.png',
    body: "Would you like to start '" + task.name + "'?",
  });

  notification.onclick = function () {
    window.focus()
  }
}

function browserUnsupported() {
	alert('Your browser is not supported.  Timetris supports the latest versions of Chrome, Firefox, Safari, and Opera.');
    return;
}

function appendAlert(htmlAlert) {
	$('.notification').html(htmlAlert).toggle().slideDown();
}

function setSnoozeTime(e) {
	var snoozeMinutes = $(this).attr('minutes');
	var snoozeDateTime = new Date(new Date().getTime() + (snoozeMinutes * 60000));
	
	$('.notification').slideUp();

	$.ajax({
    contentType: "application/json; charset=utf-8",
		url: "/users/snooze",
		method: "patch",
		data: JSON.stringify({"user": {"snooze_until": snoozeDateTime}})
	})
}

function getEachMinute() {
  window.setTimeout(getEachMinute, 60000);
  $.get("/users/alerts").done(function(r) {
  	if (r.alerts === true) {
  		getSuggestedTask();
  	}
  })
 }
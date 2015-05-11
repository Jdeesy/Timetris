$(document).ready(function(){
	getEachMinute();
});

function getSuggestedEvent() {
  $.ajax({
    type: "GET",
    url: "/"
  }).done(parseEvent);
}

function parseEvent(suggestedEvent) {
	onScreenNotify(suggestedEvent);
	if (suggestedEvent !== null && !document.hasFocus()) {
		hudNotify(suggestedEvent);
	}
}

function onScreenNotify(event) {
	$('.notification').html(
		"<div class='alert alert-warning' role='alert'><strong>You've got spare time! </strong>" + 
		"Would you like to start <em>" + event.name + "</em>? (" + event.time_box + " minutes)" +
		
		"<div class='btn-group pull-right' role='group' aria-label='...'>" +
  	"<button type='button' class='btn btn-default'>Start Task!</button>" +
		"<div class='btn-group' role='group'>" + 
		"<button class='btn btn-default dropdown-toggle' type='button' id='dropdownMenu1' data-toggle='dropdown' aria-expanded='true'>Snooze" +
    "<span class='caret'></span></button><ul class='dropdown-menu' role='menu' aria-labelledby='dropdownMenu1'>" +
    "<li role='presentation'><a role='menuitem' tabindex='-1' href='#'>30 minutes</a></li>" +
    "<li role='presentation'><a role='menuitem' tabindex='-1' href='#'>1 hour</a></li>" +
    "<li role='presentation'><a role='menuitem' tabindex='-1' href='#'>3 hours</a></li>" +
    "<li role='presentation'><a role='menuitem' tabindex='-1' href='#'>6 hours</a></li>" +
    "<li role='presentation'><a role='menuitem' tabindex='-1' href='#'>12 hours</a></li>" +
  	"</ul></div></div></div>"
		);
}

function hudNotify(event) {
  if (!Notification) {
  	browserUnsupported();
  }

  if (Notification.permission !== "granted") {
    Notification.requestPermission();
  }

  var notification = new Notification("You've got spare time!", {
    icon: 'http://i.imgur.com/GPPFEUP.jpg',
    body: "Would you like to start '" + event.name + "'?",
  });

  notification.onclick = function () {
    window.focus()
  }
}

function browserUnsupported() {
	alert('Your browser is not supported.  Timetris supports the latest versions of Chrome, Firefox, Safari, and Opera.');
    return;
}

function getEachMinute() {
     var d = new Date(),
         h = new Date(d.getFullYear(), d.getMonth(), d.getDate(), d.getHours(), (d.getMinutes() - (d.getMinutes() % 1)) + 1, 0, 0),
         e = h - d;
     window.setTimeout(getEachMinute, e);

     getSuggestedEvent();
 }
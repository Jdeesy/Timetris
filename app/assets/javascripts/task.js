$(document).ready(function(){

  $(document).on("click", ".task-edit", function(e) {
    e.preventDefault();
    var taskForm = $(this).parent().parent();
    var taskID = taskForm.parent().attr('id');

    $.ajax({
      type: "GET",
      url: "tasks/" + taskID + "/edit"
    }).done(function(r) {
      taskForm.replaceWith(r);
    });
  });

  $(document).on("submit", ".task .task-form form", function(e) {
    e.preventDefault();
    var taskForm = $(this).parent()
    var taskID = taskForm.parent().attr('id');
    var formData = $(this).serialize();

    $.ajax({
      type: "POST",
      url: "tasks/" + taskID,
      data: formData
    }).done(function(r) {
      taskForm.replaceWith(r);
    });
  });

  $(document).on("click", ".timebox-subtract", function(e) {
    e.preventDefault();
    var task = $(this).parent();
    var taskID = task.attr('id');

    $.ajax({
      type: "POST",
      url: "tasks/" + taskID + '/tb_sub'
    }).done(function(r) {
      task.find('.time-box').text(r.time_box);
    });
  });

  $(document).on("click", ".timebox-add", function(e) {
    e.preventDefault();
    var task = $(this).parent();
    var taskID = task.attr('id');

    $.ajax({
      type: "POST",
      url: "tasks/" + taskID + '/tb_add'
    }).done(function(r) {
      task.find('.time-box').text(r.time_box);
    });
  });

  $(document).on("click", ".priority-subtract", function(e) {
    e.preventDefault();
    var task = $(this).parent();
    var taskID = task.attr('id');

    $.ajax({
      type: "POST",
      url: "tasks/" + taskID + '/pr_sub'
    }).done(function(r) {
      task.find('.priority').text(r.priority);
    });
  });

  $(document).on("click", ".priority-add", function(e) {
    e.preventDefault();
    var task = $(this).parent();
    var taskID = task.attr('id');

    $.ajax({
      type: "POST",
      url: "tasks/" + taskID + '/pr_add'
    }).done(function(r) {
      task.find('.priority').text(r.priority);
    });
  });

});
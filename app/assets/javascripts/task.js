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
    console.log("Timebox-Subtraction!")

  });

  $(document).on("click", ".timebox-add", function(e) {
    e.preventDefault();
    console.log("Timebox-Addition!")

  });

  $(document).on("click", ".priority-subtract", function(e) {
    e.preventDefault();
    console.log("Priority-Subtraction!")

  });

  $(document).on("click", ".priority-add", function(e) {
    e.preventDefault();
    console.log("Priority-Addition!")

  });

});
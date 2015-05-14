$(document).ready(function(){

  $(document).on("click", ".task .task-edit", function(e) {
    e.preventDefault();
    var nameHeader = $(this).parent().parent();
    var taskID = nameHeader.parent().parent().attr('id');

    $.ajax({
      type: "GET",
      url: "tasks/" + taskID + "/edit"
    }).done(function(r) {
      nameHeader.html(r);
    });
  });

  $(document).on("submit", ".task .name form", function(e) {
    e.preventDefault();
    var taskForm = $(this).parent();
    var taskID = taskForm.parent().parent().parent().attr('id');
    var formData = $(this).serialize();

    console.log(formData);

    $.ajax({
      type: "POST",
      url: "tasks/" + taskID,
      data: formData
    }).done(function(r) {
      taskForm.replaceWith(r);
    });
  });

  // $(".task .form_date .due_date").change(function(e) {
  //   $(this).parent().submit();
  // });

  $(".edit_task input[type='date']").change(function(e) {
    $(this).parent().submit();
  });

  $(document).on("click", ".task .timebox-subtract", function(e) {
    e.preventDefault();
    var task = $(this).parent().parent().parent().parent().parent();
    var taskID = task.attr('id');

    $.ajax({
      type: "POST",
      url: "tasks/" + taskID + '/tb_sub'
    }).done(function(r) {
      task.find('.timebox-tag').html(r);
    });
  });

  $(document).on("click", ".task .timebox-add", function(e) {
    e.preventDefault();
    var task = $(this).parent().parent().parent().parent().parent();
    var taskID = task.attr('id');

    $.ajax({
      type: "POST",
      url: "tasks/" + taskID + '/tb_add'
    }).done(function(r) {
      task.find('.timebox-tag').html(r);
    });
  });

  $(document).on("click", ".task .priority-subtract", function(e) {
    e.preventDefault();
    var task = $(this).parent().parent().parent().parent().parent();
    var taskID = task.attr('id');

    $.ajax({
      type: "POST",
      url: "tasks/" + taskID + '/pr_sub'
    }).done(function(r) {
      task.find('.priority-tag').html(r);
    });
  });

  $(document).on("click", ".task .priority-add", function(e) {
    e.preventDefault();
    var task = $(this).parent().parent().parent().parent().parent();
    var taskID = task.attr('id');

    $.ajax({
      type: "POST",
      url: "tasks/" + taskID + '/pr_add'
    }).done(function(r) {
      task.find('.priority-tag').html(r);
    });
  });

  $(document).on("submit", ".edit_task", function(e){
    e.preventDefault();
    var form = $(this);
    var url = form.attr('action');
    var data = $(this).serialize();
    $.ajax({
      type: "POST",
      url: url,
      data: data
    })

    .success(function(r) {
      var save = $("<div class='alert alert-success' role='alert'>Changes saved!</div>");
        $('.jumbotron').append(save);
        save.fadeOut(3000);
    });
  });

});
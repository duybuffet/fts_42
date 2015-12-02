var question_type;
var num_question;
ready_var = function() {
  question_type = $(".question_type").val();
  num_question = $(".single_answer").length;
  if (question_type == "text") {
    hide_checkbox_delete_btn();
    disable_btn_add(true);
  }
}

$(document).ready(ready_var);
$(document).on("page:load", ready_var);

$(function(){
  $(document).on("change", ".question_type", function(){
    question_type = $(".question_type").val();
    if (question_type == "single") {
      $("input.checkbox_answer").each(function(){
          $(this).prop("checked", false);
      });
      show_checkbox_delete_btn();
      disable_btn_add(false);
    } else if (question_type == "text") {
      disable_btn_add(true);
      if (num_question == 0) {
        add_answer($(".add_child")[0]);
      } else {
        $(".single_answer:not(:first)").each(function(){
          $(this).find(".hidden_destroy_field").val(1);
          $(this).find(".question_content").val("");
          $(this).find(".checkbox_answer").prop("checked", false);
          $(this).hide();
          $(this).removeClass("single_answer");
          num_question--;
        });
      }
      hide_checkbox_delete_btn();
    } else if (question_type == "multiple") {
      show_checkbox_delete_btn();
      disable_btn_add(false);
    }
  });

  $(document).on("click", ".checkbox_answer", function(){
    question_type = $(".question_type").val();
    checkbox = this;
    if (question_type == "single"){
      if (checkbox.checked){
        $("input.checkbox_answer").each(function(){
          if (checkbox != this) {
            $(this).prop("checked", false);
          }
        });
      }
    }
  });

  $(document).on("click", "#btn_question", function(){
    var flag = false;
    question_type = $(".question_type").val();
    if (question_type != "text") {
      $("input[type=checkbox]").each(function(){
        if(this.checked) {
          flag = true;
          if($(this).parent().find(".question_content").val().trim() == ""){
            flag = false;
          }
          if($(this).next().next().val() == "1"){
            flag = false;
          }
        }
      });
    } else {
      $(".single_answer:first").each(function(){
        if ($(this).find(".question_content").val().trim() != "") {
          flag = true;
        }
      });
    }

    if (!flag) {
      alert($("span.alert_true_answer").text());
    }
    return flag;
  });

  $(document).on("click", ".remove_fields", function(){
    $(this).prev().val(1);
    $(this).prev().prev().prev().prop("checked", false);
    $(this).parent().parent().parent().hide(100);
    $(this).parent().parent().parent().removeClass("single_answer");
    num_question--;
  });

  $(document).on("click", ".add_child", function() {
    add_answer($(this));
    return false;
  });
  $(document).on("click", "#save_exam", function() {
    $(".status_exam").attr("value", "testing");
    return true;
  });
});


function disable_btn_add(status) {
  $(".add_child").prop("disabled", status);
  if (status) {
    $(".add_child").hide();
  } else {
    $(".add_child").show();
  }
}

function hide_checkbox_delete_btn() {
  $(".single_answer:first").each(function(){
    $(this).find(".hidden_destroy_field").val("");
    $(this).find(".checkbox_answer").hide();
    $(this).find(".correct_answer").hide();
    $(this).find(".remove_fields").hide();
  });
}

function show_checkbox_delete_btn() {
  $(".single_answer:first").each(function(){
    $(this).find(".checkbox_answer").show();
    $(this).find(".correct_answer").show();
    $(this).find(".remove_fields").show();
  });
}

function add_answer(obj) {
  var association = $(obj).attr("data-association");
  var regexp = new RegExp("new_" + association, "g");
  var new_id = new Date().getTime();
  $($(obj).attr("target")).append(window[association+"_form"]
    .replace(regexp, new_id));
  num_question++;
}

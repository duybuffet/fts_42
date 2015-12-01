var question_type;
ready_var = function() {
  question_type = $(".question_type").val();
  if (question_type == "text") {
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
      disable_btn_add(false);
    } else if (question_type == "text") {
      disable_btn_add(true);
      $(".single_answer:not(:first)").each(function(){
        $(this).find(".hidden_destroy_field").val(1);
        $(this).find(".question_content").val("");
        $(this).find(".checkbox_answer").prop("checked", false);
        $(this).hide();
      });
    } else if (question_type == "multiple") {
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

    if (!flag) {
      alert($("span.alert_true_answer").text());
    }
    return flag;
  });

  $(document).on("click", ".remove_fields", function(){
    $(this).prev().val(1);
    $(this).prev().prev().prev().prop("checked", false);
    $(this).parent().parent().hide(100);
  });

  $(document).on("click", ".add_child", function() {
    var association = $(this).attr("data-association");
    var regexp = new RegExp("new_" + association, "g");
    var new_id = new Date().getTime();
    $($(this).attr("target")).append(window[association+"_form"]
      .replace(regexp, new_id));
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

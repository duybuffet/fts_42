module ApplicationHelper
  def full_title page_title = ""
    base_title = t "base_title"
    if page_title.empty?
      base_title
    else
      "#{page_title} | #{base_title}"
    end
  end

  def new_fields_template f, association
    new_object = f.object.class.reflect_on_association(association).klass.new
    tmpl = f.fields_for(association, new_object,
      child_index: "new_#{association}") do |b|
      render(partial: association.to_s.singularize + "_form", locals: {f: b})
    end
    tmpl = tmpl.gsub /(?<!\n)\n(?!\n)/, " "
    return "<script> var #{association.to_s}_form = '#{tmpl.to_s}' </script>"
      .html_safe
  end

  def add_child_button name, association, target
    content_tag(:spam, "<span class='btn btn-success'>#{name}</span>".html_safe,
      class: "add_child", "data-association"=> association, target: target)
  end

  def add_label_for_type type
    case type
    when Settings.question.type.single
      content_tag :span, t("admin.question.type.single"), class: "label label-info"
    when Settings.question.type.multiple
      content_tag :span, t("admin.question.type.multiple"), class: "label label-warning"
    when Settings.question.type.text
      content_tag :span, t("admin.question.type.text"), class: "label label-primary"
    end
  end

  def add_label_for_status status
    case status
    when Settings.question.status.waiting
      content_tag :span, t("admin.question.type.waiting"), class: "label label-default"
    when Settings.question.status.approved
      content_tag :span, t("admin.question.type.approved"), class: "label label-success"
    end
  end
end

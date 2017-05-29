module LabelsHelper

  def format_label(text, type)
    content_tag(:span, text, class: "label label-#{type}")
  end

end

module IconsHelper

  def fa_icon(name, options)
    content_tag(:i, nil, class: "fa #{name} #{options}")
  end

end

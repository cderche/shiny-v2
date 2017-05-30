module IconsHelper

  def fa_icon(name, options)
    content_tag(:i, nil, class: "fa #{name} #{options}")
  end

  def icon_link(path, iKlass, options = {})
    link_to(icon(iKlass), path, options)
  end

  def icon(klass)
    content_tag(:i, nil, class: klass)
  end

end

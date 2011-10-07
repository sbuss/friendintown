module ApplicationHelper

  # Return a title on a per-page basis.
  def title
    base_title = "Tourious"
    if @title.nil?
      base_title
    else
      "#{base_title} | #{@title}"
    end
  end

  def logo
    logo = image_tag("logo.png", :alt => "Sample App", :class => "round")
    link_to(logo, root_path)
  end
end

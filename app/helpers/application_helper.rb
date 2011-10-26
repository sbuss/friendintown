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

  # Inspired by http://adambird.com/add-filters-to-views-using-named-scopes-in-ra
  def list_select_filter(name, filters, selected_scope)
    select_tag(name, 
      options_for_select(filters.collect { |filter|
        [filter[:label], filter[:scope]]
      },
      :selected => selected_scope[name]),
      :class => "filter_select",
      :onchange => "this.form.submit()" )
  end

  def search_form(name, params)
    search_field_tag(name, params[name])
  end
end

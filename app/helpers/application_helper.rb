module ApplicationHelper

  # Returns the full title on a per-page basis
  def full_title(page_title)
    base_title = "Brighter"
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end

  def link_to_add_fields(name, f, association, locals={})
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render(association.to_s.singularize + "_fields", f: builder)
    end

    link_to_function(name, "add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")", class: locals[:class])
  end

  def link_to_remove_fields(name, f, locals={})
    f.hidden_field(:_destroy) + link_to_function(name, "remove_fields(this)", class: locals[:class])
  end

end

module ApplicationHelper
  
  def contribution_image_type(action)
    case action
    when "Create"
      image_tag "addition.png"
    when "Update"
      image_tag "check.png"
    when "Added"
      image_tag "addition.png"
    end
  end
  
  def contribution_word_type(action)
    case action
    when "Create"
      "added to"
    when "Update"
      "edited in"
    when "Added"
      "added to"
    end
  end
end

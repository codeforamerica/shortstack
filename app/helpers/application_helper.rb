require 'builder'

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

  def alphabet_header(items, item)
    item.name[0..0].upcase unless item.name[0..0].downcase == items[items.index(item)-1].name[0..0].downcase
  end

  def tag_links(tags)
    tag_links = []
    tags.each do |tag|
      tag_links << "<a href='/tags/#{tag.tag.id}/#{tag.tag.name}'>#{tag.tag.name}</a>"
    end
    "Tags: " + tag_links.to_sentence
  end

  def picture_for(user, size = 150, opts = {})
    src = user.picture :size => size

    return image_tag src, opts
  end

  def sort_list(collection, param, default)
    list = collection.collect do |elem|
      content_tag(:li, sort_link(param, elem[:id], elem[:name].capitalize, (elem[:name] == default)))
    end
    content_tag :ul, list.join, {:id => 'submenu'}, false
  end

  def sort_link(param, value, text, default = false)
    if params[param] == value || (params[param].nil? && default)
      text
    else
      link_to text, "?#{param}=#{value}"
    end
  end
end

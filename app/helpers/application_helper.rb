require 'builder'
require 'google_chart'

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

  def tag_cloud(tags, classes)
    tags = tags.all if tags.respond_to?(:all)

    return [] if tags.empty?

    if is_tag = (tags.first.class == Tag)
      max_count = tags.sort_by { |t| t.taggings.count }.last.taggings.count.to_f
    else
      max_count = tags.sort_by(&:count).last.count.to_f
    end

    tags.each do |tag|
      if is_tag
        count = tag.taggings.count
      else
        count = tag.count
      end
      index = ((count / max_count) * (classes.size - 1)).round
      yield tag, classes[index]
    end
  end

  def highlight_search_hit(hit)
    hit.highlights.map do |hl|
      hl.format do |word|
        "<strong>#{word}</strong>"
      end
    end.join(' &hellip; ').html_safe
  end

  def format_result_name(result)
    case result.class.to_s
    when 'Organization'
      result.org_type.name
    else
      result.class.to_s
    end
  end

  def make_bar_chart(label, name, cur, avg)
    chart = GoogleChart::BarChart.new('150x200', label, :vertical, false) do |chart|
      max = [avg, cur].max

      chart.data name, [(cur.to_f / max)], 'C9D7D8'
      chart.data 'Average', [(avg.to_f / max)], '409DD6'
      chart.axis :y, :range => [0, max]
    end

    image_tag chart.to_url + '&chdlp=b', :alt => 'Comparison', :class => 'twitter_chart'
  end

  def twitter_chart(type, stat)
    case type
    when :followers
      cur = stat.followers_count
      avg = TwitterSummary.average_followers
      label = 'Followers'
    when :following
      cur = stat.following_count
      avg = TwitterSummary.average_following
      label = 'Following'
    when :statuses
      cur = stat.statuses_count
      avg = TwitterSummary.average_statuses
      label = 'Posts'
    end

    make_bar_chart label, stat.twitter_stat.screen_name, cur, avg
  end
end

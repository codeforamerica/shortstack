module TwitterHelper
  def twitter_link(screen_name)
    link_to '@' + screen_name, 'http://twitter.com/' + screen_name
  end

  def sortable(column, title)
    direction = column == sort_column && sort_direction == 'asc' ? 'desc' : 'asc'
    title += " (#{direction == 'desc' ? '&#8593;' : '&#8595;'})" if column == sort_column

    link_to title.html_safe, {:sort => column, :direction => direction}
  end
end

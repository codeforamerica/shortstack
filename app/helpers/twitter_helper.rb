module TwitterHelper
  def twitter_link(screen_name)
    link_to '@' + screen_name, 'http://twitter.com/' + screen_name
  end

  def sortable(column, title)
    direction = column == sort_column && sort_direction == 'asc' ? 'desc' : 'asc'
    link_to title, {:sort => column, :direction => direction}
  end
end

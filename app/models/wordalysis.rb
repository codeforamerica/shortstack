class Wordalysis

  def initialize(org, type, days = 1, start_date = nil)
    if type == "All"
      @text = pull_words(org, "Twitter", days, start_date)
      @text << pull_words(org, "Facebook", days, start_date)
    else
      @text = pull_words(org, type, days, start_date)
    end
  end

  # This should probably live in Organization; queries are
  # structured around start and end dates. Entering nil in
  # the length field will return results from start date
  # to present.
  def pull_words(org, type, length = 1, start_date = nil)
    if start_date.nil?
      end_date = Time.now
      start_date = Time.now - length.days
    else
      if length.nil?
        end_date = Time.now
      else
        end_date = start_date + length.days
      end
    end

    linktype = LinkType.find_by_name('type').id
    authors = Link.where(:link_type_id => linktype)
    temp_text = ""

    authors.each do |author|
      case type
      when "Twitter"
        if length = 1
          tweet_texts = #query limited to 200; returns data["text"] array
  #something like: Tweet.find({"date" : {$lt: end_date, $gt: start_date}, {"text": 1} })
        else
          tweet_texts = #query
        end
      #when "Facebook" , facebook-related queries
      temp_text << " " << tweet_texts.shift until tweet_texts.empty?
    end
    return temp_text
  end

  def get_top_n(n)
    freq_hash = get_freqs
    freq_a = freq_hash.to_a.sort_by! {|x,y| -y}
    return freq_a[0..n]
  end

  def get_top_n(n)
  end


end

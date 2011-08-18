class Wordalysis

  def initialize(time)
    orgs = Organization.all
    orgs.each do |org|
      twit_init(org, time)
      face_init(org, time)
    end
    make_global
  end


  def twit_init(org, time)
    words = ""
    twitters = org.links.where(:link_type_id => 6)
    twitters.each do |id|
      Tweet.all(:created_at => { '$gt' => time - 1.day, '$lt' => time}, :link_id => id.id).each do |tweet|
        words << " " << tweet.data["text"]
      end
    end
    day = WordDay.new(words, "Twitter", org.id).save unless (words == "")
  end

  def face_init(org, time)
    linktype = LinkType.find_by_name("Facebook").id
    links = org.links.where(:link_type_id => linktype) 
    words = ""
    links.each do |id|
      FacebookPost.all(:published => { '$gt' => time - 1.day, '$lt' => time}, :link_id => id.id).each do |post|
        words << " " << post.summary
      end
    end
    day = WordDay.new(words, "Facebook", org.id).save unless (words == "")
  end

  def make_global
    twitter_stats = WordDay.new("", "Twitter", nil)
    WordDay.all(:time_date => { '$gt' => Time.now - 7.days, '$lt' => Time.now}, :type => "Twitter").each do |tweet|
      twitter_stats.add_hash(twitter_stats.word_hash, tweet.word_hash)
      twitter_stats.add_hash(twitter_stats.bigram_hash, tweet.bigram_hash)
    end
    twitter_stats.save
    facebook_stats = WordDay.new("", "Facebook", nil)
    WordDay.all(:time_date => { '$gt' => Time.now - 7.days, '$lt' => Time.now}, :type => "Facebook").each do |post|
      facebook_stats.add_hash(facebook_stats.word_hash, post.word_hash)
      facebook_stats.add_hash(facebook_stats.bigram_hash, post.bigram_hash)
    end
    facebook_stats.save
  end

end

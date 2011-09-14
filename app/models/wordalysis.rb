class Wordalysis

#  def initialize(time)
#    orgs = Organization.all
#    orgs.each do |org|
#      twit_init(org, time)
#      face_init(org, time)
#    end
#  end


  def twit_init(org, time)
    day = WordDay.new(:type => "Twitter", :org_id => org.id)
    words = ""
    twitters = org.links.where(:link_type_id => 6)
    twitters.each do |id|
      Tweet.all(:created_at => { '$gt' => time - 1.day, '$lt' => time}, :link_id => id.id).each do |tweet|
        words << " " << tweet.data["text"]
      end
    end
    day.initialize(words)
  end

  def face_init(org, time)
    linktype = LinkType.find_by_name('Facebook').id
    links = org.links.where(:link_type_id => linktype)
    day = WordDay.new(:type => "Facebook", :org_id => org.id)
    words = ""
    FacebookPost.all(:created_at => { '$gt' => time - 1.day, '$lt' => time}, :org_id => org.id).each do |tweet|
      words << " " << tweet.data["text"]
    end
    day.initialize(words)
  end




end

desc "This task is called by the Heroku cron add-on"
task :cron => :environment do
#   
#   if Time.now.hour == 0 # run at midnight
#     linktype = LinkType.find_by_name('Facebook').id
#     links = Link.where(:link_type_id => linktype)   
#     links.each do |link|
#       link.facebook_stats.new.delay.save_facebook_data
#       link.delay.update_wall
#     end 
#   end
#   
#    if Time.now.hour == 0 # run at midnight
#      linktype = LinkType.find_by_name('Twitter').id
#      links = Link.where(:link_type_id => linktype)
#      c = links.size/150 
# # # we throttled to 350 requests an hour, so we'll need to schedule
#     c.times do |num|
#        links[0..150].each do |link|
#          link.delay(:run_at => Time.now + num.hours).grab_tweets(1)
#         link.delay(:run_at => Time.now + num.hours).twitalyze!
#         link.delay(:run_at => Time.now + num.hours).update_tweets
#       end
#       links = links.drop(175)
#     end
#   end
#   
#   if Time.now.hour == 0 # run at midnight
#     linktype = LinkType.find_by_name('Website').id
#     links = Link.where(:link_type_id => linktype)
#     g = []
#       links.each do |link|
#         link.statistics.where('"statistics".created_at > ?', 30.days.ago).blank? ? g << link : nil
#       end
# # we throttled to 1000 requests a day, so we'll need to schedule 900 per day
#       links[0..900].each do |link|
#         CompeteStat.new(link).delay.create_statistic
#       end
#   end
  
end

desc "This task is called by the Heroku cron add-on"
task :cron => :environment do
  if Time.now.hour == 0 # run at midnight
    linktype = LinkType.find_by_name('Twitter').id
    links = Link.where(:link_type_id => linktype)
    c = links.size/350
# we throttled to 350 requests an hour, so we'll need to schedule
    c.times do |num|
      links[0..350].each do |link|
        link.delay(:run_at => Time.now + num.hours).twitalyze!
      end
      links = links.drop(350)
    end
  end
end
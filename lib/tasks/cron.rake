desc "This task is called by the Heroku cron add-on"
task :cron => :environment do
  if Time.now.hour == 0 # run at midnight
    linktype = LinkType.find_by_name('Twitter').id
    Link.where(:link_type_id => linktype).each do |link|
      link.delay.twitalyze!
    end
  end
end
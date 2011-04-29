namespace :twitalysis do
  desc 'analyze twitter stuff'
  task :twitalyze => :environment do
    puts 'twitalyzing'
    Link.where(:link_type_id => Link.twitter_link_type).all.each do |l|
      puts "Twitalyzing link (#{l.id})"
      l.twitalyze!
    end
  end

  desc 'do twitter census'
  task :do_census => :environment do
    puts 'running census'
    Link.where(:link_type_id => Link.twitter_link_type).all.each do |l|
      puts "Running census on link (#{l.id})"
      l.do_census!
    end
  end
end

namespace :facebook do
  desc 'Delete all facebook_links based on category'
  task :delete_category, [:category] => :environment do |t, args|
    puts 'deleting by category'
    FacebookSummary.where(:category => args.category).all.each { |fs|
      fs.link.delete
    }
  end
end

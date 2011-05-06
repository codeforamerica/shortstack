namespace :facebook do
  desc 'Delete all facebook_links based on category'
  task :delete_category, [:category] => :environment do |t, args|
    puts 'deleting by category'
    FacebookSummary.where(:category => args.category).all.each(&:completely_delete)
  end

  desc 'Delete all non-governmental facebook_links based on category'
  task :delete_non_gov => :environment do |t|
    puts 'deleting non-governmental facebook_links'
    FacebookSummary.non_gov.all.each(&:completely_delete)
  end
end

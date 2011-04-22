# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :twitter_summary do
      organization_id 1
      link_id 1
      twitter_stat_id 1
      followers_count 1
      following_count 1
      listed_count 1
      statuses_count 1
      week_growth 1.5
      month_growth 1.5
      year_growth 1.5
    end
end

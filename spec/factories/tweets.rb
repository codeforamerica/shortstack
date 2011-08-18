Factory.define :tweets do |t|
  #t.data {"text" => Faker::Lorem.paragraph}
  t.created_at Time.now
  t.link_id 1
end

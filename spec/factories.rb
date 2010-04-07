Factory.define :random_event, :class => Event do |f|
  f.name "my new event"
  f.date_and_time 1.day.from_now.to_s
  f.allow_check false
  f.allow_cash false
  f.permalink "my-new-event"
  f.registration true
  f.registration_limit 1000
end

Factory.define :random_public_group, :class => PersonGroup do |f|
  f.sequence(:title) { |n| "uniquely titled public group#{n}"}
  f.public false
end

Factory.define :random_price_option, :class => PriceOption do |f|
  f.sequence(:title) {|n| "member#{n}"}
  f.sequence(:price) {|n| "1#{n}"}
  f.sequence(:description) {|n| "for member#{n}s only"}
  f.public true
end

Factory.define :price_option do |f|
  f.title "member"
  f.price "5"
  f.description "members only"
  f.public true
end

Factory.define :random_public_group, :class => PersonGroup do |f|
  f.sequence(:title) { |n| "uniquely titled public group#{n}"}
  f.public false
end
Factory.define :random_event_registration_group, :class => EventRegistrationGroup do |f|
  f.sequence(:title) { |n|"Guest list 1"}
  f.public false
  f.event_id 1
  f.owner_id 1
  f.owner_attending true
end
Factory.define :event_registration do |f|
  f.person_id
  f.public false
  f.event_id
end
Factory.define :random_person, :class => Person do |f|
  f.sequence(:first_name) {|n| "first#{n}"}
  f.sequence(:last_name) {|n| "last#{n}"}
  f.sequence(:email){|n| "#{n}email@email.com"} 
end

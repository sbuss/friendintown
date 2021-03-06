Factory.sequence :username do |n|
  "Test user ##{n}"
end

Factory.sequence :tour_name do |n|
  "Test tour #{n}"
end

Factory.sequence :email do |n|
  "person-#{n}@example.com"
end

Factory.define :tour do |tour|
  tour.name   { Factory.next(:tour_name) }
  tour.desc   "The test tour, used for testing"
  tour.association :user
end

Factory.define :stop do |stop|
  Factory.sequence :stop_num do |n|
    n
  end

  stop.stop_num    { Factory.next(:stop_num) }
  
  stop.association :tour
  stop.association :place
end

# Must be before the :place factory, since it uses it
Factory.sequence :latlng do |n|
  [n, n]
end

Factory.define :place do |place|
  place.name  "A test place"
  ll = Factory.next(:latlng)
  place.lat   ll[0]
  place.long  ll[1]
end

Factory.define :user do |user|
  user.name                   { Factory.next(:username) }
  user.email                  { Factory.next(:email) }
  user.password               "foobar"
  user.password_confirmation  "foobar"
end

Factory.define :tour do |tour|
  tour.name   "Test tour"
  tour.desc   "The test tour, used for testing"
end

Factory.define :stop do |stop|
  Factory.sequence(:stop_num) { |n| n }

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


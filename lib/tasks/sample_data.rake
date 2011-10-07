namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke
    admin = User.create!(:name => "Example User",
                 :email => "admin@tourioushq.com",
                 :password => "foobar",
                 :password_confirmation => "foobar")
    admin.toggle!(:admin)
    99.times do |n|
      name = Faker::Name.name
      email = "example-#{n+1}@tourioushq.com"
      password = "password"
      User.create!(:name => name,
                   :email => email,
                   :password => password,
                   :password_confirmation => password)
    end

    # Establish a valid area for places
    latmin = -122.336926
    latmax = -122.303495
    longmin = 47.602893
    longmax = 47.620455
    r = Random.new
    100.times do |n|
      name = Faker::Company.name
      lat = r.rand() * (latmax-latmin) + latmin
      long = r.rand() * (longmax-longmin) + longmin
      Place.create!(:name => name,
                   :lat  => lat,
                   :long => long)
    end

    # Build some routes!
    35.times do |n|
      name = "Tour ##{n}"
      desc = "Description for tour ##{n}"
      numStops = r.rand(2..10)
      u = User.find_by_id(n+1)
      t = u.tours.create!(:name => name, :desc => desc, 
                          :duration => r.rand(30..2000),
                          :cost => r.rand(10..1000))
      numStops.times do |m|
        Stop.create!(:tour => t, 
                     :place => Place.find_by_id(r.rand(1..100)),
                     :stop_num => m+1)
      end
    end
  end
end

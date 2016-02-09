# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

1000.times do
  SupportRequest.create(name: Faker::Name.name,
                        email: Faker::Internet.email,
                        department: ["sales","marketing","technical"].sample,
                        message: Faker::Lorem.paragraph,
                        completed: "not done")
end

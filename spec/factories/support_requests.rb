FactoryGirl.define do
  factory :support_request do
    name        {Faker::Name.name}
    email       {Faker::Internet.email}
    department  {["sales","marketing","technical"].sample}
    message     {Faker::Lorem.paragraph}
    completed   "not done"
  end
end

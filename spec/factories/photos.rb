FactoryBot.define do
  factory :photo do
    title { Faker::Lorem.characters(number: 5) }
    photo_introduction { Faker::Lorem.characters(number: 20) }
    cat_color { "cat_color" }
    customer
  end
end

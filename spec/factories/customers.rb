FactoryBot.define do
  factory :customer do
    first_name { Faker::Lorem.characters(number: 10) }
    last_name { Faker::Lorem.characters(number: 10) }
    first_name_kana { Faker::Lorem.characters(number: 10) }
    last_name_kana { Faker::Lorem.characters(number: 10) }
    phone_number { "phone_number" }
    email { Faker::Internet.email }
    introduction { Faker::Lorem.characters(number: 20) }
    password { 'password' }
    password_confirmation { 'password' }
    after(:build) do |customer|
      customer.profile_image.attach(io: File.open('spec/images/no_image1.jpg'), filename: 'no_image1.jpg', content_type: 'application/xlsx')
    end
  end
end

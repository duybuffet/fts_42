FactoryGirl.define do
  factory :user do
    name Faker::Name.name
    email Faker::Internet.email
    chatwork_id Faker::Name.name
    role 0
    password "12345678"
    password_confirmation "12345678"
    factory :admin do
      role 1
    end
  end
end

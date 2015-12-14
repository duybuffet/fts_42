FactoryGirl.define do
  factory :user do
    name Faker::Name.name
    email Faker::Internet.email
    chatwork_id Faker::Name.name
    role :member
    password "12345678"
    password_confirmation "12345678"
    factory :admin do
      email Faker::Internet.email
      role :admin
    end
    factory :member do
      email Faker::Internet.email
    end
  end
end

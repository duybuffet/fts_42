FactoryGirl.define do
  factory :question do
    content Faker::Lorem.sentence
    question_type 0
  end
end

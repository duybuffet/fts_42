FactoryGirl.define do
  factory :question do
    content Faker::Lorem.sentence
    question_type :single
    status :waiting
    subject {FactoryGirl.build :subject}
    user {FactoryGirl.build :user}
    factory :admin_question do
      user {FactoryGirl.build :admin}
    end
  end

  factory :single_question do
    content Faker::Lorem.sentence
    question_type :single
    status :waiting
    user {FactoryGirl.build :user}
  end
end

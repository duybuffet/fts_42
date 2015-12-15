FactoryGirl.define do
  factory :subject do
    name Faker::Name.name
    factory :subject_with_question do
      transient do
        questions_count 5
      end

      after :create do |subject, evaluator|
        create_list :question, evaluator.questions_count, subject: subject
      end
    end
  end
end

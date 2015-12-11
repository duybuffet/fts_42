require "rails_helper"

describe Question, type: :model do
  let!(:question){FactoryGirl.build :question}

  it {is_expected.to respond_to :content}
  it {is_expected.to respond_to :question_type}

  it "name can't be blank" do
    question.content = ""
    expect(question).to_not be_valid
  end

  it "question type can't be blank" do
    question.question_type = ""
    expect(question).to_not be_valid
  end
end

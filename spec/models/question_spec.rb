require "rails_helper"

describe Question do
  subject {FactoryGirl.build :question}

  it {is_expected.to be_valid}

  describe "#content" do
    before {subject.content = nil}
    it {is_expected.to have(1).error_on :content}
  end

  describe "#question_type" do
    before {subject.question_type = nil}
    it {is_expected.to have(1).error_on :question_type}
  end
end

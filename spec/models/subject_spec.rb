require "rails_helper"

describe Subject do
  subject {FactoryGirl.build :subject}

  it {is_expected.to be_valid}

  describe "#name" do
    before {subject.name = nil}
    it {expect(subject).to have(1).error_on :name}
  end
end

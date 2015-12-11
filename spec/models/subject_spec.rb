require "rails_helper"

describe Subject, type: :model do
  let!(:subject){FactoryGirl.build :subject}

  it {is_expected.to respond_to :name}

  it "name can't be blank" do
    subject.name = ""
    expect(subject).to_not be_valid
  end
end

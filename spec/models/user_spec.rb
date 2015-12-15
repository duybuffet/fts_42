require "rails_helper"
require "cancan/matchers"

describe User do
  subject {FactoryGirl.create :user}
  let(:user2) {FactoryGirl.build :user}

  it {is_expected.to be_valid}

  describe "invalid input" do
    context "#name blank" do
      before {subject.name = nil}
      it {is_expected.to have(1).error_on :name}
    end

    context "#name > 100" do
      before {subject.name = "a"*101}
      it {is_expected.to have(1).error_on :name}
    end

    context "#email blank" do
      before {subject.email = nil}
      it {is_expected.to have(1).error_on :email}
    end

    context "#email invalid" do
      before {subject.email = "example@example"}
      it {is_expected.to have(1).error_on :email}
    end

    context "#email duplicate" do
      before {user2.email = subject.email}
      it {expect{user2.save}.to change{User.count}.by 0}
    end

    context "#chatwork blank" do
      before {subject.chatwork_id = nil}
      it {is_expected.to have(1).error_on :chatwork_id}
    end

    context "#chatwork_id duplicate" do
      before {user2.chatwork_id = subject.chatwork_id}
      it {expect{user2.save}.to change{User.count}.by 0}
    end

    context "#password blank" do
      before {subject.password = nil}
      it {is_expected.to have(1).error_on :password}
    end

    context "#password < 8" do
      before {subject.password = "123123"}
      it {is_expected.to have(1).error_on :password}
    end

    context "#password_confirmation" do
      before {subject.password_confirmation = "123123123"}
      it {is_expected.to have(1).error_on :password_confirmation}
    end
  end
end

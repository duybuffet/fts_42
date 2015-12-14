require "rails_helper"
require "cancan/matchers"

describe User, type: :model do
  let!(:user){FactoryGirl.create :user}
  let!(:user2){FactoryGirl.build :user}

  it {is_expected.to respond_to :name}
  it {is_expected.to respond_to :chatwork_id}
  it {is_expected.to respond_to :email}
  it {is_expected.to respond_to :password}
  it {is_expected.to respond_to :password_confirmation}
  it {is_expected.to respond_to :role}

  context "invalid input" do
    it "name is blank" do
      user.name = ""
      expect(user).to_not be_valid
    end

    it "name has length > 100" do
      user.name = "a"*101
      expect(user).to_not be_valid
    end

    it "email is blank" do
      user.email = ""
      expect(user).to_not be_valid
    end

    it "email is not valid" do
      user.email = "example@example"
      expect(user).to_not be_valid
    end

    it "email is duplicate" do
      expect{
        user2.email = user.email
        user2.save
      }.to change{User.count}.by 0
    end

    it "chatwork id is blank" do
      user.chatwork_id = ""
      expect(user).to_not be_valid
    end

    it "chatwork id is duplicate" do
      expect{
        user2.chatwork_id = user.chatwork_id
        user2.save
      }.to change{User.count}.by 0
    end

    it "password is blank" do
      user.password = ""
      expect(user).to_not be_valid
    end

    it "password has length < 8" do
      user.password = "123123"
      user.password_confirmation = user.password
      expect(user).to_not be_valid
    end

    it "password confirmation is not match" do
      user.password_confirmation = "123123123"
      expect(user).to_not be_valid
    end
  end

  describe "admin abilities" do
    subject(:ability){Ability.new admin}

    context "when user is an admin" do
      let(:admin){FactoryGirl.create(:admin)}

      it{should be_able_to(:manage, Subject)}
      it{should be_able_to(:manage, Question)}
      it{should be_able_to(:manage, User)}
      it{should be_able_to(:manage, Exam)}
    end
  end

  describe "member abilities" do
    subject(:ability){Ability.new member}

    context "When user is a member" do
      let(:member){FactoryGirl.create(:member)}

      it{should_not be_able_to(:destroy, User.new)}
      it{should_not be_able_to(:destroy, Exam)}
      it{should_not be_able_to(:destroy, Subject)}
      it{should_not be_able_to(:create, Subject)}
      it{should_not be_able_to(:update, Subject)}

      it{should be_able_to(:create, Question)}
      it{should be_able_to(:update, Question, member.id)}
      it{should be_able_to(:destroy, Question, member.id)}
      it{should be_able_to(:index, Question, member.id)}
      it{should be_able_to(:read, Exam, member.id)}
      it{should be_able_to(:update, Exam, member.id)}
      it{should be_able_to(:show, Exam, member.id)}
    end
  end
end

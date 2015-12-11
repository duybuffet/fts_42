require "rails_helper"

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
end

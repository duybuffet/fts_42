describe Ability do
  describe "admin abilities" do
    let(:admin) {FactoryGirl.create :admin}
    subject(:ability) {Ability.new admin}

    it {is_expected.to be_able_to(:manage, Subject)}
    it {is_expected.to be_able_to(:manage, Question)}
    it {is_expected.to be_able_to(:manage, User)}
    it {is_expected.to be_able_to(:manage, Exam)}
  end

  describe "member abilities" do
    let(:member) {FactoryGirl.create :member}
    subject(:ability) {Ability.new member}

    it {is_expected.to_not be_able_to(:destroy, User.new)}
    it {is_expected.to_not be_able_to(:destroy, Exam)}
    it {is_expected.to_not be_able_to(:destroy, Subject)}
    it {is_expected.to_not be_able_to(:create, Subject)}
    it {is_expected.to_not be_able_to(:update, Subject)}

    it {is_expected.to be_able_to(:create, Question)}
    it {is_expected.to be_able_to(:update, Question, member.id)}
    it {is_expected.to be_able_to(:destroy, Question, member.id)}
    it {is_expected.to be_able_to(:index, Question, member.id)}
    it {is_expected.to be_able_to(:read, Exam, member.id)}
    it {is_expected.to be_able_to(:update, Exam, member.id)}
    it {is_expected.to be_able_to(:show, Exam, member.id)}
  end
end


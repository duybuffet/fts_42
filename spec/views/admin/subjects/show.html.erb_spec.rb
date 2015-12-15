require "spec_helper"
require "rspec/active_model/mocks"

describe "admin/subjects/show.html.erb" do
  subject {rendered}
  let!(:admin) {FactoryGirl.build :admin}
  let(:subject_with_question) {create :subject_with_question, questions_count: 80}

  before do
    sign_in admin
    assign :subject, subject_with_question
    render
  end

  it {is_expected.to have_selector "h3", text: "List Question"}
  it {is_expected.to have_selector "table"}
  it {is_expected.to include subject_with_question.name}
  it {is_expected.to include subject_with_question.questions.count.to_s}
end

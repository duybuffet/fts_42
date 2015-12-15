require "spec_helper"
require "rspec/active_model/mocks"

describe "admin/subjects/new.html.erb" do
  subject {rendered}
  let!(:admin) {FactoryGirl.build :admin}
  let(:subject) {mock_model(Subject).as_new_record.as_null_object}

  before do
    sign_in admin
    assign :subject, subject
    render
  end

  it {is_expected.to have_selector "form"}
  it {is_expected.to have_selector "label[for=subject_name]", text: "Name"}
  it {is_expected.to have_selector "input", id: "subject_name", class: "form-control"}
  it {is_expected.to have_selector "input[type=submit]", text: "Add New"}
end

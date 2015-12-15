require "rails_helper"

describe Admin::SubjectsController, type: :controller do
  let(:subject) {FactoryGirl.create(:subject)}
  let(:user) {FactoryGirl.create(:admin)}
  before {sign_in user}

  describe "GET #index" do
    before {get :index}

    it {expect(response.status).to eq 200}

    it {expect(response).to be_success}

    it {expect(response).to render_template :index}
  end

  describe "GET #show" do
    before {get :show, id: subject}

    it {expect(response).to render_template :show}
  end

  describe "GET #new" do
    before {get :new}

    it {expect(response.status).to eq 200}

    it {expect(assigns(:subject)).to be_a_new(Subject)}

    it {expect(response).to render_template :new}
  end

  describe "POST #create" do
    context "with valid attributes" do
      before {post :create, subject: FactoryGirl.attributes_for(:subject)}

      it {expect(response).to redirect_to admin_subjects_path}

      it {expect(flash[:success]).to be_present}
    end

    context "with invalid attributes" do
      before {post :create, subject: FactoryGirl.attributes_for(:subject, name: nil)}

      it {expect(response).to render_template :new}

      it {expect(flash[:danger]).to be_present}
    end
  end

  describe "PATCH #update" do
    context "with valid attributes" do
      before {patch :update, id: subject, subject: attributes_for(:subject)}

      it {expect(response).to redirect_to admin_subjects_path}

      it {expect(flash[:success]).to be_present}
    end

    context "with invalid attributes" do
      before {patch :update, id: subject, subject: attributes_for(:subject, name: nil)}

      it {expect(response).to render_template :edit}

      it {expect(flash[:danger]).to be_present}
    end
  end

  describe "DELETE #destroy" do
    before {delete :destroy, id: subject}

    it {expect(response).to redirect_to admin_subjects_path}

    it {expect(flash[:success]).to be_present}
  end
end

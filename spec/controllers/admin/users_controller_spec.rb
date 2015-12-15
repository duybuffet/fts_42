require "rails_helper"

describe Admin::UsersController, type: :controller do
  let!(:user) {FactoryGirl.create(:user)}
  let!(:admin) {FactoryGirl.create(:admin)}
  before {sign_in admin}

  describe "GET #index" do
    before {get :index}

    it {expect(response.status).to eq 200}

    it {expect(response).to be_success}

    it {expect(response).to render_template :index}
  end

  describe "PATCH #update" do
    context "with valid attributes" do
      before {patch :update, id: user, user: attributes_for(:user, role: :admin)}

      it {expect(response).to redirect_to admin_users_path}

      it {expect(flash[:success]).to be_present}
    end
  end

  describe "DELETE #destroy" do
    before {delete :destroy, id: user}

    it {expect(response).to redirect_to admin_users_path}

    it {expect(flash[:success]).to be_present}
  end
end

require "rails_helper"

describe Admin::UsersController, type: :controller do
  let!(:user){FactoryGirl.create(:user)}
  let!(:admin){FactoryGirl.create(:admin)}
  before{
    sign_in admin
  }

  describe "GET #index" do
    it "returns status code 200" do
      expect(response.status).to eq 200
    end

    it "shows all users" do
      get :index
      expect(response).to be_success
    end

    it "renders index template" do
      get :index
      expect(response).to render_template :index
    end
  end

  describe "PATCH #update" do
    context "with valid attributes" do
      before{patch :update, id: user, user: attributes_for(:user, role: :admin)}
      it "redirects to the user index" do
        expect(response).to redirect_to admin_users_path
      end

      it "renders a success flash" do
        expect(flash[:success]).to be_present
      end
    end
  end

  describe "DELETE #destroy" do
    before{delete :destroy, id: user}

    it "redirects to the user index" do
      expect(response).to redirect_to admin_users_path
    end

    it "renders a success flash" do
      expect(flash[:success]).to be_present
    end
  end
end

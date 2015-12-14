require "rails_helper"

describe Admin::SubjectsController, type: :controller do
  let!(:subject){FactoryGirl.create(:subject)}
  let!(:user){FactoryGirl.create(:admin)}
  before{sign_in user}

  describe "GET #index" do
    it "returns status code 200" do
      expect(response.status).to eq 200
    end

    it "shows all contribute subjects of signed in user" do
      get :index
      expect(response).to be_success
    end

    it "renders index template" do
      get :index
      expect(response).to render_template :index
    end
  end

  describe "GET #show" do
    it "renders show template" do
      get :show, id: subject
      expect(response).to render_template :show
    end
  end

  describe "GET #new" do
    it "returns status code 200" do
      expect(response.status).to eq 200
    end

    it "assigns a new Subject to @subject" do
      get :new
      expect(assigns(:subject)).to be_a_new(Subject)
    end

    it "renders the :new template" do
      get :new
      expect(response).to render_template :new
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      before{post :create, subject: FactoryGirl.attributes_for(:subject)}

      it "redirects to the subject index" do
        expect(response).to redirect_to admin_subjects_path
      end

      it "render a success flash" do
        expect(flash[:success]).to be_present
      end
    end

    context "with invalid attributes" do
      before{post :create, subject: FactoryGirl.attributes_for(:subject, name: nil)}

      it "re-renders the :new template" do
        expect(response).to render_template :new
      end

      it "renders a danger flash" do
        expect(flash[:danger]).to be_present
      end
    end
  end

  describe "PATCH #update" do
    context "with valid attributes" do
      before{patch :update, id: subject, subject: attributes_for(:subject)}
      it "redirects to the subject index" do
        expect(response).to redirect_to admin_subjects_path
      end

      it "renders a success flash" do
        expect(flash[:success]).to be_present
      end
    end

    context "with invalid attributes" do
      before{patch :update, id: subject, subject: attributes_for(:subject, name: nil)}
      it "re-renders the :edit template" do
        expect(response).to render_template :edit
      end

      it "renders a danger flash" do
        expect(flash[:danger]).to be_present
      end
    end
  end

  describe "DELETE #destroy" do
    before{delete :destroy, id: subject}

    it "redirects to the subject index" do
      expect(response).to redirect_to admin_subjects_path
    end

    it "renders a success flash" do
      expect(flash[:success]).to be_present
    end
  end
end

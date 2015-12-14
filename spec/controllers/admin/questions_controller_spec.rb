require "rails_helper"

describe Admin::QuestionsController, type: :controller do
  let!(:question){FactoryGirl.create :admin_question}
  before{sign_in question.user}
  describe "GET #index" do
    it "returns status code 200" do
      expect(response.status).to eq 200
    end

    it "shows all contribute questions of signed in user" do
      get :index, {user_id: question.user_id}
      expect(response).to be_success
    end

    it "renders index template" do
      get :index, {user_id: question.user_id}
      expect(response).to render_template :index
    end
  end

  describe "GET #new" do
    it "returns status code 200" do
      expect(response.status).to eq 200
    end

    it "assigns a new Question to @question" do
      get :new
      expect(assigns(:question)).to be_a_new(Question)
    end
    it "renders the :new template" do
      get :new
      expect(response).to render_template :new
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      before{post :create, question: FactoryGirl.attributes_for(:question)}

      it "redirects to the question index" do
        expect(response).to redirect_to new_admin_question_path
      end

      it "render a success flash" do
        expect(flash[:success]).to be_present
      end
    end

    context "with invalid attributes" do
      before{post :create, question: FactoryGirl.attributes_for(:question, question_type: nil)}

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
      before{patch :update, id: question, question: attributes_for(:question)}
      it "redirects to the question index" do
        expect(response).to redirect_to admin_questions_path
      end

      it "renders a success flash" do
        expect(flash[:success]).to be_present
      end
    end

    context "with invalid attributes" do
      before{patch :update, id: question, question: attributes_for(:question, question_type: nil)}
      it "re-renders the :edit template" do
        expect(response).to render_template :edit
      end

      it "renders a danger flash" do
        expect(flash[:danger]).to be_present
      end
    end
  end

  describe "DELETE #destroy" do
    before{delete :destroy, id: question}

    it "redirects to the question index" do
      expect(response).to redirect_to admin_questions_path
    end

    it "renders a success flash" do
      expect(flash[:success]).to be_present
    end
  end
end

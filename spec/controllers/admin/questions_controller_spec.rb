require "rails_helper"

describe Admin::QuestionsController, type: :controller do
  let(:question) {FactoryGirl.create :admin_question}
  before {sign_in question.user}
  describe "GET #index" do
    before{get :index, {user_id: question.user_id}}

    it {expect(response.status).to eq 200}

    it {expect(response).to be_success}

    it {expect(response).to render_template :index}
  end

  describe "GET #new" do
    before {get :new}

    it {expect(response.status).to eq 200}

    it {expect(assigns(:question)).to be_a_new(Question)}

    it {expect(response).to render_template :new}
  end

  describe "POST #create" do
    context "with valid attributes" do
      before {post :create, question: FactoryGirl.attributes_for(:question)}

      it {expect(response).to redirect_to new_admin_question_path}

      it {expect(flash[:success]).to be_present}
    end

    context "with invalid attributes" do
      before {post :create, question: FactoryGirl.attributes_for(:question, question_type: nil)}

      it {expect(response).to render_template :new}

      it {expect(flash[:danger]).to be_present}
    end
  end

  describe "PATCH #update" do
    context "with valid attributes" do
      before {patch :update, id: question, question: attributes_for(:question)}
      it {expect(response).to redirect_to admin_questions_path}

      it {expect(flash[:success]).to be_present}
    end

    context "with invalid attributes" do
      before {patch :update, id: question, question: attributes_for(:question, question_type: nil)}
      it {expect(response).to render_template :edit}

      it {expect(flash[:danger]).to be_present}
    end
  end

  describe "DELETE #destroy" do
    before {delete :destroy, id: question}

    it {expect(response).to redirect_to admin_questions_path}

    it {expect(flash[:success]).to be_present}
  end
end

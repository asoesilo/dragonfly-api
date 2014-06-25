require 'spec_helper'

describe SessionsController do
  describe "POST #create" do
    AUTHENTICATION_ERROR_MESSAGE = "invalid username/password combination"

    let (:user) { create(:user) }

    context "valid registered user" do
      before :each do
        post :create, email: user.email, password: user.password
      end

      it "returns HTTP status OK(200)" do
        expect(response.status).to eq 200
      end

      it "returns user ID" do
        expect(json["id"]).to eq user.id
      end

      # TODO:
      # it "saves session" do
      #   expect(session[:user_id]).to eq @user.id
      # end
    end

    context "invalid email" do
      before :each do
        post :create, email: nil, password: user.password
      end

      it "receives HTTP status BAD REQUEST(400)" do
        expect(response.status).to eq 400
      end

      it "receives error message" do
        errors = json["errors"]
        expect(errors.count).to eq 1
        expect(errors[0]).to eq AUTHENTICATION_ERROR_MESSAGE
      end

      # TODO:
      # it "do not save session" do
      #   expect(session[:user_id]).to be_nil
      # end
    end

    context "invalid password" do
      before :each do
        post :create, email: user.email, password: nil
      end

      it "receives HTTP status BAD REQUEST(400)" do
        expect(response.status).to eq 400
      end

      it "receives error" do
        errors = json["errors"]
        expect(errors.count).to eq 1
        expect(errors[0]).to eq AUTHENTICATION_ERROR_MESSAGE
      end

      # TODO:
      # it "do not save session" do
      #   expect(session[:user_id]).to be_nil
      # end
    end
  end

  describe "DELETE #destroy" do

    let (:user) { create(:user) }

    before :each do
      auth_with_user(user)
      delete :destroy
    end

    it "returns HTTP status OK(200)" do
      expect(response.status).to eq 200
    end

    # TODO:
    # it "session is deleted" do
    #   expect(session[:user_id]).to be_nil
    # end
  end
end
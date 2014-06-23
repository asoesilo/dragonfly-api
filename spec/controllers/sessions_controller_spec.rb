require 'spec_helper'

describe SessionsController do
  describe "POST #create" do
    AUTHENTICATION_ERROR_MESSAGE = "invalid username/password combination"

    logged_out_user

    before :each do
      @user = create(:user)
      assert session[:user_id].nil?, "should not be logged in prior to test execution"
    end

    context "valid registered user" do
      before :each do
        post :create, email: @user.email, password: @user.password
      end

      it "returns HTTP status OK(200)" do
        expect(response.status).to eq 200
      end

      it "saves session" do
        expect(session[:user_id]).to eq @user.id
      end
    end

    context "invalid email" do
      before :each do
        post :create, email: nil, password: @user.password
      end

      it "receives HTTP status UNPROCESSABLE ENTITY(400)" do
        expect(response.status).to eq 400
      end

      it "receives error message" do
        body = JSON.parse(response.body)
        errors = body["errors"]
        expect(errors.count).to eq 1
        expect(errors[0]).to eq AUTHENTICATION_ERROR_MESSAGE
      end

      it "do not save session" do
        expect(session[:user_id]).to be_nil
      end
    end

    context "invalid password" do
      before :each do
        post :create, email: @user.email, password: nil
      end

      it "receives HTTP status UNPROCESSABLE ENTITY(400)" do
        expect(response.status).to eq 400
      end

      it "receives error" do
        body = JSON.parse(response.body)
        errors = body["errors"]
        expect(errors.count).to eq 1
        expect(errors[0]).to eq AUTHENTICATION_ERROR_MESSAGE
      end

      it "do not save session" do
        expect(session[:user_id]).to be_nil
      end
    end
  end

  describe "DELETE #destroy" do
    logged_in_user

    before :each do
      assert !session[:user_id].nil?, "should be logged in prior to test execution"
      delete :destroy
    end

    it "returns HTTP status OK(200)" do
      expect(response.status).to eq 200
    end

    it "session is deleted" do
      expect(session[:user_id]).to be_nil
    end
  end
end
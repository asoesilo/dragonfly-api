require 'spec_helper'

describe UsersController do
  describe "POST #create" do
    context "valid user" do
      before :each do
        @gender = create(:gender)
        post :create, user: attributes_for(:user, gender_id: @gender.id)
      end

      it "save user to database" do
        expect do
          post :create, user: attributes_for(:user, gender_id: @gender.id)
        end.to change(User, :count).by(1)
      end

      it "returns user ID" do
        user = JSON.parse(response.body)
        expect(user["id"]).to be
      end

      it "set user to be online" do
        user = JSON.parse(response.body)
        expect(user["is_online"]).to be_true
      end

      it "returns HTTP status OK(200)" do
        expect(response.status).to eq 200
      end
    end

    context "invalid user" do
    end
  end

  describe "GET #details" do
  end

  describe "PUT #update" do
  end

  describe "DELETE #destroy" do
  end
end
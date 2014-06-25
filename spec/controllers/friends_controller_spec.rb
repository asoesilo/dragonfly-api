require 'spec_helper'

describe FriendsController do

  let (:user) { create(:user) }

  before :each do
    auth_with_user(user)
  end

  describe "POST #create" do
    context "valid friendship" do
      let (:user2) { create(:user2) }

      it "saves to database" do
        expect do
          post :create, id: user2.id
        end.to change(Friend, :count).by(1)
      end

      it "returns HTTP status OK(200)" do
        post :create, id: user2.id
        expect(response.status).to eq 200
      end
    end

    context "invalid friendship" do
      it "does not save to database" do
        expect do
          post :create, id: user.id
        end.to_not change(Friend, :count)
      end

      it "returns HTTP status BAD REQUEST(400)" do
        post :create, id: user.id
        expect(response.status).to eq 400
      end
    end
  end

  describe "DELETE #destroy" do
    context "friendship exists" do
      let (:friendship) { create(:friend, user1: user) }

      it "destroy friendship from the database" do
        friendship # call to create friendship
        expect do
          delete :destroy, id: friendship.user2.id
        end.to change(Friend, :count).by(-1)
      end

      it "returns HTTP status OK(200)" do
        delete :destroy, id: friendship.user2.id
        expect(response.status).to eq 200
      end
    end

    context "friendship does not exist" do
      let (:friendship) { create(:friend, user1: user) }

      it "destroy friendship from the database" do
        friendship # call to create friendship
        expect do
          delete :destroy, id: friendship.user1.id
        end.to_not change(Friend, :count)
      end

      it "returns HTTP status OK(200)" do
        delete :destroy, id: friendship.user2.id
        expect(response.status).to eq 200
      end
    end
  end
end
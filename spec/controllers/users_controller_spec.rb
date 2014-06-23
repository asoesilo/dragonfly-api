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
      context "invalid email" do
        before :each do
          @gender = create(:gender)
          post :create, user: attributes_for(:user, gender_id: @gender.id, email: nil)
        end

        it "does not save user to database" do
          expect do
            post :create, user: attributes_for(:user, gender_id: @gender.id, email: nil)
          end.to_not change(User, :count)
        end

        it "returns HTTP status BAD REQUEST(400)" do
          expect(response.status).to eq 400
        end

        it "returns error messages" do
          body = JSON.parse(response.body)
          expect(body["errors"].count).to eq 2
          expect(body["errors"][0].downcase).to include("email")
          expect(body["errors"][1].downcase).to include("email")
        end
      end

      context "invalid password" do
        before :each do
          @gender = create(:gender)
          post :create, user: attributes_for(:user, gender_id: @gender.id, password: nil)
        end

        it "does not save user to database" do
          expect do
            post :create, user: attributes_for(:user, gender_id: @gender.id, password: nil)
          end.to_not change(User, :count)
        end

        it "returns HTTP status BAD REQUEST(400)" do
          expect(response.status).to eq 400
        end

        it "returns error messages" do
          body = JSON.parse(response.body)
          expect(body["errors"].count).to eq 1
          expect(body["errors"][0].downcase).to include("password")
        end
      end

      context "invalid firstname" do
        before :each do
          @gender = create(:gender)
          post :create, user: attributes_for(:user, gender_id: @gender.id, firstname: nil)
        end

        it "does not save user to database" do
          expect do
            post :create, user: attributes_for(:user, gender_id: @gender.id, firstname: nil)
          end.to_not change(User, :count)
        end

        it "returns HTTP status BAD REQUEST(400)" do
          expect(response.status).to eq 400
        end

        it "returns error messages" do
          body = JSON.parse(response.body)
          expect(body["errors"].count).to eq 1
          expect(body["errors"][0].downcase).to include("firstname")
        end
      end

      context "invalid lastname" do
        before :each do
          @gender = create(:gender)
          post :create, user: attributes_for(:user, gender_id: @gender.id, lastname: nil)
        end

        it "does not save user to database" do
          expect do
            post :create, user: attributes_for(:user, gender_id: @gender.id, lastname: nil)
          end.to_not change(User, :count)
        end

        it "returns HTTP status BAD REQUEST(400)" do
          expect(response.status).to eq 400
        end

        it "returns error messages" do
          body = JSON.parse(response.body)
          expect(body["errors"].count).to eq 1
          expect(body["errors"][0].downcase).to include("lastname")
        end
      end
    end
  end

  describe "GET #details" do
  end

  describe "PUT #update" do
  end

  describe "DELETE #destroy" do
  end
end
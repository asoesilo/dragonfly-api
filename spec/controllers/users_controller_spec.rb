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

        it "returns error messages" do
          body = JSON.parse(response.body)
          expect(body["errors"].count).to eq 2
          expect(body["errors"][0].downcase).to include("email")
          expect(body["errors"][1].downcase).to include("email")
        end

        it "returns HTTP status BAD REQUEST(400)" do
          expect(response.status).to eq 400
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

        it "returns error messages" do
          body = JSON.parse(response.body)
          expect(body["errors"].count).to eq 1
          expect(body["errors"][0].downcase).to include("password")
        end

        it "returns HTTP status BAD REQUEST(400)" do
          expect(response.status).to eq 400
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

        it "returns error messages" do
          body = JSON.parse(response.body)
          expect(body["errors"].count).to eq 1
          expect(body["errors"][0].downcase).to include("lastname")
        end

        it "returns HTTP status BAD REQUEST(400)" do
          expect(response.status).to eq 400
        end
      end
    end
  end

  describe "GET #details" do
    context "not allowed if not logged in" do
      logged_out_user

      before :each do
        get :details
      end

      it "throws an error" do
        body = JSON.parse(response.body)
        expect(body["errors"].count).to be > 0
      end

      it "returns HTTP status FORBIDDEN(403)" do
        expect(response.status).to eq 403
      end
    end

    context "user is logged in" do
      logged_in_user

      before :each do
        get :details
      end

      it "returns HTTP status OK(200)" do
        expect(response.status).to eq 200
      end

      it "returns same information as current user" do
        user = JSON.parse(response.body)
        expect(user["email"]).to eq current_user.email
        expect(user["firstname"]).to eq current_user.firstname
        expect(user["lastname"]).to eq current_user.lastname
        expect(user["birthday"]).to eq current_user.birthday
        expect(user["gender"]).to eq current_user.gender.description
        expect(user["about"]).to eq current_user.about
        expect(user["is_online"]).to eq current_user.is_online
      end
    end
  end

  describe "PUT #update" do
    context "not allowed if not logged in" do
      logged_out_user

      before :each do
        put :update
      end

      it "throws an error" do
        body = JSON.parse(response.body)
        expect(body["errors"].count).to be > 0
      end

      it "returns HTTP status FORBIDDEN(403)" do
        expect(response.status).to eq 403
      end
    end

    context "user is logged in" do
      logged_in_user

      context "can modify email" do
        before :each do
          @new_email = "new@email.com"
          put :update, user: attributes_for(:user, email: @new_email)
        end

        it "returns HTTP status OK(200)" do
          expect(response.status).to eq 200
        end

        it "email has new value" do
          current_user.reload
          expect(current_user.email).to eq @new_email
        end
      end

      context "can modify firstname" do
        before :each do
          @firstname = "New-Firstname"
          put :update, user: attributes_for(:user, firstname: @firstname)
        end

        it "returns HTTP status OK(200)" do
          expect(response.status).to eq 200
        end

        it "firstname has new value" do
          current_user.reload
          expect(current_user.firstname).to eq @firstname
        end
      end

      context "can modify lastname" do
        before :each do
          @lastname = "New-Lastname"
          put :update, user: attributes_for(:user, lastname: @lastname)
        end

        it "returns HTTP status OK(200)" do
          expect(response.status).to eq 200
        end

        it "lastname has new value" do
          current_user.reload
          expect(current_user.lastname).to eq @lastname
        end
      end

      context "can modify birthday" do
        before :each do
          @birthday = 100.years.ago(Date.today)
          put :update, user: attributes_for(:user, birthday: @birthday)
        end

        it "returns HTTP status OK(200)" do
          expect(response.status).to eq 200
        end

        it "birthday has new value" do
          current_user.reload
          expect(current_user.birthday).to eq @birthday.strftime("%F")
        end
      end

      context "can modify gender" do
        before :each do
          @gender = create(:gender, description: Faker::Lorem.word)
          put :update, user: attributes_for(:user, gender_id: @gender.id)
        end

        it "returns HTTP status OK(200)" do
          expect(response.status).to eq 200
        end

        it "gender has new value" do
          current_user.reload
          expect(current_user.gender).to eq @gender
        end
      end

      context "can modify about" do
        before :each do
          @about = Faker::Lorem.sentence
          put :update, user: attributes_for(:user, about: @about)
        end

        it "returns HTTP status OK(200)" do
          expect(response.status).to eq 200
        end

        it "about has new value" do
          current_user.reload
          expect(current_user.about).to eq @about
        end
      end

      context "cannot modify is_online" do
        it "does not change is_online" do
          expect do
            put :update, user: attributes_for(:user, is_online: !current_user.is_online)
            current_user.reload
          end.to_not change(current_user, :is_online)
        end
      end
    end
  end

  describe "DELETE #destroy" do
    context "not allowed if not logged in" do
      logged_out_user

      before :each do
        delete :destroy
      end

      it "throws an error" do
        body = JSON.parse(response.body)
        expect(body["errors"].count).to be > 0
      end

      it "returns HTTP status FORBIDDEN(403)" do
        expect(response.status).to eq 403
      end
    end

    context "user is logged in" do
      logged_in_user

      it "removes user from database" do
        expect do
          delete :destroy
        end.to change(User, :count).by(-1)
      end

      it "logs out user" do
        delete :destroy
        expect(session[:user_id]).to eq nil
      end

      it "returns HTTP status OK(200)" do
        delete :destroy
        expect(response.status).to eq 200
      end
    end
  end
end
require 'spec_helper'

describe User do
  describe "validation" do
    it "has a valid factory" do
      expect(build(:user)).to be_valid
    end

    it "is invalid without an email" do
      expect(build(:user, email: nil)).to have(2).errors_on(:email)
    end

    it "is invalid without a password" do
      expect(build(:user, password: nil)).to have(1).errors_on(:password)
    end

    it "is invalid without a first name" do
      expect(build(:user, firstname: nil)).to have(1).errors_on(:firstname)
    end

    it "is invalid without a last name" do
      expect(build(:user, lastname: nil)).to have(1).errors_on(:lastname)
    end

    it "is valid without a birthday" do
      expect(build(:user, birthday: nil)).to be_valid
    end

    it "is valid without a gender" do
      expect(build(:user, gender: nil)).to be_valid
    end

    it "is valid without an about" do
      expect(build(:user, about: nil)).to be_valid
    end

    it "saves avatar" do
      expect(build(:user).avatar_file_name).to eq 'avatar.jpeg'
    end
  end
end
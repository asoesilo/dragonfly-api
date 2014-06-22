require 'spec_helper'

describe Profile do
  describe "validation" do
    it "has a valid factory" do
      expect(build(:profile)).to be_valid
    end

    it "is invalid without an email" do
      expect(build(:profile, email: nil)).to have(2).errors_on(:email)
    end

    it "is invalid without a password" do
      expect(build(:profile, password: nil)).to have(1).errors_on(:password)
    end

    it "is invalid without a first name" do
      expect(build(:profile, firstname: nil)).to have(1).errors_on(:firstname)
    end

    it "is invalid without a last name" do
      expect(build(:profile, lastname: nil)).to have(1).errors_on(:lastname)
    end

    it "is valid without a birthday" do
      expect(build(:profile, birthday: nil)).to be_valid
    end

    it "is valid without a gender" do
      expect(build(:profile, gender: nil)).to be_valid
    end

    it "is valid without an about" do
      expect(build(:profile, about: nil)).to be_valid
    end
  end
end
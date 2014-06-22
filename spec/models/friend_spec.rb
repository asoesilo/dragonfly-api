require 'spec_helper'

describe Friend do
  describe "validation" do
    it "has a valid factory" do
      expect(build(:friend)).to be_valid
    end

    it "not valid if friend is with self" do
      profile = build(:profile)
      expect(build(:friend, profile1: profile, profile2: profile)).to have(1).errors_on(:profile2)
    end
  end
end
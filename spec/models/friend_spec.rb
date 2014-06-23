require 'spec_helper'

describe Friend do
  describe "validation" do
    it "has a valid factory" do
      expect(build(:friend)).to be_valid
    end

    it "not valid if friend is with self" do
      user = build(:user)
      expect(build(:friend, user1: user, user2: user)).to have(1).errors_on(:user2)
    end
  end
end
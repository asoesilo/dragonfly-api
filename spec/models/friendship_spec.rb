require 'spec_helper'

describe Friendship do
  describe "validation" do
    it "has a valid factory" do
      expect(build(:friendship)).to be_valid
    end

    it "not valid if friend is with self" do
      user = build(:user)
      expect(build(:friendship, user1: user, user2: user)).to have(1).errors_on(:user2)
    end

    it "does not allow duplicate friendship entries" do
      friendship = create(:friendship)
      expect(build(:friendship, user1: friendship.user1, user2: friendship.user2)).to have(1).errors_on(:user2)
    end
  end
end
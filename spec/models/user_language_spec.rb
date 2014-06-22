require 'spec_helper'

describe UserLanguage do
  describe "validation" do
    it "has a valid factory" do
      expect(build(:user_language)).to be_valid
    end
  end
end
require 'spec_helper'

describe Language do
  describe "validation" do
    it "has a valid factory" do
      expect(build(:language)).to be_valid
    end
  end
end
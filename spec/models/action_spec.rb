require 'spec_helper'

describe Action do
  describe "validation" do
    it "has a valid factory" do
      expect(build(:action)).to be_valid
    end
  end
end
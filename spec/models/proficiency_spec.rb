require 'spec_helper'

describe Proficiency do
  describe "validation" do
    it "has a valid factory" do
      expect(build(:proficiency)).to be_valid
    end
  end
end
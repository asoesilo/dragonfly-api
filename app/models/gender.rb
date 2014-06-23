class Gender < ActiveRecord::Base
  validates :description, presence:true, uniqueness: true

  class << self
    def MALE
      @male ||= Gender.find_by(description: 'Male')
    end

    def FEMALE
      @female ||= Gender.find_by(description: 'Female')
    end
  end
end
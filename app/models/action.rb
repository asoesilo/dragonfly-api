class Action < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true

  class << self
    def TEACH
      @teach ||= Action.find_by(name: 'Teach')
    end

    def LEARN
      @learn ||= Action.find_by(name: 'Learn')
    end
  end

  def as_json(options)
    {
      id: id,
      name: name
    }
  end
end
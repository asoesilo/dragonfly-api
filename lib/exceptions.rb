module Exceptions
  class ApplicationError < StandardError
    attr_reader :messages
    def initialize(messages=[])
      @messages = messages
    end
  end
  class AuthenticationError < ApplicationError; end
  class InvalidParametersError < ApplicationError; end
  class InvalidUserError < ApplicationError; end
  class InvalidUserLanguageError < ApplicationError; end
  class InvalidFriendshipCreationError < ApplicationError; end
  class InvalidFriendshipDestroyError < ApplicationError; end
end
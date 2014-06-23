module Exceptions
  class ApplicationError < StandardError; end
  class AuthenticationError < ApplicationError; end
end
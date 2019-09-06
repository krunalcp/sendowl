require_relative "sendowl/version"
require_relative "sendowl/request"

require_relative "sendowl/resources/license"

module Sendowl
  class << self
    attr_accessor :api_endpoint, :open_timeout, :timeout, :api_key, :api_secret
  end

  self.api_endpoint   = "https://www.sendowl.com/api/v1"
  self.open_timeout   = 10
  self.timeout        = 30
  self.api_key        = ENV["SENDOWL_API_KEY"]
  self.api_secret     = ENV["SENDOWL_API_SECRET"]
end

# frozen_string_literal: true

require_relative "lotrb/version"

require "lotrb/list_object"
require "lotrb/resources"

require "lotrb/util"

module Lotrb
  autoload :Client, "lotrb/client"
  autoload :Error, "lotrb/error"

  class << self
    attr_accessor :access_token

  end
end

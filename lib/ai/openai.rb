# frozen_string_literal: true

# Wrapper for OpenAI API

require 'openai'

module Ai
  class Openai
    def initialize
      @client = OpenAI::Client.new(
        access_token: ENV['OPENAI_API_KEY'],
        log_error: true
      )
    end
  end
end

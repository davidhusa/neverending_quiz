# frozen_string_literal: true

require 'openai'

# Wrapper for OpenAI API
class AIClient
  DEFAULT_MODEL = 'gpt-4o-mini'
  attr_reader :client
  attr_accessor :last_response

  def initialize
    @client = ::OpenAI::Client.new(
      access_token: ENV['OPENAI_API_KEY'],
      log_errors: true
    )
  end

  def send_message(message)
    response = @client.chat(parameters: {
                              model: DEFAULT_MODEL,
                              messages: [{ role: 'user', content: message }],
                              temperature: 0.7
                            })
    @last_response = response

    response.dig('choices', 0, 'message', 'content')
  end
end

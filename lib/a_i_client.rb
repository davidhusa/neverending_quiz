# frozen_string_literal: true

require 'openai'

# Wrapper for OpenAI API
class AIClient
  DEFAULT_MODEL = 'gpt-4o-mini'
  attr_reader :client, :model
  attr_accessor :last_response

  def initialize(model: nil)
    @model = model || DEFAULT_MODEL
    @client = ::OpenAI::Client.new(
      access_token: ENV['OPENAI_API_KEY'],
      log_errors: true
    )
  end

  def send_system_message(message)
    send_message(message, role: 'system')
  end

  def send_message(message, role: 'user')
    response = @client.chat(parameters: {
                              model: DEFAULT_MODEL,
                              messages: [{ role: 'user', content: message }],
                              temperature: 0.7
                            })
    @last_response = response

    response.dig('choices', 0, 'message', 'content')
  end
end

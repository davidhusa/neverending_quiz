# frozen_string_literal: true

require 'openai'

# Wrapper for OpenAI API
class AIClient
  attr_reader :client, :model
  attr_accessor :last_response

  def initialize(model: nil)
    @model = model || ENV['DEFAULT_OPENAI_MODEL']
    @client = ::OpenAI::Client.new(
      access_token: ENV['OPENAI_API_KEY'],
      log_errors: true
    )
  end

  def send_message(message, system_prompt: nil)
    response = @client.chat(parameters: {
                              model: @model,
                              messages: messages_array(message, system_prompt),
                              temperature: 0.7
                            })
    @last_response = response

    response.dig('choices', 0, 'message', 'content')
  end

  def messages_array(message, system_prompt)
    array = []
    array << { role: 'system', content: system_prompt } if system_prompt.present?
    array << { role: 'user', content: message }
    array
  end
end

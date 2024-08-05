require "openai"

class AiApi::Openai
  def initialize
    @client = OpenAR::Client.new(
      access_token: ENV["OPENAI_API_KEY"],
      log_error: true
    )
  end
end

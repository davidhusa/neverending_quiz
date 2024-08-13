require 'a_i_client'

class AssistantInstantiator
  attr_reader :name, :model, :ai_client, :assistant_id
  def initialize(name: nil, model: nil)
    @name = name || "assistant!"
    @model = model || ENV["DEFAULT_OPENAI_MODEL"]
    @ai_client = AIClient.new(model: model)
  end

  def client
    @ai_client.client
  end

  def register
    response = client.assistants.create(
      parameters: { model: @model, name: @name, }
          # description: nil,
          # instructions: "You are a Ruby dev bot. When asked a question, write and run Ruby code to answer the question",
          # tools: [
          #     { type: "code_interpreter" },
          #     { type: "file_search" }
          # ],
          # tool_resources: {
          #   code_interpreter: {
          #     file_ids: [] # See Files section above for how to upload files
          #   },
          #   file_search: {
          #     vector_store_ids: [] # See Vector Stores section above for how to add vector stores
          #   }
          # },
          # "metadata": { my_internal_version_id: "1.0.0" }
    )
    @assistant_id = response.dig("id")
  end
end

# thread_id = "thread_C0v0ChEXqua2w3Bcvi2Jq0kw"
# 
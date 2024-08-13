# require 'a_i_client'

# class Assistant < ApplicationRecord
#   validates :name, presence: true
#   validates :model, presence: true

#   def ai_client
#     @@ai_client ||= AIClient.new
#   end

#   def register
#     return if remote_assitant_id.present

#     response = ai_client.assistants.create(
#       parameters: {
#         model: ENV['DEFAULT_OPENAI_MODEL'],
#         name: self.name,
#         description: self.description,
#         instructions: 'You are a Ruby dev bot. When asked a question, write and run Ruby code to answer the question',
#         # tools: [
#         #   { type: 'code_interpreter' },
#         #   { type: 'file_search' }
#         # ],
#         # tool_resources: {
#         #   code_interpreter: {
#         #     file_ids: [] # See Files section above for how to upload files
#         #   },
#         #   file_search: {
#         #     vector_store_ids: [] # See Vector Stores section above for how to add vector stores
#         #   }
#         # },
#         "metadata": { trivia_assistant_id: '0.0.1' }
#       }
#     )
#     assistant_id = response['id']
#     raise 'No assistant ID returned' unless assistant_id.present?

#     update_attribute!(:assistant_id, assistant_id)
#   end
# end

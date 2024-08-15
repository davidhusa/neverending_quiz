require 'openai'

@client = ::OpenAI::Client.new(
  access_token: ENV['OPENAI_API_KEY'],
  log_errors: true
)

INSTRUCTIONS = <<-INSTRUCTIONS
  You create multiple choice questions with four answers with one correct answer that is marked with \"[correct]\" at the beginning.#{' '}
  Separate each question with a line with just \"=====\""
INSTRUCTIONS

INSTRUCTIONS_NEW = <<-INSTRUCTIONS
  You create multiple choice questions with four answers with one correct answer.
  Each question is prepended with \"QUESTION :\" and not a number.
  The correct answer is prepended with \"CORRECT: \".
  Each incorrect answer is prepended with \"INCORRECT: \".
  Separate each question with a line with just \"=====\".
  Include a line after each correct and incorrect answer that explains why the specific answer was correct or incorrect in detail.
  Ensure that unique explanation follows each possible answer, not just the correct one.
INSTRUCTIONS

INSTRUCTIONS_NEWER = <<-INSTRUCTIONS
  You create multiple choice questions with four answers with one correct answer.
  Express the output as a JSON object.#{' '}
  The question is under the key "question" and the answers are in an array under the key "answers".
  Each answer in "answers" in a JSON object where the answer text is under the key "answer", the explanation text is under the key "explanation," and whether or not it is correct as a boolean under the key "correct".
  Include with correct and incorrect answer text that explains why the specific answer was correct or incorrect in detail.
  Ensure that unique explanation follows each possible answer, not just the correct one.
INSTRUCTIONS

def assistant_id
  return @assistant_id if @assistant_id

  response = @client.assistants.create(
    parameters: {
      model: 'gpt-4o',
      name: 'Open AI trivia generator',
      description: nil,
      instructions: INSTRUCTIONS_NEWER
    }
  )
  @assistant_id = response['id']
end

def change_instructions(instructions)
  @client.assistants.modify(
    id: assistant_id,
    parameters: {
      instructions:
    }
  )
end

def thread_id
  return @thread_id if @thread_id

  response = @client.threads.create

  @thread_id = response['id']
end

def create_message(message)
  response = @client.messages.create(
    thread_id:,
    parameters: {
      role: 'user', # Required for manually created messages
      content: message
    }
  )
  @message_ids ||= []
  @message_ids << response['id']
  response['id']
end

def list_messages
  @client.messages.list(thread_id:)
end

def last_message
  list_messages.dig('data', 0, 'content', 0, 'text', 'value')
end

def run_message
  response = @client.runs.create(thread_id:,
                                 parameters: {
                                   assistant_id:,
                                   max_prompt_tokens: 4000,
                                   max_completion_tokens: 4000
                                 })
  response['id']
end

def run_status(run_id)
  response = @client.runs.retrieve(id: run_id, thread_id:)
  response['status']
end

def first_message(topic)
  message = "Write 10 trivia questions about #{topic}."
  create_message(message)
end

def addtl_message(topic)
  message = "Write 10 more trivia questions about #{topic} with no repeats."
  create_message(message)
end

# def sanitize_question_text(question_text)
#   return unless question_text.present?

#   question_text
#     .strip
#     .scan(/^(\d+\.\s+){,1}(.+)$/)
#     .dig(-1, -1)
# end

# def process_response_text(response_text)
#   response_test.split("=====").map { |question_text| process_question_and_answers(question_text.split("\n").reject(&:blank?)) }
# end

# def process_question_and_answers(question_text)
# end
#
JSON_TAG = /\A```json(.*)```\z/m
def process_json(message)
  json_text = message.scan(JSON_TAG).dig(0, 0) || message

  JSON.parse(json_text)
end

def run_and_await_message
  run_id = run_message
  while true
    response = @client.runs.retrieve(id: run_id, thread_id:)
    status = response['status']

    case status
    when 'queued', 'in_progress', 'cancelling'
      print '.'
      sleep 1 # Wait one second and poll again
    when 'completed'
      break last_message
    when 'cancelled', 'failed', 'expired', 'incomplete'
      puts response['last_error'].inspect
      break false
    else
      puts "Unknown status response: #{status}"
    end
  end
end

if false
  load 'lib/getter.rb'
  topic = 'rare monkeys'
  first_message(topic)
  # run_id = run_message

  # run_status(run_id)

  run_and_await_message

  message = last_message
  process_json(message)

  addtl_message(topic)
  run_id = run_message

end

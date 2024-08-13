
require 'openai'

@client = ::OpenAI::Client.new(
      access_token: ENV['OPENAI_API_KEY'],
      log_errors: true
    )

INSTRUCTIONS = <<-INSTRUCTIONS
  You create multiple choice questions with four answers with one correct answer that is marked with \"[correct]\" at the beginning. 
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


def assistant_id
  return @assistant_id if @assistant_id
  
  response = @client.assistants.create(
  parameters: {
    model: 'gpt-4o',
    name: 'Open AI trivia generator',
    description: nil,
    instructions: INSTRUCTIONS_NEW,
    }
  )
  @assistant_id = response['id']
end

def change_instructions(instructions)
  @client.assistants.modify(
        id: assistant_id,
        parameters: {
          instructions: instructions
        })
end

def thread_id
  return @thread_id if @thread_id

  response = @client.threads.create

  @thread_id = response['id']
end

def create_message(message)
  response = @client.messages.create(
    thread_id: thread_id,
    parameters: {
        role: "user", # Required for manually created messages
        content: message
    })
  @message_ids ||= []
  @message_ids << response['id']
  response['id']
end

def list_messages
  @client.messages.list(thread_id: thread_id)
end

def last_message
  list_messages.dig('data', 0, 'content', 0, 'text', 'value')
end

def run_message
  response = @client.runs.create(thread_id: thread_id,
    parameters: {
        assistant_id: assistant_id,
        max_prompt_tokens: 4000,
        max_completion_tokens: 4000
    })
  response['id']
end

def run_status(run_id)
  response = @client.runs.retrieve(id: run_id, thread_id: thread_id)
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

if false


  load 'lib/getter.rb'
  topic = "rare monkeys"
  first_message(topic)
  run_id = run_message
  
  run_status(run_id)

  last_message

  addtl_message(topic)
  run_id = run_message

end
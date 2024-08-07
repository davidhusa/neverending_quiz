require 'a_i_client'

module QuestionGenerator
  # Provides an AI a topic and prompt to populate the database with topics, questions, and answers
  class Generator
    attr_reader :ai_client

    def initialize
      @ai_client = AIClient.new
      @number_of_questions = 3
    end

    def retrieve_questions(topic)
      question_response_text = retrieve_raw_question_text(topic)
      puts "question_response_text: #{question_response_text}"
      question_hashes = process_response_text_to_hashes(question_response_text)
      generate_models(question_hashes, topic)
    end

    def generate_models(question_hashes, topic)
      topic = Topic.find_or_create_by(topic:)
      question_hashes.each do |question_hash|
        question = Question.create(question: question_hash[:question], topic:)
        question_hash[:correct_answers].each do |correct_answer|
          Answer.create(answer: correct_answer, correct: true, question:)
        end
        question_hash[:wrong_answers].each do |wrong_answer|
          Answer.create(answer: wrong_answer, correct: false, question:)
        end
      end
    end

    def retrieve_raw_question_text(topic)
      # send_system_prompt_if_not_sent # not sure if system prompt is necessary or useful for this
      @ai_client.send_message(trivia_prompt(topic))
    end

    def process_response_text_to_hashes(question_response_text)
      question_hashes = []
      question_response_text.split('=====').each do |question_and_answers_text|
        question_hashes.push(construct_question_hash(question_and_answers_text))
      end
      question_hashes
    end

    def construct_question_hash(question_and_answers_text)
      questions_and_answers = question_and_answers_text.strip.split("\n")
      question = questions_and_answers[0]&.strip
      correct_answer = questions_and_answers[1]&.strip
      return unless question.present? && correct_answer.present?

      wrong_answers = (2..5).map do |index|
        questions_and_answers[index]
      end.compact.map(&:strip)

      { question:, correct_answers: [correct_answer], wrong_answers: }
    end

    def trivia_prompt(topic)
      <<~PROMPT.chomp
        Generate to #{@number_of_questions} multiple choice questions about #{topic}.
        Include four answers with only one correct answer that is always the first option.
        Do not include any text aside from the questions and answers.
        Separate each question with "=====".
        Keep the questions and answers each on their own, singular line.
      PROMPT
    end

    # def system_prompt
    # end

    # def send_system_prompt_if_not_sent
    #   return if @prompt_sent

    #   @ai_client.send_system_message(system_prompt)
    #   @prompt_sent = true
    # end
  end
end

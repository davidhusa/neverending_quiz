require 'a_i_client'

module QuestionGenerator
  # Provides an AI a topic and prompt to populate the database with topics, questions, and answers
  class Generator
    attr_reader :ai_client

    def initialize(ai_client: AIClient.new, number_of_questions: 25)
      @ai_client = ai_client
      @number_of_questions = number_of_questions
    end

    def import_topic(topic)
      question_hashes = retrieve_questions(topic)
      generate_models(question_hashes, topic)
    end

    private

    def retrieve_questions(topic)
      question_response_text = retrieve_raw_question_text(topic)
      puts "question_response_text: #{question_response_text}"
      process_response_text_to_hashes(question_response_text)
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
      @ai_client.send_message(trivia_prompt(topic), system_prompt:)
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
      question = sanitize_question_text(questions_and_answers[0])
      correct_answer = questions_and_answers[1]&.strip
      return unless question.present? && correct_answer.present?

      wrong_answers = (2..5).map do |index|
        questions_and_answers[index]
      end.compact.map(&:strip)

      { question:, correct_answers: [correct_answer], wrong_answers: }
    end

    # Filters out possible question numbers and returns the question text
    def sanitize_question_text(question_text)
      return unless question_text.present?

      question_text
        .strip
        .scan(/^(\d+\.\s+){,1}(.+)$/)
        .dig(-1, -1)
    end

    def trivia_prompt(topic)
      <<~PROMPT.chomp
        Generate to #{@number_of_questions} questions about #{topic}.
      PROMPT
    end

    def system_prompt
      <<~PROMPT.chomp
        Generate multiple choice questions with four answers with only one correct answer that is always the first option.
        Do not include any text aside from the questions and answers.
        Separate each question with "=====".
        Keep the questions and answers each on their own, singular line.
        Return only questions with four possible answers, return nothing if you cannot generate a question with four possible answers.
      PROMPT
    end
  end
end

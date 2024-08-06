# frozen_string_literal: true

require 'test_helper'

class QuestionTest < ActiveSupport::TestCase
  def setup
    @question = Question.create(question: 'What is the capital of France?')
    @question.answers << [Answer.new(answer: 'Paris', correct: true),
                          Answer.new(answer: 'London', correct: false)]
    @question_two = Question.create(question: 'Who let the dogs out?')
    @question_two.answers << [Answer.new(answer: 'I did', correct: false),
                              Answer.new(answer: 'The dog unleasher', correct: true),
                              Answer.new(answer: 'All of us in our own way', correct: false)]
  end

  test 'should be valid' do
    assert @question.valid?
  end

  test 'question should be present' do
    @question.question = ''
    assert_not @question.valid?
  end

  test 'should have many answers' do
    assert_respond_to @question, :answers
    assert_equal 2, @question.answers.size
  end

  test 'next_question should be defined' do
    assert_respond_to @question, :next_question
    assert_equal @question_two, @question.next_question
  end
end

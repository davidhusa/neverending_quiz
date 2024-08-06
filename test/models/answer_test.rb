# frozen_string_literal: true

require 'test_helper'

class AnswerTest < ActiveSupport::TestCase
  def setup
    question = Question.create(question: 'What does it all mean?')
    @answer_one = Answer.create(answer: '42', correct: true, question: question)
    @answer_two = Answer.create(answer: 'nm hbu', correct: false, question: question)
  end

  test 'should be valid' do
    assert @answer_one.valid?
  end

  test 'answer should be present' do
    @answer_one.answer = ''
    assert_not @answer_one.valid?
  end

  test 'should have a question with other answers' do
    assert_respond_to @answer_one, :question
    assert_equal Question, @answer_one.question.class
    assert_includes @answer_one.question.answers, @answer_two
  end
end

class Api::V1::QuestionsController < ApplicationController
  def index
    @questions = Question.order(created_at: :desc).all
    render json: @questions
  end

  def show
    # allow passing 'first' to get first question
    params[:id] = Question.first.id if params[:id] == 'first'
    @question = Question.find(params[:id])
    render json: @question.to_json(include: [:answers, :next_question])
  end
end

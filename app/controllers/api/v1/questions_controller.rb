class Api::V1::QuestionsController < ApplicationController
  def index
    @questions = Question.order(created_at: :desc).all
    render json: @questions
  end

  # def create
  # end

  def show
    @question = Question.find(params[:id])
    render json: @question
  end

  # def destroy
  # end
end

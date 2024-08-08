# frozen_string_literal: true

module Api
  module V1
    # API endpoint for retrieving questions and answers
    class QuestionsController < ApplicationController
      def index
        @questions = Question.order(created_at: :desc).all
        render json: @questions
      end

      def show
        # allow passing 'first' to get first question
        params[:id] = Question.first.id if params[:id] == 'first'
        @question = Question.find(params[:id])
        render json: @question.to_json(include: %i[answers next_question topic next_topic_first_question])
      end
    end
  end
end

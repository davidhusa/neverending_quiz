# frozen_string_literal: true

# Model for storing answers to questions
class Answer < ApplicationRecord
  belongs_to :question
end

# frozen_string_literal: true

# Model for storing answers to questions
class Answer < ApplicationRecord
  validates :answer, presence: true
  belongs_to :question
end

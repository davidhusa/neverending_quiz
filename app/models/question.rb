# frozen_string_literal: true

# Model for questions, will have many answers
class Question < ApplicationRecord
  validates :question, presence: true
  has_many :answers, dependent: :destroy
  belongs_to :topic

  def next_question
    self.class.where('id > ?', id).first
  end
end

# frozen_string_literal: true

class Question < ApplicationRecord
  validates :question, presence: true
  has_many :answers

  def next_question
    self.class.where('id > ?', id).first
  end
end

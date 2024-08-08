# frozen_string_literal: true

# Model for questions, will have many answers
class Question < ApplicationRecord
  validates :question, presence: true
  has_many :answers, dependent: :destroy
  belongs_to :topic

  def next_question
    self.class.where('id > ?', id).where(topic:).first
  end

  def next_topic_first_question
    return unless topic.next_topic.present?

    topic.next_topic.questions.first
  end
end

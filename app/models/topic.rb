# frozen_string_literal: true

# Model for topic, will have many questions
class Topic < ApplicationRecord
  validates :topic, presence: true
  has_many :questions, dependent: :destroy

  def next_topic
    self.class.where('id > ?', id).first
  end
end

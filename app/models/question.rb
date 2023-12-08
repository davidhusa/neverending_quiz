class Question < ApplicationRecord
  validates :question, presence: true
  has_many :answers

  def next_question
    next_question = self.class.where("id > ?", self.id).first
  end

end

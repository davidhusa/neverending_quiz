# frozen_string_literal: true

# Create the table to support the Answer model
class CreateAnswers < ActiveRecord::Migration[7.1]
  def change
    create_table :answers do |t|
      t.integer :question_id, null: false
      t.string :answer, null: false
      t.boolean :correct, null: false

      t.timestamps
    end
  end
end

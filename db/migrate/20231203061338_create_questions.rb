# frozen_string_literal: true

# Create the table to support the Question model
class CreateQuestions < ActiveRecord::Migration[7.1]
  def change
    create_table :questions do |t|
      t.string :question, null: false

      t.timestamps
    end
  end
end

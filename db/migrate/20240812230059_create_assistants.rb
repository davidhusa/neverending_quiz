class CreateAssistants < ActiveRecord::Migration[7.1]
  def change
    create_table :assistants do |t|
      t.string :remote_assistant_id, null: false
      t.string :name, null: false
      t.string :description
      t.timestamps
    end
  end
end

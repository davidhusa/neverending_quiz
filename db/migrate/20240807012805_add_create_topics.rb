class AddCreateTopics < ActiveRecord::Migration[7.1]
  def change
    create_table :topics do |t|
      t.text :topic, limit: 1000, null: false

      t.timestamps
    end
  end
end

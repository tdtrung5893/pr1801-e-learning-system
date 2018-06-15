class CreateWords < ActiveRecord::Migration[5.1]
  def change
    create_table :words do |t|
      t.string :name
      t.text :description
      t.string :question
      t.integer :lesson_id

      t.timestamps
    end
  end
end

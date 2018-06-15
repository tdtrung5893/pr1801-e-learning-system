class CreateUserLessons < ActiveRecord::Migration[5.1]
  def change
    create_table :user_lessons do |t|
      t.integer :user_id
      t.integer :lesson_id
      t.boolean :status

      t.timestamps
    end
  end
end

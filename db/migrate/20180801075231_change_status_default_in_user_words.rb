class ChangeStatusDefaultInUserWords < ActiveRecord::Migration[5.1]
  def change
    change_column_default :user_words, :status, false
  end
end

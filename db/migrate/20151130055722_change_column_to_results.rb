class ChangeColumnToResults < ActiveRecord::Migration
  def change
    remove_reference :results, :answer, index: true, foreign_key: true
    add_column :results, :content_answer, :string
  end
end

class AddIndexToResults < ActiveRecord::Migration
  def change
    add_index :results, [:answer_id, :question_id, :exam_id], unique: true
  end
end

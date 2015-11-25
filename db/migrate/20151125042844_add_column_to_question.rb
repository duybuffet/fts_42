class AddColumnToQuestion < ActiveRecord::Migration
  def change
    add_column :questions, :question_type, :integer, {null: false, default: 0}
  end
end

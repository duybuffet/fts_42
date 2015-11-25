class ChangeColumnToExams < ActiveRecord::Migration
  def change
    rename_column :exams, :duration, :spent_time
  end
end

class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :chatwork_id
      t.integer :role, null: false, default: 1
      t.timestamps null: false
    end
  end
end

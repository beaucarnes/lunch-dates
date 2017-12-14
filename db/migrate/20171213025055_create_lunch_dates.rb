class CreateLunchDates < ActiveRecord::Migration
  def change
    create_table :lunch_dates do |t|
      t.integer :teammate_a_id, :null => false
      t.integer :teammate_b_id, :null => false
      t.date :date, :null => false

      t.timestamps null: false
    end
  end
end

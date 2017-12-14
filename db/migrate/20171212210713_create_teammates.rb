class CreateTeammates < ActiveRecord::Migration
  def change
    create_table :teammates do |t|
      t.string :name
      t.string :twitter_username

      t.timestamps null: false
    end
  end
end

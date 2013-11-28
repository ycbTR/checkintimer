class CreateCheckins < ActiveRecord::Migration
  def change
    create_table :checkins do |t|
      t.integer :user_id
      t.string :venue_id
      t.string :broadcast
      t.string :lat
      t.string :long
      t.string :shout

      t.timestamps
    end
  end
end

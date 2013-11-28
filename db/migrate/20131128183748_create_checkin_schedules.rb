class CreateCheckinSchedules < ActiveRecord::Migration
  def change
    create_table :checkin_schedules do |t|
      t.integer :user_id
      t.string :shout
      t.string :broadcast
      t.boolean :private
      t.boolean :post_to_facebook
      t.boolean :post_to_twitter
      t.time :time
      t.string :days
      t.string :state
      t.string :venue_id
      t.string :lat
      t.string :long

      t.timestamps
    end
  end
end

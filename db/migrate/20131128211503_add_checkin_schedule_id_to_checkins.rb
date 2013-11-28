class AddCheckinScheduleIdToCheckins < ActiveRecord::Migration
  def change
    add_column :checkins, :checkin_schedule_id, :integer
  end
end

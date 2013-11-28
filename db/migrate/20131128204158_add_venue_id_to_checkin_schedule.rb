class AddVenueIdToCheckinSchedule < ActiveRecord::Migration
  def change
    add_column :checkin_schedules, :venue_id, :string
  end
end

class AddVenueNameToCheckinSchedule < ActiveRecord::Migration
  def change
    add_column :checkin_schedules, :venue_name, :string
  end
end

class AddLatLongToCheckinSchedules < ActiveRecord::Migration
  def change
    add_column :checkin_schedules, :lat, :string
    add_column :checkin_schedules, :long, :string
  end
end

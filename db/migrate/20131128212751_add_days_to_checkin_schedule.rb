class AddDaysToCheckinSchedule < ActiveRecord::Migration
  def change
    add_column :checkin_schedules, :monday, :boolean
    add_column :checkin_schedules, :tuesday, :boolean
    add_column :checkin_schedules, :wednesday, :boolean
    add_column :checkin_schedules, :thursday, :boolean
    add_column :checkin_schedules, :friday, :boolean
    add_column :checkin_schedules, :saturday, :boolean
    add_column :checkin_schedules, :sunday, :boolean
    remove_column :checkin_schedules, :days
  end
end

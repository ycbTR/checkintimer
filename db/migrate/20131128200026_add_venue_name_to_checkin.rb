class AddVenueNameToCheckin < ActiveRecord::Migration
  def change
    add_column :checkins, :venue_name, :string
  end
end

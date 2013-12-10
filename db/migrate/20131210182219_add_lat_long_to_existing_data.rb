class AddLatLongToExistingData < ActiveRecord::Migration
  def change
    CheckinSchedule.all.each do |cs|
      cs.save
    end
  end
end

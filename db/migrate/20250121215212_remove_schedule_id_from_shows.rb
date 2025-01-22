class RemoveScheduleIdFromShows < ActiveRecord::Migration[7.2]
  def change
    remove_column :shows, :schedule_id, :integer
  end
end

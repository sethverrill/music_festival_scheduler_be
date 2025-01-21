class CreateScheduleShows < ActiveRecord::Migration[7.2]
  def change
    create_table :schedule_shows do |t|
      t.references :schedule, foreign_key: true
      t.references :show, foreign_key: true
      t.timestamps
    end
  end
end

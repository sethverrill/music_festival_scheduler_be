class CreateShows < ActiveRecord::Migration[7.2]
  def change
    create_table :shows do |t|
      t.integer :time_slot
      t.references :schedule, null: false, foreign_key: true
      t.references :venue, null: false, foreign_key: true
      t.references :artist, null: false, foreign_key: true

      t.timestamps
    end
  end
end

class ScheduleSerializer
  include JSONAPI::Serializer

  attributes :id, :created_at

  has_many :shows

  attribute :time_slot_map do |schedule|
    (1..8).map do |slot|
      {
        time_slot: slot,
        shows: schedule.shows.select { |show| show.time_slot == slot }.map do |show|
          {
            id: show.id,
            artist: show.artist.name,
            venue: show.venue.name
          }
        end
      }
    end
  end
end

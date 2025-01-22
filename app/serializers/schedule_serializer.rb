class ScheduleSerializer
  include JSONAPI::Serializer

  attributes :id

  attribute :shows do |schedule|
    schedule.shows.map do |show|
      {
        id: show.id,
        time_slot: show.time_slot,
        artist: { id: show.artist.id, name: show.artist.name },
        venue: { id: show.venue.id, name: show.venue.name }
      }
    end
  end
end

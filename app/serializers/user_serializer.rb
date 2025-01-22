class UserSerializer
  include JSONAPI::Serializer

  attributes :id, :first_name, :last_name, :email

  attribute :schedule do |user|
    user.schedule&.then do |schedule|
      {
        id: schedule.id,
        shows: schedule.shows.map do |show|
          {
            id: show.id,
            time_slot: show.time_slot,
            artist: { id: show.artist&.id, name: show.artist&.name },
            venue: { id: show.venue&.id, name: show.venue&.name }
          }
        end
      }
    end
  end
end
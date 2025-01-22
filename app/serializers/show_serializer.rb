class ShowSerializer
  include JSONAPI::Serializer

  attributes :id, :time_slot

  attribute :artist do |show|
    { id: show.artist.id, name: show.artist.name }
  end

  attribute :venue do |show|
    { id: show.venue.id, name: show.venue.name }
  end
end
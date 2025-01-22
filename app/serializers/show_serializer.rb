class ShowSerializer
  include JSONAPI::Serializer

  attributes :id, :time_slot

  attribute :artist do |show|
    ArtistSerializer.new(show.artist).serializable_hash[:data][:attributes]
  end

  attribute :venue do |show|
    VenueSerializer.new(show.venue).serializable_hash[:data][:attributes]
  end
end

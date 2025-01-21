class ShowSerializer
  include JSONAPI::Serializer

  attributes :id, :time_slot

  belongs_to :venue
  belongs_to :artist
end
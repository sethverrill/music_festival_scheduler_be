class VenueSerializer
  include JSONAPI::Serializer

  attributes :id, :name

  has_many :shows
end
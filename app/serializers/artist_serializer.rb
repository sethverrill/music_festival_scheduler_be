class ArtistSerializer
  include JSONAPI::Serializer

  attributes :id, :name
end

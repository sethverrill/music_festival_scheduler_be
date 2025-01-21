class ScheduleSerializer
  include JSONAPI::Serializer

  attributes :id, :created_at

  has_many :shows
end

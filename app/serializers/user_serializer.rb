class UserSerializer
  include JSONAPI::Serializer

  attributes :id, :first_name, :last_name, :email

  attribute :schedule do |user|
    {
      id: user.schedule&.id,
      created_at: user.schedule&.created_at
    }
  end
end

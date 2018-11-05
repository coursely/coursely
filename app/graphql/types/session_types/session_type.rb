class Types::SessionTypes::SessionType < Types::BaseObject
  field :csrf, String, null: false
  field :access, String, null: false
  field :access_expires_at, String, null: false
  field :refresh, String, null: false
  field :refresh_expires_at, String, null: false
end

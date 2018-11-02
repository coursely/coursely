class Types::UserTypes::ReadType < Types::BaseObject
  description "User model"

  field :id, ID, null: false
  field :name, String, null: false
  field :email, String, null: false
end

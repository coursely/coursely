class Types::UserTypes::UserType < Types::BaseObject
  description "User model"

  field :id, ID, null: false
  field :name, String, null: false
  field :email, String, null: false
end

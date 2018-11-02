class Types::UserTypes::CreateType < Types::BaseInputObject
  description "User creation type"

  argument :name, String, required: true
  argument :email, String, required: true
  argument :password, String, required: true
  argument :password_confirmation, String, required: true
end

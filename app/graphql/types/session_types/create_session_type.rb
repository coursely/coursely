class Types::SessionTypes::CreateSessionType < Types::BaseInputObject
  description "User sign in type"

  argument :email, String, required: true
  argument :password, String, required: true
end

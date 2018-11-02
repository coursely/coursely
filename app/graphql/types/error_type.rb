class Types::ErrorType < Types::BaseObject
  description "A user-readable error message"

  field :message, String, null: false, description: "A description of the error"
  field :path, [String], null: true, description: "The location of the value that caused the error"
end

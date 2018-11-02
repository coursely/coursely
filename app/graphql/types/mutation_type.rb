module Types
  class MutationType < Types::BaseObject
    field :create_user, mutation: Mutations::UserMutations::CreateUserMutation
  end
end

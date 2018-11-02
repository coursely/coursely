module Types
  class MutationType < Types::BaseObject
    field :create_user, mutation: Mutations::UserMutations::CreateMutation
  end
end

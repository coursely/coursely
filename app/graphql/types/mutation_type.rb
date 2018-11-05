module Types
  class MutationType < Types::BaseObject
    field :create_session, mutation: Mutations::SessionMutations::CreateSessionMutation
    field :create_user, mutation: Mutations::UserMutations::CreateUserMutation
  end
end

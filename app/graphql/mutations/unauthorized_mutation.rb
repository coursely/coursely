class Mutations::UnauthorizedMutation < Mutations::BaseMutation
  def ready?(**args)
    !context[:current_user] or raise GraphQL::ExecutionError, "You are already signed in"
  end
end

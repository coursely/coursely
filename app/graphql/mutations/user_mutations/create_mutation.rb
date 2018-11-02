class Mutations::UserMutations::CreateMutation < Mutations::BaseMutation
  argument :user, Types::UserTypes::CreateType, required: true

  field :user, Types::UserTypes::ReadType, null: false

  def resolve(user:)
    u = User.create!(user.to_h)

    {
      user: u
    }
  end
end

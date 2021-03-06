class Mutations::UserMutations::CreateUserMutation < Mutations::BaseMutation
  argument :user, Types::UserTypes::CreateUserType, required: true

  field :user, Types::UserTypes::UserType, null: true

  def resolve(user:)
    {
      user: User.create!(user.to_h),
      errors: []
    }
  rescue ActiveRecord::RecordInvalid => e
    map_record_invalid_errors(e)
  end
end

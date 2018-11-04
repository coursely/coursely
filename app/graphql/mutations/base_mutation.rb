class Mutations::BaseMutation < GraphQL::Schema::Mutation
  field :errors, [Types::ErrorType], null: false

  protected

  def map_errors(e, *path)
    errors = e.map do |attr, msg|
      {
        path: [*path, attr.to_s],
        message: msg
      }
    end

    {
      errors: errors
    }
  end
end

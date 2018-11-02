class Mutations::BaseMutation < GraphQL::Schema::Mutation
  field :errors, [Types::ErrorType], null: false

  protected

  def map_record_invalid_errors(e)
    errors = e.record.errors.map do |attr, msg|
      {
        path: ["attributes", attr.to_s],
        message: msg
      }
    end

    {
      errors: errors
    }
  end
end

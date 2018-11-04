require "rails_helper"

RSpec.describe Mutations::UserMutations::CreateUserMutation do
  let(:password_confirmation) { user.password }
  let(:context) { {} }
  let(:variables) { { user: user.as_json(only: [:name, :email]).merge({ password: user.password, passwordConfirmation: password_confirmation }) } }
  let(:query_string) { <<~GRAPHQL }
    mutation ($user: CreateUser!) {
      createUser(user: $user) {
        user {
          id
          name
          email
        }
        errors {
          message
          path
        }
      }
    }
  GRAPHQL

  subject { CourselySchema.execute(query_string, context: context, variables: variables).to_h }

  context "a valid user" do
    let(:user) { FactoryBot.build :user }

    it { is_expected.to match "data" => {
        "createUser" => {
          "user" => {
            "id" => an_instance_of(String),
            "name" => user.name,
            "email" => user.email
          },
          "errors" => []
        }
      }
    }
  end

  context "a duplicate email" do
    let(:old_user) { FactoryBot.create :user }
    let(:user) { FactoryBot.build :user, email: old_user.email }

    it { is_expected.to match "data" => {
        "createUser" => {
          "user" => nil,
          "errors" => [{
            "message" => "has already been taken",
            "path" => ["user", "email"]
          }]
        }
      }
    }
  end

  context "an invalid password confirmation" do
    let(:user) { FactoryBot.build :user }
    let(:password_confirmation) { user.password.reverse }

    it { is_expected.to match "data" => {
        "createUser" => {
          "user" => nil,
          "errors" => [{
            "message" => "doesn't match Password",
            "path" => ["user", "password_confirmation"]
          }]
        }
      }
    }
  end
end

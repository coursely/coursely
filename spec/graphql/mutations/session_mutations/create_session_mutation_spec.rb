require "rails_helper"

RSpec.describe Mutations::SessionMutations::CreateSessionMutation do
  let(:context) { {} }
  let(:variables) { { user: { email: user.email, password: user.password } } }
  let(:query_string) { <<~GRAPHQL }
    mutation ($user: CreateSession!) {
      createSession(user: $user) {
        user {
          id
          name
          email
        }
        session {
          csrf
          access
          accessExpiresAt
          refresh
          refreshExpiresAt
        }
        errors {
          message
          path
        }
      }
    }
  GRAPHQL

  subject { CourselySchema.execute(query_string, context: context, variables: variables).to_h }

  context "valid credentials" do
    let(:user) { FactoryBot.create :user }

    it { is_expected.to match "data" => {
      "createSession" => {
        "user" => {
          "id" => an_instance_of(String),
          "name" => user.name,
          "email" => user.email
        },
        "session" => {
          "csrf" => an_instance_of(String),
          "access" => an_instance_of(String),
          "accessExpiresAt" => an_instance_of(String),
          "refresh" => an_instance_of(String),
          "refreshExpiresAt" => an_instance_of(String)
        },
        "errors" => []
      }
    } }
  end
end

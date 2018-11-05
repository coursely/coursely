require Rails.root.join("lib", "errors")

class Mutations::SessionMutations::CreateSessionMutation < Mutations::BaseMutation
  argument :user, Types::SessionTypes::CreateSessionType, required: true

  field :user, Types::UserTypes::UserType, null: true
  field :session, Types::SessionTypes::SessionType, null: true

  def resolve(user:)
    u = User.find_by!(email: user.email)
    u.authenticate!(user.password)

    payload = {
      user_id: u.id
    }

    session = JWTSessions::Session.new(payload: payload, refresh_payload: payload)

    {
      user: u,
      session: session.login
    }
  rescue ActiveRecord::RecordNotFound, InvalidCredentials
    map_errors({user: "Incorrect e-mail address or password"})
  end
end

class User < ApplicationRecord
  has_secure_password

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, length: { minimum: 8 }, presence: true

  def authenticate!(unencrypted_password)
    authenticate(unencrypted_password) or raise InvalidCredentials
  end

  def build_session
    payload = {
      user_id: id
    }

    JWTSessions::Session.new(payload: payload, refresh_payload: payload)
  end
end

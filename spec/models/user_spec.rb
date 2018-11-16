require "rails_helper"
require Rails.root.join("lib", "errors")

RSpec.describe User, type: :model do
  let(:user) { FactoryBot.build :user, password: nil }
  subject { user }

  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_presence_of :email }
  it { is_expected.to validate_uniqueness_of :email }
  it { is_expected.to validate_confirmation_of :password }
  it { is_expected.to validate_length_of(:password).is_at_least(8).is_at_most(72) }
  it { is_expected.to validate_presence_of :password }

  describe "#authenticate!" do
    let(:user) { FactoryBot.build :user }
    subject { user.authenticate!(password) }

    context "a valid password" do
      let(:password) { user.password }
      it { is_expected.to eql user }
    end

    context "an invalid password" do
      let(:password) { "THIS_IS_NOT_THE_CORRECT_PASSWORD" }
      it { expect { subject }.to raise_error InvalidCredentials }
    end
  end

  describe "#build_session" do
    subject { user.build_session }
    let(:payload) { { user_id: user.id } }

    it { is_expected.to be_a JWTSessions::Session }
    it { expect(subject.payload).to eql payload }
    it { expect(subject.refresh_payload).to eql payload }
  end
end

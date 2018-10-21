require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryBot.build :user, password: nil }
  subject { user }

  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_presence_of :email }
  it { is_expected.to validate_uniqueness_of :email }
  it { is_expected.to validate_confirmation_of :password }
  it { is_expected.to validate_length_of(:password).is_at_least(8).is_at_most(72) }
  it { is_expected.to validate_presence_of :password }
end
